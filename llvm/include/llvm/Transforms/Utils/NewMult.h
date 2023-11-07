#ifndef LLVM_TRANSFORMS_NewMult_H
#define LLVM_TRANSFORMS_NewMult_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewMultPass : public PassInfoMixin<NewMultPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewMult_H