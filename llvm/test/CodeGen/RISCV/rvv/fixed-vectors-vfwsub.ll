; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v,+zfh,+zvfh,+f,+d -target-abi=ilp32d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfh,+f,+d -target-abi=lp64d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s

define <2 x float> @vfwsub_v2f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vle16.v v10, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v9, v10
; CHECK-NEXT:    ret
  %a = load <2 x half>, ptr %x
  %b = load <2 x half>, ptr %y
  %c = fpext <2 x half> %a to <2 x float>
  %d = fpext <2 x half> %b to <2 x float>
  %e = fsub <2 x float> %c, %d
  ret <2 x float> %e
}

define <4 x float> @vfwsub_v4f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vle16.v v10, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v9, v10
; CHECK-NEXT:    ret
  %a = load <4 x half>, ptr %x
  %b = load <4 x half>, ptr %y
  %c = fpext <4 x half> %a to <4 x float>
  %d = fpext <4 x half> %b to <4 x float>
  %e = fsub <4 x float> %c, %d
  ret <4 x float> %e
}

define <8 x float> @vfwsub_v8f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    vle16.v v11, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v10, v11
; CHECK-NEXT:    ret
  %a = load <8 x half>, ptr %x
  %b = load <8 x half>, ptr %y
  %c = fpext <8 x half> %a to <8 x float>
  %d = fpext <8 x half> %b to <8 x float>
  %e = fsub <8 x float> %c, %d
  ret <8 x float> %e
}

define <16 x float> @vfwsub_v16f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vle16.v v12, (a0)
; CHECK-NEXT:    vle16.v v14, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v12, v14
; CHECK-NEXT:    ret
  %a = load <16 x half>, ptr %x
  %b = load <16 x half>, ptr %y
  %c = fpext <16 x half> %a to <16 x float>
  %d = fpext <16 x half> %b to <16 x float>
  %e = fsub <16 x float> %c, %d
  ret <16 x float> %e
}

define <32 x float> @vfwsub_v32f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, ta, ma
; CHECK-NEXT:    vle16.v v16, (a0)
; CHECK-NEXT:    vle16.v v20, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v16, v20
; CHECK-NEXT:    ret
  %a = load <32 x half>, ptr %x
  %b = load <32 x half>, ptr %y
  %c = fpext <32 x half> %a to <32 x float>
  %d = fpext <32 x half> %b to <32 x float>
  %e = fsub <32 x float> %c, %d
  ret <32 x float> %e
}

define <64 x float> @vfwsub_v64f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v64f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 4
; CHECK-NEXT:    sub sp, sp, a2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    li a2, 64
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vle16.v v0, (a1)
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vslidedown.vx v16, v8, a0
; CHECK-NEXT:    vslidedown.vx v8, v0, a0
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vmv4r.v v24, v8
; CHECK-NEXT:    vfwsub.vv v8, v16, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vfwsub.vv v8, v16, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %a = load <64 x half>, ptr %x
  %b = load <64 x half>, ptr %y
  %c = fpext <64 x half> %a to <64 x float>
  %d = fpext <64 x half> %b to <64 x float>
  %e = fsub <64 x float> %c, %d
  ret <64 x float> %e
}

define <2 x double> @vfwsub_v2f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vle32.v v10, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v9, v10
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %b = load <2 x float>, ptr %y
  %c = fpext <2 x float> %a to <2 x double>
  %d = fpext <2 x float> %b to <2 x double>
  %e = fsub <2 x double> %c, %d
  ret <2 x double> %e
}

define <4 x double> @vfwsub_v4f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vle32.v v11, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v10, v11
; CHECK-NEXT:    ret
  %a = load <4 x float>, ptr %x
  %b = load <4 x float>, ptr %y
  %c = fpext <4 x float> %a to <4 x double>
  %d = fpext <4 x float> %b to <4 x double>
  %e = fsub <4 x double> %c, %d
  ret <4 x double> %e
}

define <8 x double> @vfwsub_v8f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v12, (a0)
; CHECK-NEXT:    vle32.v v14, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v12, v14
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %b = load <8 x float>, ptr %y
  %c = fpext <8 x float> %a to <8 x double>
  %d = fpext <8 x float> %b to <8 x double>
  %e = fsub <8 x double> %c, %d
  ret <8 x double> %e
}

define <16 x double> @vfwsub_v16f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v16, (a0)
; CHECK-NEXT:    vle32.v v20, (a1)
; CHECK-NEXT:    vfwsub.vv v8, v16, v20
; CHECK-NEXT:    ret
  %a = load <16 x float>, ptr %x
  %b = load <16 x float>, ptr %y
  %c = fpext <16 x float> %a to <16 x double>
  %d = fpext <16 x float> %b to <16 x double>
  %e = fsub <16 x double> %c, %d
  ret <16 x double> %e
}

define <32 x double> @vfwsub_v32f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_v32f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 4
; CHECK-NEXT:    sub sp, sp, a2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vle32.v v0, (a1)
; CHECK-NEXT:    vsetivli zero, 16, e32, m8, ta, ma
; CHECK-NEXT:    vslidedown.vi v16, v8, 16
; CHECK-NEXT:    vslidedown.vi v8, v0, 16
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vmv4r.v v24, v8
; CHECK-NEXT:    vfwsub.vv v8, v16, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vfwsub.vv v8, v16, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %a = load <32 x float>, ptr %x
  %b = load <32 x float>, ptr %y
  %c = fpext <32 x float> %a to <32 x double>
  %d = fpext <32 x float> %b to <32 x double>
  %e = fsub <32 x double> %c, %d
  ret <32 x double> %e
}

define <2 x float> @vfwsub_vf_v2f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_vf_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v9, fa0
; CHECK-NEXT:    ret
  %a = load <2 x half>, ptr %x
  %b = insertelement <2 x half> poison, half %y, i32 0
  %c = shufflevector <2 x half> %b, <2 x half> poison, <2 x i32> zeroinitializer
  %d = fpext <2 x half> %a to <2 x float>
  %e = fpext <2 x half> %c to <2 x float>
  %f = fsub <2 x float> %d, %e
  ret <2 x float> %f
}

define <4 x float> @vfwsub_vf_v4f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_vf_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v9, fa0
; CHECK-NEXT:    ret
  %a = load <4 x half>, ptr %x
  %b = insertelement <4 x half> poison, half %y, i32 0
  %c = shufflevector <4 x half> %b, <4 x half> poison, <4 x i32> zeroinitializer
  %d = fpext <4 x half> %a to <4 x float>
  %e = fpext <4 x half> %c to <4 x float>
  %f = fsub <4 x float> %d, %e
  ret <4 x float> %f
}

define <8 x float> @vfwsub_vf_v8f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_vf_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vle16.v v10, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v10, fa0
; CHECK-NEXT:    ret
  %a = load <8 x half>, ptr %x
  %b = insertelement <8 x half> poison, half %y, i32 0
  %c = shufflevector <8 x half> %b, <8 x half> poison, <8 x i32> zeroinitializer
  %d = fpext <8 x half> %a to <8 x float>
  %e = fpext <8 x half> %c to <8 x float>
  %f = fsub <8 x float> %d, %e
  ret <8 x float> %f
}

define <16 x float> @vfwsub_vf_v16f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_vf_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vle16.v v12, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v12, fa0
; CHECK-NEXT:    ret
  %a = load <16 x half>, ptr %x
  %b = insertelement <16 x half> poison, half %y, i32 0
  %c = shufflevector <16 x half> %b, <16 x half> poison, <16 x i32> zeroinitializer
  %d = fpext <16 x half> %a to <16 x float>
  %e = fpext <16 x half> %c to <16 x float>
  %f = fsub <16 x float> %d, %e
  ret <16 x float> %f
}

define <32 x float> @vfwsub_vf_v32f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_vf_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, ta, ma
; CHECK-NEXT:    vle16.v v16, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v16, fa0
; CHECK-NEXT:    ret
  %a = load <32 x half>, ptr %x
  %b = insertelement <32 x half> poison, half %y, i32 0
  %c = shufflevector <32 x half> %b, <32 x half> poison, <32 x i32> zeroinitializer
  %d = fpext <32 x half> %a to <32 x float>
  %e = fpext <32 x half> %c to <32 x float>
  %f = fsub <32 x float> %d, %e
  ret <32 x float> %f
}

define <2 x double> @vfwsub_vf_v2f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_vf_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v9, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v9, fa0
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %b = insertelement <2 x float> poison, float %y, i32 0
  %c = shufflevector <2 x float> %b, <2 x float> poison, <2 x i32> zeroinitializer
  %d = fpext <2 x float> %a to <2 x double>
  %e = fpext <2 x float> %c to <2 x double>
  %f = fsub <2 x double> %d, %e
  ret <2 x double> %f
}

define <4 x double> @vfwsub_vf_v4f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_vf_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v10, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v10, fa0
; CHECK-NEXT:    ret
  %a = load <4 x float>, ptr %x
  %b = insertelement <4 x float> poison, float %y, i32 0
  %c = shufflevector <4 x float> %b, <4 x float> poison, <4 x i32> zeroinitializer
  %d = fpext <4 x float> %a to <4 x double>
  %e = fpext <4 x float> %c to <4 x double>
  %f = fsub <4 x double> %d, %e
  ret <4 x double> %f
}

define <8 x double> @vfwsub_vf_v8f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_vf_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v12, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v12, fa0
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %b = insertelement <8 x float> poison, float %y, i32 0
  %c = shufflevector <8 x float> %b, <8 x float> poison, <8 x i32> zeroinitializer
  %d = fpext <8 x float> %a to <8 x double>
  %e = fpext <8 x float> %c to <8 x double>
  %f = fsub <8 x double> %d, %e
  ret <8 x double> %f
}

define <16 x double> @vfwsub_vf_v16f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_vf_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v16, (a0)
; CHECK-NEXT:    vfwsub.vf v8, v16, fa0
; CHECK-NEXT:    ret
  %a = load <16 x float>, ptr %x
  %b = insertelement <16 x float> poison, float %y, i32 0
  %c = shufflevector <16 x float> %b, <16 x float> poison, <16 x i32> zeroinitializer
  %d = fpext <16 x float> %a to <16 x double>
  %e = fpext <16 x float> %c to <16 x double>
  %f = fsub <16 x double> %d, %e
  ret <16 x double> %f
}

define <32 x double> @vfwsub_vf_v32f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_vf_v32f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; CHECK-NEXT:    vle32.v v16, (a0)
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v8, v16
; CHECK-NEXT:    vsetivli zero, 16, e32, m8, ta, ma
; CHECK-NEXT:    vslidedown.vi v16, v16, 16
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfwcvt.f.f.v v24, v16
; CHECK-NEXT:    vfmv.v.f v16, fa0
; CHECK-NEXT:    vfwcvt.f.f.v v0, v16
; CHECK-NEXT:    vsetvli zero, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfsub.vv v16, v24, v0
; CHECK-NEXT:    vfsub.vv v8, v8, v0
; CHECK-NEXT:    ret
  %a = load <32 x float>, ptr %x
  %b = insertelement <32 x float> poison, float %y, i32 0
  %c = shufflevector <32 x float> %b, <32 x float> poison, <32 x i32> zeroinitializer
  %d = fpext <32 x float> %a to <32 x double>
  %e = fpext <32 x float> %c to <32 x double>
  %f = fsub <32 x double> %d, %e
  ret <32 x double> %f
}

define <2 x float> @vfwsub_wv_v2f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle16.v v9, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v9
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %b = load <2 x half>, ptr %y
  %c = fpext <2 x half> %b to <2 x float>
  %d = fsub <2 x float> %a, %c
  ret <2 x float> %d
}

define <4 x float> @vfwsub_wv_v4f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle16.v v9, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v9
; CHECK-NEXT:    ret
  %a = load <4 x float>, ptr %x
  %b = load <4 x half>, ptr %y
  %c = fpext <4 x half> %b to <4 x float>
  %d = fsub <4 x float> %a, %c
  ret <4 x float> %d
}

define <8 x float> @vfwsub_wv_v8f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle16.v v10, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v10
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %b = load <8 x half>, ptr %y
  %c = fpext <8 x half> %b to <8 x float>
  %d = fsub <8 x float> %a, %c
  ret <8 x float> %d
}

define <16 x float> @vfwsub_wv_v16f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle16.v v12, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v12
; CHECK-NEXT:    ret
  %a = load <16 x float>, ptr %x
  %b = load <16 x half>, ptr %y
  %c = fpext <16 x half> %b to <16 x float>
  %d = fsub <16 x float> %a, %c
  ret <16 x float> %d
}

define <32 x float> @vfwsub_wv_v32f16(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle16.v v16, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v16
; CHECK-NEXT:    ret
  %a = load <32 x float>, ptr %x
  %b = load <32 x half>, ptr %y
  %c = fpext <32 x half> %b to <32 x float>
  %d = fsub <32 x float> %a, %c
  ret <32 x float> %d
}

define <2 x double> @vfwsub_wv_v2f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vle32.v v9, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v9
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %b = load <2 x float>, ptr %y
  %c = fpext <2 x float> %b to <2 x double>
  %d = fsub <2 x double> %a, %c
  ret <2 x double> %d
}

define <4 x double> @vfwsub_wv_v4f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vle32.v v10, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v10
; CHECK-NEXT:    ret
  %a = load <4 x double>, ptr %x
  %b = load <4 x float>, ptr %y
  %c = fpext <4 x float> %b to <4 x double>
  %d = fsub <4 x double> %a, %c
  ret <4 x double> %d
}

define <8 x double> @vfwsub_wv_v8f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vle32.v v12, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v12
; CHECK-NEXT:    ret
  %a = load <8 x double>, ptr %x
  %b = load <8 x float>, ptr %y
  %c = fpext <8 x float> %b to <8 x double>
  %d = fsub <8 x double> %a, %c
  ret <8 x double> %d
}

define <16 x double> @vfwsub_wv_v16f32(ptr %x, ptr %y) {
; CHECK-LABEL: vfwsub_wv_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vle32.v v16, (a1)
; CHECK-NEXT:    vfwsub.wv v8, v8, v16
; CHECK-NEXT:    ret
  %a = load <16 x double>, ptr %x
  %b = load <16 x float>, ptr %y
  %c = fpext <16 x float> %b to <16 x double>
  %d = fsub <16 x double> %a, %c
  ret <16 x double> %d
}

define <2 x float> @vfwsub_wf_v2f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_wf_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwsub.wf v8, v8, fa0
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %b = insertelement <2 x half> poison, half %y, i32 0
  %c = shufflevector <2 x half> %b, <2 x half> poison, <2 x i32> zeroinitializer
  %d = fpext <2 x half> %c to <2 x float>
  %e = fsub <2 x float> %a, %d
  ret <2 x float> %e
}

define <4 x float> @vfwsub_wf_v4f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_wf_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwsub.wf v8, v8, fa0
; CHECK-NEXT:    ret
  %a = load <4 x float>, ptr %x
  %b = insertelement <4 x half> poison, half %y, i32 0
  %c = shufflevector <4 x half> %b, <4 x half> poison, <4 x i32> zeroinitializer
  %d = fpext <4 x half> %c to <4 x float>
  %e = fsub <4 x float> %a, %d
  ret <4 x float> %e
}

define <8 x float> @vfwsub_wf_v8f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_wf_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwsub.wf v8, v8, fa0
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %b = insertelement <8 x half> poison, half %y, i32 0
  %c = shufflevector <8 x half> %b, <8 x half> poison, <8 x i32> zeroinitializer
  %d = fpext <8 x half> %c to <8 x float>
  %e = fsub <8 x float> %a, %d
  ret <8 x float> %e
}

define <16 x float> @vfwsub_wf_v16f16(ptr %x, half %y) {
; CHECK-LABEL: vfwsub_wf_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwsub.wf v8, v8, fa0
; CHECK-NEXT:    ret
  %a = load <16 x float>, ptr %x
  %b = insertelement <16 x half> poison, half %y, i32 0
  %c = shufflevector <16 x half> %b, <16 x half> poison, <16 x i32> zeroinitializer
  %d = fpext <16 x half> %c to <16 x float>
  %e = fsub <16 x float> %a, %d
  ret <16 x float> %e
}

define <2 x double> @vfwsub_wf_v2f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_wf_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfwsub.wf v8, v8, fa0
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %b = insertelement <2 x float> poison, float %y, i32 0
  %c = shufflevector <2 x float> %b, <2 x float> poison, <2 x i32> zeroinitializer
  %d = fpext <2 x float> %c to <2 x double>
  %e = fsub <2 x double> %a, %d
  ret <2 x double> %e
}

define <4 x double> @vfwsub_wf_v4f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_wf_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfwsub.wf v8, v8, fa0
; CHECK-NEXT:    ret
  %a = load <4 x double>, ptr %x
  %b = insertelement <4 x float> poison, float %y, i32 0
  %c = shufflevector <4 x float> %b, <4 x float> poison, <4 x i32> zeroinitializer
  %d = fpext <4 x float> %c to <4 x double>
  %e = fsub <4 x double> %a, %d
  ret <4 x double> %e
}

define <8 x double> @vfwsub_wf_v8f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_wf_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfwsub.wf v8, v8, fa0
; CHECK-NEXT:    ret
  %a = load <8 x double>, ptr %x
  %b = insertelement <8 x float> poison, float %y, i32 0
  %c = shufflevector <8 x float> %b, <8 x float> poison, <8 x i32> zeroinitializer
  %d = fpext <8 x float> %c to <8 x double>
  %e = fsub <8 x double> %a, %d
  ret <8 x double> %e
}

define <16 x double> @vfwsub_wf_v16f32(ptr %x, float %y) {
; CHECK-LABEL: vfwsub_wf_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfwsub.wf v8, v8, fa0
; CHECK-NEXT:    ret
  %a = load <16 x double>, ptr %x
  %b = insertelement <16 x float> poison, float %y, i32 0
  %c = shufflevector <16 x float> %b, <16 x float> poison, <16 x i32> zeroinitializer
  %d = fpext <16 x float> %c to <16 x double>
  %e = fsub <16 x double> %a, %d
  ret <16 x double> %e
}
