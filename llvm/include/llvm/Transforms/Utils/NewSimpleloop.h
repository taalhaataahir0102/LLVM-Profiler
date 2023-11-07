#ifndef LLVM_TRANSFORMS_NewSimpleloop_H
#define LLVM_TRANSFORMS_NewSimpleloop_H

#include "llvm/IR/PassManager.h"
#include "llvm/Analysis/LoopAnalysisManager.h"

namespace llvm {

class Loop;
class LPMUpdater;

class NewSimpleloopPass : public PassInfoMixin<NewSimpleloopPass> {
public:
  PreservedAnalyses run(Loop &L, LoopAnalysisManager &AM, LoopStandardAnalysisResults &AR, LPMUpdater &U);
};

} // namespace llvm 

#endif // LLVM_TRANSFORMS_NewSimpleloop_H