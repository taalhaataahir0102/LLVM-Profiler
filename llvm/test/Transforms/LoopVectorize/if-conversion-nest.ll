; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-vectorize,dce,instcombine -force-vector-interleave=1 -force-vector-width=4 -enable-if-conversion -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"

define i32 @foo(ptr nocapture %A, ptr nocapture %B, i32 %n) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP26:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP26]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[N]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_MEMCHECK:%.*]]
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[N]], -1
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw nsw i64 [[TMP2]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = add nuw nsw i64 [[TMP3]], 4
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[A:%.*]], i64 [[TMP4]]
; CHECK-NEXT:    [[UGLYGEP1:%.*]] = getelementptr i8, ptr [[B:%.*]], i64 [[TMP4]]
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ugt ptr [[UGLYGEP1]], [[A]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ugt ptr [[UGLYGEP]], [[B]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label [[SCALAR_PH]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_VEC:%.*]] = and i64 [[TMP0]], 4294967292
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP5]], align 4, !alias.scope !0, !noalias !3
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x i32>, ptr [[TMP6]], align 4, !alias.scope !3
; CHECK-NEXT:    [[TMP7:%.*]] = icmp sgt <4 x i32> [[WIDE_LOAD]], [[WIDE_LOAD2]]
; CHECK-NEXT:    [[TMP8:%.*]] = icmp sgt <4 x i32> [[WIDE_LOAD]], <i32 19, i32 19, i32 19, i32 19>
; CHECK-NEXT:    [[TMP9:%.*]] = icmp slt <4 x i32> [[WIDE_LOAD2]], <i32 4, i32 4, i32 4, i32 4>
; CHECK-NEXT:    [[TMP10:%.*]] = select <4 x i1> [[TMP9]], <4 x i32> <i32 4, i32 4, i32 4, i32 4>, <4 x i32> <i32 5, i32 5, i32 5, i32 5>
; CHECK-NEXT:    [[TMP11:%.*]] = and <4 x i1> [[TMP7]], [[TMP8]]
; CHECK-NEXT:    [[TMP12:%.*]] = xor <4 x i1> [[TMP8]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[TMP13:%.*]] = and <4 x i1> [[TMP7]], [[TMP12]]
; CHECK-NEXT:    [[PREDPHI:%.*]] = select <4 x i1> [[TMP11]], <4 x i32> <i32 3, i32 3, i32 3, i32 3>, <4 x i32> <i32 9, i32 9, i32 9, i32 9>
; CHECK-NEXT:    [[PREDPHI3:%.*]] = select <4 x i1> [[TMP13]], <4 x i32> [[TMP10]], <4 x i32> [[PREDPHI]]
; CHECK-NEXT:    store <4 x i32> [[PREDPHI3]], ptr [[TMP5]], align 4, !alias.scope !0, !noalias !3
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N_VEC]], [[TMP0]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_END_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_PREHEADER]] ], [ 0, [[VECTOR_MEMCHECK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[IF_END14:%.*]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP15:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP16:%.*]] = load i32, ptr [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[CMP3:%.*]] = icmp sgt i32 [[TMP15]], [[TMP16]]
; CHECK-NEXT:    br i1 [[CMP3]], label [[IF_THEN:%.*]], label [[IF_END14]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CMP6:%.*]] = icmp sgt i32 [[TMP15]], 19
; CHECK-NEXT:    br i1 [[CMP6]], label [[IF_END14]], label [[IF_ELSE:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    [[CMP10:%.*]] = icmp slt i32 [[TMP16]], 4
; CHECK-NEXT:    [[DOT:%.*]] = select i1 [[CMP10]], i32 4, i32 5
; CHECK-NEXT:    br label [[IF_END14]]
; CHECK:       if.end14:
; CHECK-NEXT:    [[X_0:%.*]] = phi i32 [ 9, [[FOR_BODY]] ], [ 3, [[IF_THEN]] ], [ [[DOT]], [[IF_ELSE]] ]
; CHECK-NEXT:    store i32 [[X_0]], ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[LFTR_WIDEIV:%.*]] = trunc i64 [[INDVARS_IV_NEXT]] to i32
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[LFTR_WIDEIV]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret i32 undef
;
entry:
  %cmp26 = icmp sgt i32 %n, 0
  br i1 %cmp26, label %for.body, label %for.end

for.body:
  %indvars.iv = phi i64 [ %indvars.iv.next, %if.end14 ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %A, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %B, i64 %indvars.iv
  %1 = load i32, ptr %arrayidx2, align 4
  %cmp3 = icmp sgt i32 %0, %1
  br i1 %cmp3, label %if.then, label %if.end14

if.then:
  %cmp6 = icmp sgt i32 %0, 19
  br i1 %cmp6, label %if.end14, label %if.else

if.else:
  %cmp10 = icmp slt i32 %1, 4
  %. = select i1 %cmp10, i32 4, i32 5
  br label %if.end14

if.end14:
  %x.0 = phi i32 [ 9, %for.body ], [ 3, %if.then ], [ %., %if.else ]  ; <------------- A PHI with 3 entries that we can still vectorize.
  store i32 %x.0, ptr %arrayidx, align 4
  %indvars.iv.next = add i64 %indvars.iv, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32
  %exitcond = icmp eq i32 %lftr.wideiv, %n
  br i1 %exitcond, label %for.end, label %for.body

for.end:
  ret i32 undef
}

