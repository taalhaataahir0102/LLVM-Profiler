; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+zvfh,+f,+d -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+zvfh,+f,+d -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

; Tests that a floating-point build_vector doesn't try and generate a VID
; instruction
define void @buildvec_no_vid_v4f32(<4 x float>* %x) {
; CHECK-LABEL: buildvec_no_vid_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, %hi(.LCPI0_0)
; CHECK-NEXT:    addi a1, a1, %lo(.LCPI0_0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a1)
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  store <4 x float> <float 0.0, float 4.0, float 0.0, float 2.0>, <4 x float>* %x
  ret void
}

; Not all BUILD_VECTORs are successfully lowered by the backend: some are
; expanded into scalarized stack stores. However, this may result in an
; infinite loop in the DAGCombiner which tries to recombine those stores into a
; BUILD_VECTOR followed by a vector store. The BUILD_VECTOR is then expanded
; and the loop begins.
; Until all BUILD_VECTORs are lowered, we disable store-combining after
; legalization for fixed-length vectors.
; This test uses a trick with a shufflevector which can't be lowered to a
; SHUFFLE_VECTOR node; the mask is shorter than the source vectors and the
; shuffle indices aren't located within the same 4-element subvector, so is
; expanded to 4 EXTRACT_VECTOR_ELTs and a BUILD_VECTOR. This then triggers the
; loop when expanded.
define <4 x float> @hang_when_merging_stores_after_legalization(<8 x float> %x, <8 x float> %y) optsize {
; CHECK-LABEL: hang_when_merging_stores_after_legalization:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vid.v v12
; CHECK-NEXT:    li a0, 7
; CHECK-NEXT:    vmul.vx v14, v12, a0
; CHECK-NEXT:    vrgather.vv v12, v8, v14
; CHECK-NEXT:    vadd.vi v8, v14, -14
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 12
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; CHECK-NEXT:    vrgather.vv v12, v10, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v12
; CHECK-NEXT:    ret
  %z = shufflevector <8 x float> %x, <8 x float> %y, <4 x i32> <i32 0, i32 7, i32 8, i32 15>
  ret <4 x float> %z
}

define void @buildvec_dominant0_v2f32(<2 x float>* %x) {
; CHECK-LABEL: buildvec_dominant0_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vfcvt.f.x.v v8, v8
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  store <2 x float> <float 0.0, float 1.0>, <2 x float>* %x
  ret void
}

; We don't want to lower this to the insertion of two scalar elements as above,
; as each would require their own load from the constant pool.

define void @buildvec_dominant1_v2f32(<2 x float>* %x) {
; CHECK-LABEL: buildvec_dominant1_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vi v8, v8, 1
; CHECK-NEXT:    vfcvt.f.x.v v8, v8
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  store <2 x float> <float 1.0, float 2.0>, <2 x float>* %x
  ret void
}

define void @buildvec_dominant0_v4f32(<4 x float>* %x) {
; CHECK-LABEL: buildvec_dominant0_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v8, a1
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 2
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  store <4 x float> <float 2.0, float 2.0, float 0.0, float 2.0>, <4 x float>* %x
  ret void
}

define void @buildvec_dominant1_v4f32(<4 x float>* %x, float %f) {
; CHECK-LABEL: buildvec_dominant1_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    vmv.s.x v9, zero
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %v0 = insertelement <4 x float> poison, float %f, i32 0
  %v1 = insertelement <4 x float> %v0, float 0.0, i32 1
  %v2 = insertelement <4 x float> %v1, float %f, i32 2
  %v3 = insertelement <4 x float> %v2, float %f, i32 3
  store <4 x float> %v3, <4 x float>* %x
  ret void
}

define void @buildvec_dominant2_v4f32(<4 x float>* %x, float %f) {
; CHECK-LABEL: buildvec_dominant2_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.s.x v8, a1
; CHECK-NEXT:    vfmv.v.f v9, fa0
; CHECK-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v9, (a0)
; CHECK-NEXT:    ret
  %v0 = insertelement <4 x float> poison, float %f, i32 0
  %v1 = insertelement <4 x float> %v0, float 2.0, i32 1
  %v2 = insertelement <4 x float> %v1, float %f, i32 2
  %v3 = insertelement <4 x float> %v2, float %f, i32 3
  store <4 x float> %v3, <4 x float>* %x
  ret void
}

define void @buildvec_merge0_v4f32(<4 x float>* %x, float %f) {
; CHECK-LABEL: buildvec_merge0_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.v.f v8, fa0
; CHECK-NEXT:    vmv.v.i v0, 6
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    vmerge.vxm v8, v8, a1, v0
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %v0 = insertelement <4 x float> poison, float %f, i32 0
  %v1 = insertelement <4 x float> %v0, float 2.0, i32 1
  %v2 = insertelement <4 x float> %v1, float 2.0, i32 2
  %v3 = insertelement <4 x float> %v2, float %f, i32 3
  store <4 x float> %v3, <4 x float>* %x
  ret void
}

define <4 x half> @splat_c3_v4f16(<4 x half> %v) {
; CHECK-LABEL: splat_c3_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vrgather.vi v9, v8, 3
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %x = extractelement <4 x half> %v, i32 3
  %ins = insertelement <4 x half> poison, half %x, i32 0
  %splat = shufflevector <4 x half> %ins, <4 x half> poison, <4 x i32> zeroinitializer
  ret <4 x half> %splat
}

define <4 x half> @splat_idx_v4f16(<4 x half> %v, i64 %idx) {
; CHECK-LABEL: splat_idx_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vrgather.vx v9, v8, a0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %x = extractelement <4 x half> %v, i64 %idx
  %ins = insertelement <4 x half> poison, half %x, i32 0
  %splat = shufflevector <4 x half> %ins, <4 x half> poison, <4 x i32> zeroinitializer
  ret <4 x half> %splat
}

define <8 x float> @splat_c5_v8f32(<8 x float> %v) {
; CHECK-LABEL: splat_c5_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vrgather.vi v10, v8, 5
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %x = extractelement <8 x float> %v, i32 5
  %ins = insertelement <8 x float> poison, float %x, i32 0
  %splat = shufflevector <8 x float> %ins, <8 x float> poison, <8 x i32> zeroinitializer
  ret <8 x float> %splat
}

define <8 x float> @splat_idx_v8f32(<8 x float> %v, i64 %idx) {
;
; CHECK-LABEL: splat_idx_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vrgather.vx v10, v8, a0
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %x = extractelement <8 x float> %v, i64 %idx
  %ins = insertelement <8 x float> poison, float %x, i32 0
  %splat = shufflevector <8 x float> %ins, <8 x float> poison, <8 x i32> zeroinitializer
  ret <8 x float> %splat
}

; Test that we pull the vlse of the constant pool out of the loop.
define dso_local void @splat_load_licm(float* %0) {
; RV32-LABEL: splat_load_licm:
; RV32:       # %bb.0:
; RV32-NEXT:    li a1, 1024
; RV32-NEXT:    lui a2, 263168
; RV32-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; RV32-NEXT:    vmv.v.x v8, a2
; RV32-NEXT:  .LBB12_1: # =>This Inner Loop Header: Depth=1
; RV32-NEXT:    vse32.v v8, (a0)
; RV32-NEXT:    addi a1, a1, -4
; RV32-NEXT:    addi a0, a0, 16
; RV32-NEXT:    bnez a1, .LBB12_1
; RV32-NEXT:  # %bb.2:
; RV32-NEXT:    ret
;
; RV64-LABEL: splat_load_licm:
; RV64:       # %bb.0:
; RV64-NEXT:    li a1, 1024
; RV64-NEXT:    lui a2, 263168
; RV64-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; RV64-NEXT:    vmv.v.x v8, a2
; RV64-NEXT:  .LBB12_1: # =>This Inner Loop Header: Depth=1
; RV64-NEXT:    vse32.v v8, (a0)
; RV64-NEXT:    addiw a1, a1, -4
; RV64-NEXT:    addi a0, a0, 16
; RV64-NEXT:    bnez a1, .LBB12_1
; RV64-NEXT:  # %bb.2:
; RV64-NEXT:    ret
  br label %2

2:                                                ; preds = %2, %1
  %3 = phi i32 [ 0, %1 ], [ %6, %2 ]
  %4 = getelementptr inbounds float, float* %0, i32 %3
  %5 = bitcast float* %4 to <4 x float>*
  store <4 x float> <float 3.000000e+00, float 3.000000e+00, float 3.000000e+00, float 3.000000e+00>, <4 x float>* %5, align 4
  %6 = add nuw i32 %3, 4
  %7 = icmp eq i32 %6, 1024
  br i1 %7, label %8, label %2

8:                                                ; preds = %2
  ret void
}

define <2 x half> @buildvec_v2f16(half %a, half %b) {
; CHECK-LABEL: buildvec_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa0
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa1
; CHECK-NEXT:    ret
  %v1 = insertelement <2 x half> poison, half %a, i64 0
  %v2 = insertelement <2 x half> %v1, half %b, i64 1
  ret <2 x half> %v2
}

define <2 x float> @buildvec_v2f32(float %a, float %b) {
; CHECK-LABEL: buildvec_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa0
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa1
; CHECK-NEXT:    ret
  %v1 = insertelement <2 x float> poison, float %a, i64 0
  %v2 = insertelement <2 x float> %v1, float %b, i64 1
  ret <2 x float> %v2
}

define <2 x double> @buildvec_v2f64(double %a, double %b) {
; CHECK-LABEL: buildvec_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa0
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa1
; CHECK-NEXT:    ret
  %v1 = insertelement <2 x double> poison, double %a, i64 0
  %v2 = insertelement <2 x double> %v1, double %b, i64 1
  ret <2 x double> %v2
}

define <2 x double> @buildvec_v2f64_b(double %a, double %b) {
; CHECK-LABEL: buildvec_v2f64_b:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa0
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa1
; CHECK-NEXT:    ret
  %v1 = insertelement <2 x double> poison, double %b, i64 1
  %v2 = insertelement <2 x double> %v1, double %a, i64 0
  ret <2 x double> %v2
}

define <4 x float> @buildvec_v4f32(float %a, float %b, float %c, float %d) {
; CHECK-LABEL: buildvec_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa0
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa1
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa2
; CHECK-NEXT:    vfslide1down.vf v8, v8, fa3
; CHECK-NEXT:    ret
  %v1 = insertelement <4 x float> poison, float %a, i64 0
  %v2 = insertelement <4 x float> %v1, float %b, i64 1
  %v3 = insertelement <4 x float> %v2, float %c, i64 2
  %v4 = insertelement <4 x float> %v3, float %d, i64 3
  ret <4 x float> %v4
}
