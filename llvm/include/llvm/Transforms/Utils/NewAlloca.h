#ifndef LLVM_TRANSFORMS_NewAlloca_H
#define LLVM_TRANSFORMS_NewAlloca_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewAllocaPass : public PassInfoMixin<NewAllocaPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewAlloca_H