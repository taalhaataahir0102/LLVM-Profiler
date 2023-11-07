; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2p1 -verify-machineinstrs < %s | FileCheck %s

;
; S/UQRSHRN x2
;

define <vscale x 8 x i16> @multi_vector_sat_shift_narrow_interleave_x2_s16(<vscale x 4 x i32> %unused, <vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2) {
; CHECK-LABEL: multi_vector_sat_shift_narrow_interleave_x2_s16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z3.d, z2.d
; CHECK-NEXT:    mov z2.d, z1.d
; CHECK-NEXT:    sqrshrn z0.h, { z2.s, z3.s }, #16
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.aarch64.sve.sqrshrn.x2.nxv8i16(<vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2, i32 16)
  ret <vscale x 8 x i16> %res
}

define <vscale x 8 x i16> @multi_vector_sat_shift_narrow_interleave_x2_u16(<vscale x 4 x i32> %unused, <vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2) {
; CHECK-LABEL: multi_vector_sat_shift_narrow_interleave_x2_u16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z3.d, z2.d
; CHECK-NEXT:    mov z2.d, z1.d
; CHECK-NEXT:    uqrshrn z0.h, { z2.s, z3.s }, #16
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.aarch64.sve.uqrshrn.x2.nxv8i16(<vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2, i32 16)
  ret <vscale x 8 x i16> %res
}

;
; SQRSHRUN x2
;

define <vscale x 8 x i16> @multi_vector_sat_shift_unsigned_narrow_interleave_x2_s16(<vscale x 4 x i32> %unused, <vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2) {
; CHECK-LABEL: multi_vector_sat_shift_unsigned_narrow_interleave_x2_s16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z3.d, z2.d
; CHECK-NEXT:    mov z2.d, z1.d
; CHECK-NEXT:    sqrshrun z0.h, { z2.s, z3.s }, #16
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.aarch64.sve.sqrshrun.x2.nxv8i16(<vscale x 4 x i32> %zn1, <vscale x 4 x i32> %zn2, i32 16)
  ret <vscale x 8 x i16> %res
}

declare <vscale x 8 x i16> @llvm.aarch64.sve.sqrshrn.x2.nxv8i16(<vscale x 4 x i32>, <vscale x 4 x i32>, i32)
declare <vscale x 8 x i16> @llvm.aarch64.sve.uqrshrn.x2.nxv8i16(<vscale x 4 x i32>, <vscale x 4 x i32>, i32)

declare <vscale x 8 x i16> @llvm.aarch64.sve.sqrshrun.x2.nxv8i16(<vscale x 4 x i32>, <vscale x 4 x i32>, i32)
