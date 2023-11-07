; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx906 -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

; The custom CSR spills inserted during the frame lowering was earlier using SP as the frame base.
; The offsets allocated for the CS objects go wrong when any local stack object has a higher
; alignment requirement than the default stack alignment for AMDGPU (either 4 or 16). The offsets
; in such cases should be from the newly aligned FP. Even to adjust the offset from the SP value
; at function entry, the FP-SP can't be statically determined with dynamic stack realignment. To
; fix the problem, use FP as the frame base in the spills whenever the function has FP.

define void @test_stack_realign(<8 x i32> %val, i32 %idx) #0 {
; GCN-LABEL: test_stack_realign:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s16, s33
; GCN-NEXT:    s_mov_b32 s33, s32
; GCN-NEXT:    s_or_saveexec_b64 s[18:19], -1
; GCN-NEXT:    buffer_store_dword v42, off, s[0:3], s33 offset:8 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[18:19]
; GCN-NEXT:    s_addk_i32 s32, 0x400
; GCN-NEXT:    v_writelane_b32 v42, s16, 2
; GCN-NEXT:    s_getpc_b64 s[16:17]
; GCN-NEXT:    s_add_u32 s16, s16, extern_func@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s17, s17, extern_func@gotpcrel32@hi+12
; GCN-NEXT:    s_load_dwordx2 s[16:17], s[16:17], 0x0
; GCN-NEXT:    v_writelane_b32 v42, s30, 0
; GCN-NEXT:    v_mov_b32_e32 v0, v8
; GCN-NEXT:    buffer_store_dword v40, off, s[0:3], s33 offset:4 ; 4-byte Folded Spill
; GCN-NEXT:    buffer_store_dword v41, off, s[0:3], s33 ; 4-byte Folded Spill
; GCN-NEXT:    v_writelane_b32 v42, s31, 1
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_swappc_b64 s[30:31], s[16:17]
; GCN-NEXT:    buffer_load_dword v41, off, s[0:3], s33 ; 4-byte Folded Reload
; GCN-NEXT:    buffer_load_dword v40, off, s[0:3], s33 offset:4 ; 4-byte Folded Reload
; GCN-NEXT:    v_readlane_b32 s31, v42, 1
; GCN-NEXT:    v_readlane_b32 s30, v42, 0
; GCN-NEXT:    v_readlane_b32 s4, v42, 2
; GCN-NEXT:    s_or_saveexec_b64 s[6:7], -1
; GCN-NEXT:    buffer_load_dword v42, off, s[0:3], s33 offset:8 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, s[6:7]
; GCN-NEXT:    s_addk_i32 s32, 0xfc00
; GCN-NEXT:    s_mov_b32 s33, s4
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %alloca.val = alloca <8 x i32>, align 64, addrspace(5)
  store volatile <8 x i32> %val, ptr addrspace(5) %alloca.val, align 64
  call void asm sideeffect "", "~{v40}" ()
  call void asm sideeffect "", "~{v41}" ()
  call void @extern_func(i32 %idx)
  ret void
}

declare void @extern_func(i32) #0

attributes #0 = { noinline nounwind }
