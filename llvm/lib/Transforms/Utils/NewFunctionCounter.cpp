#include "llvm/Transforms/Utils/NewFunctionCounter.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"

#include <string>

using namespace llvm;

PreservedAnalyses NewFunctionCounterPass::run(Module &M, ModuleAnalysisManager &AM) {
    LLVMContext &Context = M.getContext();

    int counter = 1; // Initialize the counter

    for (Function &F : M) {
        // Check if the function has a function implementation
        if (!F.isDeclaration()) {
            errs() << F.getName() << "\n";

            // Generate the function name (e.g., counter1(), counter2(), ...)
            std::string functionName = "counter" + std::to_string(counter++);

            // Create a prototype for the new function
            FunctionType *FuncType = FunctionType::get(Type::getVoidTy(Context), false);
            Function *NewFunc = Function::Create(FuncType, Function::ExternalLinkage, functionName, &M);

            // Create an entry block for each function
            BasicBlock &EntryBlock = F.getEntryBlock();
            Instruction *FirstInst = &*EntryBlock.getFirstInsertionPt();

            // Insert a call to the new function at the start of the entry block
            IRBuilder<> Builder(FirstInst);
            Builder.CreateCall(NewFunc);
        }
    }

    return PreservedAnalyses::all();
}