; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=vector-combine -S -mtriple=x86_64-- -mattr=SSE2 | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: opt < %s -passes=vector-combine -S -mtriple=x86_64-- -mattr=AVX2 | FileCheck %s --check-prefixes=CHECK,AVX

declare void @use_i8(i8)
declare void @use_f32(float)

; Eliminating extract is profitable.

define i8 @ext0_ext0_add(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext0_ext0_add(
; CHECK-NEXT:    [[TMP1:%.*]] = add <16 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <16 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = add i8 %e0, %e1
  ret i8 %r
}

; Eliminating extract is still profitable. Flags propagate.

define i8 @ext1_ext1_add_flags(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_add_flags(
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw nsw <16 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <16 x i8> [[TMP1]], i32 1
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 1
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = add nsw nuw i8 %e0, %e1
  ret i8 %r
}

; Negative test - eliminating extract is profitable, but vector shift is expensive.

define i8 @ext1_ext1_shl(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_shl(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 1
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[R:%.*]] = shl i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 1
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = shl i8 %e0, %e1
  ret i8 %r
}

; Negative test - eliminating extract is profitable, but vector multiply is expensive.

define i8 @ext13_ext13_mul(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: @ext13_ext13_mul(
; SSE-NEXT:    [[TMP1:%.*]] = mul <16 x i8> [[X:%.*]], [[Y:%.*]]
; SSE-NEXT:    [[R:%.*]] = extractelement <16 x i8> [[TMP1]], i32 13
; SSE-NEXT:    ret i8 [[R]]
;
; AVX-LABEL: @ext13_ext13_mul(
; AVX-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 13
; AVX-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 13
; AVX-NEXT:    [[R:%.*]] = mul i8 [[E0]], [[E1]]
; AVX-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 13
  %e1 = extractelement <16 x i8> %y, i32 13
  %r = mul i8 %e0, %e1
  ret i8 %r
}

; Negative test - cost is irrelevant because sdiv has potential UB.

define i8 @ext0_ext0_sdiv(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext0_ext0_sdiv(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 0
; CHECK-NEXT:    [[R:%.*]] = sdiv i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = sdiv i8 %e0, %e1
  ret i8 %r
}

; Extracts are free and vector op has same cost as scalar, but we
; speculatively transform to vector to create more optimization
; opportunities..

define double @ext0_ext0_fadd(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: @ext0_ext0_fadd(
; CHECK-NEXT:    [[TMP1:%.*]] = fadd <2 x double> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <2 x double> [[TMP1]], i32 0
; CHECK-NEXT:    ret double [[R]]
;
  %e0 = extractelement <2 x double> %x, i32 0
  %e1 = extractelement <2 x double> %y, i32 0
  %r = fadd double %e0, %e1
  ret double %r
}

; Eliminating extract is profitable. Flags propagate.

define double @ext1_ext1_fsub(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: @ext1_ext1_fsub(
; CHECK-NEXT:    [[TMP1:%.*]] = fsub fast <2 x double> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <2 x double> [[TMP1]], i32 1
; CHECK-NEXT:    ret double [[R]]
;
  %e0 = extractelement <2 x double> %x, i32 1
  %e1 = extractelement <2 x double> %y, i32 1
  %r = fsub fast double %e0, %e1
  ret double %r
}

; Negative test - type mismatch.

define double @ext1_ext1_fadd_different_types(<2 x double> %x, <4 x double> %y) {
; CHECK-LABEL: @ext1_ext1_fadd_different_types(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <2 x double> [[X:%.*]], i32 1
; CHECK-NEXT:    [[E1:%.*]] = extractelement <4 x double> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[R:%.*]] = fadd fast double [[E0]], [[E1]]
; CHECK-NEXT:    ret double [[R]]
;
  %e0 = extractelement <2 x double> %x, i32 1
  %e1 = extractelement <4 x double> %y, i32 1
  %r = fadd fast double %e0, %e1
  ret double %r
}

; Disguised same vector operand; scalar code is not cheaper (with default
; x86 target), so aggressively form vector binop.

define i32 @ext1_ext1_add_same_vec(<4 x i32> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = add <4 x i32> [[X:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <4 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    ret i32 [[R]]
;
  %e0 = extractelement <4 x i32> %x, i32 1
  %e1 = extractelement <4 x i32> %x, i32 1
  %r = add i32 %e0, %e1
  ret i32 %r
}

; Functionally equivalent to above test; should transform as above.

define i32 @ext1_ext1_add_same_vec_cse(<4 x i32> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_cse(
; CHECK-NEXT:    [[TMP1:%.*]] = add <4 x i32> [[X:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <4 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    ret i32 [[R]]
;
  %e0 = extractelement <4 x i32> %x, i32 1
  %r = add i32 %e0, %e0
  ret i32 %r
}

; Don't assert if extract indices have different types.

define i32 @ext1_ext1_add_same_vec_diff_idx_ty(<4 x i32> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_diff_idx_ty(
; CHECK-NEXT:    [[TMP1:%.*]] = add <4 x i32> [[X:%.*]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <4 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    ret i32 [[R]]
;
  %e0 = extractelement <4 x i32> %x, i32 1
  %e1 = extractelement <4 x i32> %x, i64 1
  %r = add i32 %e0, %e1
  ret i32 %r
}

; Negative test - same vector operand; scalar code is cheaper than general case
;                 and vector code would be more expensive still.

define i8 @ext1_ext1_add_same_vec_extra_use0(<16 x i8> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_extra_use0(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E0]])
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[X]], i32 0
; CHECK-NEXT:    [[R:%.*]] = add i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  call void @use_i8(i8 %e0)
  %e1 = extractelement <16 x i8> %x, i32 0
  %r = add i8 %e0, %e1
  ret i8 %r
}

; Negative test - same vector operand; scalar code is cheaper than general case
;                 and vector code would be more expensive still.

define i8 @ext1_ext1_add_same_vec_extra_use1(<16 x i8> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_extra_use1(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[X]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E1]])
; CHECK-NEXT:    [[R:%.*]] = add i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %x, i32 0
  call void @use_i8(i8 %e1)
  %r = add i8 %e0, %e1
  ret i8 %r
}

; Negative test - same vector operand; scalar code is cheaper than general case
;                 and vector code would be more expensive still.

define i8 @ext1_ext1_add_same_vec_cse_extra_use(<16 x i8> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_cse_extra_use(
; CHECK-NEXT:    [[E:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E]])
; CHECK-NEXT:    [[R:%.*]] = add i8 [[E]], [[E]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e = extractelement <16 x i8> %x, i32 0
  call void @use_i8(i8 %e)
  %r = add i8 %e, %e
  ret i8 %r
}

; Vector code costs the same as scalar, so aggressively form vector op.

define i8 @ext1_ext1_add_uses1(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_add_uses1(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E0]])
; CHECK-NEXT:    [[TMP1:%.*]] = add <16 x i8> [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <16 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  call void @use_i8(i8 %e0)
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = add i8 %e0, %e1
  ret i8 %r
}

; Vector code costs the same as scalar, so aggressively form vector op.

define i8 @ext1_ext1_add_uses2(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_add_uses2(
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E1]])
; CHECK-NEXT:    [[TMP1:%.*]] = add <16 x i8> [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <16 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 0
  call void @use_i8(i8 %e1)
  %r = add i8 %e0, %e1
  ret i8 %r
}

define i8 @ext0_ext1_add(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: @ext0_ext1_add(
; SSE-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; SSE-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 1
; SSE-NEXT:    [[R:%.*]] = add nuw i8 [[E0]], [[E1]]
; SSE-NEXT:    ret i8 [[R]]
;
; AVX-LABEL: @ext0_ext1_add(
; AVX-NEXT:    [[SHIFT:%.*]] = shufflevector <16 x i8> [[Y:%.*]], <16 x i8> poison, <16 x i32> <i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; AVX-NEXT:    [[TMP1:%.*]] = add nuw <16 x i8> [[X:%.*]], [[SHIFT]]
; AVX-NEXT:    [[R:%.*]] = extractelement <16 x i8> [[TMP1]], i32 0
; AVX-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = add nuw i8 %e0, %e1
  ret i8 %r
}

define i8 @ext5_ext0_add(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: @ext5_ext0_add(
; SSE-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 5
; SSE-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 0
; SSE-NEXT:    [[R:%.*]] = sub nsw i8 [[E0]], [[E1]]
; SSE-NEXT:    ret i8 [[R]]
;
; AVX-LABEL: @ext5_ext0_add(
; AVX-NEXT:    [[SHIFT:%.*]] = shufflevector <16 x i8> [[X:%.*]], <16 x i8> poison, <16 x i32> <i32 5, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; AVX-NEXT:    [[TMP1:%.*]] = sub nsw <16 x i8> [[SHIFT]], [[Y:%.*]]
; AVX-NEXT:    [[R:%.*]] = extractelement <16 x i8> [[TMP1]], i64 0
; AVX-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 5
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = sub nsw i8 %e0, %e1
  ret i8 %r
}

define i8 @ext1_ext6_add(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: @ext1_ext6_add(
; SSE-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 1
; SSE-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 6
; SSE-NEXT:    [[R:%.*]] = and i8 [[E0]], [[E1]]
; SSE-NEXT:    ret i8 [[R]]
;
; AVX-LABEL: @ext1_ext6_add(
; AVX-NEXT:    [[SHIFT:%.*]] = shufflevector <16 x i8> [[Y:%.*]], <16 x i8> poison, <16 x i32> <i32 poison, i32 6, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; AVX-NEXT:    [[TMP1:%.*]] = and <16 x i8> [[X:%.*]], [[SHIFT]]
; AVX-NEXT:    [[R:%.*]] = extractelement <16 x i8> [[TMP1]], i32 1
; AVX-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 1
  %e1 = extractelement <16 x i8> %y, i32 6
  %r = and i8 %e0, %e1
  ret i8 %r
}

define float @ext1_ext0_fmul(<4 x float> %x) {
; CHECK-LABEL: @ext1_ext0_fmul(
; CHECK-NEXT:    [[SHIFT:%.*]] = shufflevector <4 x float> [[X:%.*]], <4 x float> poison, <4 x i32> <i32 1, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP1:%.*]] = fmul <4 x float> [[SHIFT]], [[X]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <4 x float> [[TMP1]], i64 0
; CHECK-NEXT:    ret float [[R]]
;
  %e0 = extractelement <4 x float> %x, i32 1
  %e1 = extractelement <4 x float> %x, i32 0
  %r = fmul float %e0, %e1
  ret float %r
}

define float @ext0_ext3_fmul_extra_use1(<4 x float> %x) {
; CHECK-LABEL: @ext0_ext3_fmul_extra_use1(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <4 x float> [[X:%.*]], i32 0
; CHECK-NEXT:    call void @use_f32(float [[E0]])
; CHECK-NEXT:    [[SHIFT:%.*]] = shufflevector <4 x float> [[X]], <4 x float> poison, <4 x i32> <i32 3, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP1:%.*]] = fmul nnan <4 x float> [[X]], [[SHIFT]]
; CHECK-NEXT:    [[R:%.*]] = extractelement <4 x float> [[TMP1]], i32 0
; CHECK-NEXT:    ret float [[R]]
;
  %e0 = extractelement <4 x float> %x, i32 0
  call void @use_f32(float %e0)
  %e1 = extractelement <4 x float> %x, i32 3
  %r = fmul nnan float %e0, %e1
  ret float %r
}

define float @ext0_ext3_fmul_extra_use2(<4 x float> %x) {
; CHECK-LABEL: @ext0_ext3_fmul_extra_use2(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <4 x float> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <4 x float> [[X]], i32 3
; CHECK-NEXT:    call void @use_f32(float [[E1]])
; CHECK-NEXT:    [[R:%.*]] = fmul ninf nsz float [[E0]], [[E1]]
; CHECK-NEXT:    ret float [[R]]
;
  %e0 = extractelement <4 x float> %x, i32 0
  %e1 = extractelement <4 x float> %x, i32 3
  call void @use_f32(float %e1)
  %r = fmul ninf nsz float %e0, %e1
  ret float %r
}

define float @ext0_ext4_fmul_v8f32(<8 x float> %x) {
; SSE-LABEL: @ext0_ext4_fmul_v8f32(
; SSE-NEXT:    [[E0:%.*]] = extractelement <8 x float> [[X:%.*]], i32 0
; SSE-NEXT:    [[E1:%.*]] = extractelement <8 x float> [[X]], i32 4
; SSE-NEXT:    [[R:%.*]] = fadd float [[E0]], [[E1]]
; SSE-NEXT:    ret float [[R]]
;
; AVX-LABEL: @ext0_ext4_fmul_v8f32(
; AVX-NEXT:    [[SHIFT:%.*]] = shufflevector <8 x float> [[X:%.*]], <8 x float> poison, <8 x i32> <i32 4, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; AVX-NEXT:    [[TMP1:%.*]] = fadd <8 x float> [[X]], [[SHIFT]]
; AVX-NEXT:    [[R:%.*]] = extractelement <8 x float> [[TMP1]], i32 0
; AVX-NEXT:    ret float [[R]]
;
  %e0 = extractelement <8 x float> %x, i32 0
  %e1 = extractelement <8 x float> %x, i32 4
  %r = fadd float %e0, %e1
  ret float %r
}

define float @ext7_ext4_fmul_v8f32(<8 x float> %x) {
; SSE-LABEL: @ext7_ext4_fmul_v8f32(
; SSE-NEXT:    [[E0:%.*]] = extractelement <8 x float> [[X:%.*]], i32 7
; SSE-NEXT:    [[E1:%.*]] = extractelement <8 x float> [[X]], i32 4
; SSE-NEXT:    [[R:%.*]] = fadd float [[E0]], [[E1]]
; SSE-NEXT:    ret float [[R]]
;
; AVX-LABEL: @ext7_ext4_fmul_v8f32(
; AVX-NEXT:    [[SHIFT:%.*]] = shufflevector <8 x float> [[X:%.*]], <8 x float> poison, <8 x i32> <i32 poison, i32 poison, i32 poison, i32 poison, i32 7, i32 poison, i32 poison, i32 poison>
; AVX-NEXT:    [[TMP1:%.*]] = fadd <8 x float> [[SHIFT]], [[X]]
; AVX-NEXT:    [[R:%.*]] = extractelement <8 x float> [[TMP1]], i64 4
; AVX-NEXT:    ret float [[R]]
;
  %e0 = extractelement <8 x float> %x, i32 7
  %e1 = extractelement <8 x float> %x, i32 4
  %r = fadd float %e0, %e1
  ret float %r
}

define float @ext0_ext8_fmul_v16f32(<16 x float> %x) {
; CHECK-LABEL: @ext0_ext8_fmul_v16f32(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x float> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x float> [[X]], i32 8
; CHECK-NEXT:    [[R:%.*]] = fadd float [[E0]], [[E1]]
; CHECK-NEXT:    ret float [[R]]
;
  %e0 = extractelement <16 x float> %x, i32 0
  %e1 = extractelement <16 x float> %x, i32 8
  %r = fadd float %e0, %e1
  ret float %r
}

define float @ext14_ext15_fmul_v16f32(<16 x float> %x) {
; CHECK-LABEL: @ext14_ext15_fmul_v16f32(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x float> [[X:%.*]], i32 14
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x float> [[X]], i32 15
; CHECK-NEXT:    [[R:%.*]] = fadd float [[E0]], [[E1]]
; CHECK-NEXT:    ret float [[R]]
;
  %e0 = extractelement <16 x float> %x, i32 14
  %e1 = extractelement <16 x float> %x, i32 15
  %r = fadd float %e0, %e1
  ret float %r
}

define <4 x float> @ins_bo_ext_ext(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: @ins_bo_ext_ext(
; CHECK-NEXT:    [[SHIFT:%.*]] = shufflevector <4 x float> [[A:%.*]], <4 x float> poison, <4 x i32> <i32 poison, i32 poison, i32 poison, i32 2>
; CHECK-NEXT:    [[TMP1:%.*]] = fadd <4 x float> [[SHIFT]], [[A]]
; CHECK-NEXT:    [[A23:%.*]] = extractelement <4 x float> [[TMP1]], i64 3
; CHECK-NEXT:    [[V3:%.*]] = insertelement <4 x float> [[B:%.*]], float [[A23]], i32 3
; CHECK-NEXT:    ret <4 x float> [[V3]]
;
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %a23 = fadd float %a2, %a3
  %v3 = insertelement <4 x float> %b, float %a23, i32 3
  ret <4 x float> %v3
}

; TODO: This is conservatively left to extract from the lower index value,
;       but it is likely that extracting from index 3 is the better option.

define <4 x float> @ins_bo_ext_ext_uses(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: @ins_bo_ext_ext_uses(
; CHECK-NEXT:    [[SHIFT:%.*]] = shufflevector <4 x float> [[A:%.*]], <4 x float> poison, <4 x i32> <i32 poison, i32 poison, i32 3, i32 poison>
; CHECK-NEXT:    [[TMP1:%.*]] = fadd <4 x float> [[A]], [[SHIFT]]
; CHECK-NEXT:    [[A23:%.*]] = extractelement <4 x float> [[TMP1]], i32 2
; CHECK-NEXT:    call void @use_f32(float [[A23]])
; CHECK-NEXT:    [[V3:%.*]] = insertelement <4 x float> [[B:%.*]], float [[A23]], i32 3
; CHECK-NEXT:    ret <4 x float> [[V3]]
;
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %a23 = fadd float %a2, %a3
  call void @use_f32(float %a23)
  %v3 = insertelement <4 x float> %b, float %a23, i32 3
  ret <4 x float> %v3
}

define <4 x float> @PR34724(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: @PR34724(
; CHECK-NEXT:    [[A0:%.*]] = extractelement <4 x float> [[A:%.*]], i32 0
; CHECK-NEXT:    [[A1:%.*]] = extractelement <4 x float> [[A]], i32 1
; CHECK-NEXT:    [[SHIFT:%.*]] = shufflevector <4 x float> [[A]], <4 x float> poison, <4 x i32> <i32 poison, i32 poison, i32 3, i32 poison>
; CHECK-NEXT:    [[TMP1:%.*]] = fadd <4 x float> [[A]], [[SHIFT]]
; CHECK-NEXT:    [[A23:%.*]] = extractelement <4 x float> [[TMP1]], i32 2
; CHECK-NEXT:    [[SHIFT1:%.*]] = shufflevector <4 x float> [[B:%.*]], <4 x float> poison, <4 x i32> <i32 1, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP2:%.*]] = fadd <4 x float> [[B]], [[SHIFT1]]
; CHECK-NEXT:    [[B01:%.*]] = extractelement <4 x float> [[TMP2]], i32 0
; CHECK-NEXT:    [[SHIFT2:%.*]] = shufflevector <4 x float> [[B]], <4 x float> poison, <4 x i32> <i32 poison, i32 poison, i32 poison, i32 2>
; CHECK-NEXT:    [[TMP3:%.*]] = fadd <4 x float> [[SHIFT2]], [[B]]
; CHECK-NEXT:    [[B23:%.*]] = extractelement <4 x float> [[TMP3]], i64 3
; CHECK-NEXT:    [[V1:%.*]] = insertelement <4 x float> undef, float [[A23]], i32 1
; CHECK-NEXT:    [[V2:%.*]] = insertelement <4 x float> [[V1]], float [[B01]], i32 2
; CHECK-NEXT:    [[V3:%.*]] = insertelement <4 x float> [[V2]], float [[B23]], i32 3
; CHECK-NEXT:    ret <4 x float> [[V3]]
;
  %a0 = extractelement <4 x float> %a, i32 0
  %a1 = extractelement <4 x float> %a, i32 1
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3

  %b0 = extractelement <4 x float> %b, i32 0
  %b1 = extractelement <4 x float> %b, i32 1
  %b2 = extractelement <4 x float> %b, i32 2
  %b3 = extractelement <4 x float> %b, i32 3

  %a23 = fadd float %a2, %a3
  %b01 = fadd float %b0, %b1
  %b23 = fadd float %b2, %b3

  %v1 = insertelement <4 x float> undef, float %a23, i32 1
  %v2 = insertelement <4 x float> %v1, float %b01, i32 2
  %v3 = insertelement <4 x float> %v2, float %b23, i32 3
  ret <4 x float> %v3
}

define i32 @ext_ext_or_reduction_v4i32(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @ext_ext_or_reduction_v4i32(
; CHECK-NEXT:    [[Z:%.*]] = and <4 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SHIFT:%.*]] = shufflevector <4 x i32> [[Z]], <4 x i32> poison, <4 x i32> <i32 1, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP1:%.*]] = or <4 x i32> [[Z]], [[SHIFT]]
; CHECK-NEXT:    [[SHIFT1:%.*]] = shufflevector <4 x i32> [[Z]], <4 x i32> poison, <4 x i32> <i32 2, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP2:%.*]] = or <4 x i32> [[TMP1]], [[SHIFT1]]
; CHECK-NEXT:    [[SHIFT2:%.*]] = shufflevector <4 x i32> [[Z]], <4 x i32> poison, <4 x i32> <i32 3, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = or <4 x i32> [[SHIFT2]], [[TMP2]]
; CHECK-NEXT:    [[Z0123:%.*]] = extractelement <4 x i32> [[TMP3]], i64 0
; CHECK-NEXT:    ret i32 [[Z0123]]
;
  %z = and <4 x i32> %x, %y
  %z0 = extractelement <4 x i32> %z, i32 0
  %z1 = extractelement <4 x i32> %z, i32 1
  %z01 = or i32 %z0, %z1
  %z2 = extractelement <4 x i32> %z, i32 2
  %z012 = or i32 %z01, %z2
  %z3 = extractelement <4 x i32> %z, i32 3
  %z0123 = or i32 %z3, %z012
  ret i32 %z0123
}

define i32 @ext_ext_partial_add_reduction_v4i32(<4 x i32> %x) {
; CHECK-LABEL: @ext_ext_partial_add_reduction_v4i32(
; CHECK-NEXT:    [[SHIFT:%.*]] = shufflevector <4 x i32> [[X:%.*]], <4 x i32> poison, <4 x i32> <i32 1, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP1:%.*]] = add <4 x i32> [[SHIFT]], [[X]]
; CHECK-NEXT:    [[SHIFT1:%.*]] = shufflevector <4 x i32> [[X]], <4 x i32> poison, <4 x i32> <i32 2, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP2:%.*]] = add <4 x i32> [[SHIFT1]], [[TMP1]]
; CHECK-NEXT:    [[X210:%.*]] = extractelement <4 x i32> [[TMP2]], i64 0
; CHECK-NEXT:    ret i32 [[X210]]
;
  %x0 = extractelement <4 x i32> %x, i32 0
  %x1 = extractelement <4 x i32> %x, i32 1
  %x10 = add i32 %x1, %x0
  %x2 = extractelement <4 x i32> %x, i32 2
  %x210 = add i32 %x2, %x10
  ret i32 %x210
}

define i32 @ext_ext_partial_add_reduction_and_extra_add_v4i32(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @ext_ext_partial_add_reduction_and_extra_add_v4i32(
; CHECK-NEXT:    [[SHIFT:%.*]] = shufflevector <4 x i32> [[Y:%.*]], <4 x i32> poison, <4 x i32> <i32 1, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP1:%.*]] = add <4 x i32> [[SHIFT]], [[Y]]
; CHECK-NEXT:    [[SHIFT1:%.*]] = shufflevector <4 x i32> [[Y]], <4 x i32> poison, <4 x i32> <i32 2, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP2:%.*]] = add <4 x i32> [[SHIFT1]], [[TMP1]]
; CHECK-NEXT:    [[SHIFT2:%.*]] = shufflevector <4 x i32> [[X:%.*]], <4 x i32> poison, <4 x i32> <i32 2, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = add <4 x i32> [[SHIFT2]], [[TMP2]]
; CHECK-NEXT:    [[X2Y210:%.*]] = extractelement <4 x i32> [[TMP3]], i64 0
; CHECK-NEXT:    ret i32 [[X2Y210]]
;
  %y0 = extractelement <4 x i32> %y, i32 0
  %y1 = extractelement <4 x i32> %y, i32 1
  %y10 = add i32 %y1, %y0
  %y2 = extractelement <4 x i32> %y, i32 2
  %y210 = add i32 %y2, %y10
  %x2 = extractelement <4 x i32> %x, i32 2
  %x2y210 = add i32 %x2, %y210
  ret i32 %x2y210
}

define i32 @constant_fold_crash(<4 x i32> %x) {
; CHECK-LABEL: @constant_fold_crash(
; CHECK-NEXT:    [[A:%.*]] = extractelement <4 x i32> <i32 16, i32 17, i32 18, i32 19>, i32 1
; CHECK-NEXT:    [[B:%.*]] = extractelement <4 x i32> [[X:%.*]], i32 0
; CHECK-NEXT:    [[C:%.*]] = add i32 [[A]], [[B]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %a = extractelement <4 x i32> <i32 16, i32 17, i32 18, i32 19>, i32 1
  %b = extractelement <4 x i32> %x, i32 0
  %c = add i32 %a, %b
  ret i32 %c
}

define float @constant_fold_crash_commute(<4 x float> %x) {
; CHECK-LABEL: @constant_fold_crash_commute(
; CHECK-NEXT:    [[A:%.*]] = extractelement <4 x float> <float 1.600000e+01, float 1.700000e+01, float 1.800000e+01, float 1.900000e+01>, i32 3
; CHECK-NEXT:    [[B:%.*]] = extractelement <4 x float> [[X:%.*]], i32 1
; CHECK-NEXT:    [[C:%.*]] = fadd float [[B]], [[A]]
; CHECK-NEXT:    ret float [[C]]
;
  %a = extractelement <4 x float> <float 16.0, float 17.0, float 18.0, float 19.0>, i32 3
  %b = extractelement <4 x float> %x, i32 1
  %c = fadd float %b, %a
  ret float %c
}
