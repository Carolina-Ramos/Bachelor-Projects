#ifndef __L22_AST_LEFTVALUE_H__
#define __L22_AST_LEFTVALUE_H__

#include <cdk/ast/lvalue_node.h>
#include "targets/basic_ast_visitor.h"

namespace l22 {

  class leftvalue_node: public cdk::lvalue_node {
    cdk::expression_node *_base;
    cdk::expression_node *_index;

  public:
    leftvalue_node(int lineno, cdk::expression_node *base, cdk::expression_node *index) :
        cdk::lvalue_node(lineno), _base(base), _index(index) {
    }

  public:
    cdk::expression_node *base() {
      return _base;
    }
    cdk::expression_node *index() {
      return _index;
    }

  public:
    void accept(basic_ast_visitor *sp, int level) {
      sp->do_leftvalue_node(this, level);
    }

  };

} // l22

#endif