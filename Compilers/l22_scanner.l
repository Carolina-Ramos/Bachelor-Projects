%option c++ prefix="l22_scanner_" outfile="l22_scanner.cpp"
%option stack noyywrap yylineno 8bit debug
%{ 
// make relevant includes before including the parser's tab file
#include <string>
#include <cstring>
#include <sstream>
#include <cdk/ast/sequence_node.h>
#include <cdk/ast/expression_node.h>
#include <cdk/ast/lvalue_node.h>
#include "l22_parser.tab.h"

static std::ostringstream strlit;

// don't change this
#define yyerror LexerError
%}
%x X_STRING X_SPECIALCASE
%%
  yydebug=1; set_debug(1);

"--".*                 ; /* ignore comments */

[\[\](),?]       return *yytext;
[-+*/%~<>@?=]        return *yytext;
">="                   return tGE; 
"<="                   return tLE; 
"=="                   return tEQ; 
"!="                   return tNE; 
"and"                  return tAND;
"or"                   return tOR;
"not"                  return tNOT;

"while"                return tWHILE; 
"if"                   return tIF; 
"then:"                return tTHEN;
"elif"                 return tELIF;
"else:"                return tELSE;
"write"                return tWRITE; 
"writeln"              return tWRITELN;
"input"                return tINPUT; 
"begin"                return tBEGIN; 
"end"                  return tEND; 

"id"                   return tIDENTIFIER;

"do:"                   return tDO;
"stop"                 return tSTOP;
"again"                return tAGAIN;

[\[\]():,]             return *yytext;
"return"               return tRETURN;

"sizeof"               return tSIZEOF;

"public"               return tPUBLIC;
"private"              return tPRIVATE;
"use"                  return tUSE;

"int"                  return tTYPE_INT;
"double"               return tTYPE_DOUBLE;

[<>]                   return *yytext;

 /* identificadores */
[A-Za-z][A-Za-z0-9_]*  yylval.s = new std::string(yytext); return tIDENTIFIER;

 /*Integers*/
0                       yylval.i = 0; return tINTEGER;
0[0]+                   yyerror("Invalid integer 0.");
[1-9][0-9]*             {  try { 
                            yylval.i = std::stoi(yytext, NULL, 10);
                            return tINTEGER;
                         } catch (std::out_of_range& e) { yyerror("Integer out of range.");}
                        }



0[0-7]*                 {  try { 
                            yylval.i = std::stoi(yytext, NULL, 8);
                            return tINTEGER;
                         } catch (std::out_of_range& e) { yyerror("Integer out of range.");}
                        } 

0[0-9]+                 yyerror("Invalid base 8 number.");

 /*Known symbols*/
[-()<>=+*/%;{}.,?\[\]@]       return *yytext;

 /*Whitespace*/
[ \t\n\r]+               ; /* ignore whitespace */

 /*Strings*/
"\""                    yy_push_state(X_STRING);
<X_STRING>"\"            yy_push_state(X_SPECIALCASE);
<X_STRING>"\""          { yylval.s = new std::string(strlit.str());
                          strlit.str("");
                          yy_pop_state();
                          return tSTRING;
                        }
                        
<X_STRING>\n            yyerror("Error in string");
<X_STRING>.             strlit << yytext;

<X_SPECIALCASE>n        {strlit << '\n'; yy_pop_state(); }
<X_SPECIALCASE>t        {strlit << '\t'; yy_pop_state(); }
<X_SPECIALCASE>r        {strlit << '\r'; yy_pop_state(); }
<X_SPECIALCASE>" "      {strlit << ' '; yy_pop_state(); }
<X_SPECIALCASE>\"       {strlit << '\"'; yy_pop_state(); }

<X_SPECIALCASE>[0-9A-Fa-f]{1,2} { strlit << (char)(unsigned char)std::stoul(yytext, NULL, 16);
                                  yy_pop_state();
                                }

<X_SPECIALCASE>.		    { strlit << *yytext; yy_pop_state(); }

 /*Doubles*/
[0-9]+"."[0-9]+  { try { yylval.d = std::stod(yytext, NULL); 
                         return tDOUBLE; 
                       } catch (std::out_of_range& e) { yyerror("Real out of range."); }
                 }

[0-9]+"."        { try { yylval.d = std::stod(yytext, NULL); 
                         return tDOUBLE; 
                       } catch (std::out_of_range& e) { yyerror("Real out of range."); }
                 }

"."[0-9]+        { try { yylval.d = std::stod(yytext, NULL); 
                         return tDOUBLE; 
                       } catch (std::out_of_range& e) { yyerror("Real out of range."); }
                 }

[0-9]+("."[0-9]+)?[Ee][-+]?[0-9]+  { try { yylval.d = std::stod(yytext, NULL); 
                                           return tDOUBLE; 
                                         } catch (std::out_of_range& e) { yyerror("Real out of range."); }
                                   }

 /*Unknown character*/
.                      yyerror("Unknown character");
%%