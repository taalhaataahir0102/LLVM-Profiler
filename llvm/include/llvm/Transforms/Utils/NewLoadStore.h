#ifndef LLVM_TRANSFORMS_NewLoadStore_H
#define LLVM_TRANSFORMS_NewLoadStore_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewLoadStorePass : public PassInfoMixin<NewLoadStorePass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewLoadStore_H
