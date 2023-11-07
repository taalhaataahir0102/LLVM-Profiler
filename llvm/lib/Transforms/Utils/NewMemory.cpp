#include "llvm/Transforms/Utils/NewMemory.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Support/CommandLine.h"

#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"

#include "llvm/IR/DataLayout.h"

using namespace llvm;


PreservedAnalyses NewMemoryPass::run(Module &M, ModuleAnalysisManager &AM) {
    for (Function &F : M) {
        errs() <<  F.getName() << " New mem\n";
        const DataLayout &DL = F.getParent()->getDataLayout();                        // Get Datalayout
        for (auto Inst = inst_begin(F), IE = inst_end(F); Inst != IE; ++Inst) {
            if (AllocaInst *AI = dyn_cast<AllocaInst>(&*Inst)) {                      // Check if instruction is Alloc
                errs() << "Alloca Instruction: " << *AI << "\n";
                std::optional<TypeSize> AllocSizeOpt = AI->getAllocationSize(DL);     // Get size allocated by alloc
                errs() << "AllocSizeOpt: " << AllocSizeOpt << "\n";
            }
        }
    }
    return PreservedAnalyses::all();
  }