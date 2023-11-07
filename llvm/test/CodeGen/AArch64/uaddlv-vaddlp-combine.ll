; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple aarch64-none-linux-gnu < %s | FileCheck %s

define i32 @uaddlv_uaddlp_v8i16(<8 x i16> %0) {
; CHECK-LABEL: uaddlv_uaddlp_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uaddlv s0, v0.8h
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %2 = tail call <4 x i32> @llvm.aarch64.neon.uaddlp.v4i32.v8i16(<8 x i16> %0)
  %3 = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> %2)
  %4 = trunc i64 %3 to i32
  ret i32 %4
}

define i16 @uaddlv_uaddlp_v16i8(<16 x i8> %0) {
; CHECK-LABEL: uaddlv_uaddlp_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uaddlv h0, v0.16b
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %2 = tail call <8 x i16> @llvm.aarch64.neon.uaddlp.v8i16.v16i8(<16 x i8> %0)
  %3 = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16> %2)
  %4 = trunc i32 %3 to i16
  ret i16 %4
}

declare i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32>)
declare i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16>)
declare <4 x i32> @llvm.aarch64.neon.uaddlp.v4i32.v8i16(<8 x i16>)
declare <8 x i16> @llvm.aarch64.neon.uaddlp.v8i16.v16i8(<16 x i8>)
