#ifndef LLVM_TRANSFORMS_NEWFunctionFrequency_H
#define LLVM_TRANSFORMS_NEWFunctionFrequency_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewFunctionFrequencyPass : public PassInfoMixin<NewFunctionFrequencyPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NEWFunctionFrequency_H