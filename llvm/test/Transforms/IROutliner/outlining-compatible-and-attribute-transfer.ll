; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; This has two compatible regions based on function attributes.  We have
; attributes that should be transferred only if it is on all of the regions.

; This includes the attributes, no-nans-fp-math,
; no-signed-zeros-fp-math, less-precise-fpmad, unsafe-fp-math, and
; no-infs-fp-math.  Only when each instance of similarity has these attributes
; can we say that the outlined function can have these attributes since that
; is the more general case for these attributes.

define void @outline_attrs1() #0 {
; CHECK-LABEL: @outline_attrs1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_1(ptr [[A]], ptr [[B]], ptr [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  store i32 4, ptr %c, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %cl = load i32, ptr %c
  ret void
}

define void @outline_attrs2() #0 {
; CHECK-LABEL: @outline_attrs2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_1(ptr [[A]], ptr [[B]], ptr [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  store i32 4, ptr %c, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %cl = load i32, ptr %c
  ret void
}

define void @outline_attrs3() #0 {
; CHECK-LABEL: @outline_attrs3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca float, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca float, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca float, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]], ptr [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca float, align 4
  %b = alloca float, align 4
  %c = alloca float, align 4
  store float 2.0, ptr %a, align 4
  store float 3.0, ptr %b, align 4
  store float 4.0, ptr %c, align 4
  %al = load float, ptr %a
  %bl = load float, ptr %b
  %cl = load float, ptr %c
  %0 = fmul float %al, %bl
  ret void
}

define void @outline_attrs4() {
; CHECK-LABEL: @outline_attrs4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca float, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca float, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca float, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]], ptr [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca float, align 4
  %b = alloca float, align 4
  %c = alloca float, align 4
  store float 2.0, ptr %a, align 4
  store float 3.0, ptr %b, align 4
  store float 4.0, ptr %c, align 4
  %al = load float, ptr %a
  %bl = load float, ptr %b
  %cl = load float, ptr %c
  %0 = fmul float %al, %bl
  ret void
}

attributes #0 = { "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "less-precise-fpmad"="true"
"unsafe-fp-math"="true" "no-infs-fp-math"="true"}

; CHECK: define internal void @outlined_ir_func_0(ptr [[ARG0:%.*]], ptr [[ARG1:%.*]], ptr [[ARG2:%.*]]) [[ATTR1:#[0-9]+]] {
; CHECK: entry_to_outline:
; CHECK-NEXT:    store float 2.000000e+00, ptr [[ARG0]], align 4
; CHECK-NEXT:    store float 3.000000e+00, ptr [[ARG1]], align 4
; CHECK-NEXT:    store float 4.000000e+00, ptr [[ARG2]], align 4
; CHECK-NEXT:    [[AL:%.*]] = load float, ptr [[ARG0]], align 4
; CHECK-NEXT:    [[BL:%.*]] = load float, ptr [[ARG1]], align 4
; CHECK-NEXT:    [[CL:%.*]] = load float, ptr [[ARG2]], align 4

; CHECK: define internal void @outlined_ir_func_1(ptr [[ARG0:%.*]], ptr [[ARG1:%.*]], ptr [[ARG2:%.*]]) [[ATTR:#[0-9]+]] {
; CHECK: entry_to_outline:
; CHECK-NEXT:    store i32 2, ptr [[ARG0]], align 4
; CHECK-NEXT:    store i32 3, ptr [[ARG1]], align 4
; CHECK-NEXT:    store i32 4, ptr [[ARG2]], align 4
; CHECK-NEXT:    [[AL:%.*]] = load i32, ptr [[ARG0]], align 4
; CHECK-NEXT:    [[BL:%.*]] = load i32, ptr [[ARG1]], align 4
; CHECK-NEXT:    [[CL:%.*]] = load i32, ptr [[ARG2]], align 4


; CHECK: attributes [[ATTR1]] =   { minsize optsize "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "unsafe-fp-math"="false" }
; CHECK: attributes [[ATTR]] = { minsize optsize "less-precise-fpmad"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "unsafe-fp-math"="true" }
