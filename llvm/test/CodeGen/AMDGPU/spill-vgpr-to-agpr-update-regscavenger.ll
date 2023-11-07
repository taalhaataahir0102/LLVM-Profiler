; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx908 -O0 -verify-machineinstrs -o - %s | FileCheck %s

; Regression test for `processFunctionBeforeFrameFinalized`:
; Check that it correctly updates RegisterScavenger so we
; don't end up with bad machine code due to using undefined
; physical registers.

define void @test() {
; CHECK-LABEL: test:
; CHECK:       ; %bb.0: ; %bb.0
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_xor_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_store_dword v0, off, s[0:3], s32 ; 4-byte Folded Spill
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    ; implicit-def: $vgpr0
; CHECK-NEXT:  .LBB0_1: ; %bb.1
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    s_cbranch_scc1 .LBB0_3
; CHECK-NEXT:  ; %bb.2: ; %bb.2
; CHECK-NEXT:    ; in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:  .LBB0_3: ; %bb.3
; CHECK-NEXT:    ; in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    s_or_saveexec_b64 s[10:11], -1
; CHECK-NEXT:    v_accvgpr_read_b32 v0, a0 ; Reload Reuse
; CHECK-NEXT:    s_mov_b64 exec, s[10:11]
; CHECK-NEXT:    ; implicit-def: $sgpr4
; CHECK-NEXT:    v_mov_b32_e32 v1, s4
; CHECK-NEXT:    v_readfirstlane_b32 s6, v1
; CHECK-NEXT:    s_mov_b64 s[4:5], -1
; CHECK-NEXT:    s_mov_b32 s7, 0
; CHECK-NEXT:    s_cmp_eq_u32 s6, s7
; CHECK-NEXT:    v_writelane_b32 v0, s4, 0
; CHECK-NEXT:    v_writelane_b32 v0, s5, 1
; CHECK-NEXT:    s_mov_b64 s[10:11], exec
; CHECK-NEXT:    s_mov_b64 exec, -1
; CHECK-NEXT:    v_accvgpr_write_b32 a0, v0 ; Reload Reuse
; CHECK-NEXT:    s_mov_b64 exec, s[10:11]
; CHECK-NEXT:    s_cbranch_scc1 .LBB0_5
; CHECK-NEXT:  ; %bb.4: ; %bb.4
; CHECK-NEXT:    ; in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    s_or_saveexec_b64 s[10:11], -1
; CHECK-NEXT:    v_accvgpr_read_b32 v0, a0 ; Reload Reuse
; CHECK-NEXT:    s_mov_b64 exec, s[10:11]
; CHECK-NEXT:    s_mov_b64 s[4:5], 0
; CHECK-NEXT:    v_writelane_b32 v0, s4, 0
; CHECK-NEXT:    v_writelane_b32 v0, s5, 1
; CHECK-NEXT:    s_or_saveexec_b64 s[10:11], -1
; CHECK-NEXT:    s_nop 0
; CHECK-NEXT:    v_accvgpr_write_b32 a0, v0 ; Reload Reuse
; CHECK-NEXT:    s_mov_b64 exec, s[10:11]
; CHECK-NEXT:  .LBB0_5: ; %Flow
; CHECK-NEXT:    ; in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    s_or_saveexec_b64 s[10:11], -1
; CHECK-NEXT:    s_nop 0
; CHECK-NEXT:    v_accvgpr_read_b32 v0, a0 ; Reload Reuse
; CHECK-NEXT:    s_mov_b64 exec, s[10:11]
; CHECK-NEXT:    v_readlane_b32 s4, v0, 0
; CHECK-NEXT:    v_readlane_b32 s5, v0, 1
; CHECK-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[4:5]
; CHECK-NEXT:    s_mov_b32 s4, 1
; CHECK-NEXT:    ; implicit-def: $sgpr5
; CHECK-NEXT:    v_cmp_ne_u32_e64 s[4:5], v0, s4
; CHECK-NEXT:    s_and_b64 vcc, exec, s[4:5]
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_1
; CHECK-NEXT:  ; %bb.6: ; %bb.5
; CHECK-NEXT:    s_or_saveexec_b64 s[10:11], -1
; CHECK-NEXT:    v_accvgpr_read_b32 v0, a0 ; Reload Reuse
; CHECK-NEXT:    s_mov_b64 exec, s[10:11]
; CHECK-NEXT:    ; kill: killed $vgpr0
; CHECK-NEXT:    s_xor_saveexec_b64 s[4:5], -1
; CHECK-NEXT:    buffer_load_dword v0, off, s[0:3], s32 ; 4-byte Folded Reload
; CHECK-NEXT:    s_mov_b64 exec, s[4:5]
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[30:31]
bb.0:
  br label %bb.1
bb.1:                                                ; preds = %bb.4, %bb.0
  br i1 poison, label %bb.2, label %bb.3
bb.2:                                                ; preds = %bb.1
  br label %bb.3
bb.3:                                                ; preds = %bb.2, %bb.1
  %call = tail call i32 @llvm.amdgcn.readfirstlane(i32 poison)
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %bb.5, label %bb.4
bb.4:                                                ; preds = %bb.3
  br label %bb.1
bb.5:                                                ; preds = %bb.3
  ret void
}

declare i32 @llvm.amdgcn.readfirstlane(i32)
