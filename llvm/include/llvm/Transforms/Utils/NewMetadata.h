#ifndef LLVM_TRANSFORMS_NewMetadata_H
#define LLVM_TRANSFORMS_NewMetadata_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class NewMetadataPass : public PassInfoMixin<NewMetadataPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_NewMetadata_H