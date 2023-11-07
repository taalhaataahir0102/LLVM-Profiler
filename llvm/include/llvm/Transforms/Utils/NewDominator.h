#ifndef LLVM_TRANSFORMS_NewDominator_H
#define LLVM_TRANSFORMS_NewDominator_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewDominatorPass : public PassInfoMixin<NewDominatorPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewDominator_H