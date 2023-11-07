#include "llvm/Transforms/Utils/NewAdd.h"

#include "llvm/ADT/Statistic.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/IR/InstIterator.h"

using namespace llvm;


bool runOnBasicBlock(BasicBlock &BB) {
    errs() << "chal rha he\n";
    bool Changed = false;

    for (auto Inst = BB.begin(), IE = BB.end(); Inst != IE; ++Inst) {
    auto *BinOp = dyn_cast<BinaryOperator>(Inst);
    if (!BinOp){
      errs() << "!BinOp\n";
      continue;
    }

    if (BinOp->getOpcode() != Instruction::Add){
      errs() << "!Add\n";
      continue;
    }

    if (!BinOp->getType()->isIntegerTy()){ 
    // ||
    //     !(BinOp->getType()->getIntegerBitWidth() == 8)){
          errs() << "! 8 bit integer\n";
          continue;
        }
    errs() << "All conditions are okay :)\n";
    errs() << *Inst << "\n";    
    IRBuilder<> Builder(BinOp);

    // Constants used in building the instruction for substitution
    auto Val39 = ConstantInt::get(BinOp->getType(), 39);
    auto Val151 = ConstantInt::get(BinOp->getType(), 151);
    auto Val23 = ConstantInt::get(BinOp->getType(), 23);
    auto Val2 = ConstantInt::get(BinOp->getType(), 2);
    auto Val111 = ConstantInt::get(BinOp->getType(), 111);

    // Build an instruction representing `(((a ^ b) + 2 * (a & b)) * 39 + 23) *
    // 151 + 111`
    Instruction *NewInst =
        // E = e5 + 111
        BinaryOperator::CreateAdd(
            Val111,
            // e5 = e4 * 151
            Builder.CreateMul(
                Val151,
                // e4 = e2 + 23
                Builder.CreateAdd(
                    Val23,
                    // e3 = e2 * 39
                    Builder.CreateMul(
                        Val39,
                        // e2 = e0 + e1
                        Builder.CreateAdd(
                            // e0 = a ^ b
                            Builder.CreateXor(BinOp->getOperand(0),
                                              BinOp->getOperand(1)),
                            // e1 = 2 * (a & b)
                            Builder.CreateMul(
                                Val2, Builder.CreateAnd(BinOp->getOperand(0),
                                                        BinOp->getOperand(1))))
                    ) // e3 = e2 * 39
                ) // e4 = e2 + 23
            ) // e5 = e4 * 151
        ); // E = e5 + 111

    // Instruction *n = BinaryOperator::CreateMul(BinOp->getOperand(0), BinOp->getOperand(1));

    // The following is visible only if you pass -debug on the command line
    // *and* you have an assert build.
    // LLVM_DEBUG(dbgs() << *BinOp << " -> " << *NewInst << "\n");

    // Replace `(a + b)` (original instructions) with `(((a ^ b) + 2 * (a & b))
    // * 39 + 23) * 151 + 111` (the new instruction)
    ReplaceInstWithInst(&BB, Inst, NewInst);
    Changed = true;

    }
     return Changed;

}

PreservedAnalyses NewAddPass::run(llvm::Function &F,
                              llvm::FunctionAnalysisManager &) {
  bool Changed = false;

  for (auto &BB : F) {
    Changed |= runOnBasicBlock(BB);
  }
  return (Changed ? llvm::PreservedAnalyses::none()
                  : llvm::PreservedAnalyses::all());
}