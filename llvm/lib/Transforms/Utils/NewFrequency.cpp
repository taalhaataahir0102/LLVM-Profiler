#include "llvm/Transforms/Utils/NewFrequency.h"
#include "llvm/IR/InstIterator.h"
#include <cstring>
#include <map>

using namespace llvm;
// cl::opt<>()
PreservedAnalyses NewFrequencyPass::run(Module &M, ModuleAnalysisManager &AM) {
  errs() << "Instruction frequency:\n";

  // Map to store instruction frequency
  std::map<llvm::StringRef, int> instFrequency;              // Like a python dictionary {inst1:count, inst2:count,...}

  for (Function &F : M) {                               // Looping over the functions inside the module
    for (auto Inst = inst_begin(F), IE = inst_end(F); Inst != IE; ++Inst) {  // looping over instructions
      llvm::StringRef instName = Inst->getOpcodeName();                          // Getting instructions opcode
      instFrequency[instName]++;                                             // Increment instruction frequency
    }
  }

  for (const auto &entry : instFrequency) {                                  // Looping over the instruction map
    errs() << "Instruction " << entry.first << " appeared " << entry.second << " times\n";     // Printing instructions
  }

  return PreservedAnalyses::all();
}