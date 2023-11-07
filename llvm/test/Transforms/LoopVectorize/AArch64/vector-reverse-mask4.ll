; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; This is the loop in c++ being vectorize in this file with
; shuffle reverse

;#pragma clang loop vectorize_width(4, fixed)
;  for (long int i = N - 1; i >= 0; i--)
;  {
;    if (cond[i])
;      a[i] += 1;
;  }

; The test checks if the mask is being correctly created, reverted  and used

; RUN: opt -passes=loop-vectorize,dce,instcombine -mtriple aarch64-linux-gnu -S \
; RUN:   -prefer-predicate-over-epilogue=scalar-epilogue < %s | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

define void @vector_reverse_mask_v4i1(ptr noalias %a, ptr noalias %cond, i64 %N) #0 {
; CHECK-LABEL: @vector_reverse_mask_v4i1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP7:%.*]] = icmp sgt i64 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP7]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N]], 8
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[N]], -8
; CHECK-NEXT:    [[IND_END:%.*]] = and i64 [[N]], 7
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = xor i64 [[INDEX]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[TMP0]], [[N]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds double, ptr [[COND:%.*]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds double, ptr [[TMP2]], i64 -3
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x double>, ptr [[TMP3]], align 8
; CHECK-NEXT:    [[REVERSE:%.*]] = shufflevector <4 x double> [[WIDE_LOAD]], <4 x double> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds double, ptr [[TMP2]], i64 -7
; CHECK-NEXT:    [[WIDE_LOAD1:%.*]] = load <4 x double>, ptr [[TMP4]], align 8
; CHECK-NEXT:    [[REVERSE2:%.*]] = shufflevector <4 x double> [[WIDE_LOAD1]], <4 x double> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP5:%.*]] = fcmp une <4 x double> [[REVERSE]], zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = fcmp une <4 x double> [[REVERSE2]], zeroinitializer
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr double, ptr [[A:%.*]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr double, ptr [[TMP7]], i64 -3
; CHECK-NEXT:    [[REVERSE3:%.*]] = shufflevector <4 x i1> [[TMP5]], <4 x i1> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x double> @llvm.masked.load.v4f64.p0(ptr [[TMP8]], i32 8, <4 x i1> [[REVERSE3]], <4 x double> poison)
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr double, ptr [[TMP7]], i64 -7
; CHECK-NEXT:    [[REVERSE5:%.*]] = shufflevector <4 x i1> [[TMP6]], <4 x i1> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[WIDE_MASKED_LOAD6:%.*]] = call <4 x double> @llvm.masked.load.v4f64.p0(ptr [[TMP9]], i32 8, <4 x i1> [[REVERSE5]], <4 x double> poison)
; CHECK-NEXT:    [[TMP10:%.*]] = fadd <4 x double> [[WIDE_MASKED_LOAD]], <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>
; CHECK-NEXT:    [[TMP11:%.*]] = fadd <4 x double> [[WIDE_MASKED_LOAD6]], <double 1.000000e+00, double 1.000000e+00, double 1.000000e+00, double 1.000000e+00>
; CHECK-NEXT:    call void @llvm.masked.store.v4f64.p0(<4 x double> [[TMP10]], ptr [[TMP8]], i32 8, <4 x i1> [[REVERSE3]])
; CHECK-NEXT:    call void @llvm.masked.store.v4f64.p0(<4 x double> [[TMP11]], ptr [[TMP9]], i32 8, <4 x i1> [[REVERSE5]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[N]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[N]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[I_08_IN:%.*]] = phi i64 [ [[I_08:%.*]], [[FOR_INC:%.*]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[I_08]] = add nsw i64 [[I_08_IN]], -1
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds double, ptr [[COND]], i64 [[I_08]]
; CHECK-NEXT:    [[TMP13:%.*]] = load double, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[TOBOOL:%.*]] = fcmp une double [[TMP13]], 0.000000e+00
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds double, ptr [[A]], i64 [[I_08]]
; CHECK-NEXT:    [[TMP14:%.*]] = load double, ptr [[ARRAYIDX1]], align 8
; CHECK-NEXT:    [[ADD:%.*]] = fadd double [[TMP14]], 1.000000e+00
; CHECK-NEXT:    store double [[ADD]], ptr [[ARRAYIDX1]], align 8
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i64 [[I_08_IN]], 1
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_COND_CLEANUP_LOOPEXIT]], !llvm.loop [[LOOP4:![0-9]+]]
;

entry:
  %cmp7 = icmp sgt i64 %N, 0
  br i1 %cmp7, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup, %entry
  ret void

for.body:                                         ; preds = %for.body, %entry
  %i.08.in = phi i64 [ %i.08, %for.inc ], [ %N, %entry ]
  %i.08 = add nsw i64 %i.08.in, -1
  %arrayidx = getelementptr inbounds double, ptr %cond, i64 %i.08
  %0 = load double, ptr %arrayidx, align 8
  %tobool = fcmp une double %0, 0.000000e+00
  br i1 %tobool, label %if.then, label %for.inc

if.then:                                          ; preds = %for.body
  %arrayidx1 = getelementptr inbounds double, ptr %a, i64 %i.08
  %1 = load double, ptr %arrayidx1, align 8
  %add = fadd double %1, 1.000000e+00
  store double %add, ptr %arrayidx1, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body, %if.then
  %cmp = icmp sgt i64 %i.08.in, 1
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !0
}

attributes #0 = {"target-cpu"="generic" "target-features"="+neon,+sve" vscale_range(2,0) }


!0 = distinct !{!0, !1, !2, !3, !4, !5}
!1 = !{!"llvm.loop.mustprogress"}
!2 = !{!"llvm.loop.vectorize.width", i32 4}
!3 = !{!"llvm.loop.vectorize.scalable.enable", i1 false}
!4 = !{!"llvm.loop.vectorize.enable", i1 true}
!5 = !{!"llvm.loop.interleave.count", i32 2}
