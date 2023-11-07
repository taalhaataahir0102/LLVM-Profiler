# LLVM-Profiler

## Setup:

Build LLVM for Risc-V target:

https://github.com/sifive/riscv-llvm

Copy this llvm folder in riscv/riscv-llvm/llvm.

Rebuild llvm and clang using ninja

## Usage:

Inside /riscv/riscv-llvm/_build/bin generate llvm IR from your C file using:

```clang -S -O0 -Xclang -disable-O0-optnone -emit-llvm -fno-discard-value-names example.c -o example.ll```

Run your optimization pass in the same directory using opt:

```./opt -passes=newprofiler example.ll -S -o newexample.ll```

From riscv/_install/bin/ generate your binary from this LLVM IR:

```./llvm-as newexample.ll -o newexample.bc```

Next generate your object file:

```./clang -c newexample.bc```

Now generate executable using:

```./clang newexample.o```

run the executable:

```./qemu-riscv64 a.out```

The output will show the following results at runtime:

1. Number of basic blocks traversed
2. Total number of instructions
3. Count of ech function traversed
4. count of heavy instructions including memory, branch and multiply isntructions

## Example output:

num_inst.glob: 2191285
num_bb.glob: 563533
num_mult.glob: 59205
num_branch.glob: 533529
num_mem.glob: 856583
isPrime.glob: 30000
sumPrimesInRange.glob: 3
main.glob: 1
