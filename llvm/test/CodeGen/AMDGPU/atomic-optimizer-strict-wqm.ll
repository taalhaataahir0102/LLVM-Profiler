; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx1010 < %s | FileCheck %s -check-prefixes=GFX10

declare void @llvm.amdgcn.exp.f32(i32 immarg, i32 immarg, float, float, float, float, i1 immarg, i1 immarg)
declare i32 @llvm.amdgcn.raw.ptr.buffer.atomic.and.i32(i32, ptr addrspace(8), i32, i32, i32 immarg)
declare float @llvm.amdgcn.strict.wqm.f32(float)

define amdgpu_ps void @main(i32 %arg) {
; GFX10-LABEL: main:
; GFX10:       ; %bb.0: ; %bb
; GFX10-NEXT:    v_cmp_eq_u32_e32 vcc_lo, 1, v0
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_mov_b32 s1, exec_lo
; GFX10-NEXT:    s_mov_b32 s4, 0
; GFX10-NEXT:    s_mov_b32 s2, 0
; GFX10-NEXT:    s_branch .LBB0_2
; GFX10-NEXT:  .LBB0_1: ; %Flow
; GFX10-NEXT:    ; in Loop: Header=BB0_2 Depth=1
; GFX10-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-NEXT:    s_or_b32 exec_lo, exec_lo, s3
; GFX10-NEXT:    s_and_b32 s0, exec_lo, vcc_lo
; GFX10-NEXT:    s_or_b32 s2, s0, s2
; GFX10-NEXT:    s_andn2_b32 exec_lo, exec_lo, s2
; GFX10-NEXT:    s_cbranch_execz .LBB0_5
; GFX10-NEXT:  .LBB0_2: ; %bb4
; GFX10-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX10-NEXT:    s_and_saveexec_b32 s3, s1
; GFX10-NEXT:    s_cbranch_execz .LBB0_1
; GFX10-NEXT:  ; %bb.3: ; in Loop: Header=BB0_2 Depth=1
; GFX10-NEXT:    v_mbcnt_lo_u32_b32 v1, exec_lo, 0
; GFX10-NEXT:    v_cmp_eq_u32_e64 s0, 0, v1
; GFX10-NEXT:    s_and_b32 exec_lo, exec_lo, s0
; GFX10-NEXT:    s_cbranch_execz .LBB0_1
; GFX10-NEXT:  ; %bb.4: ; in Loop: Header=BB0_2 Depth=1
; GFX10-NEXT:    s_mov_b32 s5, s4
; GFX10-NEXT:    s_mov_b32 s6, s4
; GFX10-NEXT:    s_mov_b32 s7, s4
; GFX10-NEXT:    buffer_atomic_and v0, off, s[4:7], 0
; GFX10-NEXT:    s_branch .LBB0_1
; GFX10-NEXT:  .LBB0_5: ; %bb8
; GFX10-NEXT:    s_or_b32 exec_lo, exec_lo, s2
; GFX10-NEXT:    s_mov_b32 s0, 0
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-NEXT:    exp mrt0 off, off, off, off
; GFX10-NEXT:    s_endpgm
bb:
  br label %bb4

bb4:
  %i5 = call i32 @llvm.amdgcn.raw.ptr.buffer.atomic.and.i32(i32 0, ptr addrspace(8) null, i32 0, i32 0, i32 0)
  %i7 = icmp eq i32 %arg, 1
  br i1 %i7, label %bb8, label %bb4

bb8:
  %i9 = call float @llvm.amdgcn.strict.wqm.f32(float 0.0)
  call void @llvm.amdgcn.exp.f32(i32 0, i32 0, float %i9, float 0.0, float 0.0, float 0.0, i1 false, i1 false)
  ret void
}
