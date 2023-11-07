#ifndef LLVM_TRANSFORMS_NEWFunctionCounter_H
#define LLVM_TRANSFORMS_NEWFunctionCounter_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewFunctionCounterPass : public PassInfoMixin<NewFunctionCounterPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NEWFunctionCounter_H