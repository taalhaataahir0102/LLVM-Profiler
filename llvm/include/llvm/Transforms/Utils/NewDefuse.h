#ifndef LLVM_TRANSFORMS_NewDefuse_H
#define LLVM_TRANSFORMS_NewDefuse_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewDefusePass : public PassInfoMixin<NewDefusePass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewDefuse_H