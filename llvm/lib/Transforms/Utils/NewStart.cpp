#include "llvm/Transforms/Utils/NewStart.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Value.h"

using namespace llvm;

PreservedAnalyses NewStartPass::run(Module &M, ModuleAnalysisManager &AM) {
    LLVMContext &Context = M.getContext();

    // Creating a prototype for the 'func' function
    FunctionType *FuncType = FunctionType::get(Type::getVoidTy(Context), false);
    Function *FuncDecl = Function::Create(FuncType, Function::ExternalLinkage, "func", &M);

    Function *StartAnalysisFunc = M.getFunction("start_analysis");
    Function *EndAnalysisFunc = M.getFunction("end_analysis");

    bool do_analysis = false;
    if (!StartAnalysisFunc || !EndAnalysisFunc) {
        errs() << "start_analysis() and/or end_analysis() not found. No transformation applied.\n";
        return PreservedAnalyses::all();
    }

    for (Function &F : M) {
        errs() << F.getName() << "\n";

        for (BasicBlock &BB : F) {
            for (Instruction &I : BB) {
                errs() << "Instruction: " << I << "  " << do_analysis << "\n";

                if (CallInst *Call = dyn_cast<CallInst>(&I)) {
                    Function *Callee = Call->getCalledFunction();
                    if(!Callee)
                        continue;
                    if (Callee->getName() == "start_analysis") {
                            do_analysis = true;
                    }
                    if (Callee->getName() == "end_analysis") {
                            do_analysis = false;
                    }

                    if (do_analysis == true){
                        errs() << "Function called: " << Callee->getName() << "\n";

                        if (Callee->getName() == "printf") {
                            errs() << "Yes, it's printf!\n";

                            IRBuilder<> Builder(Call);
                            Builder.CreateCall(FuncDecl);
                        }
                    }
                }
            }
        }
    }

    return PreservedAnalyses::none();
}
