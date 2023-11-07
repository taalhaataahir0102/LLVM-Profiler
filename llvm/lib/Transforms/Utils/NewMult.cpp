#include "llvm/Pass.h"
#include "llvm/IR/Function.h"

#include "llvm/Transforms/Utils/NewMult.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"

using namespace llvm;


const llvm::APInt isOperandConstant(Instruction *I) {
    
    Value *Op0 = I->getOperand(0);                      // operand 1
    Value *Op1 = I->getOperand(1);                      // operand 2

    ConstantInt *ConstOp = nullptr;


    if (isa<ConstantInt>(Op0)) {                        // Check if operand 1 is constant
        ConstOp = dyn_cast<ConstantInt>(Op0);
    }
    else if (isa<ConstantInt>(Op1)) {                   // Check if operand 2 is constant
        ConstOp = dyn_cast<ConstantInt>(Op1);
    }

    if (!ConstOp) {                                     // If both operands are not constant
        return llvm::APInt(32,0);
    }
    return ConstOp->getValue();                         // Return the operand value
}


int constLocation(Instruction *I) {
    // Return 0 if first operand is not constant else 1. This function returns the position of non constant operand
    Value *Op0 = I->getOperand(0);
    if (isa<ConstantInt>(Op0)) {
        return 1;
    }
    else{
        return 0;
    }
}

PreservedAnalyses NewMultPass::run(Module &M, ModuleAnalysisManager &AM) {
    for (Function &F : M) {
        errs() << F.getName() << "\n";
        std::vector<Instruction *> multInstructions;
        for (auto Inst = inst_begin(F), IE = inst_end(F); Inst != IE; ++Inst) {
            if (Inst->getOpcode() == Instruction::Mul) {
                errs() << *Inst << "\n";
                multInstructions.push_back(&*Inst);                         // pushing all mult instructions in a vector
            }
        }

        for (Instruction *multInst : multInstructions) {
            const llvm::APInt constant = isOperandConstant(&*multInst);     // Fetching the constant
            errs() << "constant: " << constant << "\n";

            errs() << constant.isPowerOf2() << "\n";

            if (constant.isPowerOf2()){                                     // Checking if constant is a power of 2
                int location = constLocation(&*multInst);                   // fetching position of non constant operand
                errs() << "location: "<< location << "\n";


                unsigned bitWidth = constant.getBitWidth();

                APInt logValue(bitWidth, constant.logBase2());                     // Taking log of constant operand

                errs() << "logValue: " << logValue << "\n";

                // Create an IRBuilder at the location of the multiply instruction
                IRBuilder<> Builder(&*multInst);
                

                Value *Op0 = multInst->getOperand(location);                        // Fetching non constant operand

                // Create a left shift instruction
                Value *ShiftedValue = Builder.CreateShl(Op0, logValue, "shl");      // Creating new shift left command

                // Replacing the original multiply instruction with the shift instruction
                multInst->replaceAllUsesWith(ShiftedValue);
                multInst->eraseFromParent();                               // Removing the original multiply instruction
            }
        }
    }
    return PreservedAnalyses::all();
}
