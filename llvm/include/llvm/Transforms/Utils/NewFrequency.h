#ifndef LLVM_TRANSFORMS_NEWFrequency_H
#define LLVM_TRANSFORMS_NEWFrequency_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewFrequencyPass : public PassInfoMixin<NewFrequencyPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NEWFrequency_H