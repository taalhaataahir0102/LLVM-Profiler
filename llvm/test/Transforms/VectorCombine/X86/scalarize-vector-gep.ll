; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=vector-combine -S -mtriple=x86_64-- -mattr=SSE2 | FileCheck %s --check-prefixes=CHECK
; RUN: opt < %s -passes=vector-combine -S -mtriple=x86_64-- -mattr=AVX2 | FileCheck %s --check-prefixes=CHECK

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

declare void @use(ptr)

;-------------------------------------------------------------------------------

define void @both_operands_need_extraction.2elts(<2 x ptr> %baseptrs, <2 x i64> %indices) {
; CHECK-LABEL: @both_operands_need_extraction.2elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <2 x ptr> [[BASEPTRS:%.*]], <2 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, <2 x ptr> %baseptrs, <2 x i64> %indices

  %ptr.0 = extractelement <2 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <2 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  ret void
}

define void @both_operands_need_extraction.3elts(<3 x ptr> %baseptrs, <3 x i64> %indices) {
; CHECK-LABEL: @both_operands_need_extraction.3elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS:%.*]], <3 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs, <3 x i64> %indices

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @both_operands_need_extraction.4elts(<4 x ptr> %baseptrs, <4 x i64> %indices) {
; CHECK-LABEL: @both_operands_need_extraction.4elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <4 x ptr> [[BASEPTRS:%.*]], <4 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    [[PTR_3:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 3
; CHECK-NEXT:    call void @use(ptr [[PTR_3]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, <4 x ptr> %baseptrs, <4 x i64> %indices

  %ptr.0 = extractelement <4 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <4 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <4 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  %ptr.3 = extractelement <4 x ptr> %ptrs, i64 3
  call void @use(ptr %ptr.3)

  ret void
}

;-------------------------------------------------------------------------------

define void @indicies_need_extraction.2elts(ptr %baseptr, <2 x i64> %indices) {
; CHECK-LABEL: @indicies_need_extraction.2elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, ptr [[BASEPTR:%.*]], <2 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, ptr %baseptr, <2 x i64> %indices

  %ptr.0 = extractelement <2 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <2 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  ret void
}

define void @indicies_need_extraction.3elts(ptr %baseptr, <3 x i64> %indices) {
; CHECK-LABEL: @indicies_need_extraction.3elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, ptr [[BASEPTR:%.*]], <3 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, ptr %baseptr, <3 x i64> %indices

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @indicies_need_extraction.4elts(ptr %baseptr, <4 x i64> %indices) {
; CHECK-LABEL: @indicies_need_extraction.4elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, ptr [[BASEPTR:%.*]], <4 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    [[PTR_3:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 3
; CHECK-NEXT:    call void @use(ptr [[PTR_3]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, ptr %baseptr, <4 x i64> %indices

  %ptr.0 = extractelement <4 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <4 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <4 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  %ptr.3 = extractelement <4 x ptr> %ptrs, i64 3
  call void @use(ptr %ptr.3)

  ret void
}

;-------------------------------------------------------------------------------

define void @baseptrs_need_extraction.2elts(<2 x ptr> %baseptrs, i64 %indice) {
; CHECK-LABEL: @baseptrs_need_extraction.2elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <2 x ptr> [[BASEPTRS:%.*]], i64 [[INDICE:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, <2 x ptr> %baseptrs, i64 %indice

  %ptr.0 = extractelement <2 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <2 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  ret void
}

define void @baseptrs_need_extraction.3elts(<3 x ptr> %baseptrs, i64 %indice) {
; CHECK-LABEL: @baseptrs_need_extraction.3elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS:%.*]], i64 [[INDICE:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs, i64 %indice

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @baseptrs_need_extraction.4elts(<4 x ptr> %baseptrs, i64 %indice) {
; CHECK-LABEL: @baseptrs_need_extraction.4elts(
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <4 x ptr> [[BASEPTRS:%.*]], i64 [[INDICE:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    [[PTR_3:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 3
; CHECK-NEXT:    call void @use(ptr [[PTR_3]])
; CHECK-NEXT:    ret void
;
  %ptrs = getelementptr inbounds i64, <4 x ptr> %baseptrs, i64 %indice

  %ptr.0 = extractelement <4 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <4 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <4 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  %ptr.3 = extractelement <4 x ptr> %ptrs, i64 3
  call void @use(ptr %ptr.3)

  ret void
}

;-------------------------------------------------------------------------------

define void @first_baseptr_is_known.2elts(<2 x ptr> %baseptrs, ptr %second_baseptr, <2 x i64> %indices) {
; CHECK-LABEL: @first_baseptr_is_known.2elts(
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <2 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <2 x ptr> [[BASEPTRS_NEW]], <2 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new = insertelement <2 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %ptrs = getelementptr inbounds i64, <2 x ptr> %baseptrs.new, <2 x i64> %indices

  %ptr.0 = extractelement <2 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <2 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  ret void
}

define void @first_indice_is_known.2elts(<2 x ptr> %baseptrs, <2 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_indice_is_known.2elts(
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <2 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <2 x ptr> [[BASEPTRS:%.*]], <2 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    ret void
;
  %indices.new = insertelement <2 x i64> %indices, i64 %second_indice, i64 0
  %ptrs = getelementptr inbounds i64, <2 x ptr> %baseptrs, <2 x i64> %indices.new

  %ptr.0 = extractelement <2 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <2 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  ret void
}

define void @first_indice_and_baseptr_are_known.2elts(<2 x ptr> %baseptrs, ptr %second_baseptr, <2 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_indice_and_baseptr_are_known.2elts(
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <2 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <2 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <2 x ptr> [[BASEPTRS_NEW]], <2 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new = insertelement <2 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %indices.new = insertelement <2 x i64> %indices, i64 %second_indice, i64 0
  %ptrs = getelementptr inbounds i64, <2 x ptr> %baseptrs.new, <2 x i64> %indices.new

  %ptr.0 = extractelement <2 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <2 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  ret void
}

;-------------------------------------------------------------------------------

define void @first_baseptr_is_known.3elts(<3 x ptr> %baseptrs, ptr %second_baseptr, <3 x i64> %indices) {
; CHECK-LABEL: @first_baseptr_is_known.3elts(
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <3 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS_NEW]], <3 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new = insertelement <3 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs.new, <3 x i64> %indices

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @first_indice_is_known.3elts(<3 x ptr> %baseptrs, <3 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_indice_is_known.3elts(
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <3 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS:%.*]], <3 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %indices.new = insertelement <3 x i64> %indices, i64 %second_indice, i64 0
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs, <3 x i64> %indices.new

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @first_indice_and_baseptr_are_known.3elts(<3 x ptr> %baseptrs, ptr %second_baseptr, <3 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_indice_and_baseptr_are_known.3elts(
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <3 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <3 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS_NEW]], <3 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new = insertelement <3 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %indices.new = insertelement <3 x i64> %indices, i64 %second_indice, i64 0
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs.new, <3 x i64> %indices.new

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

;-------------------------------------------------------------------------------

define void @first_two_baseptrs_is_known.3elts(<3 x ptr> %baseptrs, ptr %second_baseptr, ptr %third_baseptr, <3 x i64> %indices) {
; CHECK-LABEL: @first_two_baseptrs_is_known.3elts(
; CHECK-NEXT:    [[BASEPTRS_NEW_TMP:%.*]] = insertelement <3 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <3 x ptr> [[BASEPTRS_NEW_TMP]], ptr [[THIRD_BASEPTR:%.*]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS_NEW]], <3 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new.tmp = insertelement <3 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %baseptrs.new = insertelement <3 x ptr> %baseptrs.new.tmp, ptr %third_baseptr, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs.new, <3 x i64> %indices

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @first_two_indices_is_known.3elts(<3 x ptr> %baseptrs, <3 x i64> %indices, i64 %second_indice, i64 %third_indice) {
; CHECK-LABEL: @first_two_indices_is_known.3elts(
; CHECK-NEXT:    [[INDICES_NEW_TMP:%.*]] = insertelement <3 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <3 x i64> [[INDICES_NEW_TMP]], i64 [[THIRD_INDICE:%.*]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS:%.*]], <3 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %indices.new.tmp = insertelement <3 x i64> %indices, i64 %second_indice, i64 0
  %indices.new = insertelement <3 x i64> %indices.new.tmp, i64 %third_indice, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs, <3 x i64> %indices.new

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @first_two_indices_and_first_two_baseptrs_are_known.3elts(<3 x ptr> %baseptrs, ptr %second_baseptr, ptr %third_baseptr, <3 x i64> %indices, i64 %second_indice, i64 %third_indice) {
; CHECK-LABEL: @first_two_indices_and_first_two_baseptrs_are_known.3elts(
; CHECK-NEXT:    [[BASEPTRS_NEW_TMP:%.*]] = insertelement <3 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <3 x ptr> [[BASEPTRS_NEW_TMP]], ptr [[THIRD_BASEPTR:%.*]], i64 1
; CHECK-NEXT:    [[INDICES_NEW_TMP:%.*]] = insertelement <3 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <3 x i64> [[INDICES_NEW_TMP]], i64 [[THIRD_INDICE:%.*]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS_NEW]], <3 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new.tmp = insertelement <3 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %baseptrs.new = insertelement <3 x ptr> %baseptrs.new.tmp, ptr %third_baseptr, i64 1
  %indices.new.tmp = insertelement <3 x i64> %indices, i64 %second_indice, i64 0
  %indices.new = insertelement <3 x i64> %indices.new.tmp, i64 %third_indice, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs.new, <3 x i64> %indices.new

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

;-------------------------------------------------------------------------------

define void @first_two_baseptrs_is_knownequal.3elts(<3 x ptr> %baseptrs, ptr %second_baseptr, <3 x i64> %indices) {
; CHECK-LABEL: @first_two_baseptrs_is_knownequal.3elts(
; CHECK-NEXT:    [[BASEPTRS_NEW_TMP:%.*]] = insertelement <3 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <3 x ptr> [[BASEPTRS_NEW_TMP]], ptr [[SECOND_BASEPTR]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS_NEW]], <3 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new.tmp = insertelement <3 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %baseptrs.new = insertelement <3 x ptr> %baseptrs.new.tmp, ptr %second_baseptr, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs.new, <3 x i64> %indices

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @first_two_indices_is_knownequal.3elts(<3 x ptr> %baseptrs, <3 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_two_indices_is_knownequal.3elts(
; CHECK-NEXT:    [[INDICES_NEW_TMP:%.*]] = insertelement <3 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <3 x i64> [[INDICES_NEW_TMP]], i64 [[SECOND_INDICE]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS:%.*]], <3 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %indices.new.tmp = insertelement <3 x i64> %indices, i64 %second_indice, i64 0
  %indices.new = insertelement <3 x i64> %indices.new.tmp, i64 %second_indice, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs, <3 x i64> %indices.new

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @first_two_indices_and_first_two_baseptrs_are_knownequal.3elts(<3 x ptr> %baseptrs, ptr %second_baseptr, <3 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_two_indices_and_first_two_baseptrs_are_knownequal.3elts(
; CHECK-NEXT:    [[BASEPTRS_NEW_TMP:%.*]] = insertelement <3 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <3 x ptr> [[BASEPTRS_NEW_TMP]], ptr [[SECOND_BASEPTR]], i64 1
; CHECK-NEXT:    [[INDICES_NEW_TMP:%.*]] = insertelement <3 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <3 x i64> [[INDICES_NEW_TMP]], i64 [[SECOND_INDICE]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS_NEW]], <3 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new.tmp = insertelement <3 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %baseptrs.new = insertelement <3 x ptr> %baseptrs.new.tmp, ptr %second_baseptr, i64 1
  %indices.new.tmp = insertelement <3 x i64> %indices, i64 %second_indice, i64 0
  %indices.new = insertelement <3 x i64> %indices.new.tmp, i64 %second_indice, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs.new, <3 x i64> %indices.new

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

;-------------------------------------------------------------------------------

define void @first_baseptr_is_known.4elts(<4 x ptr> %baseptrs, ptr %second_baseptr, <4 x i64> %indices) {
; CHECK-LABEL: @first_baseptr_is_known.4elts(
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <4 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <4 x ptr> [[BASEPTRS_NEW]], <4 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    [[PTR_3:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 3
; CHECK-NEXT:    call void @use(ptr [[PTR_3]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new = insertelement <4 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %ptrs = getelementptr inbounds i64, <4 x ptr> %baseptrs.new, <4 x i64> %indices

  %ptr.0 = extractelement <4 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <4 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <4 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  %ptr.3 = extractelement <4 x ptr> %ptrs, i64 3
  call void @use(ptr %ptr.3)

  ret void
}

define void @first_indice_is_known.4elts(<4 x ptr> %baseptrs, <4 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_indice_is_known.4elts(
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <4 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <4 x ptr> [[BASEPTRS:%.*]], <4 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    [[PTR_3:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 3
; CHECK-NEXT:    call void @use(ptr [[PTR_3]])
; CHECK-NEXT:    ret void
;
  %indices.new = insertelement <4 x i64> %indices, i64 %second_indice, i64 0
  %ptrs = getelementptr inbounds i64, <4 x ptr> %baseptrs, <4 x i64> %indices.new

  %ptr.0 = extractelement <4 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <4 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <4 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  %ptr.3 = extractelement <4 x ptr> %ptrs, i64 3
  call void @use(ptr %ptr.3)

  ret void
}

define void @first_indice_and_first_baseptr_are_known.4elts(<4 x ptr> %baseptrs, ptr %second_baseptr, <4 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_indice_and_first_baseptr_are_known.4elts(
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <4 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <4 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <4 x ptr> [[BASEPTRS_NEW]], <4 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    [[PTR_3:%.*]] = extractelement <4 x ptr> [[PTRS]], i64 3
; CHECK-NEXT:    call void @use(ptr [[PTR_3]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new = insertelement <4 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %indices.new = insertelement <4 x i64> %indices, i64 %second_indice, i64 0
  %ptrs = getelementptr inbounds i64, <4 x ptr> %baseptrs.new, <4 x i64> %indices.new

  %ptr.0 = extractelement <4 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <4 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <4 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  %ptr.3 = extractelement <4 x ptr> %ptrs, i64 3
  call void @use(ptr %ptr.3)

  ret void
}

;-------------------------------------------------------------------------------

define void @first_two_baseptrs_is_knownequal.4elts(<3 x ptr> %baseptrs, ptr %second_baseptr, <3 x i64> %indices) {
; CHECK-LABEL: @first_two_baseptrs_is_knownequal.4elts(
; CHECK-NEXT:    [[BASEPTRS_NEW_TMP:%.*]] = insertelement <3 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <3 x ptr> [[BASEPTRS_NEW_TMP]], ptr [[SECOND_BASEPTR]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS_NEW]], <3 x i64> [[INDICES:%.*]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new.tmp = insertelement <3 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %baseptrs.new = insertelement <3 x ptr> %baseptrs.new.tmp, ptr %second_baseptr, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs.new, <3 x i64> %indices

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @first_two_indices_is_knownequal.4elts(<3 x ptr> %baseptrs, <3 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_two_indices_is_knownequal.4elts(
; CHECK-NEXT:    [[INDICES_NEW_TMP:%.*]] = insertelement <3 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <3 x i64> [[INDICES_NEW_TMP]], i64 [[SECOND_INDICE]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS:%.*]], <3 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %indices.new.tmp = insertelement <3 x i64> %indices, i64 %second_indice, i64 0
  %indices.new = insertelement <3 x i64> %indices.new.tmp, i64 %second_indice, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs, <3 x i64> %indices.new

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

define void @first_two_indices_and_first_two_baseptrs_are_knownequal.4elts(<3 x ptr> %baseptrs, ptr %second_baseptr, <3 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_two_indices_and_first_two_baseptrs_are_knownequal.4elts(
; CHECK-NEXT:    [[BASEPTRS_NEW_TMP:%.*]] = insertelement <3 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <3 x ptr> [[BASEPTRS_NEW_TMP]], ptr [[SECOND_BASEPTR]], i64 1
; CHECK-NEXT:    [[INDICES_NEW_TMP:%.*]] = insertelement <3 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <3 x i64> [[INDICES_NEW_TMP]], i64 [[SECOND_INDICE]], i64 1
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <3 x ptr> [[BASEPTRS_NEW]], <3 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_2:%.*]] = extractelement <3 x ptr> [[PTRS]], i64 2
; CHECK-NEXT:    call void @use(ptr [[PTR_2]])
; CHECK-NEXT:    ret void
;
  %baseptrs.new.tmp = insertelement <3 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %baseptrs.new = insertelement <3 x ptr> %baseptrs.new.tmp, ptr %second_baseptr, i64 1
  %indices.new.tmp = insertelement <3 x i64> %indices, i64 %second_indice, i64 0
  %indices.new = insertelement <3 x i64> %indices.new.tmp, i64 %second_indice, i64 1
  %ptrs = getelementptr inbounds i64, <3 x ptr> %baseptrs.new, <3 x i64> %indices.new

  %ptr.0 = extractelement <3 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <3 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.2 = extractelement <3 x ptr> %ptrs, i64 2
  call void @use(ptr %ptr.2)

  ret void
}

;===============================================================================

define <2 x ptr> @first_indice_and_baseptr_need_extraction.2elts.extrause(<2 x ptr> %baseptrs, ptr %second_baseptr, <2 x i64> %indices, i64 %second_indice) {
; CHECK-LABEL: @first_indice_and_baseptr_need_extraction.2elts.extrause(
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <2 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <2 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <2 x ptr> [[BASEPTRS_NEW]], <2 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    ret <2 x ptr> [[PTRS]]
;
  %baseptrs.new = insertelement <2 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %indices.new = insertelement <2 x i64> %indices, i64 %second_indice, i64 0
  %ptrs = getelementptr inbounds i64, <2 x ptr> %baseptrs.new, <2 x i64> %indices.new

  %ptr.0 = extractelement <2 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <2 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  ret <2 x ptr> %ptrs
}

define ptr @first_indice_and_baseptr_need_extraction.2elts.variable_extraction(<2 x ptr> %baseptrs, ptr %second_baseptr, <2 x i64> %indices, i64 %second_indice, i64 %variable_extract_idx) {
; CHECK-LABEL: @first_indice_and_baseptr_need_extraction.2elts.variable_extraction(
; CHECK-NEXT:    [[BASEPTRS_NEW:%.*]] = insertelement <2 x ptr> [[BASEPTRS:%.*]], ptr [[SECOND_BASEPTR:%.*]], i64 0
; CHECK-NEXT:    [[INDICES_NEW:%.*]] = insertelement <2 x i64> [[INDICES:%.*]], i64 [[SECOND_INDICE:%.*]], i64 0
; CHECK-NEXT:    [[PTRS:%.*]] = getelementptr inbounds i64, <2 x ptr> [[BASEPTRS_NEW]], <2 x i64> [[INDICES_NEW]]
; CHECK-NEXT:    [[PTR_0:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 0
; CHECK-NEXT:    call void @use(ptr [[PTR_0]])
; CHECK-NEXT:    [[PTR_1:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 1
; CHECK-NEXT:    call void @use(ptr [[PTR_1]])
; CHECK-NEXT:    [[PTR_VAR:%.*]] = extractelement <2 x ptr> [[PTRS]], i64 [[VARIABLE_EXTRACT_IDX:%.*]]
; CHECK-NEXT:    ret ptr [[PTR_VAR]]
;
  %baseptrs.new = insertelement <2 x ptr> %baseptrs, ptr %second_baseptr, i64 0
  %indices.new = insertelement <2 x i64> %indices, i64 %second_indice, i64 0
  %ptrs = getelementptr inbounds i64, <2 x ptr> %baseptrs.new, <2 x i64> %indices.new

  %ptr.0 = extractelement <2 x ptr> %ptrs, i64 0
  call void @use(ptr %ptr.0)

  %ptr.1 = extractelement <2 x ptr> %ptrs, i64 1
  call void @use(ptr %ptr.1)

  %ptr.var = extractelement <2 x ptr> %ptrs, i64 %variable_extract_idx

  ret ptr %ptr.var
}
