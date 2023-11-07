; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=riscv64 -mattr=+v,+f,+d,+zfh,+zvfh -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 < %s | FileCheck %s
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -mtriple=riscv64 -mattr=+f,+d < %s | FileCheck %s

define void @load(ptr %p) {
; CHECK-LABEL: 'load'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %1 = load [2 x i64], ptr %p, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %2 = load [4 x i64], ptr %p, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %3 = load { i64, i64 }, ptr %p, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %4 = load { i64, i32 }, ptr %p, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  load [2 x i64], ptr %p
  load [4 x i64], ptr %p
  load {i64,i64}, ptr %p
  load {i64,i32}, ptr %p

  ret void
}

define void @store(ptr %p) {
; CHECK-LABEL: 'store'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: store [2 x i64] undef, ptr %p, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: store [4 x i64] undef, ptr %p, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: store { i64, i64 } undef, ptr %p, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: store { i64, i32 } undef, ptr %p, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  store [2 x i64] undef, ptr %p
  store [4 x i64] undef, ptr %p
  store {i64,i64} undef, ptr %p
  store {i64,i32} undef, ptr %p

  ret void
}

