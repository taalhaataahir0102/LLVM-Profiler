; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define <4 x i16> @shuffle_v4i16(<4 x i16> %x, <4 x i16> %y) {
; CHECK-LABEL: shuffle_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 11
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> %y, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  ret <4 x i16> %s
}

define <8 x i32> @shuffle_v8i32(<8 x i32> %x, <8 x i32> %y) {
; CHECK-LABEL: shuffle_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 203
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i32> %x, <8 x i32> %y, <8 x i32> <i32 0, i32 1, i32 10, i32 3, i32 12, i32 13, i32 6, i32 7>
  ret <8 x i32> %s
}

define <4 x i16> @shuffle_xv_v4i16(<4 x i16> %x) {
; CHECK-LABEL: shuffle_xv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 9
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v8, 5, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i16> %x, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x i16> %s
}

define <4 x i16> @shuffle_vx_v4i16(<4 x i16> %x) {
; CHECK-LABEL: shuffle_vx_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.i v0, 6
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v8, 5, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_permute_shuffle_vu_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_permute_shuffle_vu_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI4_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI4_0)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> poison, <4 x i32> <i32 1, i32 2, i32 0, i32 1>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_permute_shuffle_uv_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_permute_shuffle_uv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI5_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI5_0)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> poison, <4 x i16> %x, <4 x i32> <i32 5, i32 6, i32 4, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_vv_v4i16(<4 x i16> %x, <4 x i16> %y) {
; CHECK-LABEL: vrgather_shuffle_vv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI6_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI6_0)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, mu
; CHECK-NEXT:    vle16.v v11, (a0)
; CHECK-NEXT:    vmv.v.i v0, 8
; CHECK-NEXT:    vrgather.vv v10, v8, v11
; CHECK-NEXT:    vrgather.vi v10, v9, 1, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> %y, <4 x i32> <i32 1, i32 2, i32 0, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_xv_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_shuffle_xv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, mu
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    vrsub.vi v10, v9, 4
; CHECK-NEXT:    vmv.v.i v0, 12
; CHECK-NEXT:    vmv.v.i v9, 5
; CHECK-NEXT:    vrgather.vv v9, v8, v10, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i16> %x, <4 x i32> <i32 0, i32 3, i32 6, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_vx_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_shuffle_vx_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, mu
; CHECK-NEXT:    vid.v v9
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vmul.vx v10, v9, a0
; CHECK-NEXT:    vmv.v.i v0, 3
; CHECK-NEXT:    vmv.v.i v9, 5
; CHECK-NEXT:    vrgather.vv v9, v8, v10, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i32> <i32 0, i32 3, i32 6, i32 5>
  ret <4 x i16> %s
}

define <8 x i64> @vrgather_permute_shuffle_vu_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_permute_shuffle_vu_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI9_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI9_0)
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vle16.v v16, (a0)
; RV32-NEXT:    vrgatherei16.vv v12, v8, v16
; RV32-NEXT:    vmv.v.v v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_permute_shuffle_vu_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI9_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI9_0)
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vle64.v v16, (a0)
; RV64-NEXT:    vrgather.vv v12, v8, v16
; RV64-NEXT:    vmv.v.v v8, v12
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> poison, <8 x i32> <i32 1, i32 2, i32 0, i32 1, i32 7, i32 6, i32 0, i32 1>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_permute_shuffle_uv_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_permute_shuffle_uv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI10_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI10_0)
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vle16.v v16, (a0)
; RV32-NEXT:    vrgatherei16.vv v12, v8, v16
; RV32-NEXT:    vmv.v.v v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_permute_shuffle_uv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI10_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI10_0)
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vle64.v v16, (a0)
; RV64-NEXT:    vrgather.vv v12, v8, v16
; RV64-NEXT:    vmv.v.v v8, v12
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> poison, <8 x i64> %x, <8 x i32> <i32 9, i32 10, i32 8, i32 9, i32 15, i32 8, i32 8, i32 11>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_vv_v8i64(<8 x i64> %x, <8 x i64> %y) {
; RV32-LABEL: vrgather_shuffle_vv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; RV32-NEXT:    vmv.v.i v16, 2
; RV32-NEXT:    lui a0, %hi(.LCPI11_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI11_0)
; RV32-NEXT:    vle16.v v20, (a0)
; RV32-NEXT:    li a0, 5
; RV32-NEXT:    vslide1down.vx v21, v16, a0
; RV32-NEXT:    vsetvli zero, zero, e64, m4, ta, ma
; RV32-NEXT:    vrgatherei16.vv v16, v8, v20
; RV32-NEXT:    li a0, 164
; RV32-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; RV32-NEXT:    vmv.v.x v0, a0
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; RV32-NEXT:    vrgatherei16.vv v16, v12, v21, v0.t
; RV32-NEXT:    vmv.v.v v8, v16
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    lui a0, %hi(.LCPI11_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI11_0)
; RV64-NEXT:    vle64.v v20, (a0)
; RV64-NEXT:    vmv.v.i v16, 2
; RV64-NEXT:    li a0, 5
; RV64-NEXT:    vslide1down.vx v24, v16, a0
; RV64-NEXT:    vrgather.vv v16, v8, v20
; RV64-NEXT:    li a0, 164
; RV64-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; RV64-NEXT:    vmv.v.x v0, a0
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; RV64-NEXT:    vrgather.vv v16, v12, v24, v0.t
; RV64-NEXT:    vmv.v.v v8, v16
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> %y, <8 x i32> <i32 1, i32 2, i32 10, i32 5, i32 1, i32 10, i32 3, i32 13>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_xv_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_shuffle_xv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI12_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI12_0)
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vle16.v v16, (a0)
; RV32-NEXT:    vmv.v.i v20, -1
; RV32-NEXT:    vrgatherei16.vv v12, v20, v16
; RV32-NEXT:    lui a0, %hi(.LCPI12_1)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI12_1)
; RV32-NEXT:    vle16.v v16, (a0)
; RV32-NEXT:    li a0, 113
; RV32-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; RV32-NEXT:    vmv.v.x v0, a0
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; RV32-NEXT:    vrgatherei16.vv v12, v8, v16, v0.t
; RV32-NEXT:    vmv.v.v v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_xv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI12_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI12_0)
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vle64.v v16, (a0)
; RV64-NEXT:    li a0, 113
; RV64-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; RV64-NEXT:    vmv.v.x v0, a0
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; RV64-NEXT:    vmv.v.i v12, -1
; RV64-NEXT:    vrgather.vv v12, v8, v16, v0.t
; RV64-NEXT:    vmv.v.v v8, v12
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, <8 x i64> %x, <8 x i32> <i32 8, i32 3, i32 6, i32 5, i32 8, i32 12, i32 14, i32 3>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_vx_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_shuffle_vx_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI13_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI13_0)
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vle16.v v16, (a0)
; RV32-NEXT:    vrgatherei16.vv v12, v8, v16
; RV32-NEXT:    lui a0, %hi(.LCPI13_1)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI13_1)
; RV32-NEXT:    vle16.v v8, (a0)
; RV32-NEXT:    li a0, 140
; RV32-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; RV32-NEXT:    vmv.v.x v0, a0
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; RV32-NEXT:    vmv.v.i v16, 5
; RV32-NEXT:    vrgatherei16.vv v12, v16, v8, v0.t
; RV32-NEXT:    vmv.v.v v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vx_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI13_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI13_0)
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vle64.v v16, (a0)
; RV64-NEXT:    li a0, 115
; RV64-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; RV64-NEXT:    vmv.v.x v0, a0
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, mu
; RV64-NEXT:    vmv.v.i v12, 5
; RV64-NEXT:    vrgather.vv v12, v8, v16, v0.t
; RV64-NEXT:    vmv.v.v v8, v12
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> <i64 5, i64 5, i64 5, i64 5, i64 5, i64 5, i64 5, i64 5>, <8 x i32> <i32 0, i32 3, i32 10, i32 9, i32 4, i32 1, i32 7, i32 14>
  ret <8 x i64> %s
}

define <4 x i16> @shuffle_v8i16_to_vslidedown_1(<8 x i16> %x) {
; CHECK-LABEL: shuffle_v8i16_to_vslidedown_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 1
; CHECK-NEXT:    ret
entry:
  %s = shufflevector <8 x i16> %x, <8 x i16> poison, <4 x i32> <i32 1, i32 2, i32 3, i32 4>
  ret <4 x i16> %s
}

define <4 x i16> @shuffle_v8i16_to_vslidedown_3(<8 x i16> %x) {
; CHECK-LABEL: shuffle_v8i16_to_vslidedown_3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 3
; CHECK-NEXT:    ret
entry:
  %s = shufflevector <8 x i16> %x, <8 x i16> poison, <4 x i32> <i32 3, i32 4, i32 5, i32 6>
  ret <4 x i16> %s
}

define <2 x i32> @shuffle_v4i32_to_vslidedown(<4 x i32> %x) {
; CHECK-LABEL: shuffle_v4i32_to_vslidedown:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 1
; CHECK-NEXT:    ret
entry:
  %s = shufflevector <4 x i32> %x, <4 x i32> poison, <2 x i32> <i32 1, i32 2>
  ret <2 x i32> %s
}

define <4 x i8> @interleave_shuffles(<4 x i8> %x) {
; CHECK-LABEL: interleave_shuffles:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vrgather.vi v9, v8, 0
; CHECK-NEXT:    vrgather.vi v10, v8, 1
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vwaddu.vv v8, v9, v10
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vwmaccu.vx v8, a0, v10
; CHECK-NEXT:    ret
  %y = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> <i32 0, i32 0, i32 0, i32 0>
  %z = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %w = shufflevector <4 x i8> %y, <4 x i8> %z, <4 x i32> <i32 0, i32 4, i32 1, i32 5>
  ret <4 x i8> %w
}

define <8 x i8> @splat_ve4(<8 x i8> %v) {
; CHECK-LABEL: splat_ve4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vrgather.vi v9, v8, 4
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> poison, <8 x i32> <i32 4, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4>
  ret <8 x i8> %shuff
}

define <8 x i8> @splat_ve4_ins_i0ve2(<8 x i8> %v) {
; CHECK-LABEL: splat_ve4_ins_i0ve2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 4
; CHECK-NEXT:    li a0, 2
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, tu, ma
; CHECK-NEXT:    vmv.s.x v10, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> poison, <8 x i32> <i32 2, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4>
  ret <8 x i8> %shuff
}

define <8 x i8> @splat_ve4_ins_i1ve3(<8 x i8> %v) {
; CHECK-LABEL: splat_ve4_ins_i1ve3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 3
; CHECK-NEXT:    vmv.v.i v10, 4
; CHECK-NEXT:    vsetivli zero, 2, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v10, v9, 1
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vrgather.vv v9, v8, v10
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> poison, <8 x i32> <i32 4, i32 3, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4>
  ret <8 x i8> %shuff
}

define <8 x i8> @splat_ve2_we0(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: splat_ve2_we0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    li a0, 66
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vrgather.vi v10, v8, 2
; CHECK-NEXT:    vrgather.vi v10, v9, 0, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 2, i32 8, i32 2, i32 2, i32 2, i32 2, i32 8, i32 2>
  ret <8 x i8> %shuff
}

define <8 x i8> @splat_ve2_we0_ins_i0ve4(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: splat_ve2_we0_ins_i0ve4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v11, 2
; CHECK-NEXT:    li a0, 4
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, tu, ma
; CHECK-NEXT:    vmv.s.x v11, a0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, mu
; CHECK-NEXT:    li a0, 66
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vrgather.vv v10, v8, v11
; CHECK-NEXT:    vrgather.vi v10, v9, 0, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 4, i32 8, i32 2, i32 2, i32 2, i32 2, i32 8, i32 2>
  ret <8 x i8> %shuff
}

define <8 x i8> @splat_ve2_we0_ins_i0we4(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: splat_ve2_we0_ins_i0we4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vrgather.vi v10, v8, 2
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 4
; CHECK-NEXT:    li a0, 67
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vrgather.vv v10, v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 12, i32 8, i32 2, i32 2, i32 2, i32 2, i32 8, i32 2>
  ret <8 x i8> %shuff
}

define <8 x i8> @splat_ve2_we0_ins_i2ve4(<8 x i8> %v, <8 x i8> %w) {
; RV32-LABEL: splat_ve2_we0_ins_i2ve4:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, 8256
; RV32-NEXT:    addi a0, a0, 514
; RV32-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v11, a0
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; RV32-NEXT:    li a0, 66
; RV32-NEXT:    vmv.v.x v0, a0
; RV32-NEXT:    vrgather.vv v10, v8, v11
; RV32-NEXT:    vrgather.vi v10, v9, 0, v0.t
; RV32-NEXT:    vmv1r.v v8, v10
; RV32-NEXT:    ret
;
; RV64-LABEL: splat_ve2_we0_ins_i2ve4:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, 8256
; RV64-NEXT:    addiw a0, a0, 514
; RV64-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v11, a0
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; RV64-NEXT:    li a0, 66
; RV64-NEXT:    vmv.v.x v0, a0
; RV64-NEXT:    vrgather.vv v10, v8, v11
; RV64-NEXT:    vrgather.vi v10, v9, 0, v0.t
; RV64-NEXT:    vmv1r.v v8, v10
; RV64-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 2, i32 8, i32 4, i32 2, i32 2, i32 2, i32 8, i32 2>
  ret <8 x i8> %shuff
}

define <8 x i8> @splat_ve2_we0_ins_i2we4(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: splat_ve2_we0_ins_i2we4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 4
; CHECK-NEXT:    vmv.v.i v11, 0
; CHECK-NEXT:    vsetivli zero, 3, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v11, v10, 2
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    li a0, 70
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vrgather.vi v10, v8, 2
; CHECK-NEXT:    vrgather.vv v10, v9, v11, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 2, i32 8, i32 12, i32 2, i32 2, i32 2, i32 8, i32 2>
  ret <8 x i8> %shuff
}

define <8 x i8> @splat_ve2_we0_ins_i2ve4_i5we6(<8 x i8> %v, <8 x i8> %w) {
; RV32-LABEL: splat_ve2_we0_ins_i2ve4_i5we6:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vmv.v.i v10, 6
; RV32-NEXT:    vmv.v.i v11, 0
; RV32-NEXT:    vsetivli zero, 6, e8, mf2, tu, ma
; RV32-NEXT:    vslideup.vi v11, v10, 5
; RV32-NEXT:    lui a0, 8256
; RV32-NEXT:    addi a0, a0, 2
; RV32-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV32-NEXT:    vmv.v.x v12, a0
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; RV32-NEXT:    li a0, 98
; RV32-NEXT:    vmv.v.x v0, a0
; RV32-NEXT:    vrgather.vv v10, v8, v12
; RV32-NEXT:    vrgather.vv v10, v9, v11, v0.t
; RV32-NEXT:    vmv1r.v v8, v10
; RV32-NEXT:    ret
;
; RV64-LABEL: splat_ve2_we0_ins_i2ve4_i5we6:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vmv.v.i v10, 6
; RV64-NEXT:    vmv.v.i v11, 0
; RV64-NEXT:    vsetivli zero, 6, e8, mf2, tu, ma
; RV64-NEXT:    vslideup.vi v11, v10, 5
; RV64-NEXT:    lui a0, 8256
; RV64-NEXT:    addiw a0, a0, 2
; RV64-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; RV64-NEXT:    vmv.v.x v12, a0
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; RV64-NEXT:    li a0, 98
; RV64-NEXT:    vmv.v.x v0, a0
; RV64-NEXT:    vrgather.vv v10, v8, v12
; RV64-NEXT:    vrgather.vv v10, v9, v11, v0.t
; RV64-NEXT:    vmv1r.v v8, v10
; RV64-NEXT:    ret
  %shuff = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 2, i32 8, i32 4, i32 2, i32 2, i32 14, i32 8, i32 2>
  ret <8 x i8> %shuff
}

define <8 x i8> @widen_splat_ve3(<4 x i8> %v) {
; CHECK-LABEL: widen_splat_ve3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vrgather.vi v9, v8, 3
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %shuf = shufflevector <4 x i8> %v, <4 x i8> poison, <8 x i32> <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>
  ret <8 x i8> %shuf
}

define <4 x i16> @slidedown_v4i16(<4 x i16> %x) {
; CHECK-LABEL: slidedown_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 1
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> poison, <4 x i32> <i32 1, i32 2, i32 3, i32 undef>
  ret <4 x i16> %s
}

define <8 x i32> @slidedown_v8i32(<8 x i32> %x) {
; CHECK-LABEL: slidedown_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 3
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i32> %x, <8 x i32> poison, <8 x i32> <i32 3, i32 undef, i32 5, i32 6, i32 undef, i32 undef, i32 undef, i32 undef>
  ret <8 x i32> %s
}

define <4 x i16> @slideup_v4i16(<4 x i16> %x) {
; CHECK-LABEL: slideup_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 1
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> poison, <4 x i32> <i32 undef, i32 0, i32 1, i32 2>
  ret <4 x i16> %s
}

define <8 x i32> @slideup_v8i32(<8 x i32> %x) {
; CHECK-LABEL: slideup_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslideup.vi v10, v8, 3
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i32> %x, <8 x i32> poison, <8 x i32> <i32 undef, i32 undef, i32 undef, i32 undef, i32 1, i32 2, i32 3, i32 4>
  ret <8 x i32> %s
}

define <8 x i16> @splice_unary(<8 x i16> %x) {
; CHECK-LABEL: splice_unary:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v9, v8, 2
; CHECK-NEXT:    vslideup.vi v9, v8, 6
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i16> %x, <8 x i16> poison, <8 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1>
  ret <8 x i16> %s
}

define <8 x i32> @splice_unary2(<8 x i32> %x) {
; CHECK-LABEL: splice_unary2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 5
; CHECK-NEXT:    vslideup.vi v10, v8, 3
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i32> %x, <8 x i32> poison, <8 x i32> <i32 undef, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3, i32 4>
  ret <8 x i32> %s
}

define <8 x i16> @splice_binary(<8 x i16> %x, <8 x i16> %y) {
; CHECK-LABEL: splice_binary:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vslideup.vi v8, v9, 6
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i16> %x, <8 x i16> %y, <8 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 undef, i32 9>
  ret <8 x i16> %s
}

define <8 x i32> @splice_binary2(<8 x i32> %x, <8 x i32> %y) {
; CHECK-LABEL: splice_binary2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 5
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i32> %x, <8 x i32> %y, <8 x i32> <i32 undef, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12>
  ret <8 x i32> %s
}

define <4 x i16> @shuffle_shuffle_vslidedown(<16 x i16> %0) {
; CHECK-LABEL: shuffle_shuffle_vslidedown:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 5
; CHECK-NEXT:    ret
entry:
  %1 = shufflevector <16 x i16> %0, <16 x i16> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %2 = shufflevector <16 x i16> %0, <16 x i16> poison, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %3 = shufflevector <8 x i16> %1, <8 x i16> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %4 = shufflevector <8 x i16> %2, <8 x i16> poison, <4 x i32> <i32 0, i32 undef, i32 undef, i32 undef>
  %5 = shufflevector <4 x i16> %3, <4 x i16> %4, <4 x i32> <i32 1, i32 2, i32 3, i32 4>
  ret <4 x i16> %5
}

define <8 x i8> @concat_4xi8_start(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: concat_4xi8_start:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 4
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  ret <8 x i8> %res
}

define <8 x i8> @concat_4xi8_start_undef(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: concat_4xi8_start_undef:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 4
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 undef, i32 10, i32 11>
  ret <8 x i8> %res
}

define <8 x i8> @concat_4xi8_start_undef_at_start(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: concat_4xi8_start_undef_at_start:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vid.v v11
; CHECK-NEXT:    vrgather.vv v10, v8, v11
; CHECK-NEXT:    li a0, 224
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vadd.vi v8, v11, -4
; CHECK-NEXT:    vrgather.vv v10, v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 9, i32 10, i32 11>
  ret <8 x i8> %res
}

define <8 x i8> @merge_start_into_end_non_contiguous(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: merge_start_into_end_non_contiguous:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vid.v v11
; CHECK-NEXT:    vrgather.vv v10, v8, v11
; CHECK-NEXT:    li a0, 144
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vadd.vi v8, v11, -4
; CHECK-NEXT:    vrgather.vv v10, v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 5, i32 6, i32 11>
  ret <8 x i8> %res
}

define <8 x i8> @merge_end_into_end(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: merge_end_into_end:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; CHECK-NEXT:    vmv.v.v v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
  ret <8 x i8> %res
}

define <8 x i8> @merge_start_into_middle(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: merge_start_into_middle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 5, e8, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 1
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 8, i32 9, i32 10, i32 11, i32 5, i32 6, i32 7>
  ret <8 x i8> %res
}

define <8 x i8> @merge_start_into_start(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: merge_start_into_start:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i8> %res
}

define <8 x i8> @merge_slidedown(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: merge_slidedown:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vid.v v11
; CHECK-NEXT:    vadd.vi v12, v11, 1
; CHECK-NEXT:    li a0, 195
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    vrgather.vv v10, v9, v11, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 8, i32 9, i32 3, i32 4, i32 5, i32 6, i32 14, i32 15>
  ret <8 x i8> %res
}

; This should slide %v down by 2 and %w up by 1 before merging them
define <8 x i8> @merge_non_contiguous_slideup_slidedown(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: merge_non_contiguous_slideup_slidedown:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vid.v v11
; CHECK-NEXT:    vadd.vi v12, v11, 2
; CHECK-NEXT:    vrgather.vv v10, v8, v12
; CHECK-NEXT:    li a0, 234
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vadd.vi v8, v11, -1
; CHECK-NEXT:    vrgather.vv v10, v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 2, i32 8, i32 4, i32 10, i32 6, i32 12, i32 13, i32 14>
  ret <8 x i8> %res
}

; This shouldn't generate a vmerge because the elements of %w are not consecutive
define <8 x i8> @unmergable(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: unmergable:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vid.v v10
; CHECK-NEXT:    vadd.vi v11, v10, 2
; CHECK-NEXT:    lui a0, %hi(.LCPI46_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI46_0)
; CHECK-NEXT:    vle8.v v12, (a0)
; CHECK-NEXT:    li a0, 234
; CHECK-NEXT:    vmv.v.x v0, a0
; CHECK-NEXT:    vrgather.vv v10, v8, v11
; CHECK-NEXT:    vrgather.vv v10, v9, v12, v0.t
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 2, i32 9, i32 4, i32 11, i32 6, i32 13, i32 8, i32 15>
  ret <8 x i8> %res
}
