%{
//-- don't change *any* of these: if you do, you'll break the compiler.
#include <algorithm>
#include <memory>
#include <cstring>
#include <cdk/compiler.h>
#include <cdk/types/types.h>
#include ".auto/all_nodes.h"
#define LINE                         compiler->scanner()->lineno()
#define yylex()                      compiler->scanner()->scan()
#define yyerror(compiler, s)         compiler->scanner()->error(s)
//-- don't change *any* of these --- END!
%}

%parse-param {std::shared_ptr<cdk::compiler> compiler}

%union {
  //--- don't change *any* of these: if you do, you'll break the compiler.
  YYSTYPE() : type(cdk::primitive_type::create(0, cdk::TYPE_VOID)) {}
  ~YYSTYPE() {}
  YYSTYPE(const YYSTYPE &other) { *this = other; }
  YYSTYPE& operator=(const YYSTYPE &other) { type = other.type; return *this; }

  std::shared_ptr<cdk::basic_type> type;        /* expression type */
  //-- don't change *any* of these --- END!

  int                   i;	/* integer value */
  double                 d;    /* double value */
  std::string          *s;	/* symbol name or string literal */
  
  cdk::basic_node      *node;	/* node pointer */
  cdk::sequence_node   *sequence;
  cdk::expression_node *expression; /* expression nodes */
  cdk::lvalue_node     *lvalue;

  l22::block_node      *block;
};

%token <i> tINTEGER
%token <d> tDOUBLE
%token <s> tIDENTIFIER tSTRING

%token tWHILE tBEGIN tEND
%token tAND tOR tNE tLE tGE tSIZEOF tNOT
%token tINPUT tWRITE tWRITELN
%token tPUBLIC tPRIVATE tUSE
%token tTYPE_STRING tTYPE_INT tTYPE_DOUBLE
%token tIF tTHEN tELIF tELSE
%token tFOR tDO
%token tRETURN tAGAIN tSTOP
%token tNULL tVOID

%type <node> if while declaration function function_call
%type <node> instruction
%type <node> stmt program

%type <sequence> file declarations list vars_declaration
%type <sequence> expressions instructions
%type <expression> expr func_type vars 
%type <block> block
%type <lvalue> lval
%type <type> data_type void

%nonassoc tIFX
%nonassoc tTHEN
%nonassoc tELIF tELSE

%nonassoc tWHILE
%nonassoc tDO

%right '='
%left tGE tLE tEQ tNE '>' '<'
%left '+' '-'
%left '*' '/' '%'
%left tOR
%left tAND

%nonassoc '~'
%nonassoc '?' tUNARY
%nonassoc '[' ']' '(' ')'


%{
//-- The rules below will be included in yyparse, the main parsing function.
%}
%%

file	: program                            { compiler->ast($$ = new cdk::sequence_node(LINE)); }
      |declarations program                { $$ = new cdk::sequence_node(LINE, $1); }
      |declarations                        { $$ = new cdk::sequence_node(LINE, $1); }
	;

program : tBEGIN list tEND  { compiler->ast(new l22::program_node(LINE, $2)); }
      |tBEGIN block tEND { compiler->ast(new l22::program_node(LINE, $2)); }
	;

list :| stmt           { $$ = new cdk::sequence_node(LINE, $1); }
	| list stmt    { $$ = new cdk::sequence_node(LINE, $2, $1); }
	;

declarations : declaration                   { $$ = new cdk::sequence_node(LINE, $1); }
            | declarations declaration      { $$ = new cdk::sequence_node(LINE, $2, $1); }
            ;

declaration : tPUBLIC data_type tIDENTIFIER '=' expr           { $$ = new l22::declaration_node(LINE, $2, std::string("public"), *$3, $5); }
            | tPUBLIC data_type tIDENTIFIER                   { $$ = new l22::declaration_node(LINE, $2, std::string("public"), *$3, nullptr); }
            | tUSE data_type tIDENTIFIER '=' expr             { $$ = new l22::declaration_node(LINE, $2, std::string("use"), *$3, $5); }
            | tPRIVATE data_type tIDENTIFIER '=' expr         { $$ = new l22::declaration_node(LINE, $2, std::string("private"), *$3, $5); }
            | tPRIVATE data_type tIDENTIFIER                  { $$ = new l22::declaration_node(LINE, $2, std::string("private"), *$3, nullptr);}
            ;

function : '(' ')' '-' '>' data_type ':' block        { $$ = new l22::fundef_expression_node(LINE, $5, std::string("public"), $7); }
         | '(' vars ')' '-' '>' data_type ':' block   { $$ = new l22::fundef_expression_node(LINE, $6, std::string("private"), *$2, $8); delete $2;}
         | '(' ')' '-' '>' void ':' block        { $$ = new l22::fundef_expression_node(LINE, $5, std::string("public"), $7);}
         | '(' vars ')' '-' '>' void ':' block   { $$ = new l22::fundef_expression_node(LINE, $6, std::string("private"), *$2, $8); delete $2; }
         ;

function_call : tIDENTIFIER '(' data_type ')'                   { $$ = new fir::function_call_node(LINE, $3);}
            ;

vars : data_type tIDENTIFIER lval                     { $$ = new l22::declaration_node(LINE, std::string("public"), *$2, $3)}
      | data_type tIDENTIFIER lval                    { $$ = new l22::declaration_node(LINE, std::string("use"), *$2, $3)}
      | data_type tIDENTIFIER lval                    { $$ = new l22::declaration_node(LINE, std::string("foreign"), *$2, $3)}
      | data_type tTYPE_STRING tIDENTIFIER lval       { $$ = new l22::declaration_node(LINE, std::string("public"), *$3, $4)}
      | void tTYPE_STRING tIDENTIFIER lval            { $$ = new l22::declaration_node(LINE, std::string("private"), *$3, $4)}

vars_declaration : vars                   { $$ = new cdk::sequence_node(LINE, $1); }
                | vars ',' vars         { $$ = new cdk::sequence_node(LINE, $1, $3); }

func_type    : data_type '<' data_type '>'      { $$ = new l22::function_call_node(LINE, $1, $3)}
            | data_type '<' void '>'           { $$ = new l22::function_call_node(LINE, $1, $3)}
            ;

data_type    : tTYPE_INT                        { $$ = cdk::primitive_type::create(4, cdk::TYPE_INT);     }
            | tTYPE_DOUBLE                      { $$ = cdk::primitive_type::create(8, cdk::TYPE_DOUBLE);  }
            | tTYPE_STRING                      { $$ = cdk::primitive_type::create(4, cdk::TYPE_STRING);  }
            | '[' data_type ']'                 { $$ = cdk::reference_type::create(4, $2); }
            | data_type '<' '>'                 { $$ = cdk::reference_type::create(4, $1); }
            | data_type '<' data_type '>'       { $$ = cdk::reference_type::create(4, $1); }
            ;

block : '{' declarations instructions '}'      { $$ = new l22::block_node(LINE, $2, $3); }
      | '{' declarations '}'                   { $$ = new l22::block_node(LINE, $2, nullptr); }
      | '{' instructions '}'                   { $$ = new l22::block_node(LINE, nullptr, $2); }
      | '{' '}'                                { $$ = nullptr; }
      ;

instructions : instruction                   { $$ = new cdk::sequence_node(LINE, $1); }
            | instructions instruction      { $$ = new cdk::sequence_node(LINE, $2, $1); }
            ;

instruction : expressions '|'                { $$ = new cdk::sequence_node(LINE, $1); }
            | tWRITE expressions '|'         { $$ = new l22::write_node(LINE, $2); }
            | tWRITELN expressions '|'       { $$ = new l22::writeln_node(LINE, $2); }
            | tAGAIN '|'                     { $$ = new l22::again_node(LINE); }
            | tSTOP '|'                      { $$ = new l22::stop_node(LINE); }
            | tRETURN expr                  { $$ = new l22::return_node(LINE, $2); }
            | tRETURN                        { $$ = new l22::return_node(LINE); }
            | if                             { $$ = $1; }
            | while                          { $$ = $1; }
            | block                          { $$ = $1; }  
            ;

if : tIF '(' expr ')' tTHEN ':' block tELSE block                                       { $$ = new l22::if_else_node(LINE, $3, $7, $9); }
   | tIF '(' expr ')' tTHEN ':' block tELIF '(' expr ')' tTHEN ':' block tELSE block     { $$ = new l22::if_else_node(LINE, $3, $7, $10); }
   | tIF expr tTHEN block                                                               { $$ = new l22::if_node(LINE, $2, $4); }
   ;

while : tWHILE '(' expr ')' tDO ':' block  { $$ = new l22::while_node(LINE, $3, $7); }
      ;

stmt : expr ';'                            { $$ = new l22::evaluation_node(LINE, $1); }
      | tINPUT expr ';'                    { $$ = new l22::input_node(LINE, $2); }
     | tWRITE expressions ';'              { $$ = new l22::write_node(LINE, $2); }
     | tWRITELN expressions                { $$ = new l22::writeln_node(LINE, $2); }
     | tWHILE '(' expr ')' stmt            { $$ = new l22::while_node(LINE, $3, $5); }
     | tIF '(' expr ')' stmt %prec tIFX    { $$ = new l22::if_node(LINE, $3, $5); }
     | tIF '(' expr ')' stmt tELSE stmt    { $$ = new l22::if_else_node(LINE, $3, $5, $7); }
     | '{' list '}'                        { $$ = $2; }
     ;

expr : tINTEGER                         { $$ = new cdk::integer_node(LINE, $1); }
     | tDOUBLE                          { $$ = new cdk::double_node(LINE, $1); }
     | tSTRING                            { $$ = new cdk::string_node(LINE, $1); }
     | tSIZEOF '(' expr ')'             { $$ = new l22::sizeof_node(LINE, $3); }
     | '@'                              { $$ = new l22::input_node(LINE); }
     | tNULL                            { $$ = new l22::nullptr_node(LINE); }
     | '-' expr %prec tUNARY            { $$ = new cdk::neg_node(LINE, $2); }
     | expr '+' expr	               { $$ = new cdk::add_node(LINE, $1, $3); }
     | expr '-' expr	               { $$ = new cdk::sub_node(LINE, $1, $3); }
     | expr '*' expr	               { $$ = new cdk::mul_node(LINE, $1, $3); }
     | expr '/' expr	               { $$ = new cdk::div_node(LINE, $1, $3); }
     | expr '%' expr	               { $$ = new cdk::mod_node(LINE, $1, $3); }
     | expr '<' expr	               { $$ = new cdk::lt_node(LINE, $1, $3); }
     | expr '>' expr	               { $$ = new cdk::gt_node(LINE, $1, $3); }
     | expr tGE expr	               { $$ = new cdk::ge_node(LINE, $1, $3); }
     | expr tLE expr                    { $$ = new cdk::le_node(LINE, $1, $3); }
     | expr tNE expr	               { $$ = new cdk::ne_node(LINE, $1, $3); }
     | expr tEQ expr	               { $$ = new cdk::eq_node(LINE, $1, $3); }
     | expr tOR expr                    { $$ = new cdk::or_node(LINE, $1, $3); }
     | expr tAND expr                   { $$ = new cdk::and_node(LINE, $1, $3); }
     | '(' expr ')'                     { $$ = $2; }
     | tNOT expr                         { $$ = new cdk::not_node(LINE, $2); }
     | lval                             { $$ = new cdk::rvalue_node(LINE, $1); } 
     | lval '?'                         { $$ = new l22::address_of_node(LINE, $1); }
     | lval '=' expr                    { $$ = new cdk::assignment_node(LINE, $1, $3); }
     ;

expressions : expr                                { $$ = new cdk::sequence_node(LINE, $1); }
            | expressions ',' expr                { $$ = new cdk::sequence_node(LINE, $3, $1); } 
            ;

void : tVOID                { $$ = cdk::primitive_type::create(0, cdk::TYPE_VOID); }
     ;

lval : tIDENTIFIER                { $$ = new cdk::variable_node(LINE, $1); }
     ;

%%
