#ifndef LLVM_TRANSFORMS_HELLONEW_HELLOWORLD_H
#define LLVM_TRANSFORMS_HELLONEW_HELLOWORLD_H

#include "llvm/IR/PassManager.h"

namespace llvm {
 
class NewHelloWorldPass : public PassInfoMixin<NewHelloWorldPass> {
public:
  // static AnalysisKey Key;
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
  int runMyAnalysis();
};

// class collectInstructions : public PassInfoMixin<collectInstructions> {
// public:
//   static AnalysisKey Key;
//   using Result = std::vector<Instruction*>;
//   Result run(Module &M, ModuleAnalysisManager &AM);
// };


} // namespace llvm

#endif // LLVM_TRANSFORMS_HELLONEW_HELLOWORLD_H
