#ifndef LLVM_TRANSFORMS_NEWProfiler_H
#define LLVM_TRANSFORMS_NEWProfiler_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewProfilerPass : public PassInfoMixin<NewProfilerPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NEWProfiler_H