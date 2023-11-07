; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-darwin"

define i32 @widget(i64 %arg, <8 x i16> %arg1) {
; CHECK-LABEL: widget:
; CHECK:       // %bb.0: // %bb
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    umov w9, v0.h[0]
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov x10, sp
; CHECK-NEXT:    bfi x10, x0, #1, #3
; CHECK-NEXT:    mov x8, x0
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    dup v1.8h, w9
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    ld1 { v1.h }[1], [x10]
; CHECK-NEXT:    str q1, [x8]
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
bb:
  %inst = inttoptr i64 %arg to ptr
  %inst2 = extractelement <8 x i16> %arg1, i64 0
  store i16 %inst2, ptr %inst, align 2
  %inst3 = getelementptr i16, ptr %inst, i64 1
  %inst4 = getelementptr i16, ptr %inst, i64 2
  %inst5 = extractelement <8 x i16> %arg1, i64 0
  %inst6 = getelementptr i16, ptr %inst, i64 3
  %inst7 = extractelement <8 x i16> zeroinitializer, i64 %arg
  store i16 %inst7, ptr %inst3, align 2
  %inst8 = extractelement <8 x i16> %arg1, i64 0
  store i16 %inst8, ptr %inst4, align 2
  store i16 %inst5, ptr %inst6, align 2
  %inst9 = extractelement <8 x i16> %arg1, i64 0
  %inst10 = getelementptr i16, ptr %inst, i64 4
  store i16 %inst9, ptr %inst10, align 2
  %inst11 = extractelement <8 x i16> %arg1, i64 0
  %inst12 = getelementptr i16, ptr %inst, i64 5
  store i16 %inst11, ptr %inst12, align 2
  %inst13 = extractelement <8 x i16> %arg1, i64 0
  %inst14 = getelementptr i16, ptr %inst, i64 6
  store i16 %inst13, ptr %inst14, align 2
  %inst15 = extractelement <8 x i16> %arg1, i64 0
  %inst16 = getelementptr i16, ptr %inst, i64 7
  store i16 %inst15, ptr %inst16, align 2
  ret i32 0
}

