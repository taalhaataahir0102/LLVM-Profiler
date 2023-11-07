#include "llvm/Transforms/Utils/NewStats.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include <cstring>
#include "llvm/ADT/Statistic.h"
#define DEBUG_TYPE "NewStatsPass"
using namespace llvm;


STATISTIC(TotalLoadCount, "The # of load instructions");
STATISTIC(TotalStoreCount, "The # of store instructions");

PreservedAnalyses NewStatsPass::run(Function &F,
                                    FunctionAnalysisManager &AM) {
    int l = 0;

    for (auto Inst_begin = inst_begin(F), IE = inst_end(F); Inst_begin != IE; ++Inst_begin) {
        if (isa<LoadInst>(&*Inst_begin)) {
            ++TotalLoadCount;
            ++l;
        }

        if (isa<StoreInst>(&*Inst_begin)) {
            ++TotalStoreCount;
        }
    }
    //errs() << "l: "<< l << "\n";

    //errs() << "Total load instructions in function " << F.getName() << ": " << TotalLoadCount << " \n";
    //errs() << "Total store instructions in function " << F.getName() << ": " << TotalStoreCount << " \n";
    return PreservedAnalyses::all();
}
