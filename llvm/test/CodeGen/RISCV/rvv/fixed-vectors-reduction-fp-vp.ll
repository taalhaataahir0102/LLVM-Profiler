; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfhmin,+v -target-abi=ilp32d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfhmin,+v -target-abi=lp64d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s --check-prefixes=ZVFHMIN

declare half @llvm.vp.reduce.fadd.v2f16(half, <2 x half>, <2 x i1>, i32)

define half @vpreduce_fadd_v2f16(half %s, <2 x half> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_v2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v8, v9, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call reassoc half @llvm.vp.reduce.fadd.v2f16(half %s, <2 x half> %v, <2 x i1> %m, i32 %evl)
  ret half %r
}

define half @vpreduce_ord_fadd_v2f16(half %s, <2 x half> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_v2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v8, v9, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call half @llvm.vp.reduce.fadd.v2f16(half %s, <2 x half> %v, <2 x i1> %m, i32 %evl)
  ret half %r
}

declare half @llvm.vp.reduce.fadd.v4f16(half, <4 x half>, <4 x i1>, i32)

define half @vpreduce_fadd_v4f16(half %s, <4 x half> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_v4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v8, v9, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call reassoc half @llvm.vp.reduce.fadd.v4f16(half %s, <4 x half> %v, <4 x i1> %m, i32 %evl)
  ret half %r
}

define half @vpreduce_ord_fadd_v4f16(half %s, <4 x half> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_v4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v8, v9, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call half @llvm.vp.reduce.fadd.v4f16(half %s, <4 x half> %v, <4 x i1> %m, i32 %evl)
  ret half %r
}

declare float @llvm.vp.reduce.fadd.v2f32(float, <2 x float>, <2 x i1>, i32)

define float @vpreduce_fadd_v2f32(float %s, <2 x float> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_v2f32:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v9, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v9
; ZVFHMIN-NEXT:    ret
  %r = call reassoc float @llvm.vp.reduce.fadd.v2f32(float %s, <2 x float> %v, <2 x i1> %m, i32 %evl)
  ret float %r
}

define float @vpreduce_ord_fadd_v2f32(float %s, <2 x float> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_v2f32:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v9, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v9
; ZVFHMIN-NEXT:    ret
  %r = call float @llvm.vp.reduce.fadd.v2f32(float %s, <2 x float> %v, <2 x i1> %m, i32 %evl)
  ret float %r
}

declare float @llvm.vp.reduce.fadd.v4f32(float, <4 x float>, <4 x i1>, i32)

define float @vpreduce_fadd_v4f32(float %s, <4 x float> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_v4f32:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v9, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v9
; ZVFHMIN-NEXT:    ret
  %r = call reassoc float @llvm.vp.reduce.fadd.v4f32(float %s, <4 x float> %v, <4 x i1> %m, i32 %evl)
  ret float %r
}

define float @vpreduce_ord_fadd_v4f32(float %s, <4 x float> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_v4f32:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v9, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v9
; ZVFHMIN-NEXT:    ret
  %r = call float @llvm.vp.reduce.fadd.v4f32(float %s, <4 x float> %v, <4 x i1> %m, i32 %evl)
  ret float %r
}

declare float @llvm.vp.reduce.fadd.v64f32(float, <64 x float>, <64 x i1>, i32)

define float @vpreduce_fadd_v64f32(float %s, <64 x float> %v, <64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_v64f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    vslidedown.vi v24, v0, 4
; CHECK-NEXT:    mv a1, a0
; CHECK-NEXT:    bltu a0, a2, .LBB8_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:  .LBB8_2:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v25, fa0
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vfredusum.vs v25, v8, v25, v0.t
; CHECK-NEXT:    addi a1, a0, -32
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    and a0, a0, a1
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vfredusum.vs v25, v16, v25, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_v64f32:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    li a2, 32
; ZVFHMIN-NEXT:    vslidedown.vi v24, v0, 4
; ZVFHMIN-NEXT:    mv a1, a0
; ZVFHMIN-NEXT:    bltu a0, a2, .LBB8_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    li a1, 32
; ZVFHMIN-NEXT:  .LBB8_2:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v25, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v25, v8, v25, v0.t
; ZVFHMIN-NEXT:    addi a1, a0, -32
; ZVFHMIN-NEXT:    sltu a0, a0, a1
; ZVFHMIN-NEXT:    addi a0, a0, -1
; ZVFHMIN-NEXT:    and a0, a0, a1
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vmv1r.v v0, v24
; ZVFHMIN-NEXT:    vfredusum.vs v25, v16, v25, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v25
; ZVFHMIN-NEXT:    ret
  %r = call reassoc float @llvm.vp.reduce.fadd.v64f32(float %s, <64 x float> %v, <64 x i1> %m, i32 %evl)
  ret float %r
}

define float @vpreduce_ord_fadd_v64f32(float %s, <64 x float> %v, <64 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_v64f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    vslidedown.vi v24, v0, 4
; CHECK-NEXT:    mv a1, a0
; CHECK-NEXT:    bltu a0, a2, .LBB9_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:  .LBB9_2:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v25, fa0
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vfredosum.vs v25, v8, v25, v0.t
; CHECK-NEXT:    addi a1, a0, -32
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    and a0, a0, a1
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vfredosum.vs v25, v16, v25, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v25
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_v64f32:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    li a2, 32
; ZVFHMIN-NEXT:    vslidedown.vi v24, v0, 4
; ZVFHMIN-NEXT:    mv a1, a0
; ZVFHMIN-NEXT:    bltu a0, a2, .LBB9_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    li a1, 32
; ZVFHMIN-NEXT:  .LBB9_2:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v25, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v25, v8, v25, v0.t
; ZVFHMIN-NEXT:    addi a1, a0, -32
; ZVFHMIN-NEXT:    sltu a0, a0, a1
; ZVFHMIN-NEXT:    addi a0, a0, -1
; ZVFHMIN-NEXT:    and a0, a0, a1
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vmv1r.v v0, v24
; ZVFHMIN-NEXT:    vfredosum.vs v25, v16, v25, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v25
; ZVFHMIN-NEXT:    ret
  %r = call float @llvm.vp.reduce.fadd.v64f32(float %s, <64 x float> %v, <64 x i1> %m, i32 %evl)
  ret float %r
}

declare double @llvm.vp.reduce.fadd.v2f64(double, <2 x double>, <2 x i1>, i32)

define double @vpreduce_fadd_v2f64(double %s, <2 x double> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_v2f64:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v9, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v9
; ZVFHMIN-NEXT:    ret
  %r = call reassoc double @llvm.vp.reduce.fadd.v2f64(double %s, <2 x double> %v, <2 x i1> %m, i32 %evl)
  ret double %r
}

define double @vpreduce_ord_fadd_v2f64(double %s, <2 x double> %v, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_v2f64:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v9, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v9
; ZVFHMIN-NEXT:    ret
  %r = call double @llvm.vp.reduce.fadd.v2f64(double %s, <2 x double> %v, <2 x i1> %m, i32 %evl)
  ret double %r
}

declare double @llvm.vp.reduce.fadd.v3f64(double, <3 x double>, <3 x i1>, i32)

define double @vpreduce_fadd_v3f64(double %s, <3 x double> %v, <3 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_v3f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfredusum.vs v10, v8, v10, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v10
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_v3f64:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v10, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v10, v8, v10, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v10
; ZVFHMIN-NEXT:    ret
  %r = call reassoc double @llvm.vp.reduce.fadd.v3f64(double %s, <3 x double> %v, <3 x i1> %m, i32 %evl)
  ret double %r
}

define double @vpreduce_ord_fadd_v3f64(double %s, <3 x double> %v, <3 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_v3f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfredosum.vs v10, v8, v10, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v10
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_v3f64:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v10, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v10, v8, v10, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v10
; ZVFHMIN-NEXT:    ret
  %r = call double @llvm.vp.reduce.fadd.v3f64(double %s, <3 x double> %v, <3 x i1> %m, i32 %evl)
  ret double %r
}

declare double @llvm.vp.reduce.fadd.v4f64(double, <4 x double>, <4 x i1>, i32)

define double @vpreduce_fadd_v4f64(double %s, <4 x double> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfredusum.vs v10, v8, v10, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v10
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_v4f64:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v10, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v10, v8, v10, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v10
; ZVFHMIN-NEXT:    ret
  %r = call reassoc double @llvm.vp.reduce.fadd.v4f64(double %s, <4 x double> %v, <4 x i1> %m, i32 %evl)
  ret double %r
}

define double @vpreduce_ord_fadd_v4f64(double %s, <4 x double> %v, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfredosum.vs v10, v8, v10, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v10
; CHECK-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_v4f64:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v10, fa0
; ZVFHMIN-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v10, v8, v10, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa0, v10
; ZVFHMIN-NEXT:    ret
  %r = call double @llvm.vp.reduce.fadd.v4f64(double %s, <4 x double> %v, <4 x i1> %m, i32 %evl)
  ret double %r
}
