; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=indvars -indvars-predicate-loops=0 %s | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @test1(i64 %start) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[START:%.*]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END:%.*]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test1.next(i64 %start) {
; CHECK-LABEL: @test1.next(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i64 [[START:%.*]], 1
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END:%.*]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp1 = icmp slt i64 %indvars.iv.next, 0
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test2(i64 %start) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sle i64 [[START:%.*]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END:%.*]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp1 = icmp sle i64 %indvars.iv, -1
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test2.next(i64 %start) {
; CHECK-LABEL: @test2.next(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i64 [[START:%.*]], 1
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sle i64 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END:%.*]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp1 = icmp sle i64 %indvars.iv.next, 0
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

; As long as the test dominates the backedge, we're good
define void @test3(i64 %start) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[START]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test3.next(i64 %start) {
; CHECK-LABEL: @test3.next(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i64 [[START:%.*]], 1
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp slt i64 %indvars.iv.next, 0
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}


define void @test4(i64 %start) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i64 [[START]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[LOOP]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp sgt i64 %indvars.iv, -1
  br i1 %cmp1, label %loop, label %for.end

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test4.next(i64 %start) {
; CHECK-LABEL: @test4.next(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i64 [[START:%.*]], 1
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i64 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[LOOP]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp sgt i64 %indvars.iv.next, 0
  br i1 %cmp1, label %loop, label %for.end

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test5(i64 %start) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ugt i64 [[START]], 100
; CHECK-NEXT:    br i1 [[CMP1]], label [[LOOP]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp ugt i64 %indvars.iv, 100
  br i1 %cmp1, label %loop, label %for.end

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test5.next(i64 %start) {
; CHECK-LABEL: @test5.next(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add nuw i64 [[START:%.*]], 1
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ugt i64 [[TMP0]], 101
; CHECK-NEXT:    br i1 [[CMP1]], label [[LOOP]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp ugt i64 %indvars.iv.next, 101
  br i1 %cmp1, label %loop, label %for.end

for.end:                                          ; preds = %if.end, %entry
  ret void
}


define void @test6(i64 %start) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i64 [[START]], 100
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp ult i64 %indvars.iv, 100
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test6.next(i64 %start) {
; CHECK-LABEL: @test6.next(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add nuw i64 [[START:%.*]], 1
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i64 [[TMP0]], 101
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nuw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp ult i64 %indvars.iv.next, 101
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test7(i64 %start, ptr %inc_ptr) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[INC:%.*]] = load i64, ptr [[INC_PTR:%.*]], align 8, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[OK:%.*]] = icmp sge i64 [[INC]], 0
; CHECK-NEXT:    br i1 [[OK]], label [[LOOP_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[START:%.*]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END_LOOPEXIT:%.*]], label [[LOOP]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %inc = load i64, ptr %inc_ptr, !range !0
  %ok = icmp sge i64 %inc, 0
  br i1 %ok, label %loop, label %for.end

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, %inc
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test7.next(i64 %start, ptr %inc_ptr) {
; CHECK-LABEL: @test7.next(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[INC:%.*]] = load i64, ptr [[INC_PTR:%.*]], align 8, !range [[RNG0]]
; CHECK-NEXT:    [[OK:%.*]] = icmp sge i64 [[INC]], 0
; CHECK-NEXT:    br i1 [[OK]], label [[LOOP_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INC]], [[START:%.*]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END_LOOPEXIT:%.*]], label [[LOOP]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %inc = load i64, ptr %inc_ptr, !range !0
  %ok = icmp sge i64 %inc, 0
  br i1 %ok, label %loop, label %for.end

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, %inc
  %cmp1 = icmp slt i64 %indvars.iv.next, 0
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

; Negative test - we can't show that the internal branch executes, so we can't
; fold the test to a loop invariant one.
define void @test1_neg(i64 %start) {
; CHECK-LABEL: @test1_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[SKIP:%.*]]
; CHECK:       skip:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %skip
skip:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp1, label %for.end, label %backedge
backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  br label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

; Slightly subtle version of @test4 where the icmp dominates the backedge,
; but the exit branch doesn't.
define void @test2_neg(i64 %start) {
; CHECK-LABEL: @test2_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[SKIP:%.*]]
; CHECK:       skip:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp, label %backedge, label %skip
skip:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  br i1 %cmp1, label %for.end, label %backedge
backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  br label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

; The branch has to exit the loop if the condition is true
define void @test3_neg(i64 %start) {
; CHECK-LABEL: @test3_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[LOOP]], label [[FOR_END:%.*]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp1, label %loop, label %for.end

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test4_neg(i64 %start) {
; CHECK-LABEL: @test4_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 25
; CHECK-NEXT:    br i1 [[CMP]], label [[BACKEDGE]], label [[FOR_END:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %backedge ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp = icmp eq i64 %indvars.iv.next, 25
  br i1 %cmp, label %backedge, label %for.end

backedge:
  ; prevent flattening, needed to make sure we're testing what we intend
  call void @foo()
  %cmp1 = icmp sgt i64 %indvars.iv, -1

; %cmp1 can be made loop invariant only if the branch below goes to
; %the header when %cmp1 is true.
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test5_neg(i64 %start, i64 %inc) {
; CHECK-LABEL: @test5_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], [[INC:%.*]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END:%.*]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, %inc
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

define void @test8(i64 %start, ptr %inc_ptr) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[INC:%.*]] = load i64, ptr [[INC_PTR:%.*]], align 8, !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    [[OK:%.*]] = icmp sge i64 [[INC]], 0
; CHECK-NEXT:    br i1 [[OK]], label [[LOOP_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[LOOP]] ], [ [[START:%.*]], [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], [[INC]]
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END_LOOPEXIT:%.*]], label [[LOOP]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %inc = load i64, ptr %inc_ptr, !range !1
  %ok = icmp sge i64 %inc, 0
  br i1 %ok, label %loop, label %for.end

loop:
  %indvars.iv = phi i64 [ %start, %entry ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, %inc
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

; check to handle loops without preheaders, but invariant operands
; (we handle this today by inserting a preheader)
define void @test9(i1 %cnd, i64 %start) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[CND:%.*]], label [[ENTRY1:%.*]], label [[ENTRY2:%.*]]
; CHECK:       entry1:
; CHECK-NEXT:    br label [[LOOP_PREHEADER:%.*]]
; CHECK:       entry2:
; CHECK-NEXT:    br label [[LOOP_PREHEADER]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i64 [[START:%.*]], -1
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_END:%.*]], label [[LOOP]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cnd, label %entry1, label %entry2
entry1:
  br label %loop
entry2:
  br label %loop
loop:
  %indvars.iv = phi i64 [ %start, %entry1 ],[ %start, %entry2 ], [ %indvars.iv.next, %loop ]
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp1 = icmp slt i64 %indvars.iv, -1
  br i1 %cmp1, label %for.end, label %loop

for.end:                                          ; preds = %if.end, %entry
  ret void
}

declare void @use(i1 %x)

; check that we handle conditions with loop invariant operands which
; *aren't* in the header - this is a very rare and fragile case where
; we have a "loop" which is known to run exactly one iteration but
; haven't yet simplified the uses of the IV
define void @test10() {
; CHECK-LABEL: @test10(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    br i1 false, label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    br label [[LATCH:%.*]]
; CHECK:       right:
; CHECK-NEXT:    br label [[LATCH]]
; CHECK:       latch:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 -1, undef
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[CMP_LCSSA:%.*]] = phi i1 [ [[CMP]], [[LATCH]] ]
; CHECK-NEXT:    call void @use(i1 [[CMP_LCSSA]])
; CHECK-NEXT:    ret void
;
entry:
  br label %loop

loop:
  %phi1 = phi i32 [ %phi2, %latch ], [ 0, %entry ]
  %dec = add i32 %phi1, -1
  br i1 false, label %left, label %right

left:
  br label %latch

right:
  br label %latch

latch:
  %phi2 = phi i32 [ %phi1, %left ], [ %dec, %right ]
  %cmp = icmp slt i32 %phi2, undef
  br i1 true, label %exit, label %loop

exit:
  call void @use(i1 %cmp)
  ret void
}

; check that we can figure out that iv.next > 1 from the facts that iv >= 0 and
; iv.start != 0.
define void @test11(ptr %inc_ptr) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[INC:%.*]] = load i64, ptr [[INC_PTR:%.*]], align 8, !range [[RNG0]]
; CHECK-NEXT:    [[NE_COND:%.*]] = icmp ne i64 [[INC]], 0
; CHECK-NEXT:    br i1 [[NE_COND]], label [[LOOP_PREHEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[INC]], [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    br i1 true, label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK:       if.true:
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       if.false:
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[IV_NEXT]], 201
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %inc = load i64, ptr %inc_ptr, !range !0
  %ne.cond = icmp ne i64 %inc, 0
  br i1 %ne.cond, label %loop, label %exit

loop:
  %iv = phi i64 [ %inc, %entry ], [ %iv.next, %backedge ]
  %iv.next = add i64 %iv, 1
  %brcond = icmp sgt i64 %iv.next, 1
  br i1 %brcond, label %if.true, label %if.false

if.true:
  br label %backedge

if.false:
  br label %backedge

backedge:
  %loopcond = icmp slt i64 %iv, 200
  br i1 %loopcond, label %loop, label %exit

exit:
  ret void
}

; check that we can prove that a recurrency is greater than another recurrency
; in the same loop, with the same step, and with smaller starting value.
define void @test12(ptr %inc_ptr) {
; CHECK-LABEL: @test12(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[INC:%.*]] = load i64, ptr [[INC_PTR:%.*]], align 8, !range [[RNG0]]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[INC]], [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i64 [[IV]], 1
; CHECK-NEXT:    br i1 true, label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK:       if.true:
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       if.false:
; CHECK-NEXT:    br label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[IV_NEXT]], 201
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %inc = load i64, ptr %inc_ptr, !range !0
  %inc.minus.1 = sub i64 %inc, 1
  br label %loop

loop:
  %iv = phi i64 [ %inc, %entry ], [ %iv.next, %backedge ]
  %iv.minus.1 = phi i64 [ %inc.minus.1, %entry ], [ %iv.minus.1.next, %backedge ]
  %iv.next = add i64 %iv, 1
  %iv.minus.1.next = add i64 %iv.minus.1, 1
  %brcond = icmp sgt i64 %iv.next, %iv.minus.1.next
  br i1 %brcond, label %if.true, label %if.false

if.true:
  br label %backedge

if.false:
  br label %backedge

backedge:
  %loopcond = icmp slt i64 %iv, 200
  br i1 %loopcond, label %loop, label %exit

exit:
  ret void
}

!0 = !{i64 0, i64 100}
!1 = !{i64 -1, i64 100}

declare void @foo()
