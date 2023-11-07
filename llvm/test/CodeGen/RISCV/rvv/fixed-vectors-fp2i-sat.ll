; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+zvfh,+f,+d -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+zvfh,+f,+d -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define void @fp2si_v2f32_v2i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = call <2 x i32> @llvm.fptosi.sat.v2i32.v2f32(<2 x float> %a)
  store <2 x i32> %d, ptr %y
  ret void
}
declare <2 x i32> @llvm.fptosi.sat.v2i32.v2f32(<2 x float>)

define void @fp2ui_v2f32_v2i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = call <2 x i32> @llvm.fptoui.sat.v2i32.v2f32(<2 x float> %a)
  store <2 x i32> %d, ptr %y
  ret void
}
declare <2 x i32> @llvm.fptoui.sat.v2i32.v2f32(<2 x float>)

define void @fp2si_v8f32_v8i32(ptr %x, ptr %y) {
;
; CHECK-LABEL: fp2si_v8f32_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = call <8 x i32> @llvm.fptosi.sat.v8i32.v8f32(<8 x float> %a)
  store <8 x i32> %d, ptr %y
  ret void
}
declare <8 x i32> @llvm.fptosi.sat.v8i32.v8f32(<8 x float>)

define void @fp2ui_v8f32_v8i32(ptr %x, ptr %y) {
;
; CHECK-LABEL: fp2ui_v8f32_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = call <8 x i32> @llvm.fptosi.sat.v8i32.v8f32(<8 x float> %a)
  store <8 x i32> %d, ptr %y
  ret void
}
declare <8 x i32> @llvm.fptoui.sat.v8i32.v8f32(<8 x float>)

define void @fp2si_v2f32_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v9, 0, v0
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = call <2 x i64> @llvm.fptosi.sat.v2i64.v2f32(<2 x float> %a)
  store <2 x i64> %d, ptr %y
  ret void
}
declare <2 x i64> @llvm.fptosi.sat.v2i64.v2f32(<2 x float>)

define void @fp2ui_v2f32_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v9, 0, v0
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = call <2 x i64> @llvm.fptoui.sat.v2i64.v2f32(<2 x float> %a)
  store <2 x i64> %d, ptr %y
  ret void
}
declare <2 x i64> @llvm.fptoui.sat.v2i64.v2f32(<2 x float>)

define void @fp2si_v8f32_v8i64(ptr %x, ptr %y) {
;
; CHECK-LABEL: fp2si_v8f32_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v12, v8
; CHECK-NEXT:    vsetvli zero, zero, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v12, 0, v0
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = call <8 x i64> @llvm.fptosi.sat.v8i64.v8f32(<8 x float> %a)
  store <8 x i64> %d, ptr %y
  ret void
}
declare <8 x i64> @llvm.fptosi.sat.v8i64.v8f32(<8 x float>)

define void @fp2ui_v8f32_v8i64(ptr %x, ptr %y) {
;
; CHECK-LABEL: fp2ui_v8f32_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v12, v8
; CHECK-NEXT:    vsetvli zero, zero, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v12, 0, v0
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = call <8 x i64> @llvm.fptoui.sat.v8i64.v8f32(<8 x float> %a)
  store <8 x i64> %d, ptr %y
  ret void
}
declare <8 x i64> @llvm.fptoui.sat.v8i64.v8f32(<8 x float>)

define void @fp2si_v2f16_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v8, v9
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x half>, ptr %x
  %d = call <2 x i64> @llvm.fptosi.sat.v2i64.v2f16(<2 x half> %a)
  store <2 x i64> %d, ptr %y
  ret void
}
declare <2 x i64> @llvm.fptosi.sat.v2i64.v2f16(<2 x half>)

define void @fp2ui_v2f16_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v8, v9
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vim v8, v8, 0, v0
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x half>, ptr %x
  %d = call <2 x i64> @llvm.fptoui.sat.v2i64.v2f16(<2 x half> %a)
  store <2 x i64> %d, ptr %y
  ret void
}
declare <2 x i64> @llvm.fptoui.sat.v2i64.v2f16(<2 x half>)

define void @fp2si_v2f64_v2i8(ptr %x, ptr %y) {
; RV32-LABEL: fp2si_v2f64_v2i8:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-NEXT:    vle64.v v8, (a0)
; RV32-NEXT:    vslidedown.vi v9, v8, 1
; RV32-NEXT:    vfmv.f.s fa5, v9
; RV32-NEXT:    lui a0, %hi(.LCPI10_0)
; RV32-NEXT:    fld fa4, %lo(.LCPI10_0)(a0)
; RV32-NEXT:    lui a0, %hi(.LCPI10_1)
; RV32-NEXT:    fld fa3, %lo(.LCPI10_1)(a0)
; RV32-NEXT:    feq.d a0, fa5, fa5
; RV32-NEXT:    neg a0, a0
; RV32-NEXT:    fmax.d fa5, fa5, fa4
; RV32-NEXT:    fmin.d fa5, fa5, fa3
; RV32-NEXT:    fcvt.w.d a2, fa5, rtz
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    vfmv.f.s fa5, v8
; RV32-NEXT:    feq.d a2, fa5, fa5
; RV32-NEXT:    neg a2, a2
; RV32-NEXT:    fmax.d fa5, fa5, fa4
; RV32-NEXT:    fmin.d fa5, fa5, fa3
; RV32-NEXT:    fcvt.w.d a3, fa5, rtz
; RV32-NEXT:    and a2, a2, a3
; RV32-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; RV32-NEXT:    vslide1down.vx v8, v8, a2
; RV32-NEXT:    vslide1down.vx v8, v8, a0
; RV32-NEXT:    vse8.v v8, (a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: fp2si_v2f64_v2i8:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-NEXT:    vle64.v v8, (a0)
; RV64-NEXT:    vslidedown.vi v9, v8, 1
; RV64-NEXT:    vfmv.f.s fa5, v9
; RV64-NEXT:    lui a0, %hi(.LCPI10_0)
; RV64-NEXT:    fld fa4, %lo(.LCPI10_0)(a0)
; RV64-NEXT:    lui a0, %hi(.LCPI10_1)
; RV64-NEXT:    fld fa3, %lo(.LCPI10_1)(a0)
; RV64-NEXT:    feq.d a0, fa5, fa5
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    fmax.d fa5, fa5, fa4
; RV64-NEXT:    fmin.d fa5, fa5, fa3
; RV64-NEXT:    fcvt.l.d a2, fa5, rtz
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    vfmv.f.s fa5, v8
; RV64-NEXT:    feq.d a2, fa5, fa5
; RV64-NEXT:    neg a2, a2
; RV64-NEXT:    fmax.d fa5, fa5, fa4
; RV64-NEXT:    fmin.d fa5, fa5, fa3
; RV64-NEXT:    fcvt.l.d a3, fa5, rtz
; RV64-NEXT:    and a2, a2, a3
; RV64-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; RV64-NEXT:    vslide1down.vx v8, v8, a2
; RV64-NEXT:    vslide1down.vx v8, v8, a0
; RV64-NEXT:    vse8.v v8, (a1)
; RV64-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %d = call <2 x i8> @llvm.fptosi.sat.v2i8.v2f64(<2 x double> %a)
  store <2 x i8> %d, ptr %y
  ret void
}
declare <2 x i8> @llvm.fptosi.sat.v2i8.v2f64(<2 x double>)

define void @fp2ui_v2f64_v2i8(ptr %x, ptr %y) {
; RV32-LABEL: fp2ui_v2f64_v2i8:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-NEXT:    vle64.v v8, (a0)
; RV32-NEXT:    lui a0, %hi(.LCPI11_0)
; RV32-NEXT:    fld fa5, %lo(.LCPI11_0)(a0)
; RV32-NEXT:    vfmv.f.s fa4, v8
; RV32-NEXT:    fcvt.d.w fa3, zero
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa4, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa4, rtz
; RV32-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; RV32-NEXT:    vslide1down.vx v9, v8, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v8, 1
; RV32-NEXT:    vfmv.f.s fa4, v8
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa5, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa5, rtz
; RV32-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; RV32-NEXT:    vslide1down.vx v8, v9, a0
; RV32-NEXT:    vse8.v v8, (a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: fp2ui_v2f64_v2i8:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-NEXT:    vle64.v v8, (a0)
; RV64-NEXT:    lui a0, %hi(.LCPI11_0)
; RV64-NEXT:    fld fa5, %lo(.LCPI11_0)(a0)
; RV64-NEXT:    vfmv.f.s fa4, v8
; RV64-NEXT:    fmv.d.x fa3, zero
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa4, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa4, rtz
; RV64-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; RV64-NEXT:    vslide1down.vx v9, v8, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v8, 1
; RV64-NEXT:    vfmv.f.s fa4, v8
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa5, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa5, rtz
; RV64-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; RV64-NEXT:    vslide1down.vx v8, v9, a0
; RV64-NEXT:    vse8.v v8, (a1)
; RV64-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %d = call <2 x i8> @llvm.fptoui.sat.v2i8.v2f64(<2 x double> %a)
  store <2 x i8> %d, ptr %y
  ret void
}
declare <2 x i8> @llvm.fptoui.sat.v2i8.v2f64(<2 x double>)

define void @fp2si_v8f64_v8i8(ptr %x, ptr %y) {
;
; RV32-LABEL: fp2si_v8f64_v8i8:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vle64.v v8, (a0)
; RV32-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV32-NEXT:    vslidedown.vi v12, v8, 1
; RV32-NEXT:    vfmv.f.s fa3, v12
; RV32-NEXT:    lui a0, %hi(.LCPI12_0)
; RV32-NEXT:    fld fa5, %lo(.LCPI12_0)(a0)
; RV32-NEXT:    lui a0, %hi(.LCPI12_1)
; RV32-NEXT:    fld fa4, %lo(.LCPI12_1)(a0)
; RV32-NEXT:    feq.d a0, fa3, fa3
; RV32-NEXT:    neg a0, a0
; RV32-NEXT:    fmax.d fa3, fa3, fa5
; RV32-NEXT:    fmin.d fa3, fa3, fa4
; RV32-NEXT:    fcvt.w.d a2, fa3, rtz
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    vfmv.f.s fa3, v8
; RV32-NEXT:    feq.d a2, fa3, fa3
; RV32-NEXT:    neg a2, a2
; RV32-NEXT:    fmax.d fa3, fa3, fa5
; RV32-NEXT:    fmin.d fa3, fa3, fa4
; RV32-NEXT:    fcvt.w.d a3, fa3, rtz
; RV32-NEXT:    and a2, a2, a3
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v8, a2
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; RV32-NEXT:    vslidedown.vi v14, v8, 2
; RV32-NEXT:    vfmv.f.s fa3, v14
; RV32-NEXT:    feq.d a0, fa3, fa3
; RV32-NEXT:    neg a0, a0
; RV32-NEXT:    fmax.d fa3, fa3, fa5
; RV32-NEXT:    fmin.d fa3, fa3, fa4
; RV32-NEXT:    fcvt.w.d a2, fa3, rtz
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; RV32-NEXT:    vslidedown.vi v14, v8, 3
; RV32-NEXT:    vfmv.f.s fa3, v14
; RV32-NEXT:    feq.d a0, fa3, fa3
; RV32-NEXT:    neg a0, a0
; RV32-NEXT:    fmax.d fa3, fa3, fa5
; RV32-NEXT:    fmin.d fa3, fa3, fa4
; RV32-NEXT:    fcvt.w.d a2, fa3, rtz
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV32-NEXT:    vslidedown.vi v16, v8, 4
; RV32-NEXT:    vfmv.f.s fa3, v16
; RV32-NEXT:    feq.d a0, fa3, fa3
; RV32-NEXT:    neg a0, a0
; RV32-NEXT:    fmax.d fa3, fa3, fa5
; RV32-NEXT:    fmin.d fa3, fa3, fa4
; RV32-NEXT:    fcvt.w.d a2, fa3, rtz
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV32-NEXT:    vslidedown.vi v16, v8, 5
; RV32-NEXT:    vfmv.f.s fa3, v16
; RV32-NEXT:    feq.d a0, fa3, fa3
; RV32-NEXT:    neg a0, a0
; RV32-NEXT:    fmax.d fa3, fa3, fa5
; RV32-NEXT:    fmin.d fa3, fa3, fa4
; RV32-NEXT:    fcvt.w.d a2, fa3, rtz
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV32-NEXT:    vslidedown.vi v16, v8, 6
; RV32-NEXT:    vfmv.f.s fa3, v16
; RV32-NEXT:    feq.d a0, fa3, fa3
; RV32-NEXT:    neg a0, a0
; RV32-NEXT:    fmax.d fa3, fa3, fa5
; RV32-NEXT:    fmin.d fa3, fa3, fa4
; RV32-NEXT:    fcvt.w.d a2, fa3, rtz
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v8, 7
; RV32-NEXT:    vfmv.f.s fa3, v8
; RV32-NEXT:    feq.d a0, fa3, fa3
; RV32-NEXT:    neg a0, a0
; RV32-NEXT:    fmax.d fa5, fa3, fa5
; RV32-NEXT:    fmin.d fa5, fa5, fa4
; RV32-NEXT:    fcvt.w.d a2, fa5, rtz
; RV32-NEXT:    and a0, a0, a2
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v8, v12, a0
; RV32-NEXT:    vse8.v v8, (a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: fp2si_v8f64_v8i8:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vle64.v v8, (a0)
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vslidedown.vi v12, v8, 1
; RV64-NEXT:    vfmv.f.s fa3, v12
; RV64-NEXT:    lui a0, %hi(.LCPI12_0)
; RV64-NEXT:    fld fa5, %lo(.LCPI12_0)(a0)
; RV64-NEXT:    lui a0, %hi(.LCPI12_1)
; RV64-NEXT:    fld fa4, %lo(.LCPI12_1)(a0)
; RV64-NEXT:    feq.d a0, fa3, fa3
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    fmax.d fa3, fa3, fa5
; RV64-NEXT:    fmin.d fa3, fa3, fa4
; RV64-NEXT:    fcvt.l.d a2, fa3, rtz
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    vfmv.f.s fa3, v8
; RV64-NEXT:    feq.d a2, fa3, fa3
; RV64-NEXT:    neg a2, a2
; RV64-NEXT:    fmax.d fa3, fa3, fa5
; RV64-NEXT:    fmin.d fa3, fa3, fa4
; RV64-NEXT:    fcvt.l.d a3, fa3, rtz
; RV64-NEXT:    and a2, a2, a3
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v8, a2
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; RV64-NEXT:    vslidedown.vi v14, v8, 2
; RV64-NEXT:    vfmv.f.s fa3, v14
; RV64-NEXT:    feq.d a0, fa3, fa3
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    fmax.d fa3, fa3, fa5
; RV64-NEXT:    fmin.d fa3, fa3, fa4
; RV64-NEXT:    fcvt.l.d a2, fa3, rtz
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; RV64-NEXT:    vslidedown.vi v14, v8, 3
; RV64-NEXT:    vfmv.f.s fa3, v14
; RV64-NEXT:    feq.d a0, fa3, fa3
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    fmax.d fa3, fa3, fa5
; RV64-NEXT:    fmin.d fa3, fa3, fa4
; RV64-NEXT:    fcvt.l.d a2, fa3, rtz
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV64-NEXT:    vslidedown.vi v16, v8, 4
; RV64-NEXT:    vfmv.f.s fa3, v16
; RV64-NEXT:    feq.d a0, fa3, fa3
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    fmax.d fa3, fa3, fa5
; RV64-NEXT:    fmin.d fa3, fa3, fa4
; RV64-NEXT:    fcvt.l.d a2, fa3, rtz
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV64-NEXT:    vslidedown.vi v16, v8, 5
; RV64-NEXT:    vfmv.f.s fa3, v16
; RV64-NEXT:    feq.d a0, fa3, fa3
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    fmax.d fa3, fa3, fa5
; RV64-NEXT:    fmin.d fa3, fa3, fa4
; RV64-NEXT:    fcvt.l.d a2, fa3, rtz
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV64-NEXT:    vslidedown.vi v16, v8, 6
; RV64-NEXT:    vfmv.f.s fa3, v16
; RV64-NEXT:    feq.d a0, fa3, fa3
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    fmax.d fa3, fa3, fa5
; RV64-NEXT:    fmin.d fa3, fa3, fa4
; RV64-NEXT:    fcvt.l.d a2, fa3, rtz
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v8, 7
; RV64-NEXT:    vfmv.f.s fa3, v8
; RV64-NEXT:    feq.d a0, fa3, fa3
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    fmax.d fa5, fa3, fa5
; RV64-NEXT:    fmin.d fa5, fa5, fa4
; RV64-NEXT:    fcvt.l.d a2, fa5, rtz
; RV64-NEXT:    and a0, a0, a2
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v8, v12, a0
; RV64-NEXT:    vse8.v v8, (a1)
; RV64-NEXT:    ret
  %a = load <8 x double>, ptr %x
  %d = call <8 x i8> @llvm.fptosi.sat.v8i8.v8f64(<8 x double> %a)
  store <8 x i8> %d, ptr %y
  ret void
}
declare <8 x i8> @llvm.fptosi.sat.v8i8.v8f64(<8 x double>)

define void @fp2ui_v8f64_v8i8(ptr %x, ptr %y) {
;
; RV32-LABEL: fp2ui_v8f64_v8i8:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-NEXT:    vle64.v v8, (a0)
; RV32-NEXT:    lui a0, %hi(.LCPI13_0)
; RV32-NEXT:    fld fa5, %lo(.LCPI13_0)(a0)
; RV32-NEXT:    vfmv.f.s fa4, v8
; RV32-NEXT:    fcvt.d.w fa3, zero
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa4, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa4, rtz
; RV32-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v8, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV32-NEXT:    vslidedown.vi v13, v8, 1
; RV32-NEXT:    vfmv.f.s fa4, v13
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa4, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa4, rtz
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; RV32-NEXT:    vslidedown.vi v14, v8, 2
; RV32-NEXT:    vfmv.f.s fa4, v14
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa4, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa4, rtz
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; RV32-NEXT:    vslidedown.vi v14, v8, 3
; RV32-NEXT:    vfmv.f.s fa4, v14
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa4, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa4, rtz
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV32-NEXT:    vslidedown.vi v16, v8, 4
; RV32-NEXT:    vfmv.f.s fa4, v16
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa4, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa4, rtz
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV32-NEXT:    vslidedown.vi v16, v8, 5
; RV32-NEXT:    vfmv.f.s fa4, v16
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa4, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa4, rtz
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV32-NEXT:    vslidedown.vi v16, v8, 6
; RV32-NEXT:    vfmv.f.s fa4, v16
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa4, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa4, rtz
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v12, v12, a0
; RV32-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV32-NEXT:    vslidedown.vi v8, v8, 7
; RV32-NEXT:    vfmv.f.s fa4, v8
; RV32-NEXT:    fmax.d fa4, fa4, fa3
; RV32-NEXT:    fmin.d fa5, fa4, fa5
; RV32-NEXT:    fcvt.wu.d a0, fa5, rtz
; RV32-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV32-NEXT:    vslide1down.vx v8, v12, a0
; RV32-NEXT:    vse8.v v8, (a1)
; RV32-NEXT:    ret
;
; RV64-LABEL: fp2ui_v8f64_v8i8:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vle64.v v8, (a0)
; RV64-NEXT:    lui a0, %hi(.LCPI13_0)
; RV64-NEXT:    fld fa5, %lo(.LCPI13_0)(a0)
; RV64-NEXT:    vfmv.f.s fa4, v8
; RV64-NEXT:    fmv.d.x fa3, zero
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa4, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa4, rtz
; RV64-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v8, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; RV64-NEXT:    vslidedown.vi v13, v8, 1
; RV64-NEXT:    vfmv.f.s fa4, v13
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa4, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa4, rtz
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; RV64-NEXT:    vslidedown.vi v14, v8, 2
; RV64-NEXT:    vfmv.f.s fa4, v14
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa4, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa4, rtz
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; RV64-NEXT:    vslidedown.vi v14, v8, 3
; RV64-NEXT:    vfmv.f.s fa4, v14
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa4, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa4, rtz
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV64-NEXT:    vslidedown.vi v16, v8, 4
; RV64-NEXT:    vfmv.f.s fa4, v16
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa4, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa4, rtz
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV64-NEXT:    vslidedown.vi v16, v8, 5
; RV64-NEXT:    vfmv.f.s fa4, v16
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa4, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa4, rtz
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV64-NEXT:    vslidedown.vi v16, v8, 6
; RV64-NEXT:    vfmv.f.s fa4, v16
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa4, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa4, rtz
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v12, v12, a0
; RV64-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; RV64-NEXT:    vslidedown.vi v8, v8, 7
; RV64-NEXT:    vfmv.f.s fa4, v8
; RV64-NEXT:    fmax.d fa4, fa4, fa3
; RV64-NEXT:    fmin.d fa5, fa4, fa5
; RV64-NEXT:    fcvt.lu.d a0, fa5, rtz
; RV64-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; RV64-NEXT:    vslide1down.vx v8, v12, a0
; RV64-NEXT:    vse8.v v8, (a1)
; RV64-NEXT:    ret
  %a = load <8 x double>, ptr %x
  %d = call <8 x i8> @llvm.fptoui.sat.v8i8.v8f64(<8 x double> %a)
  store <8 x i8> %d, ptr %y
  ret void
}
declare <8 x i8> @llvm.fptoui.sat.v8i8.v8f64(<8 x double> %a)

define void @fp2si_v2f64_v2i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f64_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vmerge.vim v8, v9, 0, v0
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %d = call <2 x i32> @llvm.fptosi.sat.v2i32.v2f64(<2 x double> %a)
  store <2 x i32> %d, ptr %y
  ret void
}
declare <2 x i32> @llvm.fptosi.sat.v2i32.v2f64(<2 x double>)

define void @fp2ui_v2f64_v2i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f64_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vmfne.vv v0, v8, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vmerge.vim v8, v9, 0, v0
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %d = call <2 x i32> @llvm.fptoui.sat.v2i32.v2f64(<2 x double> %a)
  store <2 x i32> %d, ptr %y
  ret void
}
declare <2 x i32> @llvm.fptoui.sat.v2i32.v2f64(<2 x double>)
