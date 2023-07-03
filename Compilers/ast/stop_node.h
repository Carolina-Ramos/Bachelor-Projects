#ifndef __L22_AST_READ_NODE_H__
#define __L22_AST_READ_NODE_H__

#include <cdk/ast/basic_node.h>

namespace l22 {

  /**
   * Class for describing 'stop' instruction nodes.
   */
  class stop_node: public cdk::basic_node {

  public:
    inline stop_node(int lineno) :
        cdk::basic_node(lineno) {
    }

  public:
    void accept(basic_ast_visitor *sp, int level) {
      sp->do_stop_node(this, level);
    }

  };

} // l22

#endif