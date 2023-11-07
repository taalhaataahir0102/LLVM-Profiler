; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+zbb,+v \
; RUN:     -riscv-v-vector-bits-min=128 | FileCheck %s

; This test loads to values and stores them in reversed order. This previously
; asserted because part of DAGCombiner::tryStoreMerge thinks we can use an i64
; rotate, but the loads aren't sufficiently aligned. So then it tried to use
; a vector type, but that can't handle the swapped case.

@foo = global [2 x i32] zeroinitializer, align 4
@bar = global [2 x i32] zeroinitializer, align 4

define void @baz() nounwind {
; CHECK-LABEL: baz:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a0, %hi(foo)
; CHECK-NEXT:    addi a1, a0, %lo(foo)
; CHECK-NEXT:    lw a1, 4(a1)
; CHECK-NEXT:    lw a0, %lo(foo)(a0)
; CHECK-NEXT:    lui a2, %hi(bar)
; CHECK-NEXT:    sw a1, %lo(bar)(a2)
; CHECK-NEXT:    addi a1, a2, %lo(bar)
; CHECK-NEXT:    sw a0, 4(a1)
; CHECK-NEXT:    ret
entry:
  %0 = load i32, ptr getelementptr inbounds ([2 x i32], ptr @foo, i64 0, i64 1), align 4
  store i32 %0, ptr @bar, align 4
  %1 = load i32, ptr @foo, align 4
  store i32 %1, ptr getelementptr inbounds ([2 x i32], ptr @bar, i64 0, i64 1), align 4
  ret void
}
