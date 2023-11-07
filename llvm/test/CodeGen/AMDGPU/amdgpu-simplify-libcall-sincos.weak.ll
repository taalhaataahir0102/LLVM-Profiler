; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -mtriple=amdgcn-- -passes=amdgpu-simplifylib < %s | FileCheck %s

target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8"

declare extern_weak float @_Z3sinf(float noundef)
declare extern_weak float @_Z3cosf(float noundef)

define void @sincos_f32(float noundef %x, ptr addrspace(1) nocapture noundef writeonly %sin_out, ptr addrspace(1) nocapture noundef writeonly %cos_out) {
; CHECK-LABEL: define void @sincos_f32
; CHECK-SAME: (float noundef [[X:%.*]], ptr addrspace(1) nocapture noundef writeonly [[SIN_OUT:%.*]], ptr addrspace(1) nocapture noundef writeonly [[COS_OUT:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call contract float @_Z3sinf(float noundef [[X]])
; CHECK-NEXT:    store float [[CALL]], ptr addrspace(1) [[SIN_OUT]], align 4
; CHECK-NEXT:    [[CALL1:%.*]] = tail call contract float @_Z3cosf(float noundef [[X]])
; CHECK-NEXT:    store float [[CALL1]], ptr addrspace(1) [[COS_OUT]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %call = tail call contract float @_Z3sinf(float noundef %x)
  store float %call, ptr addrspace(1) %sin_out, align 4
  %call1 = tail call contract float @_Z3cosf(float noundef %x)
  store float %call1, ptr addrspace(1) %cos_out, align 4
  ret void
}

define void @sincos_f32_value_is_same_constantfp(ptr addrspace(1) nocapture noundef writeonly %sin_out, ptr addrspace(1) nocapture noundef writeonly %cos_out) {
; CHECK-LABEL: define void @sincos_f32_value_is_same_constantfp
; CHECK-SAME: (ptr addrspace(1) nocapture noundef writeonly [[SIN_OUT:%.*]], ptr addrspace(1) nocapture noundef writeonly [[COS_OUT:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call contract float @_Z3sinf(float 4.200000e+01)
; CHECK-NEXT:    store float [[CALL]], ptr addrspace(1) [[SIN_OUT]], align 4
; CHECK-NEXT:    [[CALL1:%.*]] = tail call contract float @_Z3cosf(float 4.200000e+01)
; CHECK-NEXT:    store float [[CALL1]], ptr addrspace(1) [[COS_OUT]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %call = tail call contract float @_Z3sinf(float 42.0)
  store float %call, ptr addrspace(1) %sin_out, align 4
  %call1 = tail call contract float @_Z3cosf(float 42.0)
  store float %call1, ptr addrspace(1) %cos_out, align 4
  ret void
}
