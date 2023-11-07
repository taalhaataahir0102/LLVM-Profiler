; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; RUN: opt -S -passes=rewrite-statepoints-for-gc < %s | FileCheck %s
; Ensure statepoints copy (valid) attributes from callsites.

declare void @f(ptr addrspace(1) %obj)

; copy over norecurse noimplicitfloat to statepoint call
define void @test1(ptr addrspace(1) %arg) gc "statepoint-example" {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 0, ptr elementtype(void (ptr addrspace(1))) @f, i32 1, i32 0, ptr addrspace(1) [[ARG:%.*]], i32 0, i32 0) #[[ATTR1:[0-9]+]] [ "gc-live"(ptr addrspace(1) [[ARG]]) ]
; CHECK-NEXT:    [[ARG_RELOCATED:%.*]] = call coldcc ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token [[STATEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    ret void
;

  call void @f(ptr addrspace(1) %arg) #1
  ret void
}


attributes #1 = { norecurse noimplicitfloat }
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR1]] = { noimplicitfloat norecurse }
;.
