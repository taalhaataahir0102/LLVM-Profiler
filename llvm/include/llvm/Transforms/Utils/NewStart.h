#ifndef LLVM_TRANSFORMS_NewStart_H
#define LLVM_TRANSFORMS_NewStart_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewStartPass : public PassInfoMixin<NewStartPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewStart_H