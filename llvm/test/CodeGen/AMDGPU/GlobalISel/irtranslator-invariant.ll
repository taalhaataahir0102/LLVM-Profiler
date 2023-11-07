; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -simplify-mir -global-isel -march=amdgcn -stop-after=irtranslator -verify-machineinstrs %s -o - | FileCheck %s

; Check the flags set on the memory operands for loads determined to
; be constants by alias analysis.

@const_gv0 = external addrspace(1) constant i32, align 4
@const_gv1 = external addrspace(1) constant i32, align 4
@const_struct_gv = external addrspace(1) constant { i32, i64 }, align 8

define i32 @load_const_i32_gv() {
  ; CHECK-LABEL: name: load_const_i32_gv
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p1) = G_GLOBAL_VALUE @const_gv0
  ; CHECK-NEXT:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[GV]](p1) :: (dereferenceable invariant load (s32) from @const_gv0, addrspace 1)
  ; CHECK-NEXT:   $vgpr0 = COPY [[LOAD]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0
  %load = load i32, ptr addrspace(1) @const_gv0, align 4
  ret i32 %load
}

define i32 @load_select_const_i32_gv(i1 %cond) {
  ; CHECK-LABEL: name: load_select_const_i32_gv
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[TRUNC:%[0-9]+]]:_(s1) = G_TRUNC [[COPY]](s32)
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p1) = G_GLOBAL_VALUE @const_gv0
  ; CHECK-NEXT:   [[GV1:%[0-9]+]]:_(p1) = G_GLOBAL_VALUE @const_gv1
  ; CHECK-NEXT:   [[SELECT:%[0-9]+]]:_(p1) = G_SELECT [[TRUNC]](s1), [[GV]], [[GV1]]
  ; CHECK-NEXT:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[SELECT]](p1) :: (dereferenceable invariant load (s32) from %ir.select, addrspace 1)
  ; CHECK-NEXT:   $vgpr0 = COPY [[LOAD]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0
  %select = select i1 %cond, ptr addrspace(1) @const_gv0, ptr addrspace(1) @const_gv1
  %load = load i32, ptr addrspace(1) %select, align 4
  ret i32 %load
}

define { i32, i64 } @load_const_struct_gv() {
  ; CHECK-LABEL: name: load_const_struct_gv
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p1) = G_GLOBAL_VALUE @const_struct_gv
  ; CHECK-NEXT:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[GV]](p1) :: (dereferenceable invariant load (s32) from @const_struct_gv, align 8, addrspace 1)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p1) = G_PTR_ADD [[GV]], [[C]](s64)
  ; CHECK-NEXT:   [[LOAD1:%[0-9]+]]:_(s64) = G_LOAD [[PTR_ADD]](p1) :: (dereferenceable invariant load (s64) from @const_struct_gv + 8, addrspace 1)
  ; CHECK-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[LOAD1]](s64)
  ; CHECK-NEXT:   $vgpr0 = COPY [[LOAD]](s32)
  ; CHECK-NEXT:   $vgpr1 = COPY [[UV]](s32)
  ; CHECK-NEXT:   $vgpr2 = COPY [[UV1]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0, implicit $vgpr1, implicit $vgpr2
  %load = load { i32, i64 }, ptr addrspace(1) @const_struct_gv, align 8
  ret { i32, i64 } %load
}

define void @test_memcpy_p1_constaddr_i64(ptr addrspace(1) %dst, ptr addrspace(4) %src) {
  ; CHECK-LABEL: name: test_memcpy_p1_constaddr_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK-NEXT:   [[MV1:%[0-9]+]]:_(p4) = G_MERGE_VALUES [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 32
  ; CHECK-NEXT:   G_MEMCPY [[MV]](p1), [[MV1]](p4), [[C]](s64), 0 :: (store (s8) into %ir.dst, addrspace 1), (dereferenceable invariant load (s8) from %ir.src, addrspace 4)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) %dst, ptr addrspace(4) %src, i64 32, i1 false)
  ret void
}

define void @test_memcpy_inline_p1_constaddr_i64(ptr addrspace(1) %dst, ptr addrspace(4) %src) {
  ; CHECK-LABEL: name: test_memcpy_inline_p1_constaddr_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK-NEXT:   [[MV1:%[0-9]+]]:_(p4) = G_MERGE_VALUES [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 32
  ; CHECK-NEXT:   G_MEMCPY_INLINE [[MV]](p1), [[MV1]](p4), [[C]](s64) :: (store (s8) into %ir.dst, addrspace 1), (dereferenceable invariant load (s8) from %ir.src, addrspace 4)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memcpy.inline.p1.p4.i64(ptr addrspace(1) %dst, ptr addrspace(4) %src, i64 32, i1 false)
  ret void
}

define void @test_memmove_p1_constaddr_i64(ptr addrspace(1) %dst, ptr addrspace(4) %src) {
  ; CHECK-LABEL: name: test_memmove_p1_constaddr_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK-NEXT:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK-NEXT:   [[MV1:%[0-9]+]]:_(p4) = G_MERGE_VALUES [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 32
  ; CHECK-NEXT:   G_MEMMOVE [[MV]](p1), [[MV1]](p4), [[C]](s64), 0 :: (store (s8) into %ir.dst, addrspace 1), (dereferenceable invariant load (s8) from %ir.src, addrspace 4)
  ; CHECK-NEXT:   SI_RETURN
  call void @llvm.memmove.p1.p4.i64(ptr addrspace(1) %dst, ptr addrspace(4) %src, i64 32, i1 false)
  ret void
}

declare void @llvm.memcpy.p1.p4.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #0
declare void @llvm.memcpy.inline.p1.p4.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #0
declare void @llvm.memmove.p1.p4.i64(ptr addrspace(1) nocapture writeonly, ptr addrspace(4) nocapture readonly, i64, i1 immarg) #0

attributes #0 = { argmemonly nofree nounwind willreturn }
