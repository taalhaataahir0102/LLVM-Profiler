; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx600 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX6 %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx700 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX7 %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX10-WGP %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1010 -mattr=+cumode -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX10-CU %s
; RUN: llc -mtriple=amdgcn-amd-amdpal -mcpu=gfx700 -amdgcn-skip-cache-invalidations -verify-machineinstrs < %s | FileCheck --check-prefixes=SKIP-CACHE-INV %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx90a -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX90A-NOTTGSPLIT %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx90a -mattr=+tgsplit -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX90A-TGSPLIT %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx940 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX940-NOTTGSPLIT %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx940 -mattr=+tgsplit -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX940-TGSPLIT %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1100 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX11-WGP %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1100 -mattr=+cumode -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX11-CU %s

define amdgpu_kernel void @private_nontemporal_load_0(
; GFX6-LABEL: private_nontemporal_load_0:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX6-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX6-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x2
; GFX6-NEXT:    s_add_u32 s8, s8, s7
; GFX6-NEXT:    s_addc_u32 s9, s9, 0
; GFX6-NEXT:    s_mov_b32 s3, 0x100f000
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s2
; GFX6-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen glc slc
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: private_nontemporal_load_0:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX7-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX7-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX7-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x2
; GFX7-NEXT:    s_add_u32 s8, s8, s7
; GFX7-NEXT:    s_addc_u32 s9, s9, 0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s2
; GFX7-NEXT:    buffer_load_dword v2, v0, s[8:11], 0 offen glc slc
; GFX7-NEXT:    v_mov_b32_e32 v0, s0
; GFX7-NEXT:    v_mov_b32_e32 v1, s1
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    flat_store_dword v[0:1], v2
; GFX7-NEXT:    s_endpgm
;
; GFX10-WGP-LABEL: private_nontemporal_load_0:
; GFX10-WGP:       ; %bb.0: ; %entry
; GFX10-WGP-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX10-WGP-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX10-WGP-NEXT:    s_clause 0x1
; GFX10-WGP-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX10-WGP-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX10-WGP-NEXT:    s_add_u32 s8, s8, s7
; GFX10-WGP-NEXT:    s_addc_u32 s9, s9, 0
; GFX10-WGP-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-WGP-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen slc
; GFX10-WGP-NEXT:    s_waitcnt vmcnt(0)
; GFX10-WGP-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX10-WGP-NEXT:    s_endpgm
;
; GFX10-CU-LABEL: private_nontemporal_load_0:
; GFX10-CU:       ; %bb.0: ; %entry
; GFX10-CU-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX10-CU-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX10-CU-NEXT:    s_clause 0x1
; GFX10-CU-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX10-CU-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX10-CU-NEXT:    s_add_u32 s8, s8, s7
; GFX10-CU-NEXT:    s_addc_u32 s9, s9, 0
; GFX10-CU-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-CU-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen slc
; GFX10-CU-NEXT:    s_waitcnt vmcnt(0)
; GFX10-CU-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX10-CU-NEXT:    s_endpgm
;
; SKIP-CACHE-INV-LABEL: private_nontemporal_load_0:
; SKIP-CACHE-INV:       ; %bb.0: ; %entry
; SKIP-CACHE-INV-NEXT:    s_getpc_b64 s[4:5]
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s4, s0
; SKIP-CACHE-INV-NEXT:    s_load_dwordx4 s[4:7], s[4:5], 0x0
; SKIP-CACHE-INV-NEXT:    s_load_dword s2, s[0:1], 0x0
; SKIP-CACHE-INV-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x2
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    v_mov_b32_e32 v0, s2
; SKIP-CACHE-INV-NEXT:    s_add_u32 s4, s4, s3
; SKIP-CACHE-INV-NEXT:    s_addc_u32 s5, s5, 0
; SKIP-CACHE-INV-NEXT:    buffer_load_dword v0, v0, s[4:7], 0 offen glc slc
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s3, 0xf000
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s2, -1
; SKIP-CACHE-INV-NEXT:    s_waitcnt vmcnt(0)
; SKIP-CACHE-INV-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SKIP-CACHE-INV-NEXT:    s_endpgm
;
; GFX90A-NOTTGSPLIT-LABEL: private_nontemporal_load_0:
; GFX90A-NOTTGSPLIT:       ; %bb.0: ; %entry
; GFX90A-NOTTGSPLIT-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX90A-NOTTGSPLIT-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX90A-NOTTGSPLIT-NEXT:    s_add_u32 s8, s8, s7
; GFX90A-NOTTGSPLIT-NEXT:    s_addc_u32 s9, s9, 0
; GFX90A-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v1, 0
; GFX90A-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v0, s2
; GFX90A-NOTTGSPLIT-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen glc slc
; GFX90A-NOTTGSPLIT-NEXT:    s_waitcnt vmcnt(0)
; GFX90A-NOTTGSPLIT-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX90A-NOTTGSPLIT-NEXT:    s_endpgm
;
; GFX90A-TGSPLIT-LABEL: private_nontemporal_load_0:
; GFX90A-TGSPLIT:       ; %bb.0: ; %entry
; GFX90A-TGSPLIT-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX90A-TGSPLIT-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX90A-TGSPLIT-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX90A-TGSPLIT-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX90A-TGSPLIT-NEXT:    s_add_u32 s8, s8, s7
; GFX90A-TGSPLIT-NEXT:    s_addc_u32 s9, s9, 0
; GFX90A-TGSPLIT-NEXT:    v_mov_b32_e32 v1, 0
; GFX90A-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-TGSPLIT-NEXT:    v_mov_b32_e32 v0, s2
; GFX90A-TGSPLIT-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen glc slc
; GFX90A-TGSPLIT-NEXT:    s_waitcnt vmcnt(0)
; GFX90A-TGSPLIT-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX90A-TGSPLIT-NEXT:    s_endpgm
;
; GFX940-NOTTGSPLIT-LABEL: private_nontemporal_load_0:
; GFX940-NOTTGSPLIT:       ; %bb.0: ; %entry
; GFX940-NOTTGSPLIT-NEXT:    s_load_dword s4, s[0:1], 0x0
; GFX940-NOTTGSPLIT-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x8
; GFX940-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v1, 0
; GFX940-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-NOTTGSPLIT-NEXT:    scratch_load_dword v0, off, s4 nt
; GFX940-NOTTGSPLIT-NEXT:    s_waitcnt vmcnt(0)
; GFX940-NOTTGSPLIT-NEXT:    global_store_dword v1, v0, s[2:3] sc0 sc1
; GFX940-NOTTGSPLIT-NEXT:    s_endpgm
;
; GFX940-TGSPLIT-LABEL: private_nontemporal_load_0:
; GFX940-TGSPLIT:       ; %bb.0: ; %entry
; GFX940-TGSPLIT-NEXT:    s_load_dword s4, s[0:1], 0x0
; GFX940-TGSPLIT-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x8
; GFX940-TGSPLIT-NEXT:    v_mov_b32_e32 v1, 0
; GFX940-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-TGSPLIT-NEXT:    scratch_load_dword v0, off, s4 nt
; GFX940-TGSPLIT-NEXT:    s_waitcnt vmcnt(0)
; GFX940-TGSPLIT-NEXT:    global_store_dword v1, v0, s[2:3] sc0 sc1
; GFX940-TGSPLIT-NEXT:    s_endpgm
;
; GFX11-WGP-LABEL: private_nontemporal_load_0:
; GFX11-WGP:       ; %bb.0: ; %entry
; GFX11-WGP-NEXT:    s_clause 0x1
; GFX11-WGP-NEXT:    s_load_b32 s2, s[0:1], 0x0
; GFX11-WGP-NEXT:    s_load_b64 s[0:1], s[0:1], 0x8
; GFX11-WGP-NEXT:    v_mov_b32_e32 v1, 0
; GFX11-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-WGP-NEXT:    scratch_load_b32 v0, off, s2 slc dlc
; GFX11-WGP-NEXT:    s_waitcnt vmcnt(0)
; GFX11-WGP-NEXT:    global_store_b32 v1, v0, s[0:1]
; GFX11-WGP-NEXT:    s_nop 0
; GFX11-WGP-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-WGP-NEXT:    s_endpgm
;
; GFX11-CU-LABEL: private_nontemporal_load_0:
; GFX11-CU:       ; %bb.0: ; %entry
; GFX11-CU-NEXT:    s_clause 0x1
; GFX11-CU-NEXT:    s_load_b32 s2, s[0:1], 0x0
; GFX11-CU-NEXT:    s_load_b64 s[0:1], s[0:1], 0x8
; GFX11-CU-NEXT:    v_mov_b32_e32 v1, 0
; GFX11-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-CU-NEXT:    scratch_load_b32 v0, off, s2 slc dlc
; GFX11-CU-NEXT:    s_waitcnt vmcnt(0)
; GFX11-CU-NEXT:    global_store_b32 v1, v0, s[0:1]
; GFX11-CU-NEXT:    s_nop 0
; GFX11-CU-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-CU-NEXT:    s_endpgm
    ptr addrspace(5) %in, ptr addrspace(1) %out) {
entry:
  %val = load i32, ptr addrspace(5) %in, align 4, !nontemporal !0
  store i32 %val, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @private_nontemporal_load_1(
; GFX6-LABEL: private_nontemporal_load_1:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX6-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX6-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x2
; GFX6-NEXT:    s_add_u32 s8, s8, s7
; GFX6-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX6-NEXT:    s_addc_u32 s9, s9, 0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; GFX6-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen glc slc
; GFX6-NEXT:    s_mov_b32 s3, 0x100f000
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt vmcnt(0)
; GFX6-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: private_nontemporal_load_1:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX7-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX7-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX7-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x2
; GFX7-NEXT:    s_add_u32 s8, s8, s7
; GFX7-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX7-NEXT:    s_addc_u32 s9, s9, 0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; GFX7-NEXT:    buffer_load_dword v2, v0, s[8:11], 0 offen glc slc
; GFX7-NEXT:    v_mov_b32_e32 v0, s0
; GFX7-NEXT:    v_mov_b32_e32 v1, s1
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    flat_store_dword v[0:1], v2
; GFX7-NEXT:    s_endpgm
;
; GFX10-WGP-LABEL: private_nontemporal_load_1:
; GFX10-WGP:       ; %bb.0: ; %entry
; GFX10-WGP-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX10-WGP-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX10-WGP-NEXT:    s_clause 0x1
; GFX10-WGP-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX10-WGP-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX10-WGP-NEXT:    s_add_u32 s8, s8, s7
; GFX10-WGP-NEXT:    s_addc_u32 s9, s9, 0
; GFX10-WGP-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX10-WGP-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen slc
; GFX10-WGP-NEXT:    s_waitcnt vmcnt(0)
; GFX10-WGP-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX10-WGP-NEXT:    s_endpgm
;
; GFX10-CU-LABEL: private_nontemporal_load_1:
; GFX10-CU:       ; %bb.0: ; %entry
; GFX10-CU-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX10-CU-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX10-CU-NEXT:    s_clause 0x1
; GFX10-CU-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX10-CU-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX10-CU-NEXT:    s_add_u32 s8, s8, s7
; GFX10-CU-NEXT:    s_addc_u32 s9, s9, 0
; GFX10-CU-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX10-CU-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen slc
; GFX10-CU-NEXT:    s_waitcnt vmcnt(0)
; GFX10-CU-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX10-CU-NEXT:    s_endpgm
;
; SKIP-CACHE-INV-LABEL: private_nontemporal_load_1:
; SKIP-CACHE-INV:       ; %bb.0: ; %entry
; SKIP-CACHE-INV-NEXT:    s_getpc_b64 s[4:5]
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s4, s0
; SKIP-CACHE-INV-NEXT:    s_load_dwordx4 s[4:7], s[4:5], 0x0
; SKIP-CACHE-INV-NEXT:    s_load_dword s2, s[0:1], 0x0
; SKIP-CACHE-INV-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x2
; SKIP-CACHE-INV-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; SKIP-CACHE-INV-NEXT:    s_add_u32 s4, s4, s3
; SKIP-CACHE-INV-NEXT:    s_addc_u32 s5, s5, 0
; SKIP-CACHE-INV-NEXT:    buffer_load_dword v0, v0, s[4:7], 0 offen glc slc
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s3, 0xf000
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s2, -1
; SKIP-CACHE-INV-NEXT:    s_waitcnt vmcnt(0)
; SKIP-CACHE-INV-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SKIP-CACHE-INV-NEXT:    s_endpgm
;
; GFX90A-NOTTGSPLIT-LABEL: private_nontemporal_load_1:
; GFX90A-NOTTGSPLIT:       ; %bb.0: ; %entry
; GFX90A-NOTTGSPLIT-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX90A-NOTTGSPLIT-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX90A-NOTTGSPLIT-NEXT:    s_add_u32 s8, s8, s7
; GFX90A-NOTTGSPLIT-NEXT:    s_addc_u32 s9, s9, 0
; GFX90A-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v1, 0
; GFX90A-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-NOTTGSPLIT-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX90A-NOTTGSPLIT-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen glc slc
; GFX90A-NOTTGSPLIT-NEXT:    s_waitcnt vmcnt(0)
; GFX90A-NOTTGSPLIT-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX90A-NOTTGSPLIT-NEXT:    s_endpgm
;
; GFX90A-TGSPLIT-LABEL: private_nontemporal_load_1:
; GFX90A-TGSPLIT:       ; %bb.0: ; %entry
; GFX90A-TGSPLIT-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX90A-TGSPLIT-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX90A-TGSPLIT-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX90A-TGSPLIT-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX90A-TGSPLIT-NEXT:    s_add_u32 s8, s8, s7
; GFX90A-TGSPLIT-NEXT:    s_addc_u32 s9, s9, 0
; GFX90A-TGSPLIT-NEXT:    v_mov_b32_e32 v1, 0
; GFX90A-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-TGSPLIT-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX90A-TGSPLIT-NEXT:    buffer_load_dword v0, v0, s[8:11], 0 offen glc slc
; GFX90A-TGSPLIT-NEXT:    s_waitcnt vmcnt(0)
; GFX90A-TGSPLIT-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX90A-TGSPLIT-NEXT:    s_endpgm
;
; GFX940-NOTTGSPLIT-LABEL: private_nontemporal_load_1:
; GFX940-NOTTGSPLIT:       ; %bb.0: ; %entry
; GFX940-NOTTGSPLIT-NEXT:    s_load_dword s4, s[0:1], 0x0
; GFX940-NOTTGSPLIT-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x8
; GFX940-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v1, 0
; GFX940-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-NOTTGSPLIT-NEXT:    v_lshl_add_u32 v0, v0, 2, s4
; GFX940-NOTTGSPLIT-NEXT:    scratch_load_dword v0, v0, off nt
; GFX940-NOTTGSPLIT-NEXT:    s_waitcnt vmcnt(0)
; GFX940-NOTTGSPLIT-NEXT:    global_store_dword v1, v0, s[2:3] sc0 sc1
; GFX940-NOTTGSPLIT-NEXT:    s_endpgm
;
; GFX940-TGSPLIT-LABEL: private_nontemporal_load_1:
; GFX940-TGSPLIT:       ; %bb.0: ; %entry
; GFX940-TGSPLIT-NEXT:    s_load_dword s4, s[0:1], 0x0
; GFX940-TGSPLIT-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x8
; GFX940-TGSPLIT-NEXT:    v_mov_b32_e32 v1, 0
; GFX940-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-TGSPLIT-NEXT:    v_lshl_add_u32 v0, v0, 2, s4
; GFX940-TGSPLIT-NEXT:    scratch_load_dword v0, v0, off nt
; GFX940-TGSPLIT-NEXT:    s_waitcnt vmcnt(0)
; GFX940-TGSPLIT-NEXT:    global_store_dword v1, v0, s[2:3] sc0 sc1
; GFX940-TGSPLIT-NEXT:    s_endpgm
;
; GFX11-WGP-LABEL: private_nontemporal_load_1:
; GFX11-WGP:       ; %bb.0: ; %entry
; GFX11-WGP-NEXT:    s_clause 0x1
; GFX11-WGP-NEXT:    s_load_b32 s2, s[0:1], 0x0
; GFX11-WGP-NEXT:    s_load_b64 s[0:1], s[0:1], 0x8
; GFX11-WGP-NEXT:    v_mov_b32_e32 v1, 0
; GFX11-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-WGP-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX11-WGP-NEXT:    scratch_load_b32 v0, v0, off slc dlc
; GFX11-WGP-NEXT:    s_waitcnt vmcnt(0)
; GFX11-WGP-NEXT:    global_store_b32 v1, v0, s[0:1]
; GFX11-WGP-NEXT:    s_nop 0
; GFX11-WGP-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-WGP-NEXT:    s_endpgm
;
; GFX11-CU-LABEL: private_nontemporal_load_1:
; GFX11-CU:       ; %bb.0: ; %entry
; GFX11-CU-NEXT:    s_clause 0x1
; GFX11-CU-NEXT:    s_load_b32 s2, s[0:1], 0x0
; GFX11-CU-NEXT:    s_load_b64 s[0:1], s[0:1], 0x8
; GFX11-CU-NEXT:    v_mov_b32_e32 v1, 0
; GFX11-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-CU-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX11-CU-NEXT:    scratch_load_b32 v0, v0, off slc dlc
; GFX11-CU-NEXT:    s_waitcnt vmcnt(0)
; GFX11-CU-NEXT:    global_store_b32 v1, v0, s[0:1]
; GFX11-CU-NEXT:    s_nop 0
; GFX11-CU-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-CU-NEXT:    s_endpgm
    ptr addrspace(5) %in, ptr addrspace(1) %out) {
entry:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %val.gep = getelementptr inbounds i32, ptr addrspace(5) %in, i32 %tid
  %val = load i32, ptr addrspace(5) %val.gep, align 4, !nontemporal !0
  store i32 %val, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @private_nontemporal_store_0(
; GFX6-LABEL: private_nontemporal_store_0:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX6-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX6-NEXT:    s_load_dword s2, s[4:5], 0x2
; GFX6-NEXT:    s_add_u32 s8, s8, s7
; GFX6-NEXT:    s_addc_u32 s9, s9, 0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX6-NEXT:    v_mov_b32_e32 v1, s2
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s0
; GFX6-NEXT:    buffer_store_dword v0, v1, s[8:11], 0 offen glc slc
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: private_nontemporal_store_0:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX7-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX7-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX7-NEXT:    s_load_dword s2, s[4:5], 0x2
; GFX7-NEXT:    s_add_u32 s8, s8, s7
; GFX7-NEXT:    s_addc_u32 s9, s9, 0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX7-NEXT:    v_mov_b32_e32 v1, s2
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s0
; GFX7-NEXT:    buffer_store_dword v0, v1, s[8:11], 0 offen glc slc
; GFX7-NEXT:    s_endpgm
;
; GFX10-WGP-LABEL: private_nontemporal_store_0:
; GFX10-WGP:       ; %bb.0: ; %entry
; GFX10-WGP-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX10-WGP-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX10-WGP-NEXT:    s_clause 0x1
; GFX10-WGP-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-WGP-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX10-WGP-NEXT:    s_add_u32 s8, s8, s7
; GFX10-WGP-NEXT:    s_addc_u32 s9, s9, 0
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX10-WGP-NEXT:    v_mov_b32_e32 v1, s2
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-WGP-NEXT:    buffer_store_dword v0, v1, s[8:11], 0 offen glc slc
; GFX10-WGP-NEXT:    s_endpgm
;
; GFX10-CU-LABEL: private_nontemporal_store_0:
; GFX10-CU:       ; %bb.0: ; %entry
; GFX10-CU-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX10-CU-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX10-CU-NEXT:    s_clause 0x1
; GFX10-CU-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-CU-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX10-CU-NEXT:    s_add_u32 s8, s8, s7
; GFX10-CU-NEXT:    s_addc_u32 s9, s9, 0
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX10-CU-NEXT:    v_mov_b32_e32 v1, s2
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    v_mov_b32_e32 v0, s0
; GFX10-CU-NEXT:    buffer_store_dword v0, v1, s[8:11], 0 offen glc slc
; GFX10-CU-NEXT:    s_endpgm
;
; SKIP-CACHE-INV-LABEL: private_nontemporal_store_0:
; SKIP-CACHE-INV:       ; %bb.0: ; %entry
; SKIP-CACHE-INV-NEXT:    s_getpc_b64 s[4:5]
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s4, s0
; SKIP-CACHE-INV-NEXT:    s_load_dwordx4 s[4:7], s[4:5], 0x0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    s_add_u32 s4, s4, s3
; SKIP-CACHE-INV-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x0
; SKIP-CACHE-INV-NEXT:    s_load_dword s0, s[0:1], 0x2
; SKIP-CACHE-INV-NEXT:    s_addc_u32 s5, s5, 0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    s_load_dword s1, s[2:3], 0x0
; SKIP-CACHE-INV-NEXT:    v_mov_b32_e32 v1, s0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    v_mov_b32_e32 v0, s1
; SKIP-CACHE-INV-NEXT:    buffer_store_dword v0, v1, s[4:7], 0 offen glc slc
; SKIP-CACHE-INV-NEXT:    s_endpgm
;
; GFX90A-NOTTGSPLIT-LABEL: private_nontemporal_store_0:
; GFX90A-NOTTGSPLIT:       ; %bb.0: ; %entry
; GFX90A-NOTTGSPLIT-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX90A-NOTTGSPLIT-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX90A-NOTTGSPLIT-NEXT:    s_add_u32 s8, s8, s7
; GFX90A-NOTTGSPLIT-NEXT:    s_addc_u32 s9, s9, 0
; GFX90A-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX90A-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v1, s2
; GFX90A-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v0, s0
; GFX90A-NOTTGSPLIT-NEXT:    buffer_store_dword v0, v1, s[8:11], 0 offen glc slc
; GFX90A-NOTTGSPLIT-NEXT:    s_endpgm
;
; GFX90A-TGSPLIT-LABEL: private_nontemporal_store_0:
; GFX90A-TGSPLIT:       ; %bb.0: ; %entry
; GFX90A-TGSPLIT-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX90A-TGSPLIT-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX90A-TGSPLIT-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX90A-TGSPLIT-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX90A-TGSPLIT-NEXT:    s_add_u32 s8, s8, s7
; GFX90A-TGSPLIT-NEXT:    s_addc_u32 s9, s9, 0
; GFX90A-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-TGSPLIT-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX90A-TGSPLIT-NEXT:    v_mov_b32_e32 v1, s2
; GFX90A-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-TGSPLIT-NEXT:    v_mov_b32_e32 v0, s0
; GFX90A-TGSPLIT-NEXT:    buffer_store_dword v0, v1, s[8:11], 0 offen glc slc
; GFX90A-TGSPLIT-NEXT:    s_endpgm
;
; GFX940-NOTTGSPLIT-LABEL: private_nontemporal_store_0:
; GFX940-NOTTGSPLIT:       ; %bb.0: ; %entry
; GFX940-NOTTGSPLIT-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x0
; GFX940-NOTTGSPLIT-NEXT:    s_load_dword s4, s[0:1], 0x8
; GFX940-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-NOTTGSPLIT-NEXT:    s_load_dword s0, s[2:3], 0x0
; GFX940-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v0, s0
; GFX940-NOTTGSPLIT-NEXT:    scratch_store_dword off, v0, s4 sc0 nt sc1
; GFX940-NOTTGSPLIT-NEXT:    s_endpgm
;
; GFX940-TGSPLIT-LABEL: private_nontemporal_store_0:
; GFX940-TGSPLIT:       ; %bb.0: ; %entry
; GFX940-TGSPLIT-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x0
; GFX940-TGSPLIT-NEXT:    s_load_dword s4, s[0:1], 0x8
; GFX940-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-TGSPLIT-NEXT:    s_load_dword s0, s[2:3], 0x0
; GFX940-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-TGSPLIT-NEXT:    v_mov_b32_e32 v0, s0
; GFX940-TGSPLIT-NEXT:    scratch_store_dword off, v0, s4 sc0 nt sc1
; GFX940-TGSPLIT-NEXT:    s_endpgm
;
; GFX11-WGP-LABEL: private_nontemporal_store_0:
; GFX11-WGP:       ; %bb.0: ; %entry
; GFX11-WGP-NEXT:    s_clause 0x1
; GFX11-WGP-NEXT:    s_load_b64 s[2:3], s[0:1], 0x0
; GFX11-WGP-NEXT:    s_load_b32 s0, s[0:1], 0x8
; GFX11-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-WGP-NEXT:    s_load_b32 s1, s[2:3], 0x0
; GFX11-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-WGP-NEXT:    v_mov_b32_e32 v0, s1
; GFX11-WGP-NEXT:    scratch_store_b32 off, v0, s0 glc slc dlc
; GFX11-WGP-NEXT:    s_endpgm
;
; GFX11-CU-LABEL: private_nontemporal_store_0:
; GFX11-CU:       ; %bb.0: ; %entry
; GFX11-CU-NEXT:    s_clause 0x1
; GFX11-CU-NEXT:    s_load_b64 s[2:3], s[0:1], 0x0
; GFX11-CU-NEXT:    s_load_b32 s0, s[0:1], 0x8
; GFX11-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-CU-NEXT:    s_load_b32 s1, s[2:3], 0x0
; GFX11-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-CU-NEXT:    v_mov_b32_e32 v0, s1
; GFX11-CU-NEXT:    scratch_store_b32 off, v0, s0 glc slc dlc
; GFX11-CU-NEXT:    s_endpgm
    ptr addrspace(1) %in, ptr addrspace(5) %out) {
entry:
  %val = load i32, ptr addrspace(1) %in, align 4
  store i32 %val, ptr addrspace(5) %out, !nontemporal !0
  ret void
}

define amdgpu_kernel void @private_nontemporal_store_1(
; GFX6-LABEL: private_nontemporal_store_1:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX6-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX6-NEXT:    s_load_dword s2, s[4:5], 0x2
; GFX6-NEXT:    s_add_u32 s8, s8, s7
; GFX6-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX6-NEXT:    s_addc_u32 s9, s9, 0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX6-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v1, s0
; GFX6-NEXT:    buffer_store_dword v1, v0, s[8:11], 0 offen glc slc
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: private_nontemporal_store_1:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX7-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX7-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX7-NEXT:    s_load_dword s2, s[4:5], 0x2
; GFX7-NEXT:    s_add_u32 s8, s8, s7
; GFX7-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX7-NEXT:    s_addc_u32 s9, s9, 0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX7-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v1, s0
; GFX7-NEXT:    buffer_store_dword v1, v0, s[8:11], 0 offen glc slc
; GFX7-NEXT:    s_endpgm
;
; GFX10-WGP-LABEL: private_nontemporal_store_1:
; GFX10-WGP:       ; %bb.0: ; %entry
; GFX10-WGP-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX10-WGP-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX10-WGP-NEXT:    s_clause 0x1
; GFX10-WGP-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-WGP-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX10-WGP-NEXT:    s_add_u32 s8, s8, s7
; GFX10-WGP-NEXT:    s_addc_u32 s9, s9, 0
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX10-WGP-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-WGP-NEXT:    buffer_store_dword v1, v0, s[8:11], 0 offen glc slc
; GFX10-WGP-NEXT:    s_endpgm
;
; GFX10-CU-LABEL: private_nontemporal_store_1:
; GFX10-CU:       ; %bb.0: ; %entry
; GFX10-CU-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX10-CU-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX10-CU-NEXT:    s_clause 0x1
; GFX10-CU-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-CU-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX10-CU-NEXT:    s_add_u32 s8, s8, s7
; GFX10-CU-NEXT:    s_addc_u32 s9, s9, 0
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX10-CU-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-CU-NEXT:    buffer_store_dword v1, v0, s[8:11], 0 offen glc slc
; GFX10-CU-NEXT:    s_endpgm
;
; SKIP-CACHE-INV-LABEL: private_nontemporal_store_1:
; SKIP-CACHE-INV:       ; %bb.0: ; %entry
; SKIP-CACHE-INV-NEXT:    s_getpc_b64 s[4:5]
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s4, s0
; SKIP-CACHE-INV-NEXT:    s_load_dwordx4 s[4:7], s[4:5], 0x0
; SKIP-CACHE-INV-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    s_add_u32 s4, s4, s3
; SKIP-CACHE-INV-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x0
; SKIP-CACHE-INV-NEXT:    s_load_dword s0, s[0:1], 0x2
; SKIP-CACHE-INV-NEXT:    s_addc_u32 s5, s5, 0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    s_load_dword s1, s[2:3], 0x0
; SKIP-CACHE-INV-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    v_mov_b32_e32 v1, s1
; SKIP-CACHE-INV-NEXT:    buffer_store_dword v1, v0, s[4:7], 0 offen glc slc
; SKIP-CACHE-INV-NEXT:    s_endpgm
;
; GFX90A-NOTTGSPLIT-LABEL: private_nontemporal_store_1:
; GFX90A-NOTTGSPLIT:       ; %bb.0: ; %entry
; GFX90A-NOTTGSPLIT-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX90A-NOTTGSPLIT-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX90A-NOTTGSPLIT-NEXT:    s_add_u32 s8, s8, s7
; GFX90A-NOTTGSPLIT-NEXT:    s_addc_u32 s9, s9, 0
; GFX90A-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-NOTTGSPLIT-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX90A-NOTTGSPLIT-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX90A-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v1, s0
; GFX90A-NOTTGSPLIT-NEXT:    buffer_store_dword v1, v0, s[8:11], 0 offen glc slc
; GFX90A-NOTTGSPLIT-NEXT:    s_endpgm
;
; GFX90A-TGSPLIT-LABEL: private_nontemporal_store_1:
; GFX90A-TGSPLIT:       ; %bb.0: ; %entry
; GFX90A-TGSPLIT-NEXT:    s_mov_b64 s[10:11], s[2:3]
; GFX90A-TGSPLIT-NEXT:    s_mov_b64 s[8:9], s[0:1]
; GFX90A-TGSPLIT-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX90A-TGSPLIT-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX90A-TGSPLIT-NEXT:    s_add_u32 s8, s8, s7
; GFX90A-TGSPLIT-NEXT:    s_addc_u32 s9, s9, 0
; GFX90A-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-TGSPLIT-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX90A-TGSPLIT-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX90A-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX90A-TGSPLIT-NEXT:    v_mov_b32_e32 v1, s0
; GFX90A-TGSPLIT-NEXT:    buffer_store_dword v1, v0, s[8:11], 0 offen glc slc
; GFX90A-TGSPLIT-NEXT:    s_endpgm
;
; GFX940-NOTTGSPLIT-LABEL: private_nontemporal_store_1:
; GFX940-NOTTGSPLIT:       ; %bb.0: ; %entry
; GFX940-NOTTGSPLIT-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x0
; GFX940-NOTTGSPLIT-NEXT:    s_load_dword s4, s[0:1], 0x8
; GFX940-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-NOTTGSPLIT-NEXT:    v_lshl_add_u32 v0, v0, 2, s4
; GFX940-NOTTGSPLIT-NEXT:    s_load_dword s0, s[2:3], 0x0
; GFX940-NOTTGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-NOTTGSPLIT-NEXT:    v_mov_b32_e32 v1, s0
; GFX940-NOTTGSPLIT-NEXT:    scratch_store_dword v0, v1, off sc0 nt sc1
; GFX940-NOTTGSPLIT-NEXT:    s_endpgm
;
; GFX940-TGSPLIT-LABEL: private_nontemporal_store_1:
; GFX940-TGSPLIT:       ; %bb.0: ; %entry
; GFX940-TGSPLIT-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x0
; GFX940-TGSPLIT-NEXT:    s_load_dword s4, s[0:1], 0x8
; GFX940-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-TGSPLIT-NEXT:    v_lshl_add_u32 v0, v0, 2, s4
; GFX940-TGSPLIT-NEXT:    s_load_dword s0, s[2:3], 0x0
; GFX940-TGSPLIT-NEXT:    s_waitcnt lgkmcnt(0)
; GFX940-TGSPLIT-NEXT:    v_mov_b32_e32 v1, s0
; GFX940-TGSPLIT-NEXT:    scratch_store_dword v0, v1, off sc0 nt sc1
; GFX940-TGSPLIT-NEXT:    s_endpgm
;
; GFX11-WGP-LABEL: private_nontemporal_store_1:
; GFX11-WGP:       ; %bb.0: ; %entry
; GFX11-WGP-NEXT:    s_clause 0x1
; GFX11-WGP-NEXT:    s_load_b64 s[2:3], s[0:1], 0x0
; GFX11-WGP-NEXT:    s_load_b32 s0, s[0:1], 0x8
; GFX11-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-WGP-NEXT:    s_load_b32 s1, s[2:3], 0x0
; GFX11-WGP-NEXT:    v_lshl_add_u32 v0, v0, 2, s0
; GFX11-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-WGP-NEXT:    v_mov_b32_e32 v1, s1
; GFX11-WGP-NEXT:    scratch_store_b32 v0, v1, off glc slc dlc
; GFX11-WGP-NEXT:    s_endpgm
;
; GFX11-CU-LABEL: private_nontemporal_store_1:
; GFX11-CU:       ; %bb.0: ; %entry
; GFX11-CU-NEXT:    s_clause 0x1
; GFX11-CU-NEXT:    s_load_b64 s[2:3], s[0:1], 0x0
; GFX11-CU-NEXT:    s_load_b32 s0, s[0:1], 0x8
; GFX11-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-CU-NEXT:    s_load_b32 s1, s[2:3], 0x0
; GFX11-CU-NEXT:    v_lshl_add_u32 v0, v0, 2, s0
; GFX11-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-CU-NEXT:    v_mov_b32_e32 v1, s1
; GFX11-CU-NEXT:    scratch_store_b32 v0, v1, off glc slc dlc
; GFX11-CU-NEXT:    s_endpgm
    ptr addrspace(1) %in, ptr addrspace(5) %out) {
entry:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %val = load i32, ptr addrspace(1) %in, align 4
  %out.gep = getelementptr inbounds i32, ptr addrspace(5) %out, i32 %tid
  store i32 %val, ptr addrspace(5) %out.gep, !nontemporal !0
  ret void
}

!0 = !{i32 1}
declare i32 @llvm.amdgcn.workitem.id.x()
