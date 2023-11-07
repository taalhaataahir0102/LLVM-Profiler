; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

define amdgpu_kernel void @if_masked_1(i32 %arg, ptr addrspace(1) %p)  {
; GCN-LABEL: if_masked_1:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x24
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x2c
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp0_b32 s4, 0
; GCN-NEXT:    s_cselect_b32 s0, 22, 33
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %and = and i32 %arg, 1
  %cmp = icmp eq i32 %and, 0
  %sel = select i1 %cmp, i32 22, i32 33
  store i32 %sel, ptr addrspace(1) %p
  ret void
}

define amdgpu_kernel void @if_masked_1024(i32 %arg, ptr addrspace(1) %p)  {
; GCN-LABEL: if_masked_1024:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x24
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x2c
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp0_b32 s4, 10
; GCN-NEXT:    s_cselect_b32 s0, 22, 33
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %and = and i32 %arg, 1024
  %cmp = icmp eq i32 %and, 0
  %sel = select i1 %cmp, i32 22, i32 33
  store i32 %sel, ptr addrspace(1) %p
  ret void
}

define amdgpu_kernel void @if_masked_0x80000000(i32 %arg, ptr addrspace(1) %p)  {
; GCN-LABEL: if_masked_0x80000000:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x24
; GCN-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x2c
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_bitcmp0_b32 s4, 31
; GCN-NEXT:    s_cselect_b32 s0, 22, 33
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %and = and i32 %arg, 2147483648
  %cmp = icmp eq i32 %and, 0
  %sel = select i1 %cmp, i32 22, i32 33
  store i32 %sel, ptr addrspace(1) %p
  ret void
}

; FIXME: this should result in "s_bitcmp0_b64 $arg, 63" or "s_bitcmp0_b32 $arg.sub1, 31"
define amdgpu_kernel void @if_masked_0x8000000000000000(i64 %arg, ptr addrspace(1) %p)  {
; GCN-LABEL: if_masked_0x8000000000000000:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s0, 0
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_and_b32 s1, s1, 0x80000000
; GCN-NEXT:    s_cmp_eq_u64 s[0:1], 0
; GCN-NEXT:    s_cselect_b32 s0, 22, 33
; GCN-NEXT:    v_mov_b32_e32 v1, s0
; GCN-NEXT:    global_store_dword v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %and = and i64 %arg, 9223372036854775808
  %cmp = icmp eq i64 %and, 0
  %sel = select i1 %cmp, i32 22, i32 33
  store i32 %sel, ptr addrspace(1) %p
  ret void
}
