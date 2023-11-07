; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -disable-output "-passes=print<scalar-evolution>" 2>&1 | FileCheck %s

; Tests loops with huge trip counts. Trip count of >=2^32 are huge. Huge trip counts have a trip multiple
; of the greatest power of 2 less than 2^32.

declare void @foo(...)

define void @trip_count_4294967295() {
; CHECK-LABEL: 'trip_count_4294967295'
; CHECK-NEXT:  Classifying expressions for: @trip_count_4294967295
; CHECK-NEXT:    %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,4294967295) S: [0,4294967295) Exits: 4294967294 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %add = add nuw nsw i64 %i.02, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%for.body> U: [1,4294967296) S: [1,4294967296) Exits: 4294967295 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_count_4294967295
; CHECK-NEXT:  Loop %for.body: backedge-taken count is 4294967294
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 4294967294
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is 4294967294
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is 4294967294
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %for.body: Trip multiple is 4294967295
;
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
  tail call void (...) @foo() #2
  %add = add nuw nsw i64 %i.02, 1
  %exitcond.not = icmp eq i64 %add, 4294967295
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @trip_count_4294967296() {
; CHECK-LABEL: 'trip_count_4294967296'
; CHECK-NEXT:  Classifying expressions for: @trip_count_4294967296
; CHECK-NEXT:    %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,4294967296) S: [0,4294967296) Exits: 4294967295 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %add = add nuw nsw i64 %i.02, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%for.body> U: [1,4294967297) S: [1,4294967297) Exits: 4294967296 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_count_4294967296
; CHECK-NEXT:  Loop %for.body: backedge-taken count is 4294967295
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 4294967295
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is 4294967295
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is 4294967295
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %for.body: Trip multiple is 2147483648
;
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
  tail call void (...) @foo() #2
  %add = add nuw nsw i64 %i.02, 1
  %exitcond.not = icmp eq i64 %add, 4294967296
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @trip_count_8589935692() {
; CHECK-LABEL: 'trip_count_8589935692'
; CHECK-NEXT:  Classifying expressions for: @trip_count_8589935692
; CHECK-NEXT:    %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,8589934592) S: [0,8589934592) Exits: 8589934591 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %add = add nuw nsw i64 %i.02, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%for.body> U: [1,8589934593) S: [1,8589934593) Exits: 8589934592 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_count_8589935692
; CHECK-NEXT:  Loop %for.body: backedge-taken count is 8589934591
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 8589934591
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is 8589934591
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is 8589934591
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %for.body: Trip multiple is 2147483648
;
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
  tail call void (...) @foo() #2
  %add = add nuw nsw i64 %i.02, 1
  %exitcond.not = icmp eq i64 %add, 8589934592
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @trip_count_9223372036854775808() {
; CHECK-LABEL: 'trip_count_9223372036854775808'
; CHECK-NEXT:  Classifying expressions for: @trip_count_9223372036854775808
; CHECK-NEXT:    %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,-9223372036854775808) S: [0,-9223372036854775808) Exits: 9223372036854775807 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %add = add nuw nsw i64 %i.02, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-9223372036854775807) S: [1,-9223372036854775807) Exits: -9223372036854775808 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_count_9223372036854775808
; CHECK-NEXT:  Loop %for.body: backedge-taken count is 9223372036854775807
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 9223372036854775807
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is 9223372036854775807
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is 9223372036854775807
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %for.body: Trip multiple is 2147483648
;
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
  tail call void (...) @foo() #2
  %add = add nuw nsw i64 %i.02, 1
  %exitcond.not = icmp eq i64 %add, 9223372036854775808
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @trip_count_18446744073709551615() {
; CHECK-LABEL: 'trip_count_18446744073709551615'
; CHECK-NEXT:  Classifying expressions for: @trip_count_18446744073709551615
; CHECK-NEXT:    %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,-9223372036854775808) S: [0,-9223372036854775808) Exits: -2 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %add = add nuw nsw i64 %i.02, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,0) S: [1,0) Exits: -1 LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @trip_count_18446744073709551615
; CHECK-NEXT:  Loop %for.body: backedge-taken count is -2
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is -2
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is -2
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is -2
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %for.body: Trip multiple is 1
;
entry:
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ 0, %entry ], [ %add, %for.body ]
  tail call void (...) @foo() #2
  %add = add nuw nsw i64 %i.02, 1
  %exitcond.not = icmp eq i64 %add, 18446744073709551615
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}
