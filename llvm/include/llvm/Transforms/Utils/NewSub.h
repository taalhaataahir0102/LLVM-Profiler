#ifndef LLVM_TRANSFORMS_NewSub_H
#define LLVM_TRANSFORMS_NewSub_H

#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"

namespace llvm {

class NewSubPass : public PassInfoMixin<NewSubPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewSub_H