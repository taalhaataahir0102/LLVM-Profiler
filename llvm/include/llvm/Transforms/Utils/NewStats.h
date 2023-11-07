#ifndef LLVM_TRANSFORMS_NewStats_H
#define LLVM_TRANSFORMS_NewStats_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewStatsPass : public PassInfoMixin<NewStatsPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewStats_H
