; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx900 < %s | FileCheck -check-prefixes=GCN,GFX9 %s
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=fiji < %s | FileCheck -check-prefixes=GCN,GFX8 %s
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1010 < %s | FileCheck -check-prefixes=GFX10 %s
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1100 -amdgpu-enable-delay-alu=0 < %s | FileCheck -check-prefixes=GFX11 %s

define half @v_constained_fma_f16_fpexcept_strict(half %x, half %y, half %z) #0 {
; GCN-LABEL: v_constained_fma_f16_fpexcept_strict:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f16 v0, v0, v1, v2
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_f16_fpexcept_strict:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f16 v0, v0, v1, v2
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: v_constained_fma_f16_fpexcept_strict:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_fma_f16 v0, v0, v1, v2
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %val = call half @llvm.experimental.constrained.fma.f16(half %x, half %y, half %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret half %val
}

define <2 x half> @v_constained_fma_v2f16_fpexcept_strict(<2 x half> %x, <2 x half> %y, <2 x half> %z) #0 {
; GFX9-LABEL: v_constained_fma_v2f16_fpexcept_strict:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_pk_fma_f16 v0, v0, v1, v2
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_constained_fma_v2f16_fpexcept_strict:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshrrev_b32_e32 v3, 16, v2
; GFX8-NEXT:    v_lshrrev_b32_e32 v4, 16, v1
; GFX8-NEXT:    v_lshrrev_b32_e32 v5, 16, v0
; GFX8-NEXT:    v_fma_f16 v3, v5, v4, v3
; GFX8-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; GFX8-NEXT:    v_fma_f16 v0, v0, v1, v2
; GFX8-NEXT:    v_or_b32_e32 v0, v0, v3
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_v2f16_fpexcept_strict:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_pk_fma_f16 v0, v0, v1, v2
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: v_constained_fma_v2f16_fpexcept_strict:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_pk_fma_f16 v0, v0, v1, v2
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %val = call <2 x half> @llvm.experimental.constrained.fma.v2f16(<2 x half> %x, <2 x half> %y, <2 x half> %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret <2 x half> %val
}

define <3 x half> @v_constained_fma_v3f16_fpexcept_strict(<3 x half> %x, <3 x half> %y, <3 x half> %z) #0 {
; GFX9-LABEL: v_constained_fma_v3f16_fpexcept_strict:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_pk_fma_f16 v0, v0, v2, v4
; GFX9-NEXT:    v_fma_f16 v1, v1, v3, v5
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_constained_fma_v3f16_fpexcept_strict:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshrrev_b32_e32 v6, 16, v4
; GFX8-NEXT:    v_lshrrev_b32_e32 v7, 16, v2
; GFX8-NEXT:    v_lshrrev_b32_e32 v8, 16, v0
; GFX8-NEXT:    v_fma_f16 v6, v8, v7, v6
; GFX8-NEXT:    v_lshlrev_b32_e32 v6, 16, v6
; GFX8-NEXT:    v_fma_f16 v0, v0, v2, v4
; GFX8-NEXT:    v_or_b32_e32 v0, v0, v6
; GFX8-NEXT:    v_fma_f16 v1, v1, v3, v5
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_v3f16_fpexcept_strict:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_pk_fma_f16 v0, v0, v2, v4
; GFX10-NEXT:    v_fma_f16 v1, v1, v3, v5
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: v_constained_fma_v3f16_fpexcept_strict:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_pk_fma_f16 v0, v0, v2, v4
; GFX11-NEXT:    v_fma_f16 v1, v1, v3, v5
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %val = call <3 x half> @llvm.experimental.constrained.fma.v3f16(<3 x half> %x, <3 x half> %y, <3 x half> %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret <3 x half> %val
}

define <4 x half> @v_constained_fma_v4f16_fpexcept_strict(<4 x half> %x, <4 x half> %y, <4 x half> %z) #0 {
; GFX9-LABEL: v_constained_fma_v4f16_fpexcept_strict:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_lshrrev_b32_e32 v6, 16, v5
; GFX9-NEXT:    v_lshrrev_b32_e32 v7, 16, v3
; GFX9-NEXT:    v_lshrrev_b32_e32 v8, 16, v1
; GFX9-NEXT:    v_fma_f16 v6, v8, v7, v6
; GFX9-NEXT:    v_lshrrev_b32_e32 v7, 16, v4
; GFX9-NEXT:    v_lshrrev_b32_e32 v8, 16, v2
; GFX9-NEXT:    v_lshrrev_b32_e32 v9, 16, v0
; GFX9-NEXT:    v_fma_f16 v7, v9, v8, v7
; GFX9-NEXT:    v_fma_f16 v1, v1, v3, v5
; GFX9-NEXT:    v_fma_f16 v0, v0, v2, v4
; GFX9-NEXT:    s_mov_b32 s4, 0x5040100
; GFX9-NEXT:    v_perm_b32 v0, v7, v0, s4
; GFX9-NEXT:    v_perm_b32 v1, v6, v1, s4
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_constained_fma_v4f16_fpexcept_strict:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshrrev_b32_e32 v6, 16, v5
; GFX8-NEXT:    v_lshrrev_b32_e32 v7, 16, v3
; GFX8-NEXT:    v_lshrrev_b32_e32 v8, 16, v1
; GFX8-NEXT:    v_fma_f16 v6, v8, v7, v6
; GFX8-NEXT:    v_lshrrev_b32_e32 v7, 16, v4
; GFX8-NEXT:    v_lshrrev_b32_e32 v8, 16, v2
; GFX8-NEXT:    v_lshrrev_b32_e32 v9, 16, v0
; GFX8-NEXT:    v_fma_f16 v7, v9, v8, v7
; GFX8-NEXT:    v_fma_f16 v0, v0, v2, v4
; GFX8-NEXT:    v_lshlrev_b32_e32 v2, 16, v7
; GFX8-NEXT:    v_fma_f16 v1, v1, v3, v5
; GFX8-NEXT:    v_or_b32_e32 v0, v0, v2
; GFX8-NEXT:    v_lshlrev_b32_e32 v2, 16, v6
; GFX8-NEXT:    v_or_b32_e32 v1, v1, v2
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_v4f16_fpexcept_strict:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_lshrrev_b32_e32 v6, 16, v5
; GFX10-NEXT:    v_lshrrev_b32_e32 v7, 16, v3
; GFX10-NEXT:    v_lshrrev_b32_e32 v8, 16, v1
; GFX10-NEXT:    v_lshrrev_b32_e32 v9, 16, v4
; GFX10-NEXT:    v_lshrrev_b32_e32 v10, 16, v2
; GFX10-NEXT:    v_lshrrev_b32_e32 v11, 16, v0
; GFX10-NEXT:    v_fmac_f16_e32 v4, v0, v2
; GFX10-NEXT:    v_fmac_f16_e32 v6, v8, v7
; GFX10-NEXT:    v_fmac_f16_e32 v5, v1, v3
; GFX10-NEXT:    v_fmac_f16_e32 v9, v11, v10
; GFX10-NEXT:    v_perm_b32 v1, v6, v5, 0x5040100
; GFX10-NEXT:    v_perm_b32 v0, v9, v4, 0x5040100
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: v_constained_fma_v4f16_fpexcept_strict:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_lshrrev_b32_e32 v6, 16, v5
; GFX11-NEXT:    v_lshrrev_b32_e32 v7, 16, v3
; GFX11-NEXT:    v_lshrrev_b32_e32 v8, 16, v1
; GFX11-NEXT:    v_lshrrev_b32_e32 v9, 16, v4
; GFX11-NEXT:    v_lshrrev_b32_e32 v10, 16, v2
; GFX11-NEXT:    v_lshrrev_b32_e32 v11, 16, v0
; GFX11-NEXT:    v_fmac_f16_e32 v4, v0, v2
; GFX11-NEXT:    v_fmac_f16_e32 v6, v8, v7
; GFX11-NEXT:    v_fmac_f16_e32 v5, v1, v3
; GFX11-NEXT:    v_fmac_f16_e32 v9, v11, v10
; GFX11-NEXT:    v_perm_b32 v1, v6, v5, 0x5040100
; GFX11-NEXT:    v_perm_b32 v0, v9, v4, 0x5040100
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %val = call <4 x half> @llvm.experimental.constrained.fma.v4f16(<4 x half> %x, <4 x half> %y, <4 x half> %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret <4 x half> %val
}

define half @v_constained_fma_f16_fpexcept_strict_fneg(half %x, half %y, half %z) #0 {
; GCN-LABEL: v_constained_fma_f16_fpexcept_strict_fneg:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f16 v0, v0, v1, -v2
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_f16_fpexcept_strict_fneg:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f16 v0, v0, v1, -v2
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: v_constained_fma_f16_fpexcept_strict_fneg:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_fma_f16 v0, v0, v1, -v2
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %neg.z = fneg half %z
  %val = call half @llvm.experimental.constrained.fma.f16(half %x, half %y, half %neg.z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret half %val
}

define half @v_constained_fma_f16_fpexcept_strict_fneg_fneg(half %x, half %y, half %z) #0 {
; GCN-LABEL: v_constained_fma_f16_fpexcept_strict_fneg_fneg:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f16 v0, -v0, -v1, v2
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_f16_fpexcept_strict_fneg_fneg:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f16 v0, -v0, -v1, v2
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: v_constained_fma_f16_fpexcept_strict_fneg_fneg:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_fma_f16 v0, -v0, -v1, v2
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %neg.x = fneg half %x
  %neg.y = fneg half %y
  %val = call half @llvm.experimental.constrained.fma.f16(half %neg.x, half %neg.y, half %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret half %val
}

define half @v_constained_fma_f16_fpexcept_strict_fabs_fabs(half %x, half %y, half %z) #0 {
; GCN-LABEL: v_constained_fma_f16_fpexcept_strict_fabs_fabs:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_fma_f16 v0, |v0|, |v1|, v2
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_f16_fpexcept_strict_fabs_fabs:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_fma_f16 v0, |v0|, |v1|, v2
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: v_constained_fma_f16_fpexcept_strict_fabs_fabs:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_fma_f16 v0, |v0|, |v1|, v2
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %neg.x = call half @llvm.fabs.f16(half %x) #0
  %neg.y = call half @llvm.fabs.f16(half %y) #0
  %val = call half @llvm.experimental.constrained.fma.f16(half %neg.x, half %neg.y, half %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret half %val
}

define <2 x half> @v_constained_fma_v2f16_fpexcept_strict_fneg_fneg(<2 x half> %x, <2 x half> %y, <2 x half> %z) #0 {
; GFX9-LABEL: v_constained_fma_v2f16_fpexcept_strict_fneg_fneg:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_pk_fma_f16 v0, v0, v1, v2 neg_lo:[1,1,0] neg_hi:[1,1,0]
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_constained_fma_v2f16_fpexcept_strict_fneg_fneg:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_lshrrev_b32_e32 v3, 16, v2
; GFX8-NEXT:    v_lshrrev_b32_e32 v4, 16, v1
; GFX8-NEXT:    v_lshrrev_b32_e32 v5, 16, v0
; GFX8-NEXT:    v_fma_f16 v3, -v5, -v4, v3
; GFX8-NEXT:    v_lshlrev_b32_e32 v3, 16, v3
; GFX8-NEXT:    v_fma_f16 v0, -v0, -v1, v2
; GFX8-NEXT:    v_or_b32_e32 v0, v0, v3
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_constained_fma_v2f16_fpexcept_strict_fneg_fneg:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    v_pk_fma_f16 v0, v0, v1, v2 neg_lo:[1,1,0] neg_hi:[1,1,0]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
;
; GFX11-LABEL: v_constained_fma_v2f16_fpexcept_strict_fneg_fneg:
; GFX11:       ; %bb.0:
; GFX11-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX11-NEXT:    v_pk_fma_f16 v0, v0, v1, v2 neg_lo:[1,1,0] neg_hi:[1,1,0]
; GFX11-NEXT:    s_setpc_b64 s[30:31]
  %neg.x = fneg <2 x half> %x
  %neg.y = fneg <2 x half> %y
  %val = call <2 x half> @llvm.experimental.constrained.fma.v2f16(<2 x half> %neg.x, <2 x half> %neg.y, <2 x half> %z, metadata !"round.tonearest", metadata !"fpexcept.strict")
  ret <2 x half> %val
}

declare half @llvm.fabs.f16(half)
declare half @llvm.experimental.constrained.fma.f16(half, half, half, metadata, metadata)
declare <2 x half> @llvm.experimental.constrained.fma.v2f16(<2 x half>, <2 x half>, <2 x half>, metadata, metadata)
declare <3 x half> @llvm.experimental.constrained.fma.v3f16(<3 x half>, <3 x half>, <3 x half>, metadata, metadata)
declare <4 x half> @llvm.experimental.constrained.fma.v4f16(<4 x half>, <4 x half>, <4 x half>, metadata, metadata)

attributes #0 = { strictfp }
