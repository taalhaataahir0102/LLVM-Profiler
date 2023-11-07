; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; RUN: opt < %s -passes=globalopt -S | FileCheck %s
target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

@G = internal global ptr null

;.
; CHECK: @[[G:[a-zA-Z0-9_$"\\.-]+]] = internal unnamed_addr global ptr null
;.
define void @t() #0 {
; CHECK-LABEL: @t(
; CHECK-NEXT:    [[MALLOCCALL:%.*]] = tail call ptr @malloc(i64 400)
; CHECK-NEXT:    store ptr [[MALLOCCALL]], ptr @G, align 8
; CHECK-NEXT:    [[GV:%.*]] = load ptr, ptr @G, align 8
; CHECK-NEXT:    [[GVE:%.*]] = getelementptr i32, ptr [[GV]], i32 40
; CHECK-NEXT:    store i32 20, ptr [[GVE]], align 4
; CHECK-NEXT:    ret void
;
  %malloccall = tail call ptr @malloc(i64 mul (i64 100, i64 4))
  store ptr %malloccall, ptr @G
  %GV = load ptr, ptr @G
  %GVe = getelementptr i32, ptr %GV, i32 40
  store i32 20, ptr %GVe
  ret void
}

declare noalias ptr @malloc(i64)
attributes #0 = { null_pointer_is_valid }
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { null_pointer_is_valid }
;.
