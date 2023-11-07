; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=indvars < %s | FileCheck %s

target datalayout = "E-m:e-i64:64-n32:64"
target triple = "powerpc64-unknown-linux-gnu"

define void @f(ptr %end.s, ptr %loc, i32 %p) {
; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[WHILE_BODY_I:%.*]]
; CHECK:       while.body.i:
; CHECK-NEXT:    br i1 true, label [[LOOP_EXIT:%.*]], label [[WHILE_BODY_I]]
; CHECK:       loop.exit:
; CHECK-NEXT:    [[END:%.*]] = getelementptr inbounds i32, ptr [[END_S:%.*]], i32 [[P:%.*]]
; CHECK-NEXT:    store ptr [[END]], ptr [[LOC:%.*]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %end = getelementptr inbounds i32, ptr %end.s, i32 %p
  br label %while.body.i

while.body.i:
  %ptr = phi ptr [ %ptr.inc, %while.body.i ], [ %end.s, %entry ]
  %ptr.inc = getelementptr inbounds i8, ptr %ptr, i8 1
  %cmp.i = icmp eq ptr %ptr.inc, %end
  br i1 %cmp.i, label %loop.exit, label %while.body.i

loop.exit:
  %ptr.inc.lcssa = phi ptr [ %ptr.inc, %while.body.i ]
  store ptr %ptr.inc.lcssa, ptr %loc
  ret void
}
