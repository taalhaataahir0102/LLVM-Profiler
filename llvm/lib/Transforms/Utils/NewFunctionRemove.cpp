#include "llvm/Transforms/Utils/NewFunctionRemove.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"

#include <string>
#include <vector>
#include <fstream>

using namespace llvm;

PreservedAnalyses NewFunctionRemovePass::run(Module &M, ModuleAnalysisManager &AM) {
    std::vector<std::string> functionNames; // Vector to store function names

    // Read function names from the text file
    std::ifstream file("txt.txt");
    if (file.is_open()) {
        std::string line;
        while (std::getline(file, line)) {
            functionNames.push_back(line);
        }
        file.close();
    } else {
        errs() << "Unable to open txt.txt\n";
        return PreservedAnalyses::all();
    }

    // Collect the functions to remove
    std::vector<Function *> functionsToRemove;

    for (Function &F : M) {
        bool keepFunction = false;
        for (BasicBlock &BB : F) {
            for (Instruction &I : BB) {
                if (CallInst *Call = dyn_cast<CallInst>(&I)) {
                    Function *Callee = Call->getCalledFunction();
                    errs() << "Function called: " << Callee->getName() << "\n";

                    // Check if the called function's name is in the vector
                    if (std::find(functionNames.begin(), functionNames.end(), Callee->getName()) != functionNames.end()) {
                        keepFunction = true;
                        break; // If any matching call is found, no need to check further
                    }
                }
            }
            if (keepFunction) {
                break; // No need to check further if any matching call is found
            }
        }

        if (!keepFunction) {
            functionsToRemove.push_back(&F);
        }
    }

    // Remove the functions that are not used
    for (Function *F : functionsToRemove) {
        if (!F->isDeclaration()) {
            errs() << "Removed function: " << F->getName() << "\n";
            F->eraseFromParent();
        }
    }

    return PreservedAnalyses::all();
}
