#include "llvm/Transforms/Utils/NewSimpleloop.h"
#include "llvm/Transforms/Utils/CanonicalizeFreezeInLoops.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Analysis/IVDescriptors.h"
#include "llvm/Analysis/LoopAnalysisManager.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/IR/Dominators.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/Utils.h"
#include <vector>
#include <algorithm>
#include <map>

using namespace llvm;

PreservedAnalyses NewSimpleloopPass::run(Loop &L, LoopAnalysisManager &AM,
                                         LoopStandardAnalysisResults &AR,
                                         LPMUpdater &U) {

    errs() << "============================" << "\n";

    std::vector<Value*> operandsvector;               // Vector for storing operands pointer
    std::vector<StoreInst*> instructionsvector;       // Vector for storing store instructions pointer

    // Iterate over all blocks in the loop
    for (BasicBlock *BB : L.blocks()) {
        for (Instruction &I : *BB) {
            // Check if it's a store instruction
            if (StoreInst *Store = dyn_cast<StoreInst>(&I)) {
                Value *StoredValue = Store->getValueOperand();
                // Check if it's storing a constant value
                if (ConstantInt *CI = dyn_cast<ConstantInt>(StoredValue)) {
                    Value *StrAddr = Store->getPointerOperand();
                    operandsvector.push_back(StrAddr);
                    instructionsvector.push_back(Store);
                }
            }
        }
    }

    // Print the collected operands and instructions
    errs() << "Variables assigned constant values (without duplicates):\n";
    for (const auto &entry : operandsvector) {
        errs() << "Value pointer of store: " << entry << "\n";
    }
    for (const auto &entry : instructionsvector) {
        errs() << "Value pointer of Instruction: " << *entry << "\n";
    }

    std::vector<size_t> indicesToRemove;

    // track the indices of operand vector which will be removed as a result of duplicate
    for (size_t i = 0; i < operandsvector.size(); ++i) {
        const Value *VarName = operandsvector[i];
        if (std::count(operandsvector.begin(), operandsvector.end(), VarName) > 1) {
            indicesToRemove.push_back(i);
        }
    }

    // Erase elements from both operandsvector and instructionsvector using indices
    for (int i = indicesToRemove.size() - 1; i >= 0; --i) {
        size_t indexToRemove = indicesToRemove[i];
        operandsvector.erase(operandsvector.begin() + indexToRemove);
        instructionsvector.erase(instructionsvector.begin() + indexToRemove);
    }

    // Print the collected unique instructions and operands
    errs() << "Variables assigned constant values (without duplicates):\n";
    for (const auto &entry : operandsvector) {
        errs() << "Value pointer of store: " << entry << "\n";
    }
    for (const auto &entry : instructionsvector) {
        errs() << "Value pointer of Instruction: " << *entry << "\n";
    }


    // Bringing store instructions out of the loop
    errs() << "============================" << "\n";
    BasicBlock *Header = L.getHeader();

    // Move the collected store instructions outside the loop
    for (StoreInst *Store : instructionsvector) {
        errs() << "Constant value assignment: " << *Store << "\n";
        Store->moveBefore(Header->getParent()->getEntryBlock().getTerminator());
        // MovedStoreInstructions.insert(Store);
    }

    return PreservedAnalyses::all();
}