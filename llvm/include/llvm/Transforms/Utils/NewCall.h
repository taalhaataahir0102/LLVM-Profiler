#ifndef LLVM_TRANSFORMS_NewCall_H
#define LLVM_TRANSFORMS_NewCall_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewCallPass : public PassInfoMixin<NewCallPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewCall_H