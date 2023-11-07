#include "llvm/Transforms/Utils/NewCall.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"

using namespace llvm;

PreservedAnalyses NewCallPass::run(Module &M, ModuleAnalysisManager &AM) {
    LLVMContext &Context = M.getContext();

    // Creating a prototype for the 'func' function
    FunctionType *FuncType = FunctionType::get(Type::getVoidTy(Context), false);
    Function *FuncDecl = Function::Create(FuncType, Function::ExternalLinkage, "func", &M);

    for (Function &F : M) {
        errs() << F.getName() << "\n";

        for (BasicBlock &BB : F) {
            for (Instruction &I : BB) {
                if (CallInst *Call = dyn_cast<CallInst>(&I)) {
                    Function *Callee = Call->getCalledFunction();
                    errs() << "Function called: " << Callee->getName() << "\n";

                    if (Callee->getName() == "printf") {
                        errs() << "Yes, it's printf!\n";

                        IRBuilder<> Builder(Call);
                        Builder.CreateCall(FuncDecl);
                    }
                }
            }
        }
    }

    return PreservedAnalyses::all();
}
