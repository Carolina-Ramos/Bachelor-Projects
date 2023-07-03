#ifndef __L22_AST_DECLARATION_H__
#define __L22_AST_DECLARATION_H__

#include <cdk/ast/basic_node.h>
#include <cdk/ast/expression_node.h>
#include <cdk/types/basic_type.h>

namespace l22 {

  class declaration_node: public cdk::typed_node {
    std::string _qualifier;
    std::string _name;
    cdk::expression_node *_expression;

  public:
    inline declaration_node(int lineno, std::shared_ptr<cdk::basic_type> var_type, std::string qualifier, std::string name, cdk::expression_node *expression) :
        typed_node(lineno), _qualifier(qualifier), _name(name), _expression(expression)
    {
          type(var_type);
    }

  public:
    bool constant() {
      return false;  
    }
    inline std::string qualifier() {
      return _qualifier;
    }
    inline std::string name() {
      return _name;
    }
    inline cdk::expression_node *expression() {
      return _expression;
    }

    void accept(basic_ast_visitor *sp, int level) {
      sp->do_declaration_node(this, level);
    }

  };

} // l22

#endif
