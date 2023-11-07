; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -march=amdgcn -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,SI %s
; RUN: llc -march=amdgcn -mcpu=tonga -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,VI %s
; RUN: llc -march=amdgcn -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefixes=GCN,GFX11 %s

; Make sure we don't crash or assert on spir_kernel calling convention.

define spir_kernel void @kernel(ptr addrspace(1) %out) {
; SI-LABEL: kernel:
; SI:       ; %bb.0: ; %entry
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_mov_b32_e32 v0, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: kernel:
; VI:       ; %bb.0: ; %entry
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; VI-NEXT:    v_mov_b32_e32 v2, 0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: kernel:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_load_b64 s[0:1], s[0:1], 0x24
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    global_store_b32 v0, v0, s[0:1]
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
entry:
  store i32 0, ptr addrspace(1) %out
  ret void
}

; FIXME: This is treated like a kernel
; XGCN-LABEL: {{^}}func:
; XGCN: s_endpgm
; define spir_func void @func(ptr addrspace(1) %out) {
; entry:
;   store i32 0, ptr addrspace(1) %out
;   ret void
; }

define amdgpu_ps half @ps_ret_cc_f16(half %arg0) {
; SI-LABEL: ps_ret_cc_f16:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: ps_ret_cc_f16:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f16_e32 v0, 1.0, v0
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: ps_ret_cc_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f16_e32 v0, 1.0, v0
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd half %arg0, 1.0
  ret half %add
}

define amdgpu_ps half @ps_ret_cc_inreg_f16(half inreg %arg0) {
; SI-LABEL: ps_ret_cc_inreg_f16:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, s0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: ps_ret_cc_inreg_f16:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f16_e64 v0, s0, 1.0
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: ps_ret_cc_inreg_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f16_e64 v0, s0, 1.0
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd half %arg0, 1.0
  ret half %add
}

define fastcc float @fastcc(float %arg0) #0 {
; GCN-LABEL: fastcc:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_add_f32_e32 v0, 4.0, v0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %add = fadd float %arg0, 4.0
  ret float %add
}

define coldcc float @coldcc(float %arg0) #0 {
; GCN-LABEL: coldcc:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_add_f32_e32 v0, 4.0, v0
; GCN-NEXT:    s_setpc_b64 s[30:31]
 %add = fadd float %arg0, 4.0
 ret float %add
}

define amdgpu_kernel void @call_coldcc() #0 {
; SI-LABEL: call_coldcc:
; SI:       ; %bb.0:
; SI-NEXT:    s_mov_b32 s32, 0
; SI-NEXT:    s_mov_b32 s8, SCRATCH_RSRC_DWORD0
; SI-NEXT:    s_mov_b32 s9, SCRATCH_RSRC_DWORD1
; SI-NEXT:    s_mov_b32 s10, -1
; SI-NEXT:    s_mov_b32 s11, 0xe8f000
; SI-NEXT:    s_add_u32 s8, s8, s1
; SI-NEXT:    s_addc_u32 s9, s9, 0
; SI-NEXT:    s_getpc_b64 s[0:1]
; SI-NEXT:    s_add_u32 s0, s0, coldcc@gotpcrel32@lo+4
; SI-NEXT:    s_addc_u32 s1, s1, coldcc@gotpcrel32@hi+12
; SI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x0
; SI-NEXT:    v_mov_b32_e32 v0, 1.0
; SI-NEXT:    s_mov_b64 s[0:1], s[8:9]
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: call_coldcc:
; VI:       ; %bb.0:
; VI-NEXT:    s_mov_b32 s88, SCRATCH_RSRC_DWORD0
; VI-NEXT:    s_mov_b32 s89, SCRATCH_RSRC_DWORD1
; VI-NEXT:    s_mov_b32 s90, -1
; VI-NEXT:    s_mov_b32 s91, 0xe80000
; VI-NEXT:    s_add_u32 s88, s88, s1
; VI-NEXT:    s_addc_u32 s89, s89, 0
; VI-NEXT:    s_getpc_b64 s[0:1]
; VI-NEXT:    s_add_u32 s0, s0, coldcc@gotpcrel32@lo+4
; VI-NEXT:    s_addc_u32 s1, s1, coldcc@gotpcrel32@hi+12
; VI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x0
; VI-NEXT:    s_mov_b64 s[0:1], s[88:89]
; VI-NEXT:    s_mov_b64 s[2:3], s[90:91]
; VI-NEXT:    v_mov_b32_e32 v0, 1.0
; VI-NEXT:    s_mov_b32 s32, 0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; VI-NEXT:    flat_store_dword v[0:1], v0
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: call_coldcc:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_getpc_b64 s[0:1]
; GFX11-NEXT:    s_add_u32 s0, s0, coldcc@gotpcrel32@lo+4
; GFX11-NEXT:    s_addc_u32 s1, s1, coldcc@gotpcrel32@hi+12
; GFX11-NEXT:    v_mov_b32_e32 v0, 1.0
; GFX11-NEXT:    s_load_b64 s[0:1], s[0:1], 0x0
; GFX11-NEXT:    s_mov_b32 s32, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_swappc_b64 s[30:31], s[0:1]
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %val = call float @coldcc(float 1.0)
  store float %val, ptr addrspace(1) undef
  ret void
}

define amdgpu_kernel void @call_fastcc() #0 {
; SI-LABEL: call_fastcc:
; SI:       ; %bb.0:
; SI-NEXT:    s_mov_b32 s32, 0
; SI-NEXT:    s_mov_b32 s8, SCRATCH_RSRC_DWORD0
; SI-NEXT:    s_mov_b32 s9, SCRATCH_RSRC_DWORD1
; SI-NEXT:    s_mov_b32 s10, -1
; SI-NEXT:    s_mov_b32 s11, 0xe8f000
; SI-NEXT:    s_add_u32 s8, s8, s1
; SI-NEXT:    s_addc_u32 s9, s9, 0
; SI-NEXT:    s_getpc_b64 s[0:1]
; SI-NEXT:    s_add_u32 s0, s0, fastcc@gotpcrel32@lo+4
; SI-NEXT:    s_addc_u32 s1, s1, fastcc@gotpcrel32@hi+12
; SI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x0
; SI-NEXT:    v_mov_b32_e32 v0, 1.0
; SI-NEXT:    s_mov_b64 s[0:1], s[8:9]
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: call_fastcc:
; VI:       ; %bb.0:
; VI-NEXT:    s_mov_b32 s88, SCRATCH_RSRC_DWORD0
; VI-NEXT:    s_mov_b32 s89, SCRATCH_RSRC_DWORD1
; VI-NEXT:    s_mov_b32 s90, -1
; VI-NEXT:    s_mov_b32 s91, 0xe80000
; VI-NEXT:    s_add_u32 s88, s88, s1
; VI-NEXT:    s_addc_u32 s89, s89, 0
; VI-NEXT:    s_getpc_b64 s[0:1]
; VI-NEXT:    s_add_u32 s0, s0, fastcc@gotpcrel32@lo+4
; VI-NEXT:    s_addc_u32 s1, s1, fastcc@gotpcrel32@hi+12
; VI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x0
; VI-NEXT:    s_mov_b64 s[0:1], s[88:89]
; VI-NEXT:    s_mov_b64 s[2:3], s[90:91]
; VI-NEXT:    v_mov_b32_e32 v0, 1.0
; VI-NEXT:    s_mov_b32 s32, 0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; VI-NEXT:    flat_store_dword v[0:1], v0
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: call_fastcc:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_getpc_b64 s[0:1]
; GFX11-NEXT:    s_add_u32 s0, s0, fastcc@gotpcrel32@lo+4
; GFX11-NEXT:    s_addc_u32 s1, s1, fastcc@gotpcrel32@hi+12
; GFX11-NEXT:    v_mov_b32_e32 v0, 1.0
; GFX11-NEXT:    s_load_b64 s[0:1], s[0:1], 0x0
; GFX11-NEXT:    s_mov_b32 s32, 0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_swappc_b64 s[30:31], s[0:1]
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %val = call float @fastcc(float 1.0)
  store float %val, ptr addrspace(1) undef
  ret void
}

; Mesa compute shader: check for 47176 (COMPUTE_PGM_RSRC1) in .AMDGPU.config
define amdgpu_cs half @cs_mesa(half %arg0) {
; SI-LABEL: cs_mesa:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: cs_mesa:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f16_e32 v0, 1.0, v0
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: cs_mesa:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f16_e32 v0, 1.0, v0
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd half %arg0, 1.0
  ret half %add
}

; Mesa pixel shader: check for 45096 (SPI_SHADER_PGM_RSRC1_PS) in .AMDGPU.config
define amdgpu_ps half @ps_mesa_f16(half %arg0) {
; SI-LABEL: ps_mesa_f16:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: ps_mesa_f16:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f16_e32 v0, 1.0, v0
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: ps_mesa_f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f16_e32 v0, 1.0, v0
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd half %arg0, 1.0
  ret half %add
}

; Mesa vertex shader: check for 45352 (SPI_SHADER_PGM_RSRC1_VS) in .AMDGPU.config
define amdgpu_vs half @vs_mesa(half %arg0) {
; SI-LABEL: vs_mesa:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: vs_mesa:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f16_e32 v0, 1.0, v0
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: vs_mesa:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f16_e32 v0, 1.0, v0
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd half %arg0, 1.0
  ret half %add
}

; Mesa geometry shader: check for 45608 (SPI_SHADER_PGM_RSRC1_GS) in .AMDGPU.config
define amdgpu_gs half @gs_mesa(half %arg0) {
; SI-LABEL: gs_mesa:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: gs_mesa:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f16_e32 v0, 1.0, v0
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: gs_mesa:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f16_e32 v0, 1.0, v0
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd half %arg0, 1.0
  ret half %add
}

; Mesa hull shader: check for 46120 (SPI_SHADER_PGM_RSRC1_HS) in .AMDGPU.config
define amdgpu_hs half @hs_mesa(half %arg0) {
; SI-LABEL: hs_mesa:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: hs_mesa:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f16_e32 v0, 1.0, v0
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: hs_mesa:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f16_e32 v0, 1.0, v0
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd half %arg0, 1.0
  ret half %add
}

; FIXME: Inconsistent ABI between targets

define amdgpu_ps <2 x half> @ps_mesa_v2f16(<2 x half> %arg0) {
; SI-LABEL: ps_mesa_v2f16:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v1, v1
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v1, v1
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    v_add_f32_e32 v1, 1.0, v1
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: ps_mesa_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    v_mov_b32_e32 v1, 0x3c00
; VI-NEXT:    v_add_f16_sdwa v1, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_add_f16_e32 v0, 1.0, v0
; VI-NEXT:    v_or_b32_e32 v0, v0, v1
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: ps_mesa_v2f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_pk_add_f16 v0, v0, 1.0 op_sel_hi:[1,0]
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd <2 x half> %arg0, <half 1.0, half 1.0>
  ret <2 x half> %add
}

define amdgpu_ps <2 x half> @ps_mesa_inreg_v2f16(<2 x half> inreg %arg0) {
; SI-LABEL: ps_mesa_inreg_v2f16:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, s1
; SI-NEXT:    v_cvt_f16_f32_e32 v1, s0
; SI-NEXT:    v_cvt_f32_f16_e32 v2, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v1
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    v_add_f32_e32 v1, 1.0, v2
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: ps_mesa_inreg_v2f16:
; VI:       ; %bb.0:
; VI-NEXT:    s_lshr_b32 s1, s0, 16
; VI-NEXT:    v_mov_b32_e32 v0, s1
; VI-NEXT:    v_mov_b32_e32 v1, 0x3c00
; VI-NEXT:    v_add_f16_sdwa v0, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; VI-NEXT:    v_add_f16_e64 v1, s0, 1.0
; VI-NEXT:    v_or_b32_e32 v0, v1, v0
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: ps_mesa_inreg_v2f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_pk_add_f16 v0, s0, 1.0 op_sel_hi:[1,0]
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd <2 x half> %arg0, <half 1.0, half 1.0>
  ret <2 x half> %add
}

define amdgpu_ps void @ps_mesa_v2i16(<2 x i16> %arg0) {
; SI-LABEL: ps_mesa_v2i16:
; SI:       ; %bb.0:
; SI-NEXT:    v_lshlrev_b32_e32 v1, 16, v1
; SI-NEXT:    v_add_i32_e32 v0, vcc, 1, v0
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; SI-NEXT:    v_or_b32_e32 v0, v1, v0
; SI-NEXT:    v_add_i32_e32 v0, vcc, 0x10000, v0
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    v_mov_b32_e32 v2, 1
; VI-NEXT:    v_add_u16_e32 v1, 1, v0
; VI-NEXT:    v_add_u16_sdwa v0, v0, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v0, v1, v0
; VI-NEXT:    flat_store_dword v[0:1], v0
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_v2i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_pk_sub_u16 v0, v0, -1 op_sel_hi:[1,0]
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = add <2 x i16> %arg0, <i16 1, i16 1>
  store <2 x i16> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_inreg_v2i16(<2 x i16> inreg %arg0) {
; SI-LABEL: ps_mesa_inreg_v2i16:
; SI:       ; %bb.0:
; SI-NEXT:    s_lshl_b32 s1, s1, 16
; SI-NEXT:    s_add_i32 s0, s0, 1
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_and_b32 s0, s0, 0xffff
; SI-NEXT:    s_or_b32 s0, s1, s0
; SI-NEXT:    s_add_i32 s0, s0, 0x10000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_mov_b32_e32 v0, s0
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_inreg_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_and_b32 s1, s0, 0xffff0000
; VI-NEXT:    s_add_i32 s0, s0, 1
; VI-NEXT:    s_and_b32 s0, s0, 0xffff
; VI-NEXT:    s_or_b32 s0, s1, s0
; VI-NEXT:    s_add_i32 s0, s0, 0x10000
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    flat_store_dword v[0:1], v0
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_inreg_v2i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_pk_sub_u16 v0, s0, -1 op_sel_hi:[1,0]
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = add <2 x i16> %arg0, <i16 1, i16 1>
  store <2 x i16> %add, ptr addrspace(1) undef
  ret void
}

; FIXME: Differenet ABI for VI+

define amdgpu_ps <4 x half> @ps_mesa_v4f16(<4 x half> %arg0) {
; SI-LABEL: ps_mesa_v4f16:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v3, v3
; SI-NEXT:    v_cvt_f16_f32_e32 v2, v2
; SI-NEXT:    v_cvt_f16_f32_e32 v1, v1
; SI-NEXT:    v_cvt_f16_f32_e32 v0, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v3, v3
; SI-NEXT:    v_cvt_f32_f16_e32 v2, v2
; SI-NEXT:    v_cvt_f32_f16_e32 v1, v1
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    v_add_f32_e32 v1, 1.0, v1
; SI-NEXT:    v_add_f32_e32 v2, 1.0, v2
; SI-NEXT:    v_add_f32_e32 v3, 1.0, v3
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: ps_mesa_v4f16:
; VI:       ; %bb.0:
; VI-NEXT:    v_mov_b32_e32 v3, 0x3c00
; VI-NEXT:    v_add_f16_e32 v2, 1.0, v1
; VI-NEXT:    v_add_f16_sdwa v1, v1, v3 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_add_f16_e32 v4, 1.0, v0
; VI-NEXT:    v_add_f16_sdwa v0, v0, v3 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v0, v4, v0
; VI-NEXT:    v_or_b32_e32 v1, v2, v1
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: ps_mesa_v4f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_pk_add_f16 v0, v0, 1.0 op_sel_hi:[1,0]
; GFX11-NEXT:    v_pk_add_f16 v1, v1, 1.0 op_sel_hi:[1,0]
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd <4 x half> %arg0, <half 1.0, half 1.0, half 1.0, half 1.0>
  ret <4 x half> %add
}

define amdgpu_ps <4 x half> @ps_mesa_inreg_v4f16(<4 x half> inreg %arg0) {
; SI-LABEL: ps_mesa_inreg_v4f16:
; SI:       ; %bb.0:
; SI-NEXT:    v_cvt_f16_f32_e32 v0, s3
; SI-NEXT:    v_cvt_f16_f32_e32 v1, s2
; SI-NEXT:    v_cvt_f16_f32_e32 v2, s1
; SI-NEXT:    v_cvt_f16_f32_e32 v3, s0
; SI-NEXT:    v_cvt_f32_f16_e32 v4, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v5, v1
; SI-NEXT:    v_cvt_f32_f16_e32 v1, v2
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v3
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    v_add_f32_e32 v1, 1.0, v1
; SI-NEXT:    v_add_f32_e32 v2, 1.0, v5
; SI-NEXT:    v_add_f32_e32 v3, 1.0, v4
; SI-NEXT:    ; return to shader part epilog
;
; VI-LABEL: ps_mesa_inreg_v4f16:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f16_e64 v1, s1, 1.0
; VI-NEXT:    s_lshr_b32 s1, s1, 16
; VI-NEXT:    v_mov_b32_e32 v0, s1
; VI-NEXT:    v_mov_b32_e32 v2, 0x3c00
; VI-NEXT:    v_add_f16_sdwa v3, v0, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; VI-NEXT:    v_add_f16_e64 v0, s0, 1.0
; VI-NEXT:    s_lshr_b32 s0, s0, 16
; VI-NEXT:    v_mov_b32_e32 v4, s0
; VI-NEXT:    v_add_f16_sdwa v2, v4, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v0, v0, v2
; VI-NEXT:    v_or_b32_e32 v1, v1, v3
; VI-NEXT:    ; return to shader part epilog
;
; GFX11-LABEL: ps_mesa_inreg_v4f16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_pk_add_f16 v0, s0, 1.0 op_sel_hi:[1,0]
; GFX11-NEXT:    v_pk_add_f16 v1, s1, 1.0 op_sel_hi:[1,0]
; GFX11-NEXT:    ; return to shader part epilog
  %add = fadd <4 x half> %arg0, <half 1.0, half 1.0, half 1.0, half 1.0>
  ret <4 x half> %add
}

define amdgpu_ps void @ps_mesa_inreg_v3i32(<3 x i32> inreg %arg0) {
; SI-LABEL: ps_mesa_inreg_v3i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_add_i32 s1, s1, 2
; SI-NEXT:    s_add_i32 s0, s0, 1
; SI-NEXT:    s_add_i32 s4, s2, 3
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_waitcnt expcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s0
; SI-NEXT:    v_mov_b32_e32 v1, s1
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_inreg_v3i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_add_i32 s2, s2, 3
; VI-NEXT:    s_add_i32 s1, s1, 2
; VI-NEXT:    s_add_i32 s0, s0, 1
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    flat_store_dwordx3 v[0:1], v[0:2]
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_inreg_v3i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_add_i32 s2, s2, 3
; GFX11-NEXT:    s_add_i32 s0, s0, 1
; GFX11-NEXT:    s_add_i32 s1, s1, 2
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX11-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v1, s1
; GFX11-NEXT:    v_mov_b32_e32 v2, s2
; GFX11-NEXT:    global_store_b96 v[0:1], v[0:2], off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = add <3 x i32> %arg0, <i32 1, i32 2, i32 3>
  store <3 x i32> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_inreg_v3f32(<3 x float> inreg %arg0) {
; SI-LABEL: ps_mesa_inreg_v3f32:
; SI:       ; %bb.0:
; SI-NEXT:    v_add_f32_e64 v1, s1, 2.0
; SI-NEXT:    v_add_f32_e64 v0, s0, 1.0
; SI-NEXT:    v_add_f32_e64 v2, s2, 4.0
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v2, off, s[0:3], 0
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_inreg_v3f32:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f32_e64 v2, s2, 4.0
; VI-NEXT:    v_add_f32_e64 v1, s1, 2.0
; VI-NEXT:    v_add_f32_e64 v0, s0, 1.0
; VI-NEXT:    flat_store_dwordx3 v[0:1], v[0:2]
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_inreg_v3f32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f32_e64 v2, s2, 4.0
; GFX11-NEXT:    v_add_f32_e64 v1, s1, 2.0
; GFX11-NEXT:    v_add_f32_e64 v0, s0, 1.0
; GFX11-NEXT:    global_store_b96 v[0:1], v[0:2], off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = fadd <3 x float> %arg0, <float 1.0, float 2.0, float 4.0>
  store <3 x float> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_inreg_v5i32(<5 x i32> inreg %arg0) {
; SI-LABEL: ps_mesa_inreg_v5i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_add_i32 s5, s3, 4
; SI-NEXT:    s_add_i32 s6, s2, 3
; SI-NEXT:    s_add_i32 s1, s1, 2
; SI-NEXT:    s_add_i32 s0, s0, 1
; SI-NEXT:    s_add_i32 s4, s4, 5
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_mov_b32_e32 v0, s4
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_waitcnt expcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s0
; SI-NEXT:    v_mov_b32_e32 v1, s1
; SI-NEXT:    v_mov_b32_e32 v2, s6
; SI-NEXT:    v_mov_b32_e32 v3, s5
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_inreg_v5i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_add_i32 s4, s4, 5
; VI-NEXT:    s_add_i32 s3, s3, 4
; VI-NEXT:    s_add_i32 s2, s2, 3
; VI-NEXT:    s_add_i32 s1, s1, 2
; VI-NEXT:    s_add_i32 s0, s0, 1
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    flat_store_dword v[0:1], v0
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s1
; VI-NEXT:    v_mov_b32_e32 v2, s2
; VI-NEXT:    v_mov_b32_e32 v3, s3
; VI-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_inreg_v5i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_add_i32 s3, s3, 4
; GFX11-NEXT:    s_add_i32 s2, s2, 3
; GFX11-NEXT:    s_add_i32 s1, s1, 2
; GFX11-NEXT:    s_add_i32 s4, s4, 5
; GFX11-NEXT:    s_add_i32 s0, s0, 1
; GFX11-NEXT:    v_dual_mov_b32 v4, s4 :: v_dual_mov_b32 v1, s1
; GFX11-NEXT:    v_dual_mov_b32 v0, s0 :: v_dual_mov_b32 v3, s3
; GFX11-NEXT:    v_mov_b32_e32 v2, s2
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    global_store_b32 v[0:1], v4, off
; GFX11-NEXT:    global_store_b128 v[0:1], v[0:3], off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = add <5 x i32> %arg0, <i32 1, i32 2, i32 3, i32 4, i32 5>
  store <5 x i32> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_inreg_v5f32(<5 x float> inreg %arg0) {
; SI-LABEL: ps_mesa_inreg_v5f32:
; SI:       ; %bb.0:
; SI-NEXT:    v_add_f32_e64 v3, s3, -1.0
; SI-NEXT:    v_add_f32_e64 v2, s2, 4.0
; SI-NEXT:    v_add_f32_e64 v1, s1, 2.0
; SI-NEXT:    v_add_f32_e64 v0, s0, 1.0
; SI-NEXT:    v_add_f32_e64 v4, s4, 0.5
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v4, off, s[0:3], 0
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_inreg_v5f32:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f32_e64 v3, s3, -1.0
; VI-NEXT:    v_add_f32_e64 v2, s2, 4.0
; VI-NEXT:    v_add_f32_e64 v1, s1, 2.0
; VI-NEXT:    v_add_f32_e64 v0, s0, 1.0
; VI-NEXT:    v_add_f32_e64 v4, s4, 0.5
; VI-NEXT:    flat_store_dword v[0:1], v4
; VI-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_inreg_v5f32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_f32_e64 v3, s3, -1.0
; GFX11-NEXT:    v_add_f32_e64 v2, s2, 4.0
; GFX11-NEXT:    v_add_f32_e64 v1, s1, 2.0
; GFX11-NEXT:    v_add_f32_e64 v4, s4, 0.5
; GFX11-NEXT:    v_add_f32_e64 v0, s0, 1.0
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    global_store_b32 v[0:1], v4, off
; GFX11-NEXT:    global_store_b128 v[0:1], v[0:3], off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = fadd <5 x float> %arg0, <float 1.0, float 2.0, float 4.0, float -1.0, float 0.5>
  store <5 x float> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_v3i32(<3 x i32> %arg0) {
; SI-LABEL: ps_mesa_v3i32:
; SI:       ; %bb.0:
; SI-NEXT:    v_add_i32_e32 v1, vcc, 2, v1
; SI-NEXT:    v_add_i32_e32 v0, vcc, 1, v0
; SI-NEXT:    v_add_i32_e32 v2, vcc, 3, v2
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v2, off, s[0:3], 0
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_v3i32:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_u32_e32 v2, vcc, 3, v2
; VI-NEXT:    v_add_u32_e32 v1, vcc, 2, v1
; VI-NEXT:    v_add_u32_e32 v0, vcc, 1, v0
; VI-NEXT:    flat_store_dwordx3 v[0:1], v[0:2]
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_v3i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_nc_u32_e32 v2, 3, v2
; GFX11-NEXT:    v_add_nc_u32_e32 v1, 2, v1
; GFX11-NEXT:    v_add_nc_u32_e32 v0, 1, v0
; GFX11-NEXT:    global_store_b96 v[0:1], v[0:2], off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = add <3 x i32> %arg0, <i32 1, i32 2, i32 3>
  store <3 x i32> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_v3f32(<3 x float> %arg0) {
; SI-LABEL: ps_mesa_v3f32:
; SI:       ; %bb.0:
; SI-NEXT:    v_add_f32_e32 v1, 2.0, v1
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    v_add_f32_e32 v2, 4.0, v2
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v2, off, s[0:3], 0
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_v3f32:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f32_e32 v2, 4.0, v2
; VI-NEXT:    v_add_f32_e32 v1, 2.0, v1
; VI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; VI-NEXT:    flat_store_dwordx3 v[0:1], v[0:2]
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_v3f32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_dual_add_f32 v2, 4.0, v2 :: v_dual_add_f32 v1, 2.0, v1
; GFX11-NEXT:    v_add_f32_e32 v0, 1.0, v0
; GFX11-NEXT:    global_store_b96 v[0:1], v[0:2], off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = fadd <3 x float> %arg0, <float 1.0, float 2.0, float 4.0>
  store <3 x float> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_v5i32(<5 x i32> %arg0) {
; SI-LABEL: ps_mesa_v5i32:
; SI:       ; %bb.0:
; SI-NEXT:    v_add_i32_e32 v3, vcc, 4, v3
; SI-NEXT:    v_add_i32_e32 v2, vcc, 3, v2
; SI-NEXT:    v_add_i32_e32 v1, vcc, 2, v1
; SI-NEXT:    v_add_i32_e32 v0, vcc, 1, v0
; SI-NEXT:    v_add_i32_e32 v4, vcc, 5, v4
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v4, off, s[0:3], 0
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_v5i32:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_u32_e32 v3, vcc, 4, v3
; VI-NEXT:    v_add_u32_e32 v2, vcc, 3, v2
; VI-NEXT:    v_add_u32_e32 v1, vcc, 2, v1
; VI-NEXT:    v_add_u32_e32 v0, vcc, 1, v0
; VI-NEXT:    v_add_u32_e32 v4, vcc, 5, v4
; VI-NEXT:    flat_store_dword v[0:1], v4
; VI-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_v5i32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_nc_u32_e32 v3, 4, v3
; GFX11-NEXT:    v_add_nc_u32_e32 v2, 3, v2
; GFX11-NEXT:    v_add_nc_u32_e32 v1, 2, v1
; GFX11-NEXT:    v_add_nc_u32_e32 v4, 5, v4
; GFX11-NEXT:    v_add_nc_u32_e32 v0, 1, v0
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    global_store_b32 v[0:1], v4, off
; GFX11-NEXT:    global_store_b128 v[0:1], v[0:3], off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = add <5 x i32> %arg0, <i32 1, i32 2, i32 3, i32 4, i32 5>
  store <5 x i32> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_v5f32(<5 x float> %arg0) {
; SI-LABEL: ps_mesa_v5f32:
; SI:       ; %bb.0:
; SI-NEXT:    v_add_f32_e32 v3, -1.0, v3
; SI-NEXT:    v_add_f32_e32 v2, 4.0, v2
; SI-NEXT:    v_add_f32_e32 v1, 2.0, v1
; SI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; SI-NEXT:    v_add_f32_e32 v4, 0.5, v4
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_dword v4, off, s[0:3], 0
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_v5f32:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_f32_e32 v3, -1.0, v3
; VI-NEXT:    v_add_f32_e32 v2, 4.0, v2
; VI-NEXT:    v_add_f32_e32 v1, 2.0, v1
; VI-NEXT:    v_add_f32_e32 v0, 1.0, v0
; VI-NEXT:    v_add_f32_e32 v4, 0.5, v4
; VI-NEXT:    flat_store_dword v[0:1], v4
; VI-NEXT:    flat_store_dwordx4 v[0:1], v[0:3]
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_v5f32:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_dual_add_f32 v3, -1.0, v3 :: v_dual_add_f32 v2, 4.0, v2
; GFX11-NEXT:    v_dual_add_f32 v1, 2.0, v1 :: v_dual_add_f32 v4, 0.5, v4
; GFX11-NEXT:    v_add_f32_e32 v0, 1.0, v0
; GFX11-NEXT:    s_clause 0x1
; GFX11-NEXT:    global_store_b32 v[0:1], v4, off
; GFX11-NEXT:    global_store_b128 v[0:1], v[0:3], off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = fadd <5 x float> %arg0, <float 1.0, float 2.0, float 4.0, float -1.0, float 0.5>
  store <5 x float> %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_i16(i16 %arg0) {
; SI-LABEL: ps_mesa_i16:
; SI:       ; %bb.0:
; SI-NEXT:    v_add_i32_e32 v0, vcc, v0, v0
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    buffer_store_short v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_i16:
; VI:       ; %bb.0:
; VI-NEXT:    v_add_u16_e32 v0, v0, v0
; VI-NEXT:    flat_store_short v[0:1], v0
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    v_add_nc_u16 v0, v0, v0
; GFX11-NEXT:    global_store_b16 v[0:1], v0, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = add i16 %arg0, %arg0
  store i16 %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps void @ps_mesa_inreg_i16(i16 inreg %arg0) {
; SI-LABEL: ps_mesa_inreg_i16:
; SI:       ; %bb.0:
; SI-NEXT:    s_add_i32 s0, s0, s0
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    v_mov_b32_e32 v0, s0
; SI-NEXT:    buffer_store_short v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: ps_mesa_inreg_i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_and_b32 s0, 0xffff, s0
; VI-NEXT:    s_add_i32 s0, s0, s0
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    flat_store_short v[0:1], v0
; VI-NEXT:    s_endpgm
;
; GFX11-LABEL: ps_mesa_inreg_i16:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_and_b32 s0, 0xffff, s0
; GFX11-NEXT:    s_delay_alu instid0(SALU_CYCLE_1) | instskip(NEXT) | instid1(SALU_CYCLE_1)
; GFX11-NEXT:    s_add_i32 s0, s0, s0
; GFX11-NEXT:    v_mov_b32_e32 v0, s0
; GFX11-NEXT:    global_store_b16 v[0:1], v0, off
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
  %add = add i16 %arg0, %arg0
  store i16 %add, ptr addrspace(1) undef
  ret void
}

define amdgpu_ps i16 @ret_ps_mesa_i16() {
; GCN-LABEL: ret_ps_mesa_i16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_movk_i32 s0, 0x7b
; GCN-NEXT:    ; return to shader part epilog
  ret i16 123
}

attributes #0 = { nounwind noinline }
