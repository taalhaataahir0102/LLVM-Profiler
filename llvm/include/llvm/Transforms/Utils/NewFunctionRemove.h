#ifndef LLVM_TRANSFORMS_NEWFunctionRemove_H
#define LLVM_TRANSFORMS_NEWFunctionRemove_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewFunctionRemovePass : public PassInfoMixin<NewFunctionRemovePass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NEWFunctionRemove_H