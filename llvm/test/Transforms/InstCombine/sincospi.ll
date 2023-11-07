; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s -mtriple=x86_64-apple-macosx10.9 | FileCheck %s --check-prefix=CHECK-FLOAT-IN-VEC
; RUN: opt -passes=instcombine -S < %s -mtriple=arm-apple-ios7.0 | FileCheck %s
; RUN: opt -passes=instcombine -S < %s -mtriple=arm64-apple-ios7.0 | FileCheck %s
; RUN: opt -passes=instcombine -S < %s -mtriple=x86_64-apple-macosx10.8 | FileCheck %s --check-prefix=CHECK-NO-SINCOS
; RUN: opt -passes=instcombine -S < %s -mtriple=arm-apple-ios6.0 | FileCheck %s --check-prefix=CHECK-NO-SINCOS
; RUN: opt -passes=instcombine -S < %s -mtriple=x86_64-none-linux-gnu | FileCheck %s --check-prefix=CHECK-NO-SINCOS


attributes #0 = { readnone nounwind }

declare float @__sinpif(float %x) #0
declare float @__cospif(float %x) #0

declare double @__sinpi(double %x) #0
declare double @__cospi(double %x) #0

@var32 = global float 0.0
@var64 = global double 0.0

define float @test_instbased_f32() {
; CHECK-FLOAT-IN-VEC-LABEL: @test_instbased_f32(
; CHECK-FLOAT-IN-VEC-NEXT:    [[VAL:%.*]] = load float, ptr @var32, align 4
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINCOSPI:%.*]] = call <2 x float> @__sincospif_stret(float [[VAL]])
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINPI:%.*]] = extractelement <2 x float> [[SINCOSPI]], i64 0
; CHECK-FLOAT-IN-VEC-NEXT:    [[COSPI:%.*]] = extractelement <2 x float> [[SINCOSPI]], i64 1
; CHECK-FLOAT-IN-VEC-NEXT:    [[COS:%.*]] = call float @__cospif(float [[VAL]]) #[[ATTR0:[0-9]+]]
; CHECK-FLOAT-IN-VEC-NEXT:    [[RES:%.*]] = fadd float [[SINPI]], [[COSPI]]
; CHECK-FLOAT-IN-VEC-NEXT:    ret float [[RES]]
;
; CHECK-LABEL: @test_instbased_f32(
; CHECK-NEXT:    [[VAL:%.*]] = load float, ptr @var32, align 4
; CHECK-NEXT:    [[SINCOSPI:%.*]] = call { float, float } @__sincospif_stret(float [[VAL]])
; CHECK-NEXT:    [[SINPI:%.*]] = extractvalue { float, float } [[SINCOSPI]], 0
; CHECK-NEXT:    [[COSPI:%.*]] = extractvalue { float, float } [[SINCOSPI]], 1
; CHECK-NEXT:    [[COS:%.*]] = call float @__cospif(float [[VAL]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[RES:%.*]] = fadd float [[SINPI]], [[COSPI]]
; CHECK-NEXT:    ret float [[RES]]
;
; CHECK-NO-SINCOS-LABEL: @test_instbased_f32(
; CHECK-NO-SINCOS-NEXT:    [[VAL:%.*]] = load float, ptr @var32, align 4
; CHECK-NO-SINCOS-NEXT:    [[SIN:%.*]] = call float @__sinpif(float [[VAL]]) #[[ATTR0:[0-9]+]]
; CHECK-NO-SINCOS-NEXT:    [[COS:%.*]] = call float @__cospif(float [[VAL]]) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[RES:%.*]] = fadd float [[SIN]], [[COS]]
; CHECK-NO-SINCOS-NEXT:    ret float [[RES]]
;
  %val = load float, ptr @var32
  %sin = call float @__sinpif(float %val) #0
  %cos = call float @__cospif(float %val) #0
  %res = fadd float %sin, %cos
  ret float %res
}

define float @test_instbased_f32_other_user(ptr %ptr) {
; CHECK-FLOAT-IN-VEC-LABEL: @test_instbased_f32_other_user(
; CHECK-FLOAT-IN-VEC-NEXT:    [[VAL:%.*]] = load float, ptr @var32, align 4
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINCOSPI:%.*]] = call <2 x float> @__sincospif_stret(float [[VAL]])
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINPI:%.*]] = extractelement <2 x float> [[SINCOSPI]], i64 0
; CHECK-FLOAT-IN-VEC-NEXT:    [[COSPI:%.*]] = extractelement <2 x float> [[SINCOSPI]], i64 1
; CHECK-FLOAT-IN-VEC-NEXT:    store float [[VAL]], ptr [[PTR:%.*]], align 4
; CHECK-FLOAT-IN-VEC-NEXT:    [[COS:%.*]] = call float @__cospif(float [[VAL]]) #[[ATTR0]]
; CHECK-FLOAT-IN-VEC-NEXT:    [[RES:%.*]] = fadd float [[SINPI]], [[COSPI]]
; CHECK-FLOAT-IN-VEC-NEXT:    ret float [[RES]]
;
; CHECK-LABEL: @test_instbased_f32_other_user(
; CHECK-NEXT:    [[VAL:%.*]] = load float, ptr @var32, align 4
; CHECK-NEXT:    [[SINCOSPI:%.*]] = call { float, float } @__sincospif_stret(float [[VAL]])
; CHECK-NEXT:    [[SINPI:%.*]] = extractvalue { float, float } [[SINCOSPI]], 0
; CHECK-NEXT:    [[COSPI:%.*]] = extractvalue { float, float } [[SINCOSPI]], 1
; CHECK-NEXT:    store float [[VAL]], ptr [[PTR:%.*]], align 4
; CHECK-NEXT:    [[COS:%.*]] = call float @__cospif(float [[VAL]]) #[[ATTR0]]
; CHECK-NEXT:    [[RES:%.*]] = fadd float [[SINPI]], [[COSPI]]
; CHECK-NEXT:    ret float [[RES]]
;
; CHECK-NO-SINCOS-LABEL: @test_instbased_f32_other_user(
; CHECK-NO-SINCOS-NEXT:    [[VAL:%.*]] = load float, ptr @var32, align 4
; CHECK-NO-SINCOS-NEXT:    store float [[VAL]], ptr [[PTR:%.*]], align 4
; CHECK-NO-SINCOS-NEXT:    [[SIN:%.*]] = call float @__sinpif(float [[VAL]]) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[COS:%.*]] = call float @__cospif(float [[VAL]]) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[RES:%.*]] = fadd float [[SIN]], [[COS]]
; CHECK-NO-SINCOS-NEXT:    ret float [[RES]]
;
  %val = load float, ptr @var32
  store float %val, ptr %ptr
  %sin = call float @__sinpif(float %val) #0
  %cos = call float @__cospif(float %val) #0
  %res = fadd float %sin, %cos
  ret float %res
}

define float @test_constant_f32() {
; CHECK-FLOAT-IN-VEC-LABEL: @test_constant_f32(
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINCOSPI:%.*]] = call <2 x float> @__sincospif_stret(float 1.000000e+00)
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINPI:%.*]] = extractelement <2 x float> [[SINCOSPI]], i64 0
; CHECK-FLOAT-IN-VEC-NEXT:    [[COSPI:%.*]] = extractelement <2 x float> [[SINCOSPI]], i64 1
; CHECK-FLOAT-IN-VEC-NEXT:    [[COS:%.*]] = call float @__cospif(float 1.000000e+00) #[[ATTR0]]
; CHECK-FLOAT-IN-VEC-NEXT:    [[RES:%.*]] = fadd float [[SINPI]], [[COSPI]]
; CHECK-FLOAT-IN-VEC-NEXT:    ret float [[RES]]
;
; CHECK-LABEL: @test_constant_f32(
; CHECK-NEXT:    [[SINCOSPI:%.*]] = call { float, float } @__sincospif_stret(float 1.000000e+00)
; CHECK-NEXT:    [[SINPI:%.*]] = extractvalue { float, float } [[SINCOSPI]], 0
; CHECK-NEXT:    [[COSPI:%.*]] = extractvalue { float, float } [[SINCOSPI]], 1
; CHECK-NEXT:    [[COS:%.*]] = call float @__cospif(float 1.000000e+00) #[[ATTR0]]
; CHECK-NEXT:    [[RES:%.*]] = fadd float [[SINPI]], [[COSPI]]
; CHECK-NEXT:    ret float [[RES]]
;
; CHECK-NO-SINCOS-LABEL: @test_constant_f32(
; CHECK-NO-SINCOS-NEXT:    [[SIN:%.*]] = call float @__sinpif(float 1.000000e+00) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[COS:%.*]] = call float @__cospif(float 1.000000e+00) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[RES:%.*]] = fadd float [[SIN]], [[COS]]
; CHECK-NO-SINCOS-NEXT:    ret float [[RES]]
;
  %sin = call float @__sinpif(float 1.0) #0
  %cos = call float @__cospif(float 1.0) #0
  %res = fadd float %sin, %cos
  ret float %res


}

define double @test_instbased_f64() {
; CHECK-FLOAT-IN-VEC-LABEL: @test_instbased_f64(
; CHECK-FLOAT-IN-VEC-NEXT:    [[VAL:%.*]] = load double, ptr @var64, align 8
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINCOSPI:%.*]] = call { double, double } @__sincospi_stret(double [[VAL]])
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINPI:%.*]] = extractvalue { double, double } [[SINCOSPI]], 0
; CHECK-FLOAT-IN-VEC-NEXT:    [[COSPI:%.*]] = extractvalue { double, double } [[SINCOSPI]], 1
; CHECK-FLOAT-IN-VEC-NEXT:    [[COS:%.*]] = call double @__cospi(double [[VAL]]) #[[ATTR0]]
; CHECK-FLOAT-IN-VEC-NEXT:    [[RES:%.*]] = fadd double [[SINPI]], [[COSPI]]
; CHECK-FLOAT-IN-VEC-NEXT:    ret double [[RES]]
;
; CHECK-LABEL: @test_instbased_f64(
; CHECK-NEXT:    [[VAL:%.*]] = load double, ptr @var64, align 8
; CHECK-NEXT:    [[SINCOSPI:%.*]] = call { double, double } @__sincospi_stret(double [[VAL]])
; CHECK-NEXT:    [[SINPI:%.*]] = extractvalue { double, double } [[SINCOSPI]], 0
; CHECK-NEXT:    [[COSPI:%.*]] = extractvalue { double, double } [[SINCOSPI]], 1
; CHECK-NEXT:    [[COS:%.*]] = call double @__cospi(double [[VAL]]) #[[ATTR0]]
; CHECK-NEXT:    [[RES:%.*]] = fadd double [[SINPI]], [[COSPI]]
; CHECK-NEXT:    ret double [[RES]]
;
; CHECK-NO-SINCOS-LABEL: @test_instbased_f64(
; CHECK-NO-SINCOS-NEXT:    [[VAL:%.*]] = load double, ptr @var64, align 8
; CHECK-NO-SINCOS-NEXT:    [[SIN:%.*]] = call double @__sinpi(double [[VAL]]) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[COS:%.*]] = call double @__cospi(double [[VAL]]) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[RES:%.*]] = fadd double [[SIN]], [[COS]]
; CHECK-NO-SINCOS-NEXT:    ret double [[RES]]
;
  %val = load double, ptr @var64
  %sin = call double @__sinpi(double %val) #0
  %cos = call double @__cospi(double %val) #0
  %res = fadd double %sin, %cos
  ret double %res


}

define double @test_constant_f64() {
; CHECK-FLOAT-IN-VEC-LABEL: @test_constant_f64(
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINCOSPI:%.*]] = call { double, double } @__sincospi_stret(double 1.000000e+00)
; CHECK-FLOAT-IN-VEC-NEXT:    [[SINPI:%.*]] = extractvalue { double, double } [[SINCOSPI]], 0
; CHECK-FLOAT-IN-VEC-NEXT:    [[COSPI:%.*]] = extractvalue { double, double } [[SINCOSPI]], 1
; CHECK-FLOAT-IN-VEC-NEXT:    [[COS:%.*]] = call double @__cospi(double 1.000000e+00) #[[ATTR0]]
; CHECK-FLOAT-IN-VEC-NEXT:    [[RES:%.*]] = fadd double [[SINPI]], [[COSPI]]
; CHECK-FLOAT-IN-VEC-NEXT:    ret double [[RES]]
;
; CHECK-LABEL: @test_constant_f64(
; CHECK-NEXT:    [[SINCOSPI:%.*]] = call { double, double } @__sincospi_stret(double 1.000000e+00)
; CHECK-NEXT:    [[SINPI:%.*]] = extractvalue { double, double } [[SINCOSPI]], 0
; CHECK-NEXT:    [[COSPI:%.*]] = extractvalue { double, double } [[SINCOSPI]], 1
; CHECK-NEXT:    [[COS:%.*]] = call double @__cospi(double 1.000000e+00) #[[ATTR0]]
; CHECK-NEXT:    [[RES:%.*]] = fadd double [[SINPI]], [[COSPI]]
; CHECK-NEXT:    ret double [[RES]]
;
; CHECK-NO-SINCOS-LABEL: @test_constant_f64(
; CHECK-NO-SINCOS-NEXT:    [[SIN:%.*]] = call double @__sinpi(double 1.000000e+00) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[COS:%.*]] = call double @__cospi(double 1.000000e+00) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[RES:%.*]] = fadd double [[SIN]], [[COS]]
; CHECK-NO-SINCOS-NEXT:    ret double [[RES]]
;
  %sin = call double @__sinpi(double 1.0) #0
  %cos = call double @__cospi(double 1.0) #0
  %res = fadd double %sin, %cos
  ret double %res


}

define double @test_fptr(ptr %fptr, double %p1) {
; CHECK-FLOAT-IN-VEC-LABEL: @test_fptr(
; CHECK-FLOAT-IN-VEC-NEXT:    [[SIN:%.*]] = call double @__sinpi(double [[P1:%.*]]) #[[ATTR0]]
; CHECK-FLOAT-IN-VEC-NEXT:    [[COS:%.*]] = call double [[FPTR:%.*]](double [[P1]])
; CHECK-FLOAT-IN-VEC-NEXT:    [[RES:%.*]] = fadd double [[SIN]], [[COS]]
; CHECK-FLOAT-IN-VEC-NEXT:    ret double [[RES]]
;
; CHECK-LABEL: @test_fptr(
; CHECK-NEXT:    [[SIN:%.*]] = call double @__sinpi(double [[P1:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    [[COS:%.*]] = call double [[FPTR:%.*]](double [[P1]])
; CHECK-NEXT:    [[RES:%.*]] = fadd double [[SIN]], [[COS]]
; CHECK-NEXT:    ret double [[RES]]
;
; CHECK-NO-SINCOS-LABEL: @test_fptr(
; CHECK-NO-SINCOS-NEXT:    [[SIN:%.*]] = call double @__sinpi(double [[P1:%.*]]) #[[ATTR0]]
; CHECK-NO-SINCOS-NEXT:    [[COS:%.*]] = call double [[FPTR:%.*]](double [[P1]])
; CHECK-NO-SINCOS-NEXT:    [[RES:%.*]] = fadd double [[SIN]], [[COS]]
; CHECK-NO-SINCOS-NEXT:    ret double [[RES]]
;
  %sin = call double @__sinpi(double %p1) #0
  %cos = call double %fptr(double %p1)
  %res = fadd double %sin, %cos
  ret double %res
}

define i1 @test_cospif_used_in_branch_cond() {
; CHECK-FLOAT-IN-VEC-LABEL: @test_cospif_used_in_branch_cond(
; CHECK-FLOAT-IN-VEC-NEXT:  entry:
; CHECK-FLOAT-IN-VEC-NEXT:    [[RES:%.*]] = call float @__cospif(float noundef 0.000000e+00)
; CHECK-FLOAT-IN-VEC-NEXT:    [[CMP:%.*]] = fcmp uno float [[RES]], 0.000000e+00
; CHECK-FLOAT-IN-VEC-NEXT:    br i1 [[CMP]], label [[THEN:%.*]], label [[ELSE:%.*]]
; CHECK-FLOAT-IN-VEC:       then:
; CHECK-FLOAT-IN-VEC-NEXT:    ret i1 false
; CHECK-FLOAT-IN-VEC:       else:
; CHECK-FLOAT-IN-VEC-NEXT:    ret i1 true
;
; CHECK-LABEL: @test_cospif_used_in_branch_cond(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = call float @__cospif(float noundef 0.000000e+00)
; CHECK-NEXT:    [[CMP:%.*]] = fcmp uno float [[RES]], 0.000000e+00
; CHECK-NEXT:    br i1 [[CMP]], label [[THEN:%.*]], label [[ELSE:%.*]]
; CHECK:       then:
; CHECK-NEXT:    ret i1 false
; CHECK:       else:
; CHECK-NEXT:    ret i1 true
;
; CHECK-NO-SINCOS-LABEL: @test_cospif_used_in_branch_cond(
; CHECK-NO-SINCOS-NEXT:  entry:
; CHECK-NO-SINCOS-NEXT:    [[RES:%.*]] = call float @__cospif(float noundef 0.000000e+00)
; CHECK-NO-SINCOS-NEXT:    [[CMP:%.*]] = fcmp uno float [[RES]], 0.000000e+00
; CHECK-NO-SINCOS-NEXT:    br i1 [[CMP]], label [[THEN:%.*]], label [[ELSE:%.*]]
; CHECK-NO-SINCOS:       then:
; CHECK-NO-SINCOS-NEXT:    ret i1 false
; CHECK-NO-SINCOS:       else:
; CHECK-NO-SINCOS-NEXT:    ret i1 true
;
entry:
  %res = call float @__cospif(float noundef 0.000000e+00) #3
  %cmp = fcmp uno float %res, 0.000000e+00
  br i1 %cmp, label %then, label %else

then:
  ret i1 false

else:
  ret i1 true
}
