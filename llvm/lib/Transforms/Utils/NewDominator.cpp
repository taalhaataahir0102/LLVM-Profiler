#include "llvm/Transforms/Utils/NewDominator.h"
#include "llvm/Support/CommandLine.h"

#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Dominators.h"

using namespace llvm;


PreservedAnalyses NewDominatorPass::run(Module &M, ModuleAnalysisManager &AM) {
    for (Function &F : M) {
        DominatorTree DT = DominatorTree(F);                               // Fetch the Dominator Tree
        errs() <<  F.getName() << " New Dominator\n";
        for (BasicBlock &BB : F) {
            errs() << "basic block " << BB.getName() << " dominates: ";

            for (BasicBlock &OtherBB : F) {                                // Iterate through basic blocks again
                if (&BB == &OtherBB) {                                     // Skip the same block
                    continue;
                }
                if (DT.dominates(&BB, &OtherBB)) {                         // check if BB dominates OtherBB
                    errs() << OtherBB.getName() << " ";
                }
            }
            errs() << "\n";
        }
    }

//==================================================================================================================
    
//==================================================================================================================

    return PreservedAnalyses::all();
}