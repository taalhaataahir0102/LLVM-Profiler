#ifndef LLVM_TRANSFORMS_NewDot_H
#define LLVM_TRANSFORMS_NewDot_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewDotPass : public PassInfoMixin<NewDotPass> {
    public:
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
    };

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewDot_H