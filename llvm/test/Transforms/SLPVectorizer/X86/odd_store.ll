; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer,dce -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

;int foo(char * restrict A, ptr restrict B, float T) {
;  A[0] = (T * B[10] + 4.0);
;  A[1] = (T * B[11] + 5.0);
;  A[2] = (T * B[12] + 6.0);
;}

define i32 @foo(ptr noalias nocapture %A, ptr noalias nocapture %B, float %T) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds float, ptr [[B:%.*]], i64 10
; CHECK-NEXT:    [[TMP2:%.*]] = load float, ptr [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = fmul float [[TMP2]], [[T:%.*]]
; CHECK-NEXT:    [[TMP4:%.*]] = fpext float [[TMP3]] to double
; CHECK-NEXT:    [[TMP5:%.*]] = fadd double [[TMP4]], 4.000000e+00
; CHECK-NEXT:    [[TMP6:%.*]] = fptosi double [[TMP5]] to i8
; CHECK-NEXT:    store i8 [[TMP6]], ptr [[A:%.*]], align 1
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds float, ptr [[B]], i64 11
; CHECK-NEXT:    [[TMP8:%.*]] = load float, ptr [[TMP7]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = fmul float [[TMP8]], [[T]]
; CHECK-NEXT:    [[TMP10:%.*]] = fpext float [[TMP9]] to double
; CHECK-NEXT:    [[TMP11:%.*]] = fadd double [[TMP10]], 5.000000e+00
; CHECK-NEXT:    [[TMP12:%.*]] = fptosi double [[TMP11]] to i8
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 1
; CHECK-NEXT:    store i8 [[TMP12]], ptr [[TMP13]], align 1
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds float, ptr [[B]], i64 12
; CHECK-NEXT:    [[TMP15:%.*]] = load float, ptr [[TMP14]], align 4
; CHECK-NEXT:    [[TMP16:%.*]] = fmul float [[TMP15]], [[T]]
; CHECK-NEXT:    [[TMP17:%.*]] = fpext float [[TMP16]] to double
; CHECK-NEXT:    [[TMP18:%.*]] = fadd double [[TMP17]], 6.000000e+00
; CHECK-NEXT:    [[TMP19:%.*]] = fptosi double [[TMP18]] to i8
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 2
; CHECK-NEXT:    store i8 [[TMP19]], ptr [[TMP20]], align 1
; CHECK-NEXT:    ret i32 undef
;
  %1 = getelementptr inbounds float, ptr %B, i64 10
  %2 = load float, ptr %1, align 4
  %3 = fmul float %2, %T
  %4 = fpext float %3 to double
  %5 = fadd double %4, 4.000000e+00
  %6 = fptosi double %5 to i8
  store i8 %6, ptr %A, align 1
  %7 = getelementptr inbounds float, ptr %B, i64 11
  %8 = load float, ptr %7, align 4
  %9 = fmul float %8, %T
  %10 = fpext float %9 to double
  %11 = fadd double %10, 5.000000e+00
  %12 = fptosi double %11 to i8
  %13 = getelementptr inbounds i8, ptr %A, i64 1
  store i8 %12, ptr %13, align 1
  %14 = getelementptr inbounds float, ptr %B, i64 12
  %15 = load float, ptr %14, align 4
  %16 = fmul float %15, %T
  %17 = fpext float %16 to double
  %18 = fadd double %17, 6.000000e+00
  %19 = fptosi double %18 to i8
  %20 = getelementptr inbounds i8, ptr %A, i64 2
  store i8 %19, ptr %20, align 1
  ret i32 undef
}

; PR41892
define void @test_v4f32_v2f32_store(<4 x float> %f, ptr %p){
; CHECK-LABEL: @test_v4f32_v2f32_store(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[F:%.*]], <4 x float> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    store <2 x float> [[TMP1]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret void
;
  %x0 = extractelement <4 x float> %f, i64 0
  %x1 = extractelement <4 x float> %f, i64 1
  %p1 = getelementptr inbounds float, ptr %p, i64 1
  store float %x0, ptr %p, align 4
  store float %x1, ptr %p1, align 4
  ret void
}

define void @test_v4f32_v2f32_splat_store(<4 x float> %f, ptr %p){
; CHECK-LABEL: @test_v4f32_v2f32_splat_store(
; CHECK-NEXT:    [[X0:%.*]] = extractelement <4 x float> [[F:%.*]], i64 0
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds float, ptr [[P:%.*]], i64 1
; CHECK-NEXT:    store float [[X0]], ptr [[P]], align 4
; CHECK-NEXT:    store float [[X0]], ptr [[P1]], align 4
; CHECK-NEXT:    ret void
;
  %x0 = extractelement <4 x float> %f, i64 0
  %p1 = getelementptr inbounds float, ptr %p, i64 1
  store float %x0, ptr %p, align 4
  store float %x0, ptr %p1, align 4
  ret void
}

define void @test_v4f32_v3f32_store(<4 x float> %f, ptr %p){
; CHECK-LABEL: @test_v4f32_v3f32_store(
; CHECK-NEXT:    [[X2:%.*]] = extractelement <4 x float> [[F:%.*]], i64 2
; CHECK-NEXT:    [[P2:%.*]] = getelementptr inbounds float, ptr [[P:%.*]], i64 2
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[F]], <4 x float> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    store <2 x float> [[TMP1]], ptr [[P]], align 4
; CHECK-NEXT:    store float [[X2]], ptr [[P2]], align 4
; CHECK-NEXT:    ret void
;
  %x0 = extractelement <4 x float> %f, i64 0
  %x1 = extractelement <4 x float> %f, i64 1
  %x2 = extractelement <4 x float> %f, i64 2
  %p1 = getelementptr inbounds float, ptr %p, i64 1
  %p2 = getelementptr inbounds float, ptr %p, i64 2
  store float %x0, ptr %p, align 4
  store float %x1, ptr %p1, align 4
  store float %x2, ptr %p2, align 4
  ret void
}

define void @test_v4f32_v3f32_splat_store(<4 x float> %f, ptr %p){
; CHECK-LABEL: @test_v4f32_v3f32_splat_store(
; CHECK-NEXT:    [[X0:%.*]] = extractelement <4 x float> [[F:%.*]], i64 0
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds float, ptr [[P:%.*]], i64 1
; CHECK-NEXT:    [[P2:%.*]] = getelementptr inbounds float, ptr [[P]], i64 2
; CHECK-NEXT:    store float [[X0]], ptr [[P]], align 4
; CHECK-NEXT:    store float [[X0]], ptr [[P1]], align 4
; CHECK-NEXT:    store float [[X0]], ptr [[P2]], align 4
; CHECK-NEXT:    ret void
;
  %x0 = extractelement <4 x float> %f, i64 0
  %p1 = getelementptr inbounds float, ptr %p, i64 1
  %p2 = getelementptr inbounds float, ptr %p, i64 2
  store float %x0, ptr %p, align 4
  store float %x0, ptr %p1, align 4
  store float %x0, ptr %p2, align 4
  ret void
}

define void @test_v4f32_v4f32_store(<4 x float> %f, ptr %p){
; CHECK-LABEL: @test_v4f32_v4f32_store(
; CHECK-NEXT:    store <4 x float> [[F:%.*]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret void
;
  %x0 = extractelement <4 x float> %f, i64 0
  %x1 = extractelement <4 x float> %f, i64 1
  %x2 = extractelement <4 x float> %f, i64 2
  %x3 = extractelement <4 x float> %f, i64 3
  %p1 = getelementptr inbounds float, ptr %p, i64 1
  %p2 = getelementptr inbounds float, ptr %p, i64 2
  %p3 = getelementptr inbounds float, ptr %p, i64 3
  store float %x0, ptr %p, align 4
  store float %x1, ptr %p1, align 4
  store float %x2, ptr %p2, align 4
  store float %x3, ptr %p3, align 4
  ret void
}

define void @test_v4f32_v4f32_splat_store(<4 x float> %f, ptr %p){
; CHECK-LABEL: @test_v4f32_v4f32_splat_store(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[F:%.*]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    store <4 x float> [[TMP1]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret void
;
  %x0 = extractelement <4 x float> %f, i64 0
  %p1 = getelementptr inbounds float, ptr %p, i64 1
  %p2 = getelementptr inbounds float, ptr %p, i64 2
  %p3 = getelementptr inbounds float, ptr %p, i64 3
  store float %x0, ptr %p, align 4
  store float %x0, ptr %p1, align 4
  store float %x0, ptr %p2, align 4
  store float %x0, ptr %p3, align 4
  ret void
}
