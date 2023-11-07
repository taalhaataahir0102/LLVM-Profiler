#ifndef LLVM_TRANSFORMS_NewAdd_H
#define LLVM_TRANSFORMS_NewAdd_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewAddPass : public PassInfoMixin<NewAddPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewAdd_H
