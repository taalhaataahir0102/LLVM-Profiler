; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=powerpc64-linux-gnu -mcpu=pwr8 -mattr=+vsx -passes=slp-vectorizer < %s | FileCheck %s

%struct.A = type { ptr, ptr }

define i64 @foo(ptr nocapture readonly %this) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[END_I:%.*]] = getelementptr inbounds [[STRUCT_A:%.*]], ptr [[THIS:%.*]], i64 0, i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i64, ptr [[END_I]], align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[THIS]], align 8
; CHECK-NEXT:    [[SUB_PTR_SUB_I:%.*]] = sub i64 [[TMP1]], [[TMP3]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i64 [[SUB_PTR_SUB_I]], 9
; CHECK-NEXT:    br i1 [[CMP]], label [[RETURN:%.*]], label [[LOR_LHS_FALSE:%.*]]
; CHECK:       lor.lhs.false:
; CHECK-NEXT:    [[TMP4:%.*]] = inttoptr i64 [[TMP3]] to ptr
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP1]] to ptr
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt ptr [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[DOT:%.*]] = select i1 [[CMP2]], i64 2, i64 -1
; CHECK-NEXT:    ret i64 [[DOT]]
; CHECK:       return:
; CHECK-NEXT:    ret i64 2
;
entry:
  %end.i = getelementptr inbounds %struct.A, ptr %this, i64 0, i32 1
  %0 = load i64, ptr %end.i, align 8
  %1 = load i64, ptr %this, align 8
  %sub.ptr.sub.i = sub i64 %0, %1
  %cmp = icmp sgt i64 %sub.ptr.sub.i, 9
  br i1 %cmp, label %return, label %lor.lhs.false

lor.lhs.false:
  %2 = inttoptr i64 %1 to ptr
  %3 = inttoptr i64 %0 to ptr
  %cmp2 = icmp ugt ptr %3, %2
  %. = select i1 %cmp2, i64 2, i64 -1
  ret i64 %.

return:
  ret i64 2
}

