# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=riscv64 -mcpu=sifive-x280 -timeline -iterations=1 < %s | FileCheck %s

# LLVM-MCA-BEGIN foo
vsetvli zero, a0, e64, m1, tu, mu
# LLVM-MCA-RISCV-LMUL M1
# LLVM-MCA-RISCV-SEW E64
vdiv.vv v8, v8, v12
# LLVM-MCA-END foo
vdiv.vv v8, v8, v12

# CHECK:      [0] Code Region - foo

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      2
# CHECK-NEXT: Total Cycles:      118
# CHECK-NEXT: Total uOps:        2

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.02
# CHECK-NEXT: IPC:               0.02
# CHECK-NEXT: Block RThroughput: 114.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                  U     vsetvli	zero, a0, e64, m1, tu, mu
# CHECK-NEXT:  1      114   114.00                      vdiv.vv	v8, v8, v12

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SiFive7FDiv
# CHECK-NEXT: [1]   - SiFive7IDiv
# CHECK-NEXT: [2]   - SiFive7PipeA
# CHECK-NEXT: [3]   - SiFive7PipeB
# CHECK-NEXT: [4]   - SiFive7PipeV
# CHECK-NEXT: [5]   - SiFive7VA
# CHECK-NEXT: [6]   - SiFive7VL
# CHECK-NEXT: [7]   - SiFive7VS

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]
# CHECK-NEXT:  -      -     1.00    -     114.00 114.00  -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    Instructions:
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -     vsetvli	zero, a0, e64, m1, tu, mu
# CHECK-NEXT:  -      -      -      -     114.00 114.00  -      -     vdiv.vv	v8, v8, v12

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123

# CHECK:      [0,0]     DeeE   vsetvli	zero, a0, e64, m1, tu, mu
# CHECK-NEXT: Truncated display due to cycle limit

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     0.0    0.0    0.0       vsetvli	zero, a0, e64, m1, tu, mu
# CHECK-NEXT: 1.     1     0.0    0.0    0.0       vdiv.vv	v8, v8, v12
# CHECK-NEXT:        1     0.0    0.0    0.0       <total>
