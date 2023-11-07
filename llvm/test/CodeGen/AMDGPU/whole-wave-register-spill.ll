; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx906 --verify-machineinstrs -o - %s | FileCheck -check-prefix=GCN %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx906 -O0 --verify-machineinstrs -o - %s | FileCheck -check-prefix=GCN-O0 %s

; Test whole-wave register spilling.

; In this testcase, the return address registers, PC value (SGPR30_SGPR31) and the scratch SGPR used in
; the inline asm statements should be preserved across the call. Since the test limits the VGPR numbers,
; the PC will be spilled to the only available CSR VGPR (VGPR40) as we spill CSR SGPRs including the PC
; directly to the physical VGPR lane to correctly generate the CFIs. The SGPR20 will get spilled to the
; virtual VGPR lane and that would be allocated by regalloc. Since there is no free VGPR to allocate, RA
; must spill a scratch VGPR. The writelane/readlane instructions that spill/restore SGPRs into/from VGPR
; are whole-wave operations and hence the VGPRs involved in such operations require whole-wave spilling.

define void @test() #0 {
; GCN-LABEL: test:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s16, s33
; GCN-NEXT:    s_mov_b32 s33, s32
; GCN-NEXT:    s_xor_saveexec_b64 s[18:19], -1
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], s33 offset:8 ; 4-byte Folded Spill
; GCN-NEXT:    buffer_store_dword v1, off, s[0:3], s33 offset:12 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, -1
; GCN-NEXT:    buffer_store_dword v40, off, s[0:3], s33 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[18:19]
; GCN-NEXT:    v_writelane_b32 v40, s28, 2
; GCN-NEXT:    v_writelane_b32 v40, s29, 3
; GCN-NEXT:    v_writelane_b32 v40, s16, 4
; GCN-NEXT:    ; implicit-def: $vgpr0
; GCN-NEXT:    v_writelane_b32 v40, s30, 0
; GCN-NEXT:    s_addk_i32 s32, 0x800
; GCN-NEXT:    v_writelane_b32 v40, s31, 1
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; def s16
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    v_writelane_b32 v0, s16, 0
; GCN-NEXT:    s_or_saveexec_b64 s[28:29], -1
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], s33 offset:4 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[28:29]
; GCN-NEXT:    s_getpc_b64 s[16:17]
; GCN-NEXT:    s_add_u32 s16, s16, ext_func@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s17, s17, ext_func@gotpcrel32@hi+12
; GCN-NEXT:    s_load_dwordx2 s[16:17], s[16:17], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_swappc_b64 s[30:31], s[16:17]
; GCN-NEXT:    s_or_saveexec_b64 s[28:29], -1
; GCN-NEXT:    buffer_load_dword v1, off, s[0:3], s33 offset:4 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, s[28:29]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readlane_b32 s4, v1, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    global_store_dword v[0:1], v0, off
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readlane_b32 s31, v40, 1
; GCN-NEXT:    v_readlane_b32 s30, v40, 0
; GCN-NEXT:    ; kill: killed $vgpr1
; GCN-NEXT:    v_readlane_b32 s28, v40, 2
; GCN-NEXT:    v_readlane_b32 s29, v40, 3
; GCN-NEXT:    v_readlane_b32 s4, v40, 4
; GCN-NEXT:    s_xor_saveexec_b64 s[6:7], -1
; GCN-NEXT:    buffer_load_dword v0, off, s[0:3], s33 offset:8 ; 4-byte Folded Reload
; GCN-NEXT:    buffer_load_dword v1, off, s[0:3], s33 offset:12 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, -1
; GCN-NEXT:    buffer_load_dword v40, off, s[0:3], s33 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, s[6:7]
; GCN-NEXT:    s_addk_i32 s32, 0xf800
; GCN-NEXT:    s_mov_b32 s33, s4
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
;
; GCN-O0-LABEL: test:
; GCN-O0:       ; %bb.0:
; GCN-O0-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-O0-NEXT:    s_mov_b32 s16, s33
; GCN-O0-NEXT:    s_mov_b32 s33, s32
; GCN-O0-NEXT:    s_xor_saveexec_b64 s[18:19], -1
; GCN-O0-NEXT:    buffer_store_dword v0, off, s[0:3], s33 offset:8 ; 4-byte Folded Spill
; GCN-O0-NEXT:    s_mov_b64 exec, -1
; GCN-O0-NEXT:    buffer_store_dword v40, off, s[0:3], s33 ; 4-byte Folded Spill
; GCN-O0-NEXT:    s_mov_b64 exec, s[18:19]
; GCN-O0-NEXT:    v_writelane_b32 v40, s28, 2
; GCN-O0-NEXT:    v_writelane_b32 v40, s29, 3
; GCN-O0-NEXT:    v_writelane_b32 v40, s16, 4
; GCN-O0-NEXT:    s_add_i32 s32, s32, 0x400
; GCN-O0-NEXT:    ; implicit-def: $vgpr0
; GCN-O0-NEXT:    v_writelane_b32 v40, s30, 0
; GCN-O0-NEXT:    v_writelane_b32 v40, s31, 1
; GCN-O0-NEXT:    ;;#ASMSTART
; GCN-O0-NEXT:    ; def s16
; GCN-O0-NEXT:    ;;#ASMEND
; GCN-O0-NEXT:    v_writelane_b32 v0, s16, 0
; GCN-O0-NEXT:    s_or_saveexec_b64 s[28:29], -1
; GCN-O0-NEXT:    buffer_store_dword v0, off, s[0:3], s33 offset:4 ; 4-byte Folded Spill
; GCN-O0-NEXT:    s_mov_b64 exec, s[28:29]
; GCN-O0-NEXT:    s_getpc_b64 s[16:17]
; GCN-O0-NEXT:    s_add_u32 s16, s16, ext_func@gotpcrel32@lo+4
; GCN-O0-NEXT:    s_addc_u32 s17, s17, ext_func@gotpcrel32@hi+12
; GCN-O0-NEXT:    s_load_dwordx2 s[16:17], s[16:17], 0x0
; GCN-O0-NEXT:    s_mov_b64 s[22:23], s[2:3]
; GCN-O0-NEXT:    s_mov_b64 s[20:21], s[0:1]
; GCN-O0-NEXT:    s_mov_b64 s[0:1], s[20:21]
; GCN-O0-NEXT:    s_mov_b64 s[2:3], s[22:23]
; GCN-O0-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-O0-NEXT:    s_swappc_b64 s[30:31], s[16:17]
; GCN-O0-NEXT:    s_or_saveexec_b64 s[28:29], -1
; GCN-O0-NEXT:    buffer_load_dword v0, off, s[0:3], s33 offset:4 ; 4-byte Folded Reload
; GCN-O0-NEXT:    s_mov_b64 exec, s[28:29]
; GCN-O0-NEXT:    s_waitcnt vmcnt(0)
; GCN-O0-NEXT:    v_readlane_b32 s4, v0, 0
; GCN-O0-NEXT:    ; implicit-def: $sgpr6_sgpr7
; GCN-O0-NEXT:    v_mov_b32_e32 v1, s6
; GCN-O0-NEXT:    v_mov_b32_e32 v2, s7
; GCN-O0-NEXT:    v_mov_b32_e32 v3, s4
; GCN-O0-NEXT:    global_store_dword v[1:2], v3, off
; GCN-O0-NEXT:    s_waitcnt vmcnt(0)
; GCN-O0-NEXT:    v_readlane_b32 s31, v40, 1
; GCN-O0-NEXT:    v_readlane_b32 s30, v40, 0
; GCN-O0-NEXT:    ; kill: killed $vgpr0
; GCN-O0-NEXT:    v_readlane_b32 s28, v40, 2
; GCN-O0-NEXT:    v_readlane_b32 s29, v40, 3
; GCN-O0-NEXT:    v_readlane_b32 s4, v40, 4
; GCN-O0-NEXT:    s_xor_saveexec_b64 s[6:7], -1
; GCN-O0-NEXT:    buffer_load_dword v0, off, s[0:3], s33 offset:8 ; 4-byte Folded Reload
; GCN-O0-NEXT:    s_mov_b64 exec, -1
; GCN-O0-NEXT:    buffer_load_dword v40, off, s[0:3], s33 ; 4-byte Folded Reload
; GCN-O0-NEXT:    s_mov_b64 exec, s[6:7]
; GCN-O0-NEXT:    s_add_i32 s32, s32, 0xfffffc00
; GCN-O0-NEXT:    s_mov_b32 s33, s4
; GCN-O0-NEXT:    s_waitcnt vmcnt(0)
; GCN-O0-NEXT:    s_setpc_b64 s[30:31]
  %sgpr = call i32 asm sideeffect "; def $0", "=s" () #0
  call void @ext_func()
  store volatile i32 %sgpr, ptr addrspace(1) undef
  ret void
}

declare void @ext_func();

attributes #0 = { nounwind "amdgpu-num-vgpr"="41" "amdgpu-num-sgpr"="34"}
