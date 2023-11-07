#include "llvm/Transforms/Utils/NewHelloWorld.h"
using namespace llvm;

// AnalysisKey collectInstructions::Key;

// collectInstructions::Result collectInstructions::run(Module &M, ModuleAnalysisManager &AM) {
//   std::vector<Instruction*> instructions;
//   for (Function &F : M) {
//     for (auto &BB : F) {
//       for (auto Inst = BB.begin(), IE = BB.end(); Inst != IE; ++Inst) {
//         instructions.push_back(&*Inst);
//       }
//     }
//   }
//   return instructions;
// }

// AnalysisKey NewHelloWorldPass::Key; 


int NewHelloWorldPass::runMyAnalysis(){
  return 1;
}


PreservedAnalyses NewHelloWorldPass::run(Module &M, ModuleAnalysisManager &AM) {
  // std::vector<Instruction*> instructions = AM.getResult<collectInstructions>(M);
  
  errs() << "====================================================\n";                                  
  for (Function &F : M) {
    errs() << "from new function name " << F.getName() << "\n";                         // print function name
                                        
    for (auto &BB : F) {                                                                // iterate over basic block
    
      errs() << "from new basic block " << BB.getName() <<"\n";                     // print basic block tag
      
      for (auto Inst = BB.begin(), IE = BB.end(); Inst != IE; ++Inst) {             // iterrate over instructions
      
        errs() << "from new instruction " << *Inst << "\n";     // print instruction
      }
    }
  }
  errs() << "====================================================\n";
  return PreservedAnalyses::all();
}
