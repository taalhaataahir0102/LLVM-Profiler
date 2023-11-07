#include "llvm/Transforms/Utils/NewAlloca.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"

using namespace llvm;



Value *getBasePointer(Value *Ptr) {
  while (true) {
    if (AllocaInst *AI = dyn_cast<AllocaInst>(Ptr)) {                          // Checking if alloca inst
      return AI;
    } else if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(Ptr)) {    // Checking if gep
      Ptr = GEP->getPointerOperand();                                          // update ptr to operand of gep
    } else {
      return nullptr;
    }
  }
  return nullptr;
}


PreservedAnalyses NewAllocaPass::run(Module &M, ModuleAnalysisManager &AM) {
  errs() << "Alloca:\n";

  for (Function &F : M) {                                                    // Looping over the functions inside the module
    int stores_with_alloca = 0;
    int stores_without_alloca = 0;
    int loads_with_alloca = 0;
    int loads_without_alloca = 0;
    for (auto Inst = inst_begin(F), IE = inst_end(F); Inst != IE; ++Inst) {  // looping over instructions
      if (LoadInst *LI = dyn_cast<LoadInst>(&*Inst)) {                       // Check if the instruction is a load
        Value *PtrOperand = LI->getPointerOperand();                         // getting the operand of load
        Value *BasePointer = getBasePointer(PtrOperand);
        if (BasePointer) {                                                   // Check if BasePointer is not null
          if (dyn_cast<AllocaInst>(BasePointer)) {                           // If base pointer is alloca
            // errs() << "load instruction with alloca: " << *LI << "\n";
            loads_with_alloca+=1;
          } else {                                                           // If base pointer is not alloca
            // errs() << "load instruction without alloca: " << *LI << "\n";
            loads_without_alloca+=1;
          }
        } else {                                                             // If base pointer is null
          // errs() << "load instruction without alloca: " << *LI << "\n";
          loads_without_alloca+=1;
        }
      }

      // Same for store as we did for load
      if (StoreInst *SI = dyn_cast<StoreInst>(&*Inst)) {
        Value *PtrOperand = SI->getPointerOperand();
        Value *BasePointer = getBasePointer(PtrOperand);
        if (BasePointer) {
          if (dyn_cast<AllocaInst>(BasePointer)) {
            // errs() << "store instruction with alloca: " << *SI << "\n";
            stores_with_alloca+=1;
          } else {
            // errs() << "store instruction without alloca: " << *SI << "\n";
            stores_without_alloca+=1;
          }
        } else {
          // errs() << "store instruction without alloca: " << *SI << "\n";
          stores_without_alloca+=1;
        }
      }
    }
    errs() << "Function: " <<F.getName() << "\n";
    errs() << "stores_with_alloca: " <<stores_with_alloca << "\n";
    errs() << "stores_without_alloca: " <<stores_without_alloca << "\n";
    errs() << "loads_with_alloca: " <<loads_with_alloca << "\n";
    errs() << "loads_without_alloca: " <<loads_without_alloca << "\n";
  }

  return PreservedAnalyses::all();
}