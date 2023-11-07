; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; Show that we are able to outline when all of the phi nodes in the starting
; block are included in the region and there is no more than one predecessor
; into those phi nodes from outside of the region.

define void @function1(ptr %a, ptr %b) {
entry:
  %0 = alloca i32, align 4
  %c = load i32, ptr %0, align 4
  %y = add i32 %c, %c
  br label %test1
dummy:
  ret void
test1:
  %1 = phi i32 [ %e, %test1 ], [ %y, %entry ]
  %2 = phi i32 [ %e, %test1 ], [ %y, %entry  ]
  %e = load i32, ptr %0, align 4
  %3 = add i32 %c, %c
  br i1 true, label %test, label %test1
test:
  %d = load i32, ptr %0, align 4
  br label %first
first:
  ret void
}

define void @function2(ptr %a, ptr %b) {
entry:
  %0 = alloca i32, align 4
  %c = load i32, ptr %0, align 4
  %y = mul i32 %c, %c
  br label %test1
dummy:
  ret void
test1:
  %1 = phi i32 [ %e, %test1 ], [ %y, %entry ]
  %2 = phi i32 [ %e, %test1 ], [ %y, %entry ]
  %e = load i32, ptr %0, align 4
  %3 = add i32 %c, %c
  br i1 true, label %test, label %test1
test:
  %d = load i32, ptr %0, align 4
  br label %first
first:
  ret void
}
; CHECK-LABEL: @function1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = load i32, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[Y:%.*]] = add i32 [[C]], [[C]]
; CHECK-NEXT:    br label [[TEST1:%.*]]
; CHECK:       dummy:
; CHECK-NEXT:    ret void
; CHECK:       test1:
; CHECK-NEXT:    call void @outlined_ir_func_0(i32 [[Y]], ptr [[TMP0]], i32 [[C]])
; CHECK-NEXT:    br label [[FIRST:%.*]]
; CHECK:       first:
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: @function2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = load i32, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[Y:%.*]] = mul i32 [[C]], [[C]]
; CHECK-NEXT:    br label [[TEST1:%.*]]
; CHECK:       dummy:
; CHECK-NEXT:    ret void
; CHECK:       test1:
; CHECK-NEXT:    call void @outlined_ir_func_0(i32 [[Y]], ptr [[TMP0]], i32 [[C]])
; CHECK-NEXT:    br label [[FIRST:%.*]]
; CHECK:       first:
; CHECK-NEXT:    ret void
;
;
; CHECK: define internal void @outlined_ir_func_0(
; CHECK-NEXT:  newFuncRoot:
; CHECK-NEXT:    br label [[TEST1_TO_OUTLINE:%.*]]
; CHECK:       test1_to_outline:
; CHECK-NEXT:    [[TMP3:%.*]] = phi i32 [ [[E:%.*]], [[TEST1_TO_OUTLINE]] ], [ [[TMP0:%.*]], [[NEWFUNCROOT:%.*]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = phi i32 [ [[E]], [[TEST1_TO_OUTLINE]] ], [ [[TMP0]], [[NEWFUNCROOT]] ]
; CHECK-NEXT:    [[E]] = load i32, ptr [[TMP1:%.*]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = add i32 [[TMP2:%.*]], [[TMP2]]
; CHECK-NEXT:    br i1 true, label [[TEST:%.*]], label [[TEST1_TO_OUTLINE]]
; CHECK:       test:
; CHECK-NEXT:    [[D:%.*]] = load i32, ptr [[TMP1]], align 4
; CHECK-NEXT:    br label [[FIRST_EXITSTUB:%.*]]
; CHECK:       first.exitStub:
; CHECK-NEXT:    ret void
;
