#include "llvm/Transforms/Utils/NewFunctionFrequency.h"
#include "llvm/IR/InstIterator.h"
#include <map>
#include "llvm/Support/CommandLine.h"
#include <string>
#include <sstream>
#include <vector>

using namespace llvm;


// Defining the 
static cl::opt<std::string> MyFunc("func-name",                                                      // command line arg
                                   cl::desc("Specify the function name to analyze (default: main)"), // description
                                   cl::value_desc("function_name"),
                                   cl::init("main"),                                                 // Default value
                                   cl::CommaSeparated,                                               // ; functionality
                                   cl::Optional);                                                    // optional argument

PreservedAnalyses NewFunctionFrequencyPass::run(Module &M, ModuleAnalysisManager &AM) {
  std::string funcNamesStr = MyFunc;                                             // Input by th user
  std::vector<std::string> funcNames;                                            // Vector to store ; seperated user inputs 

  
    size_t startPos = 0;
    size_t delimPos = funcNamesStr.find(';');                                   // Finding the first semicolon (;)
    while (delimPos != std::string::npos) {
    funcNames.push_back(funcNamesStr.substr(startPos, delimPos - startPos));    // pushing func names inside the vector
    startPos = delimPos + 1;
    delimPos = funcNamesStr.find(';', startPos);
    }
    funcNames.push_back(funcNamesStr.substr(startPos));                         // Add the last function name

   for (const auto &item : funcNames) {
        errs() << "item: "<< item << "\n";                                      // Printing the function names vector
    }

  for (Function &F : M) {
    if (std::find(funcNames.begin(), funcNames.end(), F.getName()) == funcNames.end()) {   // Checking if the function is
                                                                                          // present in the names vector
        // errs() << "Function " << F.getName() << " is not in the list provided\n";
        continue;
    }
    else{
            std::map<llvm::StringRef, int> instFrequency;
            errs() << "Instruction frequency for function: " << F.getName() << "\n";
            for (auto Inst = inst_begin(F), IE = inst_end(F); Inst != IE; ++Inst) {
                llvm::StringRef instName = Inst->getOpcodeName();
                instFrequency[instName]++;
        }
        for (const auto &entry : instFrequency) {
            errs() << "Instruction " << entry.first << " appeared " << entry.second << " times\n";
        }
      }
    }
    return PreservedAnalyses::all();
  }