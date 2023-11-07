; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes=loop-unroll,loop-unroll -verify-dom-info -debug-only=loop-unroll -unroll-peel-max-count=7 2>&1 | FileCheck %s
; REQUIRES: asserts

declare void @f1()
declare void @f2()

; Check that we can peel off iterations that make conditions true.
; The second invocation of loop-unroll will NOT do profile based peeling of
; remained iterations because the total number of peeled iterations exceeds
; threashold specified with -unroll-peel-max-count=7.
define void @test2(i32 %k) !prof !4 {
; CHECK: Loop Unroll: F[test2] Loop %for.body
; CHECK: PEELING loop %for.body with iteration count 2!
; CHECK-NOT: llvm.loop.unroll.disable
for.body.lr.ph:
  br label %for.body

for.body:
  %i.05 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.inc ]
  %cmp1 = icmp ult i32 %i.05, 2
  br i1 %cmp1, label %if.then, label %if.else

if.then:
  call void @f1()
  br label %for.inc

if.else:
  call void @f2()
  br label %for.inc

for.inc:
  %inc = add nsw i32 %i.05, 1
  %cmp = icmp slt i32 %inc, %k
  br i1 %cmp, label %for.body, label %for.end, !llvm.loop !1, !prof !3

for.end:
  ret void
}

!1 = distinct !{!1}
!3 = !{!"branch_weights", i32 8, i32 1}
!4 = !{!"function_entry_count", i64 1}
