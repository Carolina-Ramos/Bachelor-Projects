#ifndef __L22_AST_INPUT_H__
#define __L22_AST_INPUT_H__

#include <cdk/ast/expression_node.h>

namespace l22 {

  class input_node: public cdk::expression_node {
    cdk::expression_node *_expression;
  public:
    input_node(int lineno) :
        cdk::expression_node(lineno) {
    }

    input_node(int lineno, cdk::expression_node *expression) :
        cdk::expression_node(lineno), _expression(expression) {
    }

  public:
    inline cdk::expression_node *expression() {
      return _expression;
    }
    void accept(basic_ast_visitor *sp, int level) {
      sp->do_input_node(this, level);
    }

  };

} // l22

#endif