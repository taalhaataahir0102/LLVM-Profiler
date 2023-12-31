#include "llvm/Transforms/Utils/NewProfiler.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/CommandLine.h"
#include <string>
#include <vector>
#include <map>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstrTypes.h"

using namespace llvm;

std::vector<std::string> atomicCounter;

static cl::opt<std::string> MyFunc("functionality",                                          // command line arg
                               cl::desc("Specify the functionality you want to use"),    // description
                               cl::value_desc("function_name"),
                               cl::init("main"),                                         // Default value
                               cl::Optional);


void initialize_clocks(Module &M) {
    Function *clockFunc = M.getFunction("clock");          // Getting pointer to the clock function
    // Check if clock is not present inside the module
    if (!clockFunc) {
        // Declare clock function if it's not found
        FunctionType *clockType = FunctionType::get(
            IntegerType::getInt64Ty(M.getContext()),       // clock returns a 64-bit integer
            std::vector<Type *>(), false);

        // Use ExternalLinkage for clock
        clockFunc = Function::Create(
            clockType,
            Function::ExternalLinkage,
            "clock",
            &M);
    }

    for (Function &F : M) {
        // Check if the function has a declaration in the moduele
        if (!F.isDeclaration()) {
            // Push the function name in the vector. We only profile those functions which are declared in the module.
            std::string counterName = "clocks_by_" + F.getName().str() + ".glob";
            atomicCounter.push_back(counterName);
        }
    }

    IntegerType *I64Ty = Type::getInt64Ty(M.getContext()); // initializing a 64 bit integer

    for (const std::string &name : atomicCounter) {
        errs() << name << "\n";
        // Creating global counters of integer type, initialized with 0, based on the names we created in the vector above
        new GlobalVariable(M, I64Ty, false, GlobalValue::CommonLinkage, 
                           ConstantInt::get(I64Ty, 0), name);
    }
    return;
}

void initialize_counters(Module &M) {

    // Pushing basic counters in a vector
    atomicCounter.push_back("num_inst.glob");
    atomicCounter.push_back("num_bb.glob");
    atomicCounter.push_back("num_mult.glob");
    atomicCounter.push_back("num_branch.glob");
    atomicCounter.push_back("num_mem.glob");
    for (Function &F : M) {
        // Check if the function has a declaration in the moduele
        if (!F.isDeclaration()) {
            // Push the function name in the vector. We only profile those functions which are declared in the module.
            atomicCounter.push_back(F.getName().str() + ".glob");
        }
    }

    IntegerType *I64Ty = Type::getInt64Ty(M.getContext()); // initializing a 64 bit integer

    for (const std::string &name : atomicCounter) {
        errs() << name << "\n";
        // Creating global counters of integer type, initialized with 0, based on the names we created in the vector above
        new GlobalVariable(M, I64Ty, false, GlobalValue::CommonLinkage, 
                           ConstantInt::get(I64Ty, 0), name);
    }
    return;
}

 
void finalize(Module &M) {

    Function *printfFunc = M.getFunction("printf");         // Getting pointer to the printf function
    // Check if printf is not present inside the module
    if (!printfFunc) {
        // Declaring printf function if it's not found
        FunctionType *printfType = FunctionType::get(
            IntegerType::getInt32Ty(M.getContext()),
            PointerType::get(IntegerType::getInt8Ty(M.getContext()), 0), true);
        
        // Using ExternalLinkage for printf
        printfFunc = Function::Create(
            printfType,
            Function::ExternalLinkage,
            "printf",
            &M);
        // return;
    }

    Type *I64Ty = Type::getInt64Ty(M.getContext());                     // pointer to 64 bit integr type

    for (Function &F : M) {
        if (F.getName() == "main") {                                    // Checking if main function is found
            for (auto &BB : F) {
                for (auto &I : BB) {
                    if (ReturnInst *RI = dyn_cast<ReturnInst>(&I)) {    // Checking the return statement in main function
                        IRBuilder<> Builder(RI);

                        for (const std::string &name : atomicCounter) {  // Looping over the global variables
                            
                            // Getting the pointer to the global variable
                            GlobalVariable *GV = M.getGlobalVariable(name);
                            if (!GV)
                                continue;

                            // Creating load instrcution before printing the global variable 
                            Value *Counter = Builder.CreateLoad(I64Ty, GV);

                            // Creating printf for the global variable
                            Value *PrintfArgs[] = {
                                Builder.CreateGlobalStringPtr((name + ": %ld\n").c_str()),
                                Counter
                            };
                            Builder.CreateCall(printfFunc, PrintfArgs);
                        }
                        return;
                    }
                }
            }
        }
    }
}

void createAtomicAddInstruction(BasicBlock &BB, GlobalVariable *GV, unsigned int adder) {
    LLVMContext &Context = BB.getContext();
    IRBuilder<> Builder(&*BB.getFirstInsertionPt());        // Adding the instruction at the begining of basic block

    // Creating a pointer to 64 bit integer whose value is initialized with 'adder'
    Value *One = ConstantInt::get(Type::getInt64Ty(Context), adder);

    // Getting the data layout for the basic block, Data layout contains info about sizes and alignments
    const DataLayout &DL = BB.getModule()->getDataLayout();
    MaybeAlign Align = DL.getABITypeAlign(One->getType());  // Use alignment from DataLayout

    AtomicRMWInst *AtomicAdd = Builder.CreateAtomicRMW(     // Creating the atomic add instruction
        AtomicRMWInst::Add, GV, One, Align,
        AtomicOrdering::SequentiallyConsistent,
        SyncScope::System);
}


void CounterAdder(Module &M){
    // Getting pointers to global variables

    GlobalVariable *GVI = M.getGlobalVariable("num_inst.glob");
    GlobalVariable *GVB = M.getGlobalVariable("num_bb.glob");
    GlobalVariable *GVM = M.getGlobalVariable("num_mult.glob");
    GlobalVariable *GVBR = M.getGlobalVariable("num_branch.glob");
    GlobalVariable *GVMEM = M.getGlobalVariable("num_mem.glob");

    for (Function &F : M) {
        for (BasicBlock &BB : F) {
            // Creating counters for fields which we are going to report.
            unsigned int totalMem = 0;
            unsigned int totalMult = 0;
            unsigned int totalBranch = 0;
            // creating function counters map which will store the counter of each function called.
            // The map looks like this => Name of the functon:count
            std::map<std::string, unsigned int> functionCounters;
            for (Function &F : M) {
                if (!F.isDeclaration()){
                    std::string counterName = F.getName().str() + ".glob";
                    functionCounters[counterName] = 0;
                }
            }

            unsigned int instructionCount = 0;
            for (auto &I : BB) {
                if (!I.hasMetadata("Talha")) {
                    instructionCount++;                             // Incrementing Instruction count 
                }
            }
            unsigned int adder = 1;                                 // adder for rest of the counters

            createAtomicAddInstruction(BB, GVI, instructionCount);  // Incrementing instruction counter
            createAtomicAddInstruction(BB, GVB, adder);             // Incrementaing basic block counter

            for (auto Inst = BB.begin(), IE = BB.end(); Inst != IE; ++Inst) {
                if (BinaryOperator *BO = dyn_cast<BinaryOperator>(Inst)) {
                    if (BO->getOpcode() == Instruction::Mul) {
                        MDNode *TalhaMD = BO->getMetadata("Talha");
                        if (!TalhaMD){
                            totalMult++;                            // Incrementing Mult counter
                        }
                    }
                }
                if (BranchInst *BI = dyn_cast<BranchInst>(Inst)) {
                    totalBranch++;                                  // Incrementing branch counter
                }
                if (LoadInst *LI = dyn_cast<LoadInst>(Inst)) {
                    MDNode *TalhaMD = LI->getMetadata("Talha");
                    if (!TalhaMD) {
                        totalMem++;                                 // Incrementing Memory counter
                    }
                }
                if (StoreInst *SI = dyn_cast<StoreInst>(Inst)) {
                    MDNode *TalhaMD = SI->getMetadata("Talha");
                    if (!TalhaMD) {
                        totalMem++;                                 // Incrementing Memory counter
                    }
                }
                if (CallBase *CB = dyn_cast<CallBase>(Inst)) {
                    MDNode *TalhaMD = CB->getMetadata("Talha");
                    if (TalhaMD)
                        continue;
                    Function *Callee = CB->getCalledFunction();
                    if (Callee) {
                        // Creating the counter name from function name
                        std::string counterName = Callee->getName().str() + ".glob";

                        // Increment the counter in the map
                        if (functionCounters.find(counterName) != functionCounters.end()) {
                            functionCounters[counterName] += adder; // Increment the function counter
                        }
                    }
                }
            }
            createAtomicAddInstruction(BB, GVMEM, totalMem);               // Creating Memory count atomic addition
            createAtomicAddInstruction(BB, GVM, totalMult);                // Creating Multiply count atomic addition
            createAtomicAddInstruction(BB, GVBR, totalBranch);              // Creating Branch count atomic addition

            for (const auto &counterPair : functionCounters) {
                const std::string &counterName = counterPair.first;
                unsigned int count = counterPair.second;

                // Check if the count is non-zero
                if (count > 0) {
                    // Get the corresponding global variable
                    GlobalVariable *GVF = M.getGlobalVariable(counterName);
                    if (GVF) {
                        createAtomicAddInstruction(BB, GVF, count);         // Creating fuction count atomic counter
                    }
                }
            }
        }
    }
}

// void self(Module &M){

//     Function *clockFunc = M.getFunction("clock");

//     LLVMContext &Context = M.getContext();
//     MDNode *TalhaMD = MDNode::get(Context, MDString::get(Context, "Talha"));

//     IntegerType *I64Ty = Type::getInt64Ty(Context); // 64-bit integer type


//     for (Function &F : M) {
//         if (F.isDeclaration())
//             continue;
        
//         CallInst *StartClock = nullptr;
//         CallInst *EndClock = nullptr;

//         std::string counterName = "clocks_by_" + F.getName().str() + ".glob";
//         GlobalVariable *GV = M.getGlobalVariable(counterName);

//         for (auto Inst = inst_begin(F), IE = inst_end(F); Inst != IE; ++Inst) {

//             if (&*Inst == &*F.getEntryBlock().getFirstInsertionPt()) {
//                 BasicBlock &EntryBB = F.getEntryBlock();
//                 IRBuilder<> EntryBuilder(&*EntryBB.getFirstInsertionPt());
//                 StartClock = CallInst::Create(clockFunc, "", &*EntryBB.getFirstInsertionPt());
//                 StartClock->setMetadata("Start", TalhaMD);

//                 errs() << "Start clock of " << F.getName() << ":   ";
//                 StartClock->print(errs());
//             }
//             if (auto *CI = dyn_cast<CallInst>(&*Inst)) {
//                 Function *CalledFunc = CI->getCalledFunction();

//                 if (CalledFunc && !CalledFunc->isDeclaration()) {
                    
//                     IRBuilder<> EntryBuilder(CI);
//                     EndClock = CallInst::Create(clockFunc, "", CI);
//                     EndClock->setMetadata("End", TalhaMD);

//                     errs() << "End clock of " << F.getName() << ":   ";
//                     EndClock->print(errs());
//                     errs() << "\n";

//                     StartClock = CallInst::Create(clockFunc, "", CI->getNextNode());
//                     StartClock->setMetadata("Start", TalhaMD);

//                     errs() << "Start clock of " << F.getName() << ":   ";
//                     StartClock->print(errs());
//                     errs() << "\n";

//                 }
//             }
//         }

        // BasicBlock &LastBB = F.back();
        // // Insert a call to clock at the end of the last basic block
        // IRBuilder<> ExitBuilder(&*LastBB.getTerminator());
        // EndClock = CallInst::Create(clockFunc, "", LastBB.getTerminator());
        // EndClock->setMetadata("End", TalhaMD);

        // errs() << "End clock of " << F.getName() << ":   ";
        // EndClock->print(errs());
        // errs() << "\n";


        //  // Calculate the difference and store it in the global variable GV
        // LoadInst *LoadStartClock = ExitBuilder.CreateLoad(I64Ty, GV);
        // BinaryOperator *ClockDiff = BinaryOperator::Create(
        //     Instruction::Sub, EndClock, StartClock, "clock_diff", LastBB.getTerminator());
        // BinaryOperator *AddClockDiff = BinaryOperator::Create(
        //     Instruction::Add, LoadStartClock, ClockDiff, "add_clock_diff", LastBB.getTerminator());
        // ExitBuilder.CreateStore(AddClockDiff, GV);

//     }
// }




void childrens(Module &M){

    Function *clockFunc = M.getFunction("clock");

    LLVMContext &Context = M.getContext();
    MDNode *TalhaMD = MDNode::get(Context, MDString::get(Context, "Talha"));

    IntegerType *I64Ty = Type::getInt64Ty(Context); // 64-bit integer type

    for (Function &F : M) {
        if (F.isDeclaration())
            continue;

        CallInst *StartClock = nullptr;
        CallInst *EndClock = nullptr;
        
        std::string counterName = "clocks_by_" + F.getName().str() + ".glob";
        GlobalVariable *GV = M.getGlobalVariable(counterName);

        // Insert a call to clock at the start of the function
        BasicBlock &EntryBB = F.getEntryBlock();
        IRBuilder<> EntryBuilder(&*EntryBB.getFirstInsertionPt());
        StartClock = EntryBuilder.CreateCall(clockFunc, {});
        StartClock->setMetadata("Start", TalhaMD);

        // Find the last basic block in the function
        BasicBlock &LastBB = F.back();
        // Insert a call to clock at the end of the last basic block
        IRBuilder<> ExitBuilder(&*LastBB.getTerminator());
        EndClock = ExitBuilder.CreateCall(clockFunc, {});
        EndClock->setMetadata("End", TalhaMD);

        // Calculate the difference
        BinaryOperator *ClockDiff = BinaryOperator::Create(Instruction::Sub, EndClock, StartClock, "clock_diff", &*LastBB.getTerminator());

        // Load the value from the global variable
        LoadInst *LoadStartClock = ExitBuilder.CreateLoad(I64Ty, GV);

        // Add the clock difference to the global variable
        BinaryOperator *AddClockDiff = BinaryOperator::Create(Instruction::Add, LoadStartClock, ClockDiff, "add_clock_diff", &*LastBB.getTerminator());

        // Store the updated value in the global variable
        ExitBuilder.CreateStore(AddClockDiff, GV);
    }
}



PreservedAnalyses NewProfilerPass::run(Module &M, ModuleAnalysisManager &AM) {
    std::string functionalityName = MyFunc;

    if (functionalityName == "time"){
        initialize_clocks(M);        // Initializing global variables
        childrens(M);
        finalize(M);          // printing the global variables
    }
    else{
        initialize_counters(M);        // Initializing global variables
        CounterAdder(M);      // Adding atomic counters to update the global variables
        finalize(M);          // printing the global variables
    }

    return PreservedAnalyses::all();
}