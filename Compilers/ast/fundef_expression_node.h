#ifndef __L22_AST_FUNDEF_EXPRESSION_H__
#define __L22_AST_FUNDEF_EXPRESSION_H__

#include <string>
#include <cdk/ast/typed_node.h>
#include <cdk/ast/sequence_node.h>
#include "ast/block_node.h"

namespace l22 {

  class fundef_expression_node: public cdk::typed_node {
    int _qualifier; //retirar ?
    std::string _identifier; // retirar ?
    cdk::sequence_node *_arguments;
    l22::block_node *_block;

  public:
    fundef_expression_node(int lineno, int qualifier, const std::string &identifier, cdk::sequence_node *arguments,
                             l22::block_node *block) :
        cdk::typed_node(lineno), _qualifier(qualifier), _identifier(identifier), _arguments(arguments), _block(block) {
      type(cdk::primitive_type::create(0, cdk::TYPE_VOID));
    }

    fundef_expression_node(int lineno, int qualifier, std::shared_ptr<cdk::basic_type> funType, const std::string &identifier,
                             cdk::sequence_node *arguments, l22::block_node *block) :
        cdk::typed_node(lineno), _qualifier(qualifier), _identifier(identifier), _arguments(arguments), _block(block) {
      type(funType);
    }

  public:
    int qualifier() {
      return _qualifier;
    }
    const std::string& identifier() const {
      return _identifier;
    }
    cdk::sequence_node* arguments() {
      return _arguments;
    }
    cdk::typed_node* argument(size_t ax) {
      return dynamic_cast<cdk::typed_node*>(_arguments->node(ax));
    }
    l22::block_node* block() {
      return _block;
    }

    void accept(basic_ast_visitor *sp, int level) {
      sp->do_fundef_expression_node(this, level);
    }

  };

} // l22

#endif
