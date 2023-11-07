#include "llvm/Transforms/Utils/NewMetadata.h"
#include "llvm/Support/CommandLine.h"

#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"

using namespace llvm;


PreservedAnalyses NewMetadataPass::run(Module &M, ModuleAnalysisManager &AM) {
    // LLVMContext &C = M.getContext();
    for (Function &F : M) {
        errs() <<  F.getName() << " New metadata\n";
        for (auto Inst = inst_begin(F), IE = inst_end(F); Inst != IE; ++Inst) {
            if (LoadInst *AI = dyn_cast<LoadInst>(&*Inst)) {                          // Check if instruction is Load
                LLVMContext& C = Inst->getContext();
                MDNode* N = MDNode::get(C, MDString::get(C, "hello"));                  // Create metadata node
                AI->setMetadata("hi", N);                                            // Set instruction metadata
                errs() << "Load Instruction: " << *AI << "\n";
            }
        }
    }
    return PreservedAnalyses::all();
}