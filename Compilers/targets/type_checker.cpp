#include <string>
#include "targets/type_checker.h"
#include ".auto/all_nodes.h"  // automatically generated
#include <cdk/types/primitive_type.h>

#define ASSERT_UNSPEC { if (node->type() != nullptr && !node->is_typed(cdk::TYPE_UNSPEC)) return; }

//---------------------------------------------------------------------------

void l22::type_checker::do_sequence_node(cdk::sequence_node *const node, int lvl) {
  // EMPTY
}

//---------------------------------------------------------------------------

void l22::type_checker::do_nil_node(cdk::nil_node *const node, int lvl) {
  // EMPTY nao preciso 
}
void l22::type_checker::do_data_node(cdk::data_node *const node, int lvl) {
  // EMPTY nao preciso 
}
void l22::type_checker::do_double_node(cdk::double_node *const node, int lvl) {
  ASSERT_UNSPEC;
  node->type(cdk::primitive_type::create(8, cdk::TYPE_DOUBLE));
}

void l22::type_checker::do_not_node(cdk::not_node *const node, int lvl) {
  ASSERT_UNSPEC;
  node->argument()->accept(this, lvl + 2);
  if (node->argument()->is_typed(cdk::TYPE_INT)) {
    node->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
  } else if (node->argument()->is_typed(cdk::TYPE_UNSPEC)) {
    node->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
    node->argument()->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
  } else {
    throw std::string("wrong type in unary logical expression");
  }
}

void l22::type_checker::do_and_node(cdk::and_node *const node, int lvl) {
  do_BooleanLogicalExpression(node, lvl);
}

void l22::type_checker::do_or_node(cdk::or_node *const node, int lvl) {
 do_BooleanLogicalExpression(node, lvl);
}

//---------------------------------------------------------------------------

void l22::type_checker::do_integer_node(cdk::integer_node *const node, int lvl) {
  ASSERT_UNSPEC;
  node->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
}

void l22::type_checker::do_string_node(cdk::string_node *const node, int lvl) {
  ASSERT_UNSPEC;
  node->type(cdk::primitive_type::create(4, cdk::TYPE_STRING));
}

//---------------------------------------------------------------------------

void l22::type_checker::processUnaryExpression(cdk::unary_operation_node *const node, int lvl) {
  node->argument()->accept(this, lvl + 2);
  if (!node->argument()->is_typed(cdk::TYPE_INT)) throw std::string("wrong type in argument of unary expression");

  // in Simple, expressions are always int
  node->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
}

void l22::type_checker::do_neg_node(cdk::neg_node *const node, int lvl) {
  processUnaryExpression(node, lvl);
}

//---------------------------------------------------------------------------

void l22::type_checker::processBinaryExpression(cdk::binary_operation_node *const node, int lvl) {
  ASSERT_UNSPEC;
  node->left()->accept(this, lvl + 2);
  if (!node->left()->is_typed(cdk::TYPE_INT)) throw std::string("wrong type in left argument of binary expression");

  node->right()->accept(this, lvl + 2);
  if (!node->right()->is_typed(cdk::TYPE_INT)) throw std::string("wrong type in right argument of binary expression");

  // in Simple, expressions are always int
  node->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
}

void l22::type_checker::do_add_node(cdk::add_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_sub_node(cdk::sub_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_mul_node(cdk::mul_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_div_node(cdk::div_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_mod_node(cdk::mod_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_lt_node(cdk::lt_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_le_node(cdk::le_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_ge_node(cdk::ge_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_gt_node(cdk::gt_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_ne_node(cdk::ne_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}
void l22::type_checker::do_eq_node(cdk::eq_node *const node, int lvl) {
  processBinaryExpression(node, lvl);
}

//---------------------------------------------------------------------------

void l22::type_checker::do_variable_node(cdk::variable_node *const node, int lvl) {
  ASSERT_UNSPEC;
  const std::string &id = node->name();
  std::shared_ptr<l22::symbol> symbol = _symtab.find(id);

  if (symbol != nullptr) {
    node->type(symbol->type());
  } else {
    throw id;
  }
}

void l22::type_checker::do_rvalue_node(cdk::rvalue_node *const node, int lvl) {
  ASSERT_UNSPEC;
  try {
    node->lvalue()->accept(this, lvl);
    node->type(node->lvalue()->type());
  } catch (const std::string &id) {
    throw "undeclared variable '" + id + "'";
  }
}

void l22::type_checker::do_assignment_node(cdk::assignment_node *const node, int lvl) {
  ASSERT_UNSPEC;

  try {
    node->lvalue()->accept(this, lvl);
  } catch (const std::string &id) {
    auto symbol = std::make_shared<l22::symbol>(cdk::primitive_type::create(4, cdk::TYPE_INT), id, 0);
    _symtab.insert(id, symbol);
    _parent->set_new_symbol(symbol);  // advise parent that a symbol has been inserted
    node->lvalue()->accept(this, lvl);  //DAVID: bah!
  }

  if (!node->lvalue()->is_typed(cdk::TYPE_INT)) throw std::string("wrong type in left argument of assignment expression");

  node->rvalue()->accept(this, lvl + 2);
  if (!node->rvalue()->is_typed(cdk::TYPE_INT)) throw std::string("wrong type in right argument of assignment expression");

  // in Simple, expressions are always int
  node->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
}

//---------------------------------------------------------------------------

void l22::type_checker::do_program_node(l22::program_node *const node, int lvl) {
  node-> statements()->accept(this, lvl +2)
}

void l22::type_checker::do_evaluation_node(l22::evaluation_node *const node, int lvl) {
  node->argument()->accept(this, lvl + 2);
}

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

void l22::type_checker::do_while_node(l22::while_node *const node, int lvl) {
  node->condition()->accept(this, lvl + 4);
}

//---------------------------------------------------------------------------

void l22::type_checker::do_if_node(l22::if_node *const node, int lvl) {
  node->condition()->accept(this, lvl + 4);
}

void l22::type_checker::do_if_else_node(l22::if_else_node *const node, int lvl) {
  node->condition()->accept(this, lvl + 4);
}

//----------------------------------------------------------------------------

void l22::type_checker::do_stop_node(l22::stop_node * const node, int lvl) {
  //EMPTY 
}

void l22::type_checker::do_again_node(l22::again_node * const node, int lvl) {
  //EMPTY 
}

void l22::type_checker::do_return_node(l22::return_node * const node, int lvl) {
  if (node->condition()) {
    if (_function->type() != nullptr && _function->is_typed(cdk::TYPE_VOID)) 
      throw std::string("initializer specified for void function.");

    node->condition()->accept(this, lvl + 2);

    if (_function->type() == nullptr) {
      _function->set_type(node->condition()->type());
      return;
    }

    if (_inBlockReturnType == nullptr) {
      _inBlockReturnType = node->condition()->type();
    } else {
      if (_inBlockReturnType != node->condition()->type()) {
        _function->set_type(cdk::primitive_type::create(0, cdk::TYPE_ERROR));
        throw std::string("all return statements in a function must return the same type.");
      }
    }

    std::cout << "FUNCT TYPE " << (_function->type() == nullptr ? "auto" : cdk::to_string(_function->type())) << std::endl;
    std::cout << "CONDICTION TYPE " << cdk::to_string(node->condition()->type()) << std::endl;

    if (_function->is_typed(cdk::TYPE_INT)) {
      if (!node->condition()->is_typed(cdk::TYPE_INT)) throw std::string("Integer expected.");
    } else if (_function->is_typed(cdk::TYPE_DOUBLE)) {
      if (!node->condition()->is_typed(cdk::TYPE_INT) && !node->condition()->is_typed(cdk::TYPE_DOUBLE)) {
        throw std::string("Integer or double expected.");
      }
    } else if (_function->is_typed(cdk::TYPE_STRING)) {
      if (!node->condition()->is_typed(cdk::TYPE_STRING)) {
        throw std::string("String expected.");
      }
    } else if (_function->is_typed(cdk::TYPE_POINTER)) {
      int ft = 0, rt = 0;
      auto ftype = _function->type();
      while (ftype->name() == cdk::TYPE_POINTER) {
        ft++;
        ftype = cdk::reference_type::cast(ftype)->referenced();
      }
      auto rtype = node->condition()->type();
      while (rtype != nullptr && rtype->name() == cdk::TYPE_POINTER) {
        rt++;
        rtype = cdk::reference_type::cast(rtype)->referenced();
      }

      std::cout << "FUNCT TYPE " << cdk::to_string(_function->type()) << " --- " << ft << " -- " << ftype->name() << std::endl;
      std::cout << "CONDITION TYPE " << cdk::to_string(node->condition()->type()) << " --- " << rt << " -- " << cdk::to_string(rtype)
          << std::endl;

      bool compatible = (ft == rt) && (rtype == nullptr || (rtype != nullptr && ftype->name() == rtype->name()));
      if (!compatible) throw std::string("wrong type for return expression (pointer expected).");

    } else {
      throw std::string("unknown type for initializer.");
    }
  }
}

void l22::type_checker::do_write_node(l22::write_node * const node, int lvl) {
  node->argument()->accept(this, lvl + 2);
  //verificacao se e ponteiro
  for (size_t arg = 0; arg < node->argument()->size(); arg++) {
    if ( !( node->arg(arg)->is_typed(cdk::TYPE_INT) || node->arg(arg)->is_typed(cdk::TYPE_DOUBLE) || node->arg(arg)->is_typed(cdk::TYPE_STRING) ))
      throw std::string("only integer real and sring expressions expected in allocation expression");
  }
}

void l22::type_checker::do_writeln_node(l22::writeln_node * const node, int lvl) {
  node->argument()->accept(this, lvl + 2);
  //verificacao se e ponteiro
  for (size_t arg = 0; arg < node->argument()->size(); arg++) {
    if ( !( node->arg(arg)->is_typed(cdk::TYPE_INT) || node->arg(arg)->is_typed(cdk::TYPE_DOUBLE) || node->arg(arg)->is_typed(cdk::TYPE_STRING) ))
      throw std::string("only integer real and sring expressions expected in allocation expression");
  }
}

void l22::type_checker::do_sizeof_node(l22::sizeof_node * const node, int lvl) {
  ASSERT_UNSPEC;
  node->expression()->accept(this, lvl + 2);
  node->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
}

void l22::type_checker::do_input_node(l22::input_node * const node, int lvl) {
   node->type(cdk::primitive_type::create(0, cdk::TYPE_UNSPEC));
}

void l22::type_checker::do_index_node(l22::index_node * const node, int lvl) {
  ASSERT_UNSPEC;
  std::shared_ptr < cdk::reference_type > pointtype;

  if (node->base()) {
    node->base()->accept(this, lvl + 2);
    pointtype = cdk::reference_type::cast(node->base()->type());
    if (!node->base()->is_typed(cdk::TYPE_POINTER)) throw std::string("pointer expr expected in index left-value");
  } else {
    pointtype = cdk::reference_type::cast(_function->type());
    if (!_function->is_typed(cdk::TYPE_POINTER)) throw std::string("return pointer expr expected in index left-value");
  }

  node->index()->accept(this, lvl + 2);
  if (!node->index()->is_typed(cdk::TYPE_INT)) throw std::string("integer expr expected in left-value index");

  node->type(pointtype->referenced());
}

void l22::type_checker::do_block_node(l22::block_node *const node, int lvl) {
  // EMPTY
}

void l22::type_checker::do_address_of_node(l22::address_of_node * const node, int lvl) {
  ASSERT_UNSPEC;
  node->lvalue()->accept(this, lvl + 2);
  node->type(cdk::reference_type::create(4, node->lvalue()->type()));
}

void l22::type_checker::do_declaration_node(l22::declaration_node *const node, int lvl) {
  ASSERT_UNSPEC;

  if (node->expression()) { //initialized
    node->expression()->accept(this, lvl + 2);

    if (node->is_typed(cdk::TYPE_INT)) {
      if (node->expression()->is_typed(cdk::TYPE_UNSPEC))
        node->expression()->type(cdk::primitive_type::create(4, cdk::TYPE_INT));
      else if (!node->expression()->is_typed(cdk::TYPE_INT)) 
        throw std::string("integer type expected for initializer");

    } else if (node->is_typed(cdk::TYPE_DOUBLE)) {
      if (node->expression()->is_typed(cdk::TYPE_UNSPEC))
        node->expression()->type(cdk::primitive_type::create(8, cdk::TYPE_DOUBLE));
      else if (!( node->expression()->is_typed(cdk::TYPE_INT) || node->expression()->is_typed(cdk::TYPE_DOUBLE) )) 
        throw std::string("integer or double type expected for initialization");
      
    } else if (node->is_typed(cdk::TYPE_STRING)) {
      if (node->expression()->is_typed(cdk::TYPE_UNSPEC))
        node->expression()->type(cdk::primitive_type::create(4, cdk::TYPE_STRING));
      else if (!node->expression()->is_typed(cdk::TYPE_STRING))
        throw std::string("string type expected for initialization");

    } else if (node->is_typed(cdk::TYPE_POINTER)) {
      if (node->expression()->is_typed(cdk::TYPE_UNSPEC))
        node->expression()->type(cdk::primitive_type::create(4, cdk::TYPE_POINTER));
      else if (node->expression()->is_typed(cdk::TYPE_POINTER)) {
        std::shared_ptr < cdk::reference_type > vartype = cdk::reference_type::cast(node->type());
        std::shared_ptr < cdk::reference_type > exprtype = cdk::reference_type::cast(node->expression()->type());
        if (vartype->name() == exprtype->name())
          throw std::string("confliting pointer type for variable and initialization");

      } else if (!node->expression()->is_typed(cdk::TYPE_POINTER))
        throw std::string("pointer type expected for initialization");

    } else {
      throw std::string("unknown type for initialization");
    }
  }

  const std::string &id = node->name();
  auto symbol = std::make_shared<l22::symbol>(cdk::primitive_type::create(4, cdk::TYPE_INT), id, 0);
  throw std::string("variable '" + id + "' declared");
  if (_symtab.insert(id, symbol)) {
    _parent->set_new_symbol(symbol);
  } else {
    throw std::string("variable '" + id + "' already declared");
  }
}

void l22::type_checker::do_function_call_node(l22::function_call_node *const node, int lvl) {
  ASSERT_UNSPEC;

  cdk::expression_node *name = node->function();
  auto symbol = _symtab.find(function);
  if (symbol == nullptr) 
    throw std::string("symbol '" + function + "' is undeclared.");
  if (!symbol->function()) 
    throw std::string("symbol '" + function + "' is not a function.");

  // set return var
  if (symbol->is_typed(cdk::TYPE_STRUCT)) {
    const std::string returnvar = "return_" + name;
    auto return_symbol = l22::make_symbol(false, symbol->type(), symbol->qualifier(), returnvar, true, true);
    _symtab.insert(returnvar, return_symbol);
  }

  // set type
  node->type(symbol->type());

  // set arguments
  if (node->arguments()->size() == symbol->number_of_args()) {
    node->arguments()->accept(this, lvl + 4);
    for (size_t arg = 0; arg < node->arguments()->size(); arg++) {
      if (!( node->argument(arg)->type()->name() == symbol->arg_type(arg)->name() || 
             (symbol->arg_is_typed(arg, cdk::TYPE_DOUBLE) && node->argument(arg)->is_typed(cdk::TYPE_INT)) )) 
        throw std::string("type mismatch for argument " + std::to_string(arg + 1) + " of '" + name + "'.");
    }
  } else {
    throw std::string("number of arguments in call (" + 
                      std::to_string(node->arguments()->size()) + 
                      ") must match declaration ("
                      + std::to_string(symbol->number_of_args()) + ").");
  }
}

void l22::type_checker::do_fundef_expression_node(l22::fundef_expression_node *const node, int lvl) {
  /*ASSERT_UNSPEC;
  std::string id;

  if (node->name() == "l22")
    id = "_main";
  else if (node->name() == "_main")
    id = "._main";
  else
    id = node->name();
  
  if (node->body()) { //declared and defined
    auto function =l22::make_symbol(true, node->type(), node->qualifier(), id, true, true);

    std::vector < std::shared_ptr < cdk::basic_type >> argtypes;
    for (size_t arg = 0; arg < node->variables()->size(); arg++)
      argtypes.push_back(node->var(arg)->type());
    function->set_args_types(argtypes);

    if (node->type()->name() != node->return_value()->type()->name())
      throw std::string("conflicting types for function'" + id + "' and the return value");

    std::shared_ptr<l22::symbol> previous = _symtab.find(id);
    if (previous) {
      if (previous->qualifier() != node->qualifier()) {
        throw std::string("conflicting definition for '" + id + "'");
      } else {
        _symtab.insert(id, function);
        _parent->set_new_symbol(function);
      }
    }
  }
  else { //only declared
    auto function = l22::make_symbol(true, node->type(), node->qualifier(), id, true, false);

    std::vector < std::shared_ptr < cdk::basic_type >> argtypes;
    for (size_t arg = 0; arg < node->variables()->size(); arg++)
      argtypes.push_back(node->var(arg)->type());
    function->set_args_types(argtypes);

    std::shared_ptr<l22::symbol> previous = _symtab.find(id);
    if (previous) {
      if (previous->qualifier() != node->qualifier()) {
        throw std::string("conflicting definition for '" + id + "'");
      } else {
        _symtab.insert(id, function);
        _parent->set_new_symbol(function);
      }
    }
  }*/
}

void l22::type_checker::do_identity_node(l22::identity_node * const node, int lvl) {
  ASSERT_UNSPEC;
  node->argument()->accept(this, lvl);
  if (node->argument()->is_typed(cdk::TYPE_INT) || node->argument()->is_typed(cdk::TYPE_STRING)) {
    node->type(node->argument()->type());
  } else {
    throw std::string("Other expressions expected");
  }
}

void l22::type_checker::do_nullptr_node(l22::nullptr_node *const node, int lvl) {
  ASSERT_UNSPEC;
  node->type(cdk::reference_type::create(4, nullptr));
}