; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=inline -S < %s | FileCheck %s

declare void @external_function(ptr)

define internal void @inlined_function(ptr %arg) {
  call void @external_function(ptr %arg)
  ret void
}

; TODO: This is a miscompile.
define void @test(ptr %p) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[ARG:%.*]] = load ptr, ptr [[P:%.*]], align 8, !alias.scope !0
; CHECK-NEXT:    call void @external_function(ptr [[ARG]]), !noalias !0
; CHECK-NEXT:    ret void
;
  %arg = load ptr, ptr %p, !alias.scope !0
  tail call void @inlined_function(ptr %arg), !noalias !0
  ret void
}

!0 = !{!1}
!1 = distinct !{!1, !2}
!2 = distinct !{!2}
