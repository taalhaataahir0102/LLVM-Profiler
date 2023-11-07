; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v,+zfh,+zvfh \
; RUN:   -verify-machineinstrs -target-abi=ilp32d | FileCheck %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfh \
; RUN:   -verify-machineinstrs -target-abi=lp64d | FileCheck %s

declare <vscale x 1 x half> @llvm.riscv.vfslide1up.nxv1f16.f16(
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  half,
  iXLen);

define <vscale x 1 x half> @intrinsic_vfslide1up_vf_nxv1f16_nxv1f16_f16(<vscale x 1 x half> %0, half %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv1f16_nxv1f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vfslide1up.nxv1f16.f16(
    <vscale x 1 x half> undef,
    <vscale x 1 x half> %0,
    half %1,
    iXLen %2)

  ret <vscale x 1 x half> %a
}

declare <vscale x 1 x half> @llvm.riscv.vfslide1up.mask.nxv1f16.f16(
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  half,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x half> @intrinsic_vfslide1up_mask_vf_nxv1f16_nxv1f16_f16(<vscale x 1 x half> %0, <vscale x 1 x half> %1, half %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv1f16_nxv1f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v9, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vfslide1up.mask.nxv1f16.f16(
    <vscale x 1 x half> %0,
    <vscale x 1 x half> %1,
    half %2,
    <vscale x 1 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 1 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vfslide1up.nxv2f16.f16(
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  half,
  iXLen);

define <vscale x 2 x half> @intrinsic_vfslide1up_vf_nxv2f16_nxv2f16_f16(<vscale x 2 x half> %0, half %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv2f16_nxv2f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vfslide1up.nxv2f16.f16(
    <vscale x 2 x half> undef,
    <vscale x 2 x half> %0,
    half %1,
    iXLen %2)

  ret <vscale x 2 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vfslide1up.mask.nxv2f16.f16(
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  half,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x half> @intrinsic_vfslide1up_mask_vf_nxv2f16_nxv2f16_f16(<vscale x 2 x half> %0, <vscale x 2 x half> %1, half %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv2f16_nxv2f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v9, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vfslide1up.mask.nxv2f16.f16(
    <vscale x 2 x half> %0,
    <vscale x 2 x half> %1,
    half %2,
    <vscale x 2 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 2 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vfslide1up.nxv4f16.f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  half,
  iXLen);

define <vscale x 4 x half> @intrinsic_vfslide1up_vf_nxv4f16_nxv4f16_f16(<vscale x 4 x half> %0, half %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv4f16_nxv4f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vfslide1up.nxv4f16.f16(
    <vscale x 4 x half> undef,
    <vscale x 4 x half> %0,
    half %1,
    iXLen %2)

  ret <vscale x 4 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vfslide1up.mask.nxv4f16.f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  half,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x half> @intrinsic_vfslide1up_mask_vf_nxv4f16_nxv4f16_f16(<vscale x 4 x half> %0, <vscale x 4 x half> %1, half %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv4f16_nxv4f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v9, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vfslide1up.mask.nxv4f16.f16(
    <vscale x 4 x half> %0,
    <vscale x 4 x half> %1,
    half %2,
    <vscale x 4 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 4 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vfslide1up.nxv8f16.f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  half,
  iXLen);

define <vscale x 8 x half> @intrinsic_vfslide1up_vf_nxv8f16_nxv8f16_f16(<vscale x 8 x half> %0, half %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv8f16_nxv8f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vfslide1up.vf v10, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vfslide1up.nxv8f16.f16(
    <vscale x 8 x half> undef,
    <vscale x 8 x half> %0,
    half %1,
    iXLen %2)

  ret <vscale x 8 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vfslide1up.mask.nxv8f16.f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  half,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x half> @intrinsic_vfslide1up_mask_vf_nxv8f16_nxv8f16_f16(<vscale x 8 x half> %0, <vscale x 8 x half> %1, half %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv8f16_nxv8f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v10, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vfslide1up.mask.nxv8f16.f16(
    <vscale x 8 x half> %0,
    <vscale x 8 x half> %1,
    half %2,
    <vscale x 8 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 8 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vfslide1up.nxv16f16.f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  half,
  iXLen);

define <vscale x 16 x half> @intrinsic_vfslide1up_vf_nxv16f16_nxv16f16_f16(<vscale x 16 x half> %0, half %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv16f16_nxv16f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vfslide1up.vf v12, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vfslide1up.nxv16f16.f16(
    <vscale x 16 x half> undef,
    <vscale x 16 x half> %0,
    half %1,
    iXLen %2)

  ret <vscale x 16 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vfslide1up.mask.nxv16f16.f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  half,
  <vscale x 16 x i1>,
  iXLen,
  iXLen);

define <vscale x 16 x half> @intrinsic_vfslide1up_mask_vf_nxv16f16_nxv16f16_f16(<vscale x 16 x half> %0, <vscale x 16 x half> %1, half %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv16f16_nxv16f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v12, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vfslide1up.mask.nxv16f16.f16(
    <vscale x 16 x half> %0,
    <vscale x 16 x half> %1,
    half %2,
    <vscale x 16 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 16 x half> %a
}

declare <vscale x 32 x half> @llvm.riscv.vfslide1up.nxv32f16.f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>,
  half,
  iXLen);

define <vscale x 32 x half> @intrinsic_vfslide1up_vf_nxv32f16_nxv32f16_f16(<vscale x 32 x half> %0, half %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv32f16_nxv32f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vfslide1up.vf v16, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x half> @llvm.riscv.vfslide1up.nxv32f16.f16(
    <vscale x 32 x half> undef,
    <vscale x 32 x half> %0,
    half %1,
    iXLen %2)

  ret <vscale x 32 x half> %a
}

declare <vscale x 32 x half> @llvm.riscv.vfslide1up.mask.nxv32f16.f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>,
  half,
  <vscale x 32 x i1>,
  iXLen,
  iXLen);

define <vscale x 32 x half> @intrinsic_vfslide1up_mask_vf_nxv32f16_nxv32f16_f16(<vscale x 32 x half> %0, <vscale x 32 x half> %1, half %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv32f16_nxv32f16_f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v16, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x half> @llvm.riscv.vfslide1up.mask.nxv32f16.f16(
    <vscale x 32 x half> %0,
    <vscale x 32 x half> %1,
    half %2,
    <vscale x 32 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 32 x half> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfslide1up.nxv1f32.f32(
  <vscale x 1 x float>,
  <vscale x 1 x float>,
  float,
  iXLen);

define <vscale x 1 x float> @intrinsic_vfslide1up_vf_nxv1f32_nxv1f32_f32(<vscale x 1 x float> %0, float %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv1f32_nxv1f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfslide1up.nxv1f32.f32(
    <vscale x 1 x float> undef,
    <vscale x 1 x float> %0,
    float %1,
    iXLen %2)

  ret <vscale x 1 x float> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfslide1up.mask.nxv1f32.f32(
  <vscale x 1 x float>,
  <vscale x 1 x float>,
  float,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x float> @intrinsic_vfslide1up_mask_vf_nxv1f32_nxv1f32_f32(<vscale x 1 x float> %0, <vscale x 1 x float> %1, float %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv1f32_nxv1f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v9, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfslide1up.mask.nxv1f32.f32(
    <vscale x 1 x float> %0,
    <vscale x 1 x float> %1,
    float %2,
    <vscale x 1 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 1 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfslide1up.nxv2f32.f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>,
  float,
  iXLen);

define <vscale x 2 x float> @intrinsic_vfslide1up_vf_nxv2f32_nxv2f32_f32(<vscale x 2 x float> %0, float %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv2f32_nxv2f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfslide1up.nxv2f32.f32(
    <vscale x 2 x float> undef,
    <vscale x 2 x float> %0,
    float %1,
    iXLen %2)

  ret <vscale x 2 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfslide1up.mask.nxv2f32.f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>,
  float,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x float> @intrinsic_vfslide1up_mask_vf_nxv2f32_nxv2f32_f32(<vscale x 2 x float> %0, <vscale x 2 x float> %1, float %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv2f32_nxv2f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v9, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfslide1up.mask.nxv2f32.f32(
    <vscale x 2 x float> %0,
    <vscale x 2 x float> %1,
    float %2,
    <vscale x 2 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 2 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfslide1up.nxv4f32.f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>,
  float,
  iXLen);

define <vscale x 4 x float> @intrinsic_vfslide1up_vf_nxv4f32_nxv4f32_f32(<vscale x 4 x float> %0, float %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv4f32_nxv4f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfslide1up.vf v10, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfslide1up.nxv4f32.f32(
    <vscale x 4 x float> undef,
    <vscale x 4 x float> %0,
    float %1,
    iXLen %2)

  ret <vscale x 4 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfslide1up.mask.nxv4f32.f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>,
  float,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x float> @intrinsic_vfslide1up_mask_vf_nxv4f32_nxv4f32_f32(<vscale x 4 x float> %0, <vscale x 4 x float> %1, float %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv4f32_nxv4f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v10, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfslide1up.mask.nxv4f32.f32(
    <vscale x 4 x float> %0,
    <vscale x 4 x float> %1,
    float %2,
    <vscale x 4 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 4 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfslide1up.nxv8f32.f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>,
  float,
  iXLen);

define <vscale x 8 x float> @intrinsic_vfslide1up_vf_nxv8f32_nxv8f32_f32(<vscale x 8 x float> %0, float %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv8f32_nxv8f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfslide1up.vf v12, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfslide1up.nxv8f32.f32(
    <vscale x 8 x float> undef,
    <vscale x 8 x float> %0,
    float %1,
    iXLen %2)

  ret <vscale x 8 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfslide1up.mask.nxv8f32.f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>,
  float,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x float> @intrinsic_vfslide1up_mask_vf_nxv8f32_nxv8f32_f32(<vscale x 8 x float> %0, <vscale x 8 x float> %1, float %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv8f32_nxv8f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v12, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfslide1up.mask.nxv8f32.f32(
    <vscale x 8 x float> %0,
    <vscale x 8 x float> %1,
    float %2,
    <vscale x 8 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 8 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.vfslide1up.nxv16f32.f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>,
  float,
  iXLen);

define <vscale x 16 x float> @intrinsic_vfslide1up_vf_nxv16f32_nxv16f32_f32(<vscale x 16 x float> %0, float %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv16f32_nxv16f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfslide1up.vf v16, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x float> @llvm.riscv.vfslide1up.nxv16f32.f32(
    <vscale x 16 x float> undef,
    <vscale x 16 x float> %0,
    float %1,
    iXLen %2)

  ret <vscale x 16 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.vfslide1up.mask.nxv16f32.f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>,
  float,
  <vscale x 16 x i1>,
  iXLen,
  iXLen);

define <vscale x 16 x float> @intrinsic_vfslide1up_mask_vf_nxv16f32_nxv16f32_f32(<vscale x 16 x float> %0, <vscale x 16 x float> %1, float %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv16f32_nxv16f32_f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v16, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x float> @llvm.riscv.vfslide1up.mask.nxv16f32.f32(
    <vscale x 16 x float> %0,
    <vscale x 16 x float> %1,
    float %2,
    <vscale x 16 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 16 x float> %a
}

declare <vscale x 1 x double> @llvm.riscv.vfslide1up.nxv1f64.f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  double,
  iXLen);

define <vscale x 1 x double> @intrinsic_vfslide1up_vf_nxv1f64_nxv1f64_f64(<vscale x 1 x double> %0, double %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv1f64_nxv1f64_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfslide1up.vf v9, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x double> @llvm.riscv.vfslide1up.nxv1f64.f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double> %0,
    double %1,
    iXLen %2)

  ret <vscale x 1 x double> %a
}

declare <vscale x 1 x double> @llvm.riscv.vfslide1up.mask.nxv1f64.f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  double,
  <vscale x 1 x i1>,
  iXLen,
  iXLen);

define <vscale x 1 x double> @intrinsic_vfslide1up_mask_vf_nxv1f64_nxv1f64_f64(<vscale x 1 x double> %0, <vscale x 1 x double> %1, double %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv1f64_nxv1f64_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v9, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x double> @llvm.riscv.vfslide1up.mask.nxv1f64.f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double> %1,
    double %2,
    <vscale x 1 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 1 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.vfslide1up.nxv2f64.f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>,
  double,
  iXLen);

define <vscale x 2 x double> @intrinsic_vfslide1up_vf_nxv2f64_nxv2f64_f64(<vscale x 2 x double> %0, double %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv2f64_nxv2f64_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfslide1up.vf v10, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x double> @llvm.riscv.vfslide1up.nxv2f64.f64(
    <vscale x 2 x double> undef,
    <vscale x 2 x double> %0,
    double %1,
    iXLen %2)

  ret <vscale x 2 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.vfslide1up.mask.nxv2f64.f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>,
  double,
  <vscale x 2 x i1>,
  iXLen,
  iXLen);

define <vscale x 2 x double> @intrinsic_vfslide1up_mask_vf_nxv2f64_nxv2f64_f64(<vscale x 2 x double> %0, <vscale x 2 x double> %1, double %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv2f64_nxv2f64_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v10, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x double> @llvm.riscv.vfslide1up.mask.nxv2f64.f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double> %1,
    double %2,
    <vscale x 2 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 2 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.vfslide1up.nxv4f64.f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>,
  double,
  iXLen);

define <vscale x 4 x double> @intrinsic_vfslide1up_vf_nxv4f64_nxv4f64_f64(<vscale x 4 x double> %0, double %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv4f64_nxv4f64_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfslide1up.vf v12, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x double> @llvm.riscv.vfslide1up.nxv4f64.f64(
    <vscale x 4 x double> undef,
    <vscale x 4 x double> %0,
    double %1,
    iXLen %2)

  ret <vscale x 4 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.vfslide1up.mask.nxv4f64.f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>,
  double,
  <vscale x 4 x i1>,
  iXLen,
  iXLen);

define <vscale x 4 x double> @intrinsic_vfslide1up_mask_vf_nxv4f64_nxv4f64_f64(<vscale x 4 x double> %0, <vscale x 4 x double> %1, double %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv4f64_nxv4f64_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v12, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x double> @llvm.riscv.vfslide1up.mask.nxv4f64.f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double> %1,
    double %2,
    <vscale x 4 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 4 x double> %a
}

declare <vscale x 8 x double> @llvm.riscv.vfslide1up.nxv8f64.f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>,
  double,
  iXLen);

define <vscale x 8 x double> @intrinsic_vfslide1up_vf_nxv8f64_nxv8f64_f64(<vscale x 8 x double> %0, double %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_vf_nxv8f64_nxv8f64_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfslide1up.vf v16, v8, fa0
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x double> @llvm.riscv.vfslide1up.nxv8f64.f64(
    <vscale x 8 x double> undef,
    <vscale x 8 x double> %0,
    double %1,
    iXLen %2)

  ret <vscale x 8 x double> %a
}

declare <vscale x 8 x double> @llvm.riscv.vfslide1up.mask.nxv8f64.f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>,
  double,
  <vscale x 8 x i1>,
  iXLen,
  iXLen);

define <vscale x 8 x double> @intrinsic_vfslide1up_mask_vf_nxv8f64_nxv8f64_f64(<vscale x 8 x double> %0, <vscale x 8 x double> %1, double %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vfslide1up_mask_vf_nxv8f64_nxv8f64_f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, mu
; CHECK-NEXT:    vfslide1up.vf v8, v16, fa0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x double> @llvm.riscv.vfslide1up.mask.nxv8f64.f64(
    <vscale x 8 x double> %0,
    <vscale x 8 x double> %1,
    double %2,
    <vscale x 8 x i1> %3,
    iXLen %4, iXLen 1)

  ret <vscale x 8 x double> %a
}
