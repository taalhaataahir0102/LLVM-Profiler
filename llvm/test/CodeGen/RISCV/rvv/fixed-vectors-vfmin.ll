; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfhmin,+v -target-abi=ilp32d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfhmin,+v -target-abi=lp64d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=ZVFHMIN

declare <2 x half> @llvm.minnum.v2f16(<2 x half>, <2 x half>)

define <2 x half> @vfmin_v2f16_vv(<2 x half> %a, <2 x half> %b) {
; CHECK-LABEL: vfmin_v2f16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v9, v9, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <2 x half> @llvm.minnum.v2f16(<2 x half> %a, <2 x half> %b)
  ret <2 x half> %v
}

define <2 x half> @vfmin_v2f16_vf(<2 x half> %a, half %b) {
; CHECK-LABEL: vfmin_v2f16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v9, v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <2 x half> poison, half %b, i32 0
  %splat = shufflevector <2 x half> %head, <2 x half> poison, <2 x i32> zeroinitializer
  %v = call <2 x half> @llvm.minnum.v2f16(<2 x half> %a, <2 x half> %splat)
  ret <2 x half> %v
}

define <2 x half> @vfmin_v2f16_fv(<2 x half> %a, half %b) {
; CHECK-LABEL: vfmin_v2f16_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f16_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v9, v8, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <2 x half> poison, half %b, i32 0
  %splat = shufflevector <2 x half> %head, <2 x half> poison, <2 x i32> zeroinitializer
  %v = call <2 x half> @llvm.minnum.v2f16(<2 x half> %splat, <2 x half> %a)
  ret <2 x half> %v
}

declare <4 x half> @llvm.minnum.v4f16(<4 x half>, <4 x half>)

define <4 x half> @vfmin_v4f16_vv(<4 x half> %a, <4 x half> %b) {
; CHECK-LABEL: vfmin_v4f16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v9, v9, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <4 x half> @llvm.minnum.v4f16(<4 x half> %a, <4 x half> %b)
  ret <4 x half> %v
}

define <4 x half> @vfmin_v4f16_vf(<4 x half> %a, half %b) {
; CHECK-LABEL: vfmin_v4f16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v9, v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <4 x half> poison, half %b, i32 0
  %splat = shufflevector <4 x half> %head, <4 x half> poison, <4 x i32> zeroinitializer
  %v = call <4 x half> @llvm.minnum.v4f16(<4 x half> %a, <4 x half> %splat)
  ret <4 x half> %v
}

define <4 x half> @vfmin_v4f16_fv(<4 x half> %a, half %b) {
; CHECK-LABEL: vfmin_v4f16_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f16_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v9, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v9
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v9, v8, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <4 x half> poison, half %b, i32 0
  %splat = shufflevector <4 x half> %head, <4 x half> poison, <4 x i32> zeroinitializer
  %v = call <4 x half> @llvm.minnum.v4f16(<4 x half> %splat, <4 x half> %a)
  ret <4 x half> %v
}

declare <8 x half> @llvm.minnum.v8f16(<8 x half>, <8 x half>)

define <8 x half> @vfmin_v8f16_vv(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: vfmin_v8f16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v10, v12, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <8 x half> @llvm.minnum.v8f16(<8 x half> %a, <8 x half> %b)
  ret <8 x half> %v
}

define <8 x half> @vfmin_v8f16_vf(<8 x half> %a, half %b) {
; CHECK-LABEL: vfmin_v8f16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v10, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v9, v10
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v10, v10, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %head = insertelement <8 x half> poison, half %b, i32 0
  %splat = shufflevector <8 x half> %head, <8 x half> poison, <8 x i32> zeroinitializer
  %v = call <8 x half> @llvm.minnum.v8f16(<8 x half> %a, <8 x half> %splat)
  ret <8 x half> %v
}

define <8 x half> @vfmin_v8f16_fv(<8 x half> %a, half %b) {
; CHECK-LABEL: vfmin_v8f16_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f16_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v10, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v9, v10
; ZVFHMIN-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v10, v12, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %head = insertelement <8 x half> poison, half %b, i32 0
  %splat = shufflevector <8 x half> %head, <8 x half> poison, <8 x i32> zeroinitializer
  %v = call <8 x half> @llvm.minnum.v8f16(<8 x half> %splat, <8 x half> %a)
  ret <8 x half> %v
}

declare <16 x half> @llvm.minnum.v16f16(<16 x half>, <16 x half>)

define <16 x half> @vfmin_v16f16_vv(<16 x half> %a, <16 x half> %b) {
; CHECK-LABEL: vfmin_v16f16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v10
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f16_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v12, v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <16 x half> @llvm.minnum.v16f16(<16 x half> %a, <16 x half> %b)
  ret <16 x half> %v
}

define <16 x half> @vfmin_v16f16_vf(<16 x half> %a, half %b) {
; CHECK-LABEL: vfmin_v16f16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f16_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v12, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v12
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v12, v12, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %head = insertelement <16 x half> poison, half %b, i32 0
  %splat = shufflevector <16 x half> %head, <16 x half> poison, <16 x i32> zeroinitializer
  %v = call <16 x half> @llvm.minnum.v16f16(<16 x half> %a, <16 x half> %splat)
  ret <16 x half> %v
}

define <16 x half> @vfmin_v16f16_fv(<16 x half> %a, half %b) {
; CHECK-LABEL: vfmin_v16f16_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f16_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v12, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v10, v12
; ZVFHMIN-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v12, v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %head = insertelement <16 x half> poison, half %b, i32 0
  %splat = shufflevector <16 x half> %head, <16 x half> poison, <16 x i32> zeroinitializer
  %v = call <16 x half> @llvm.minnum.v16f16(<16 x half> %splat, <16 x half> %a)
  ret <16 x half> %v
}

declare <2 x float> @llvm.minnum.v2f32(<2 x float>, <2 x float>)

define <2 x float> @vfmin_v2f32_vv(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: vfmin_v2f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f32_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v8, v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <2 x float> @llvm.minnum.v2f32(<2 x float> %a, <2 x float> %b)
  ret <2 x float> %v
}

define <2 x float> @vfmin_v2f32_vf(<2 x float> %a, float %b) {
; CHECK-LABEL: vfmin_v2f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f32_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <2 x float> poison, float %b, i32 0
  %splat = shufflevector <2 x float> %head, <2 x float> poison, <2 x i32> zeroinitializer
  %v = call <2 x float> @llvm.minnum.v2f32(<2 x float> %a, <2 x float> %splat)
  ret <2 x float> %v
}

define <2 x float> @vfmin_v2f32_fv(<2 x float> %a, float %b) {
; CHECK-LABEL: vfmin_v2f32_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f32_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <2 x float> poison, float %b, i32 0
  %splat = shufflevector <2 x float> %head, <2 x float> poison, <2 x i32> zeroinitializer
  %v = call <2 x float> @llvm.minnum.v2f32(<2 x float> %splat, <2 x float> %a)
  ret <2 x float> %v
}

declare <4 x float> @llvm.minnum.v4f32(<4 x float>, <4 x float>)

define <4 x float> @vfmin_v4f32_vv(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: vfmin_v4f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f32_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v8, v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <4 x float> @llvm.minnum.v4f32(<4 x float> %a, <4 x float> %b)
  ret <4 x float> %v
}

define <4 x float> @vfmin_v4f32_vf(<4 x float> %a, float %b) {
; CHECK-LABEL: vfmin_v4f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f32_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <4 x float> poison, float %b, i32 0
  %splat = shufflevector <4 x float> %head, <4 x float> poison, <4 x i32> zeroinitializer
  %v = call <4 x float> @llvm.minnum.v4f32(<4 x float> %a, <4 x float> %splat)
  ret <4 x float> %v
}

define <4 x float> @vfmin_v4f32_fv(<4 x float> %a, float %b) {
; CHECK-LABEL: vfmin_v4f32_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f32_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <4 x float> poison, float %b, i32 0
  %splat = shufflevector <4 x float> %head, <4 x float> poison, <4 x i32> zeroinitializer
  %v = call <4 x float> @llvm.minnum.v4f32(<4 x float> %splat, <4 x float> %a)
  ret <4 x float> %v
}

declare <8 x float> @llvm.minnum.v8f32(<8 x float>, <8 x float>)

define <8 x float> @vfmin_v8f32_vv(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: vfmin_v8f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v10
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f32_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v8, v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <8 x float> @llvm.minnum.v8f32(<8 x float> %a, <8 x float> %b)
  ret <8 x float> %v
}

define <8 x float> @vfmin_v8f32_vf(<8 x float> %a, float %b) {
; CHECK-LABEL: vfmin_v8f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f32_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <8 x float> poison, float %b, i32 0
  %splat = shufflevector <8 x float> %head, <8 x float> poison, <8 x i32> zeroinitializer
  %v = call <8 x float> @llvm.minnum.v8f32(<8 x float> %a, <8 x float> %splat)
  ret <8 x float> %v
}

define <8 x float> @vfmin_v8f32_fv(<8 x float> %a, float %b) {
; CHECK-LABEL: vfmin_v8f32_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f32_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <8 x float> poison, float %b, i32 0
  %splat = shufflevector <8 x float> %head, <8 x float> poison, <8 x i32> zeroinitializer
  %v = call <8 x float> @llvm.minnum.v8f32(<8 x float> %splat, <8 x float> %a)
  ret <8 x float> %v
}

declare <16 x float> @llvm.minnum.v16f32(<16 x float>, <16 x float>)

define <16 x float> @vfmin_v16f32_vv(<16 x float> %a, <16 x float> %b) {
; CHECK-LABEL: vfmin_v16f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v12
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f32_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v8, v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <16 x float> @llvm.minnum.v16f32(<16 x float> %a, <16 x float> %b)
  ret <16 x float> %v
}

define <16 x float> @vfmin_v16f32_vf(<16 x float> %a, float %b) {
; CHECK-LABEL: vfmin_v16f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f32_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <16 x float> poison, float %b, i32 0
  %splat = shufflevector <16 x float> %head, <16 x float> poison, <16 x i32> zeroinitializer
  %v = call <16 x float> @llvm.minnum.v16f32(<16 x float> %a, <16 x float> %splat)
  ret <16 x float> %v
}

define <16 x float> @vfmin_v16f32_fv(<16 x float> %a, float %b) {
; CHECK-LABEL: vfmin_v16f32_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f32_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <16 x float> poison, float %b, i32 0
  %splat = shufflevector <16 x float> %head, <16 x float> poison, <16 x i32> zeroinitializer
  %v = call <16 x float> @llvm.minnum.v16f32(<16 x float> %splat, <16 x float> %a)
  ret <16 x float> %v
}

declare <2 x double> @llvm.minnum.v2f64(<2 x double>, <2 x double>)

define <2 x double> @vfmin_v2f64_vv(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: vfmin_v2f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f64_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v8, v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <2 x double> @llvm.minnum.v2f64(<2 x double> %a, <2 x double> %b)
  ret <2 x double> %v
}

define <2 x double> @vfmin_v2f64_vf(<2 x double> %a, double %b) {
; CHECK-LABEL: vfmin_v2f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f64_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <2 x double> poison, double %b, i32 0
  %splat = shufflevector <2 x double> %head, <2 x double> poison, <2 x i32> zeroinitializer
  %v = call <2 x double> @llvm.minnum.v2f64(<2 x double> %a, <2 x double> %splat)
  ret <2 x double> %v
}

define <2 x double> @vfmin_v2f64_fv(<2 x double> %a, double %b) {
; CHECK-LABEL: vfmin_v2f64_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v2f64_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <2 x double> poison, double %b, i32 0
  %splat = shufflevector <2 x double> %head, <2 x double> poison, <2 x i32> zeroinitializer
  %v = call <2 x double> @llvm.minnum.v2f64(<2 x double> %splat, <2 x double> %a)
  ret <2 x double> %v
}

declare <4 x double> @llvm.minnum.v4f64(<4 x double>, <4 x double>)

define <4 x double> @vfmin_v4f64_vv(<4 x double> %a, <4 x double> %b) {
; CHECK-LABEL: vfmin_v4f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v10
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f64_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v8, v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <4 x double> @llvm.minnum.v4f64(<4 x double> %a, <4 x double> %b)
  ret <4 x double> %v
}

define <4 x double> @vfmin_v4f64_vf(<4 x double> %a, double %b) {
; CHECK-LABEL: vfmin_v4f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f64_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <4 x double> poison, double %b, i32 0
  %splat = shufflevector <4 x double> %head, <4 x double> poison, <4 x i32> zeroinitializer
  %v = call <4 x double> @llvm.minnum.v4f64(<4 x double> %a, <4 x double> %splat)
  ret <4 x double> %v
}

define <4 x double> @vfmin_v4f64_fv(<4 x double> %a, double %b) {
; CHECK-LABEL: vfmin_v4f64_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v4f64_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <4 x double> poison, double %b, i32 0
  %splat = shufflevector <4 x double> %head, <4 x double> poison, <4 x i32> zeroinitializer
  %v = call <4 x double> @llvm.minnum.v4f64(<4 x double> %splat, <4 x double> %a)
  ret <4 x double> %v
}

declare <8 x double> @llvm.minnum.v8f64(<8 x double>, <8 x double>)

define <8 x double> @vfmin_v8f64_vv(<8 x double> %a, <8 x double> %b) {
; CHECK-LABEL: vfmin_v8f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v12
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f64_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v8, v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <8 x double> @llvm.minnum.v8f64(<8 x double> %a, <8 x double> %b)
  ret <8 x double> %v
}

define <8 x double> @vfmin_v8f64_vf(<8 x double> %a, double %b) {
; CHECK-LABEL: vfmin_v8f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f64_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <8 x double> poison, double %b, i32 0
  %splat = shufflevector <8 x double> %head, <8 x double> poison, <8 x i32> zeroinitializer
  %v = call <8 x double> @llvm.minnum.v8f64(<8 x double> %a, <8 x double> %splat)
  ret <8 x double> %v
}

define <8 x double> @vfmin_v8f64_fv(<8 x double> %a, double %b) {
; CHECK-LABEL: vfmin_v8f64_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v8f64_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <8 x double> poison, double %b, i32 0
  %splat = shufflevector <8 x double> %head, <8 x double> poison, <8 x i32> zeroinitializer
  %v = call <8 x double> @llvm.minnum.v8f64(<8 x double> %splat, <8 x double> %a)
  ret <8 x double> %v
}

declare <16 x double> @llvm.minnum.v16f64(<16 x double>, <16 x double>)

define <16 x double> @vfmin_v16f64_vv(<16 x double> %a, <16 x double> %b) {
; CHECK-LABEL: vfmin_v16f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vfmin.vv v8, v8, v16
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f64_vv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; ZVFHMIN-NEXT:    vfmin.vv v8, v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <16 x double> @llvm.minnum.v16f64(<16 x double> %a, <16 x double> %b)
  ret <16 x double> %v
}

define <16 x double> @vfmin_v16f64_vf(<16 x double> %a, double %b) {
; CHECK-LABEL: vfmin_v16f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f64_vf:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <16 x double> poison, double %b, i32 0
  %splat = shufflevector <16 x double> %head, <16 x double> poison, <16 x i32> zeroinitializer
  %v = call <16 x double> @llvm.minnum.v16f64(<16 x double> %a, <16 x double> %splat)
  ret <16 x double> %v
}

define <16 x double> @vfmin_v16f64_fv(<16 x double> %a, double %b) {
; CHECK-LABEL: vfmin_v16f64_fv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vfmin.vf v8, v8, fa0
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmin_v16f64_fv:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; ZVFHMIN-NEXT:    vfmin.vf v8, v8, fa0
; ZVFHMIN-NEXT:    ret
  %head = insertelement <16 x double> poison, double %b, i32 0
  %splat = shufflevector <16 x double> %head, <16 x double> poison, <16 x i32> zeroinitializer
  %v = call <16 x double> @llvm.minnum.v16f64(<16 x double> %splat, <16 x double> %a)
  ret <16 x double> %v
}
