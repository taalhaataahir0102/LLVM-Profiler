#include "llvm/Transforms/Utils/NewLoadStore.h"

#include "llvm/IR/InstIterator.h"                                                                            // using inst_begin() and inst_end from here

#include "llvm/IR/Instructions.h"

#include <cstring>

using namespace llvm;
PreservedAnalyses NewLoadStorePass::run(Function &F,
                                      FunctionAnalysisManager &AM) {
//   errs() << "load store\n";
  int loadCount = 0;                                                                                          // load instruction counter
  
  int storeCount = 0;                                                                                         // Store instruction counter
                                        
//   errs() << "from new function name " << F.getName() << "\n";                                                 // print function name
                                      
  	for (auto Inst_begin = inst_begin(F), IE = inst_end(F); Inst_begin != IE; ++Inst_begin) {             // iterrate over instructions
  	
  		// errs() << "from new instruction " << Inst_begin->getOpcodeName() << "\n";                     // print instruction opcode name
  		
  		//if (Inst_begin->getOpcode() == Instruction::Load) {
  		                                           // Checking if instruction is load 
  		//LoadInst *LI1 = dyn_cast<LoadInst>(&*Inst_begin);
  		//errs() << "Load: " << *LI1 << "\n";
        	if (LoadInst *LI = dyn_cast<LoadInst>(&*Inst_begin)) { 	
        		// errs() << "Load: " << *LI << "\n";
        		loadCount++;                                                                          // Incrementing load counter
      		}
      		
  		//if (Inst_begin->getOpcode() == Instruction::Store) {                                          // Checking if instruction is store 
        	if (dyn_cast<StoreInst>(&*Inst_begin)) { 	
        		storeCount++;                                                                         // Incrementing store counter
      		}
  	}
  errs() << "Total load instructions in funtion " << F.getName() << ": " << loadCount << " \n";                                // Printing result
  errs() << "Total store instructions in funtion " << F.getName() << ": " << storeCount << " \n";
  return PreservedAnalyses::all();
}
