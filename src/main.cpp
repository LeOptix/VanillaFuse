#include <iostream>
#include <llvm/ADT/APFloat.h>
#include <llvm/ADT/STLExtras.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Value.h>
#include "VFuseLexer.h"
#include "VFuseParser.h"

using namespace antlr4;
using namespace llvm;

static LLVMContext TheContext;
static IRBuilder<> Builder(TheContext);
static std::unique_ptr<Module> TheModule;
static std::map<std::string, Value *> NamedValues;

Value *Error(const char *Str) {
  std::cerr << "Error: " << Str << std::endl;
  return nullptr;
}

Value *GenerateCode(tree::ParseTree *node) {
  if (auto elementNode = dynamic_cast<VFuseParser::ElementContext *>(node)) {
    
  } else if (auto attributeNode = dynamic_cast<VFuseParser::AttributeContext *>(node)) {
    
  } else {
    return Error("Unknown node type");
  }
  
  return nullptr;
} 

int main() {
  ANTLRInputStream input("<window title=\"Mi Ventana\">\n"
                         "  <button text=\"Haz clic\" onclick=\"buttonClicked()\" />\n"
                         "</window>\n");
  VFuseLexer lexer(&input);
  CommonTokenStream tokens(&lexer);
  VFuseParser parser(&tokens);

  tree::ParseTree *tree = parser.program();
  
  TheModule = std::make_unique<Module>("my_module", TheContext);
  GenerateCode(tree);

  TheModule->print(outs(), nullptr);
  
  return 0;
}