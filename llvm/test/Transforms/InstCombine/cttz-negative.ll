; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

define i32 @cttz_neg_value(i32 %x) {
; CHECK-LABEL: @cttz_neg_value(
; CHECK-NEXT:    [[B:%.*]] = call i32 @llvm.cttz.i32(i32 [[X:%.*]], i1 false), !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    ret i32 [[B]]
;
  %a = sub i32 0, %x
  %b = tail call i32 @llvm.cttz.i32(i32 %a)
  ret i32 %b
}

define i32 @cttz_neg_value_multiuse(i32 %x) {
; CHECK-LABEL: @cttz_neg_value_multiuse(
; CHECK-NEXT:    [[A:%.*]] = sub i32 0, [[X:%.*]]
; CHECK-NEXT:    call void @use(i32 [[A]])
; CHECK-NEXT:    [[B:%.*]] = call i32 @llvm.cttz.i32(i32 [[X]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    ret i32 [[B]]
;
  %a = sub i32 0, %x
  call void @use(i32 %a)
  %b = tail call i32 @llvm.cttz.i32(i32 %a)
  ret i32 %b
}

define i64 @cttz_neg_value_64(i64 %x) {
; CHECK-LABEL: @cttz_neg_value_64(
; CHECK-NEXT:    [[B:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[X:%.*]], i1 true), !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = sub i64 0, %x
  %b = tail call i64 @llvm.cttz.i64(i64 %a, i1 true)
  ret i64 %b
}

define i64 @cttz_neg_value2_64(i64 %x) {
; CHECK-LABEL: @cttz_neg_value2_64(
; CHECK-NEXT:    [[B:%.*]] = tail call i64 @llvm.cttz.i64(i64 [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    ret i64 [[B]]
;
  %a = sub i64 0, %x
  %b = tail call i64 @llvm.cttz.i64(i64 %a, i1 false)
  ret i64 %b
}

define <2 x i64> @cttz_neg_value_vec(<2 x i64> %x) {
; CHECK-LABEL: @cttz_neg_value_vec(
; CHECK-NEXT:    [[B:%.*]] = call <2 x i64> @llvm.cttz.v2i64(<2 x i64> [[X:%.*]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    ret <2 x i64> [[B]]
;
  %a = sub  <2 x i64> zeroinitializer, %x
  %b = tail call <2 x i64> @llvm.cttz.v2i64(<2 x i64> %a)
  ret <2 x i64> %b
}

; Negative tests

define i32 @cttz_nonneg_value(i32 %x) {
; CHECK-LABEL: @cttz_nonneg_value(
; CHECK-NEXT:    [[A:%.*]] = sub i32 1, [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = call i32 @llvm.cttz.i32(i32 [[A]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    ret i32 [[B]]
;
  %a = sub i32 1, %x
  %b = tail call i32 @llvm.cttz.i32(i32 %a)
  ret i32 %b
}

define <2 x i64> @cttz_nonneg_value_vec(<2 x i64> %x) {
; CHECK-LABEL: @cttz_nonneg_value_vec(
; CHECK-NEXT:    [[A:%.*]] = sub <2 x i64> <i64 1, i64 0>, [[X:%.*]]
; CHECK-NEXT:    [[B:%.*]] = call <2 x i64> @llvm.cttz.v2i64(<2 x i64> [[A]], i1 false), !range [[RNG1]]
; CHECK-NEXT:    ret <2 x i64> [[B]]
;
  %a = sub  <2 x i64> <i64 1, i64 0>, %x
  %b = tail call <2 x i64> @llvm.cttz.v2i64(<2 x i64> %a)
  ret <2 x i64> %b
}

declare void @use(i32 %a)
declare i32 @llvm.cttz.i32(i32)
declare i64 @llvm.cttz.i64(i64, i1)
declare <2 x i64> @llvm.cttz.v2i64(<2 x i64>)
