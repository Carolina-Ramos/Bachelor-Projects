#ifndef __L22_AST_READ_NODE_H__
#define __L22_AST_READ_NODE_H__

#include <cdk/ast/lvalue_node.h>

namespace l22 {

  /**
   * Class for describing read nodes.
   */
  class read_node: public cdk::basic_node { //expression_node
    cdk::expression_node *_argument;

  public:
    inline read_node(int lineno, cdk::expression_node *argument) :
        cdk::basic_node(lineno), _argument(argument) { //expression_node(lineno)
    }

  public:
    inline cdk::expression_node *argument() {
      return _argument;
    }

    void accept(basic_ast_visitor *sp, int level) {
      sp->do_read_node(this, level);
    }

  };

} // l22

#endif
