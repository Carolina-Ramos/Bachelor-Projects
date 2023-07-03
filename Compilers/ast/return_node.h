#ifndef __L22_AST_RETURN_NODE_H__
#define __L22_AST_RETURN_NODE_H__

#include <cdk/ast/expression_node.h>

namespace l22 {

  /**
   * Class for describing return node.
   */
  class return_node: public cdk::basic_node {
    cdk::expression_node *_condition;

  public:
    return_node(int lineno) :
        cdk::basic_node(lineno) {
    }

    return_node(int lineno, cdk::expression_node *condition) :
        basic_node(lineno), _condition(condition) {
    }

  public:
    inline cdk::expression_node *condition() {
      return _condition;
    }

    void accept(basic_ast_visitor *sp, int level) {
      sp->do_return_node(this, level);
    }

  };

} // l22

#endif