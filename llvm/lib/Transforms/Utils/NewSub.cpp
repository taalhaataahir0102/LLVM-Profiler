#include "llvm/Transforms/Utils/NewSub.h"
#include "llvm/Transforms/Utils/NewHelloWorld.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"


using namespace llvm;

PreservedAnalyses NewSubPass::run(Module &M, ModuleAnalysisManager &AM) {
    // int here = getAnalysis<NewHelloWorldPass>().runMyAnalysis();
    for (Function &F : M) {
        errs() <<  F.getName() << "\n";
        // Step 1: Collect all add instructions
        std::vector<Instruction *> addInstructions;
        for (auto Inst = inst_begin(F), IE = inst_end(F); Inst != IE; ++Inst) {
            if (BinaryOperator *BinOp = dyn_cast<BinaryOperator>(&*Inst)) {         // Looking for add instructions
                if (BinOp->getOpcode() == Instruction::Add) {
                    errs() << *Inst << "\n";
                    addInstructions.push_back(&*Inst);                              // Adding all the addinstructions to
                                                                                    // a list
                }
            }
        }
        // Step 2: Replace add instructions with sub instructions
        for (Instruction *AddInst : addInstructions) {
            Value *Op1 = AddInst->getOperand(0);
            Value *Op2 = AddInst->getOperand(1);
            errs() << *Op1 << "    " << *Op2 << "\n";
            IRBuilder<> Builder(AddInst);
            Value *SubValue = Builder.CreateSub(Op1, Op2);                         // Creating sub instruction
            AddInst->replaceAllUsesWith(SubValue);
            AddInst->eraseFromParent();
        }
    }
    
    return PreservedAnalyses::all();
}