; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer  -S -mtriple=x86_64-unknown -mcpu=corei7-avx | FileCheck %s

%struct.complex = type { float, float }

define  void @foo (ptr %A, ptr %B, ptr %Result) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 256, 0
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[TMP1:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[TMP18:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = phi <2 x float> [ zeroinitializer, [[ENTRY]] ], [ [[TMP17:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [[STRUCT_COMPLEX:%.*]], ptr [[A:%.*]], i64 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [[STRUCT_COMPLEX]], ptr [[B:%.*]], i64 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = load float, ptr [[TMP4]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT_COMPLEX]], ptr [[B]], i64 [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP7:%.*]] = load float, ptr [[TMP6]], align 4
; CHECK-NEXT:    [[TMP9:%.*]] = load <2 x float>, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[TMP10:%.*]] = insertelement <2 x float> poison, float [[TMP5]], i32 0
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x float> [[TMP10]], <2 x float> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP11:%.*]] = fmul <2 x float> [[TMP9]], [[SHUFFLE]]
; CHECK-NEXT:    [[TMP12:%.*]] = insertelement <2 x float> poison, float [[TMP7]], i32 0
; CHECK-NEXT:    [[SHUFFLE1:%.*]] = shufflevector <2 x float> [[TMP12]], <2 x float> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP13:%.*]] = fmul <2 x float> [[TMP9]], [[SHUFFLE1]]
; CHECK-NEXT:    [[SHUFFLE2:%.*]] = shufflevector <2 x float> [[TMP13]], <2 x float> poison, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:    [[TMP14:%.*]] = fsub <2 x float> [[TMP11]], [[SHUFFLE2]]
; CHECK-NEXT:    [[TMP15:%.*]] = fadd <2 x float> [[TMP11]], [[SHUFFLE2]]
; CHECK-NEXT:    [[TMP16:%.*]] = shufflevector <2 x float> [[TMP14]], <2 x float> [[TMP15]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP17]] = fadd <2 x float> [[TMP2]], [[TMP16]]
; CHECK-NEXT:    [[TMP18]] = add nuw nsw i64 [[TMP1]], 1
; CHECK-NEXT:    [[TMP19:%.*]] = icmp eq i64 [[TMP18]], [[TMP0]]
; CHECK-NEXT:    br i1 [[TMP19]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    store <2 x float> [[TMP17]], ptr [[RESULT:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %0 = add i64 256, 0
  br label %loop

loop:
  %1 = phi i64 [ 0, %entry ], [ %20, %loop ]
  %2 = phi float [ 0.000000e+00, %entry ], [ %19, %loop ]
  %3 = phi float [ 0.000000e+00, %entry ], [ %18, %loop ]
  %4 = getelementptr inbounds %"struct.complex", ptr %A, i64 %1, i32 0
  %5 = load float, ptr %4, align 4
  %6 = getelementptr inbounds %"struct.complex", ptr %A, i64 %1, i32 1
  %7 = load float, ptr %6, align 4
  %8 = getelementptr inbounds %"struct.complex", ptr %B, i64 %1, i32 0
  %9 = load float, ptr %8, align 4
  %10 = getelementptr inbounds %"struct.complex", ptr %B, i64 %1, i32 1
  %11 = load float, ptr %10, align 4
  %12 = fmul float %5, %9
  %13 = fmul float %7, %11
  %14 = fsub float %12, %13
  %15 = fmul float %7, %9
  %16 = fmul float %5, %11
  %17 = fadd float %15, %16
  %18 = fadd float %3, %14
  %19 = fadd float %2, %17
  %20 = add nuw nsw i64 %1, 1
  %21 = icmp eq i64 %20, %0
  br i1 %21, label %exit, label %loop

exit:
  store float %18, ptr %Result, align 4
  %22 = getelementptr inbounds %"struct.complex", ptr %Result,  i32 0, i32 1
  store float %19, ptr %22, align 4
  ret void
}

