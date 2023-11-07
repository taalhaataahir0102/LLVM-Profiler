; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve -force-streaming-compatible-sve  < %s | FileCheck %s

target triple = "aarch64"

;
; NOTE: SVE lowering for the BSP pseudoinst is not currently implemented, so we
;       don't currently expect the code below to lower to BSL/BIT/BIF. Once
;       this is implemented, this test will be fleshed out.
;

define <8 x i32> @fixed_bitselect_v8i32(ptr %pre_cond_ptr, ptr %left_ptr, ptr %right_ptr) {
; CHECK-LABEL: fixed_bitselect_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    ldp q2, q1, [x0]
; CHECK-NEXT:    ldp q5, q4, [x1]
; CHECK-NEXT:    ldp q6, q7, [x2]
; CHECK-NEXT:    add z3.s, z1.s, z0.s
; CHECK-NEXT:    subr z1.s, z1.s, #0 // =0x0
; CHECK-NEXT:    add z0.s, z2.s, z0.s
; CHECK-NEXT:    subr z2.s, z2.s, #0 // =0x0
; CHECK-NEXT:    and z1.d, z1.d, z4.d
; CHECK-NEXT:    and z3.d, z3.d, z7.d
; CHECK-NEXT:    and z0.d, z0.d, z6.d
; CHECK-NEXT:    and z2.d, z2.d, z5.d
; CHECK-NEXT:    orr z1.d, z3.d, z1.d
; CHECK-NEXT:    orr z0.d, z0.d, z2.d
; CHECK-NEXT:    // kill: def $q1 killed $q1 killed $z1
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %pre_cond = load <8 x i32>, ptr %pre_cond_ptr
  %left = load <8 x i32>, ptr %left_ptr
  %right = load <8 x i32>, ptr %right_ptr

  %neg_cond = sub <8 x i32> zeroinitializer, %pre_cond
  %min_cond = add <8 x i32> %pre_cond, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %left_bits_0 = and <8 x i32> %neg_cond, %left
  %right_bits_0 = and <8 x i32> %min_cond, %right
  %bsl0000 = or <8 x i32> %right_bits_0, %left_bits_0
  ret <8 x i32> %bsl0000
}

