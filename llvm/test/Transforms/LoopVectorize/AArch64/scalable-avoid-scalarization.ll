; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=aarch64 -passes=loop-vectorize --force-vector-interleave=1 -S | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

; The test checks that scalarized code is not generated for SVE.
; It creates a scenario where the gep instruction is used outside
; the loop, preventing the gep (and consequently the loop induction
; update variable) from being classified as 'uniform'.

define void @test_no_scalarization(ptr %a, ptr noalias %b, i32 %idx, i32 %n) #0 {
; CHECK-LABEL: @test_no_scalarization(
; CHECK-NEXT:  L.entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add nsw i32 [[IDX:%.*]], 1
; CHECK-NEXT:    [[SMAX:%.*]] = call i32 @llvm.smax.i32(i32 [[N:%.*]], i32 [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[SMAX]], [[IDX]]
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP3:%.*]] = mul i32 [[TMP2]], 2
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[TMP1]], [[TMP3]]
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP5:%.*]] = mul i32 [[TMP4]], 2
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[TMP1]], [[TMP5]]
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[TMP1]], [[N_MOD_VF]]
; CHECK-NEXT:    [[IND_END:%.*]] = add i32 [[IDX]], [[N_VEC]]
; CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i32> poison, i32 [[IDX]], i64 0
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 2 x i32> [[DOTSPLATINSERT]], <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = call <vscale x 2 x i32> @llvm.experimental.stepvector.nxv2i32()
; CHECK-NEXT:    [[TMP7:%.*]] = add <vscale x 2 x i32> [[TMP6]], zeroinitializer
; CHECK-NEXT:    [[TMP8:%.*]] = mul <vscale x 2 x i32> [[TMP7]], shufflevector (<vscale x 2 x i32> insertelement (<vscale x 2 x i32> poison, i32 1, i64 0), <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer)
; CHECK-NEXT:    [[INDUCTION:%.*]] = add <vscale x 2 x i32> [[DOTSPLAT]], [[TMP8]]
; CHECK-NEXT:    [[TMP9:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP10:%.*]] = mul i32 [[TMP9]], 2
; CHECK-NEXT:    [[TMP11:%.*]] = mul i32 1, [[TMP10]]
; CHECK-NEXT:    [[DOTSPLATINSERT1:%.*]] = insertelement <vscale x 2 x i32> poison, i32 [[TMP11]], i64 0
; CHECK-NEXT:    [[DOTSPLAT2:%.*]] = shufflevector <vscale x 2 x i32> [[DOTSPLATINSERT1]], <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <vscale x 2 x i32> [ [[INDUCTION]], [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = add i32 [[IDX]], [[INDEX]]
; CHECK-NEXT:    [[TMP12:%.*]] = add i32 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr i64, ptr [[A:%.*]], <vscale x 2 x i32> [[VEC_IND]]
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <vscale x 2 x ptr> [[TMP13]], i32 0
; CHECK-NEXT:    [[TMP15:%.*]] = getelementptr double, ptr [[TMP14]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 2 x double>, ptr [[TMP15]], align 8
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr i64, ptr [[B:%.*]], i32 [[TMP12]]
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr double, ptr [[TMP16]], i32 0
; CHECK-NEXT:    store <vscale x 2 x double> [[WIDE_LOAD]], ptr [[TMP17]], align 8
; CHECK-NEXT:    [[TMP18:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP19:%.*]] = mul i32 [[TMP18]], 2
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], [[TMP19]]
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <vscale x 2 x i32> [[VEC_IND]], [[DOTSPLAT2]]
; CHECK-NEXT:    [[TMP20:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP20]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP21:%.*]] = call i32 @llvm.vscale.i32()
; CHECK-NEXT:    [[TMP22:%.*]] = mul i32 [[TMP21]], 2
; CHECK-NEXT:    [[TMP23:%.*]] = sub i32 [[TMP22]], 1
; CHECK-NEXT:    [[TMP24:%.*]] = extractelement <vscale x 2 x ptr> [[TMP13]], i32 [[TMP23]]
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[TMP1]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[L_EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[IDX]], [[L_ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[L_LOOPBODY:%.*]]
; CHECK:       L.LoopBody:
; CHECK-NEXT:    [[INDVAR:%.*]] = phi i32 [ [[INDVAR_NEXT:%.*]], [[L_LOOPBODY]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[INDVAR_NEXT]] = add nsw i32 [[INDVAR]], 1
; CHECK-NEXT:    [[TMP25:%.*]] = getelementptr i64, ptr [[A]], i32 [[INDVAR]]
; CHECK-NEXT:    [[TMP26:%.*]] = load double, ptr [[TMP25]], align 8
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr i64, ptr [[B]], i32 [[INDVAR]]
; CHECK-NEXT:    store double [[TMP26]], ptr [[GEP_B]], align 8
; CHECK-NEXT:    [[TMP27:%.*]] = icmp slt i32 [[INDVAR_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[TMP27]], label [[L_LOOPBODY]], label [[L_EXIT]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       L.exit:
; CHECK-NEXT:    [[DOTLCSSA:%.*]] = phi ptr [ [[TMP25]], [[L_LOOPBODY]] ], [ [[TMP24]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    store i64 1, ptr [[DOTLCSSA]], align 8
; CHECK-NEXT:    ret void
;
L.entry:
  br label %L.LoopBody

L.LoopBody:                                       ; preds = %L.LoopBody, %L.entry
  %indvar = phi i32 [ %indvar.next, %L.LoopBody ], [ %idx, %L.entry ]
  %indvar.next = add nsw i32 %indvar, 1
  %0 = getelementptr i64, ptr %a, i32 %indvar
  %1 = load double, ptr %0, align 8
  %gep.b = getelementptr i64, ptr %b, i32 %indvar
  store double %1, ptr %gep.b
  %2 = icmp slt i32 %indvar.next, %n
  br i1 %2, label %L.LoopBody, label %L.exit

L.exit:                                       ; preds = %L.LoopBody
  store i64 1, ptr %0, align 8
  ret void
}

attributes #0 = { nofree norecurse noreturn nosync nounwind "target-features"="+sve" }

