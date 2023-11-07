#include "llvm/Transforms/Utils/NewDefuse.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"

using namespace llvm;

PreservedAnalyses NewDefusePass::run(Module &M, ModuleAnalysisManager &AM) {
    for (Function &F : M) {
            for (User *U : F.users()) {
                if (Instruction *Inst = dyn_cast<Instruction>(U)) {
                    errs() << F.getName() <<" is used in instruction: "<< *Inst <<"\n";
                    for (Use &U : Inst->operands()) {
                        Value *v = U.get();
                        errs() << "v: "<< *v << "\n";
                    }
                }
            }
    }

    return PreservedAnalyses::all();
}
