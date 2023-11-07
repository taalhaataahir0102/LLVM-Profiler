#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Transforms/Utils/NewDot.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"
#include <map>
#include <vector>
#include <fstream>
#include <sstream>

using namespace llvm;

PreservedAnalyses NewDotPass::run(Module &M, ModuleAnalysisManager &AM) {
    // Creating a map to store the basic blocks and their successors
    std::map<BasicBlock *, std::vector<BasicBlock *>> BBSuccessors;

    // Creating a map to store basic block addresses and their instructions
    std::map<BasicBlock *, std::vector<Instruction *>> BBInstructions;

    for (Function &F : M) {
        if (!F.isDeclaration()) {
            errs() << F.getName() << "\n";
            for (BasicBlock &BB : F) {
                // Creating a vector to store the successors of the current basic block
                std::vector<BasicBlock *> Successors;

                for (BasicBlock *Succ : successors(&BB)) {
                    // Adding the successor to the vector
                    Successors.push_back(Succ);
                }

                // Storing the vector of successors in the map
                BBSuccessors[&BB] = Successors;

                // Creating a vector to store instructions inside the basic block
                std::vector<Instruction *> BBInstList;

                for (Instruction &I : BB) {
                    // Adding the instruction to the vector
                    BBInstList.push_back(&I);
                }

                // Storing the vector of instructions in the map
                BBInstructions[&BB] = BBInstList;
            }
        }
    }

    // Opening a new text file for writing
    std::ofstream outFile("new.dot");

    if (!outFile) {
        errs() << "Error opening file for writing.\n";
        return PreservedAnalyses::all(); // Return if the file couldn't open
    }

    // Writing the DOT header
    outFile << "digraph G {\n";

    // Iterating over the map of basic block relationships and writing to the file
    for (const auto &entry : BBSuccessors) {
        BasicBlock *BB = entry.first;
        const std::vector<BasicBlock *> &Successors = entry.second;
        for (BasicBlock *Succ : Successors) {
            outFile << "N" << BB << " -> " << "N" << Succ << ";\n";
        }
    }

    // Iterating over the map of basic block addresses and their instructions
    for (const auto &entry : BBInstructions) {
        BasicBlock *BBAddr = entry.first;
        const std::vector<Instruction *> &Instructions = entry.second;

        outFile << "N" << BBAddr << " [shape=record,label=\"{";

        // Converting the basic block name to a C++ string
        outFile << BBAddr->getName().str() << " :| ";

        // Write the instructions
        for (Instruction *I : Instructions) {
            std::string InstText;
            raw_string_ostream InstStream(InstText);
            I->print(InstStream);
            outFile << InstStream.str();
            outFile << "\\l"; // Insert a newline after each instruction
        }

        // Closing the record and label
        outFile << "}\"];\n";
    }

    // Writing the DOT footer
    outFile << "}\n";

    // Closing the file
    outFile.close();

    return PreservedAnalyses::all();
}
