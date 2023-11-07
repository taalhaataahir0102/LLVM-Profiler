; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx908 < %s | FileCheck %s

define amdgpu_kernel void @cannot_create_empty_or_backwards_segment(i1 %arg, i1 %arg1, i1 %arg2, i1 %arg3, i1 %arg4, i1 %arg5) {
; CHECK-LABEL: cannot_create_empty_or_backwards_segment:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_mov_b64 s[26:27], s[2:3]
; CHECK-NEXT:    s_mov_b64 s[24:25], s[0:1]
; CHECK-NEXT:    s_load_dword s2, s[4:5], 0x0
; CHECK-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; CHECK-NEXT:    s_load_dword s6, s[4:5], 0x4
; CHECK-NEXT:    s_add_u32 s24, s24, s7
; CHECK-NEXT:    s_addc_u32 s25, s25, 0
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_bitcmp1_b32 s2, 0
; CHECK-NEXT:    s_cselect_b64 s[16:17], -1, 0
; CHECK-NEXT:    s_bitcmp1_b32 s2, 8
; CHECK-NEXT:    s_cselect_b64 s[10:11], -1, 0
; CHECK-NEXT:    s_bitcmp1_b32 s2, 16
; CHECK-NEXT:    s_cselect_b64 s[2:3], -1, 0
; CHECK-NEXT:    s_bitcmp1_b32 s0, 24
; CHECK-NEXT:    s_cselect_b64 s[8:9], -1, 0
; CHECK-NEXT:    s_xor_b64 s[4:5], s[8:9], -1
; CHECK-NEXT:    s_bitcmp1_b32 s1, 0
; CHECK-NEXT:    s_cselect_b64 s[12:13], -1, 0
; CHECK-NEXT:    s_bitcmp1_b32 s6, 8
; CHECK-NEXT:    v_cndmask_b32_e64 v0, 0, 1, s[2:3]
; CHECK-NEXT:    v_cndmask_b32_e64 v1, 0, 1, s[16:17]
; CHECK-NEXT:    s_cselect_b64 s[14:15], -1, 0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s[2:3], 1, v0
; CHECK-NEXT:    s_and_b64 s[4:5], exec, s[4:5]
; CHECK-NEXT:    s_and_b64 s[6:7], exec, s[10:11]
; CHECK-NEXT:    v_mov_b32_e32 v0, 0
; CHECK-NEXT:    v_cmp_ne_u32_e64 s[0:1], 1, v1
; CHECK-NEXT:    s_branch .LBB0_3
; CHECK-NEXT:  .LBB0_1: ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 s[18:19], 0
; CHECK-NEXT:    s_mov_b64 s[20:21], -1
; CHECK-NEXT:    s_mov_b64 s[16:17], -1
; CHECK-NEXT:    s_mov_b64 s[22:23], -1
; CHECK-NEXT:  .LBB0_2: ; %Flow7
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_and_b64 vcc, exec, s[22:23]
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_12
; CHECK-NEXT:  .LBB0_3: ; %bb7
; CHECK-NEXT:    ; =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    s_and_b64 vcc, exec, s[2:3]
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_1
; CHECK-NEXT:  ; %bb.4: ; %bb8
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 vcc, s[4:5]
; CHECK-NEXT:    s_cbranch_vccz .LBB0_6
; CHECK-NEXT:  ; %bb.5: ; %bb9
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 s[16:17], 0
; CHECK-NEXT:    s_mov_b64 s[18:19], -1
; CHECK-NEXT:    s_mov_b64 s[22:23], s[10:11]
; CHECK-NEXT:    s_cbranch_execz .LBB0_7
; CHECK-NEXT:    s_branch .LBB0_8
; CHECK-NEXT:  .LBB0_6: ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 s[16:17], -1
; CHECK-NEXT:    s_mov_b64 s[18:19], 0
; CHECK-NEXT:    s_mov_b64 s[22:23], 0
; CHECK-NEXT:  .LBB0_7: ; %bb10
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 s[18:19], -1
; CHECK-NEXT:    s_mov_b64 s[16:17], 0
; CHECK-NEXT:    s_mov_b64 s[22:23], s[14:15]
; CHECK-NEXT:  .LBB0_8: ; %Flow9
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 s[20:21], -1
; CHECK-NEXT:    s_andn2_b64 vcc, exec, s[22:23]
; CHECK-NEXT:    s_mov_b64 s[22:23], -1
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_2
; CHECK-NEXT:  ; %bb.9: ; %bb13
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 vcc, s[6:7]
; CHECK-NEXT:    s_cbranch_vccz .LBB0_11
; CHECK-NEXT:  ; %bb.10: ; %bb16
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 s[16:17], 0
; CHECK-NEXT:    s_mov_b64 s[22:23], s[12:13]
; CHECK-NEXT:    s_mov_b64 s[18:19], s[16:17]
; CHECK-NEXT:    s_branch .LBB0_2
; CHECK-NEXT:  .LBB0_11: ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 s[20:21], 0
; CHECK-NEXT:    ; implicit-def: $sgpr16_sgpr17
; CHECK-NEXT:    s_mov_b64 s[18:19], s[16:17]
; CHECK-NEXT:    s_branch .LBB0_2
; CHECK-NEXT:  .LBB0_12: ; %loop.exit.guard6
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_xor_b64 s[22:23], s[20:21], -1
; CHECK-NEXT:    s_mov_b64 s[20:21], -1
; CHECK-NEXT:    s_and_b64 vcc, exec, s[22:23]
; CHECK-NEXT:    s_cbranch_vccz .LBB0_16
; CHECK-NEXT:  ; %bb.13: ; %bb14
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_and_b64 vcc, exec, s[0:1]
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_15
; CHECK-NEXT:  ; %bb.14: ; %bb15
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    buffer_store_dword v0, off, s[24:27], 0 offset:4
; CHECK-NEXT:    buffer_store_dword v0, off, s[24:27], 0
; CHECK-NEXT:  .LBB0_15: ; %Flow
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_mov_b64 s[20:21], 0
; CHECK-NEXT:  .LBB0_16: ; %Flow13
; CHECK-NEXT:    ; in Loop: Header=BB0_3 Depth=1
; CHECK-NEXT:    s_andn2_b64 vcc, exec, s[20:21]
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_3
; CHECK-NEXT:  ; %bb.17: ; %loop.exit.guard
; CHECK-NEXT:    s_and_b64 vcc, exec, s[16:17]
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_22
; CHECK-NEXT:  ; %bb.18: ; %loop.exit.guard5
; CHECK-NEXT:    s_and_b64 vcc, exec, s[18:19]
; CHECK-NEXT:    s_cbranch_vccnz .LBB0_23
; CHECK-NEXT:  ; %bb.19: ; %bb17
; CHECK-NEXT:    s_and_b64 vcc, exec, s[8:9]
; CHECK-NEXT:    s_cbranch_vccz .LBB0_21
; CHECK-NEXT:  ; %bb.20: ; %bb19
; CHECK-NEXT:    s_and_b64 vcc, exec, s[0:1]
; CHECK-NEXT:    s_cbranch_vccz .LBB0_22
; CHECK-NEXT:  .LBB0_21: ; %bb18
; CHECK-NEXT:    s_endpgm
; CHECK-NEXT:  .LBB0_22: ; %bb20
; CHECK-NEXT:  .LBB0_23: ; %bb12
bb:
  br label %bb6

bb6:                                              ; preds = %bb15, %bb14, %bb
  br label %bb7

bb7:                                              ; preds = %bb16, %bb6
  br i1 %arg2, label %bb8, label %bb20

bb8:                                              ; preds = %bb7
  br i1 %arg3, label %bb10, label %bb9

bb9:                                              ; preds = %bb8
  br i1 %arg1, label %bb13, label %bb12

bb10:                                             ; preds = %bb8
  br i1 %arg5, label %bb11, label %bb12

bb11:                                             ; preds = %bb10
  br label %bb13

bb12:                                             ; preds = %bb10, %bb9
  unreachable

bb13:                                             ; preds = %bb11, %bb9
  br i1 %arg1, label %bb16, label %bb14

bb14:                                             ; preds = %bb13
  br i1 %arg, label %bb15, label %bb6

bb15:                                             ; preds = %bb14
  store double 0.000000e+00, ptr addrspace(5) null, align 2147483648
  br label %bb6

bb16:                                             ; preds = %bb13
  br i1 %arg4, label %bb17, label %bb7

bb17:                                             ; preds = %bb16
  br i1 %arg3, label %bb19, label %bb18

bb18:                                             ; preds = %bb17
  ret void

bb19:                                             ; preds = %bb17
  br i1 %arg, label %bb20, label %bb21

bb20:                                             ; preds = %bb19, %bb7
  unreachable

bb21:                                             ; preds = %bb19
  ret void
}
