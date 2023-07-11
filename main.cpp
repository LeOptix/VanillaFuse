#include <iostream>
#include <llvm/ADT/APFloat.h>
#include <llvm/ADT/STLExtras.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Value.h>

using namespace llvm;

grammar VFuse;

OPEN_BRACKET : '<';
CLOSE_BRACKET : '>';
SLASH : '/';
EQUALS : '=';
STRING : '"' ~["<"]* '"';
IDENTIFIER : [a-zA-Z]+;