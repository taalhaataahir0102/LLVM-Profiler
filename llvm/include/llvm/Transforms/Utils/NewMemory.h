#ifndef LLVM_TRANSFORMS_NewMemory_H
#define LLVM_TRANSFORMS_NewMemory_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewMemoryPass : public PassInfoMixin<NewMemoryPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewMemory_H