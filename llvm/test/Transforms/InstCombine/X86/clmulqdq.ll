; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -mtriple=x86_64-unknown-unknown -S | FileCheck %s

declare <2 x i64> @llvm.x86.pclmulqdq(<2 x i64>, <2 x i64>, i8)
declare <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64>, <4 x i64>, i8)
declare <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64>, <8 x i64>, i8)

define <2 x i64> @test_demanded_elts_pclmulqdq_0(<2 x i64> %a0, <2 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_0(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> [[A0:%.*]], <2 x i64> [[A1:%.*]], i8 0)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = insertelement <2 x i64> %a0, i64 1, i64 1
  %2 = insertelement <2 x i64> %a1, i64 1, i64 1
  %3 = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> %1, <2 x i64> %2, i8 0)
  ret <2 x i64> %3
}

define <2 x i64> @test_demanded_elts_pclmulqdq_1(<2 x i64> %a0, <2 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_1(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> <i64 poison, i64 1>, <2 x i64> [[A1:%.*]], i8 1)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = insertelement <2 x i64> %a0, i64 1, i64 1
  %2 = insertelement <2 x i64> %a1, i64 1, i64 1
  %3 = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> %1, <2 x i64> %2, i8 1)
  ret <2 x i64> %3
}

define <2 x i64> @test_demanded_elts_pclmulqdq_16(<2 x i64> %a0, <2 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_16(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> [[A0:%.*]], <2 x i64> <i64 poison, i64 1>, i8 16)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = insertelement <2 x i64> %a0, i64 1, i64 1
  %2 = insertelement <2 x i64> %a1, i64 1, i64 1
  %3 = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> %1, <2 x i64> %2, i8 16)
  ret <2 x i64> %3
}

define <2 x i64> @test_demanded_elts_pclmulqdq_17(<2 x i64> %a0, <2 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_17(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> <i64 poison, i64 1>, <2 x i64> <i64 poison, i64 1>, i8 17)
; CHECK-NEXT:    ret <2 x i64> [[TMP1]]
;
  %1 = insertelement <2 x i64> %a0, i64 1, i64 1
  %2 = insertelement <2 x i64> %a1, i64 1, i64 1
  %3 = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> %1, <2 x i64> %2, i8 17)
  ret <2 x i64> %3
}

define <2 x i64> @test_demanded_elts_pclmulqdq_undef_0() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_undef_0(
; CHECK-NEXT:    ret <2 x i64> zeroinitializer
;
  %1 = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> <i64 undef, i64 1>, <2 x i64> <i64 undef, i64 1>, i8 0)
  ret <2 x i64> %1
}

define <2 x i64> @test_demanded_elts_pclmulqdq_undef_1() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_undef_1(
; CHECK-NEXT:    ret <2 x i64> zeroinitializer
;
  %1 = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> <i64 1, i64 undef>, <2 x i64> <i64 undef, i64 1>, i8 1)
  ret <2 x i64> %1
}

define <2 x i64> @test_demanded_elts_pclmulqdq_undef_16() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_undef_16(
; CHECK-NEXT:    ret <2 x i64> zeroinitializer
;
  %1 = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> <i64 undef, i64 1>, <2 x i64> <i64 1, i64 undef>, i8 16)
  ret <2 x i64> %1
}

define <2 x i64> @test_demanded_elts_pclmulqdq_undef_17() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_undef_17(
; CHECK-NEXT:    ret <2 x i64> zeroinitializer
;
  %1 = call <2 x i64> @llvm.x86.pclmulqdq(<2 x i64> <i64 1, i64 undef>, <2 x i64> <i64 1, i64 undef>, i8 17)
  ret <2 x i64> %1
}

define <4 x i64> @test_demanded_elts_pclmulqdq_256_0(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_256_0(
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> [[A0:%.*]], <4 x i64> [[A1:%.*]], i8 0)
; CHECK-NEXT:    ret <4 x i64> [[RES]]
;
  %1 = insertelement <4 x i64> %a0, i64 1, i64 1
  %2 = insertelement <4 x i64> %a1, i64 1, i64 1
  %3 = insertelement <4 x i64> %1, i64 1, i64 3
  %4 = insertelement <4 x i64> %2, i64 1, i64 3
  %res = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %3, <4 x i64> %4, i8 0)
  ret <4 x i64> %res
}

define <4 x i64> @test_demanded_elts_pclmulqdq_256_1(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_256_1(
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> <i64 poison, i64 1, i64 poison, i64 1>, <4 x i64> [[A1:%.*]], i8 1)
; CHECK-NEXT:    ret <4 x i64> [[RES]]
;
  %1 = insertelement <4 x i64> %a0, i64 1, i64 1
  %2 = insertelement <4 x i64> %a1, i64 1, i64 1
  %3 = insertelement <4 x i64> %1, i64 1, i64 3
  %4 = insertelement <4 x i64> %2, i64 1, i64 3
  %res = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %3, <4 x i64> %4, i8 1)
  ret <4 x i64> %res
}

define <4 x i64> @test_demanded_elts_pclmulqdq_256_16(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_256_16(
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> [[A0:%.*]], <4 x i64> <i64 poison, i64 1, i64 poison, i64 1>, i8 16)
; CHECK-NEXT:    ret <4 x i64> [[RES]]
;
  %1 = insertelement <4 x i64> %a0, i64 1, i64 1
  %2 = insertelement <4 x i64> %a1, i64 1, i64 1
  %3 = insertelement <4 x i64> %1, i64 1, i64 3
  %4 = insertelement <4 x i64> %2, i64 1, i64 3
  %res = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %3, <4 x i64> %4, i8 16)
  ret <4 x i64> %res
}

define <4 x i64> @test_demanded_elts_pclmulqdq_256_17(<4 x i64> %a0, <4 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_256_17(
; CHECK-NEXT:    [[RES:%.*]] = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> <i64 poison, i64 1, i64 poison, i64 1>, <4 x i64> <i64 poison, i64 1, i64 poison, i64 1>, i8 17)
; CHECK-NEXT:    ret <4 x i64> [[RES]]
;
  %1 = insertelement <4 x i64> %a0, i64 1, i64 1
  %2 = insertelement <4 x i64> %a1, i64 1, i64 1
  %3 = insertelement <4 x i64> %1, i64 1, i64 3
  %4 = insertelement <4 x i64> %2, i64 1, i64 3
  %res = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> %3, <4 x i64> %4, i8 17)
  ret <4 x i64> %res
}

define <4 x i64> @test_demanded_elts_pclmulqdq_256_undef_0() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_256_undef_0(
; CHECK-NEXT:    ret <4 x i64> zeroinitializer
;
  %1 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> <i64 undef, i64 1, i64 undef, i64 1>, <4 x i64> <i64 undef, i64 1, i64 undef, i64 1>, i8 0)
  ret <4 x i64> %1
}

define <4 x i64> @test_demanded_elts_pclmulqdq_256_undef_1() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_256_undef_1(
; CHECK-NEXT:    ret <4 x i64> zeroinitializer
;
  %1 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> <i64 1, i64 undef, i64 1, i64 undef>, <4 x i64> <i64 undef, i64 1, i64 undef, i64 1>, i8 1)
  ret <4 x i64> %1
}

define <4 x i64> @test_demanded_elts_pclmulqdq_256_undef_16() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_256_undef_16(
; CHECK-NEXT:    ret <4 x i64> zeroinitializer
;
  %1 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> <i64 undef, i64 1, i64 undef, i64 1>, <4 x i64> <i64 1, i64 undef, i64 1, i64 undef>, i8 16)
  ret <4 x i64> %1
}

define <4 x i64> @test_demanded_elts_pclmulqdq_256_undef_17() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_256_undef_17(
; CHECK-NEXT:    ret <4 x i64> zeroinitializer
;
  %1 = call <4 x i64> @llvm.x86.pclmulqdq.256(<4 x i64> <i64 1, i64 undef, i64 1, i64 undef>, <4 x i64> <i64 1, i64 undef, i64 1, i64 undef>, i8 17)
  ret <4 x i64> %1
}

define <8 x i64> @test_demanded_elts_pclmulqdq_512_0(<8 x i64> %a0, <8 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_512_0(
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> [[A0:%.*]], <8 x i64> [[A1:%.*]], i8 0)
; CHECK-NEXT:    ret <8 x i64> [[RES]]
;
  %1 = insertelement <8 x i64> %a0, i64 1, i64 1
  %2 = insertelement <8 x i64> %a1, i64 1, i64 1
  %3 = insertelement <8 x i64> %1, i64 1, i64 3
  %4 = insertelement <8 x i64> %2, i64 1, i64 3
  %5 = insertelement <8 x i64> %3, i64 1, i64 5
  %6 = insertelement <8 x i64> %4, i64 1, i64 5
  %7 = insertelement <8 x i64> %5, i64 1, i64 7
  %8 = insertelement <8 x i64> %6, i64 1, i64 7
  %res = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> %7, <8 x i64> %8, i8 0)
  ret <8 x i64> %res
}

define <8 x i64> @test_demanded_elts_pclmulqdq_512_1(<8 x i64> %a0, <8 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_512_1(
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> <i64 poison, i64 1, i64 poison, i64 1, i64 poison, i64 1, i64 poison, i64 1>, <8 x i64> [[A1:%.*]], i8 1)
; CHECK-NEXT:    ret <8 x i64> [[RES]]
;
  %1 = insertelement <8 x i64> %a0, i64 1, i64 1
  %2 = insertelement <8 x i64> %a1, i64 1, i64 1
  %3 = insertelement <8 x i64> %1, i64 1, i64 3
  %4 = insertelement <8 x i64> %2, i64 1, i64 3
  %5 = insertelement <8 x i64> %3, i64 1, i64 5
  %6 = insertelement <8 x i64> %4, i64 1, i64 5
  %7 = insertelement <8 x i64> %5, i64 1, i64 7
  %8 = insertelement <8 x i64> %6, i64 1, i64 7
  %res = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> %7, <8 x i64> %8, i8 1)
  ret <8 x i64> %res
}

define <8 x i64> @test_demanded_elts_pclmulqdq_512_16(<8 x i64> %a0, <8 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_512_16(
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> [[A0:%.*]], <8 x i64> <i64 poison, i64 1, i64 poison, i64 1, i64 poison, i64 1, i64 poison, i64 1>, i8 16)
; CHECK-NEXT:    ret <8 x i64> [[RES]]
;
  %1 = insertelement <8 x i64> %a0, i64 1, i64 1
  %2 = insertelement <8 x i64> %a1, i64 1, i64 1
  %3 = insertelement <8 x i64> %1, i64 1, i64 3
  %4 = insertelement <8 x i64> %2, i64 1, i64 3
  %5 = insertelement <8 x i64> %3, i64 1, i64 5
  %6 = insertelement <8 x i64> %4, i64 1, i64 5
  %7 = insertelement <8 x i64> %5, i64 1, i64 7
  %8 = insertelement <8 x i64> %6, i64 1, i64 7
  %res = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> %7, <8 x i64> %8, i8 16)
  ret <8 x i64> %res
}

define <8 x i64> @test_demanded_elts_pclmulqdq_512_17(<8 x i64> %a0, <8 x i64> %a1) {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_512_17(
; CHECK-NEXT:    [[RES:%.*]] = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> <i64 poison, i64 1, i64 poison, i64 1, i64 poison, i64 1, i64 poison, i64 1>, <8 x i64> <i64 poison, i64 1, i64 poison, i64 1, i64 poison, i64 1, i64 poison, i64 1>, i8 17)
; CHECK-NEXT:    ret <8 x i64> [[RES]]
;
  %1 = insertelement <8 x i64> %a0, i64 1, i64 1
  %2 = insertelement <8 x i64> %a1, i64 1, i64 1
  %3 = insertelement <8 x i64> %1, i64 1, i64 3
  %4 = insertelement <8 x i64> %2, i64 1, i64 3
  %5 = insertelement <8 x i64> %3, i64 1, i64 5
  %6 = insertelement <8 x i64> %4, i64 1, i64 5
  %7 = insertelement <8 x i64> %5, i64 1, i64 7
  %8 = insertelement <8 x i64> %6, i64 1, i64 7
  %res = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> %7, <8 x i64> %8, i8 17)
  ret <8 x i64> %res
}

define <8 x i64> @test_demanded_elts_pclmulqdq_512_undef_0() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_512_undef_0(
; CHECK-NEXT:    ret <8 x i64> zeroinitializer
;
  %1 = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> <i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1>, <8 x i64> <i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1>, i8 0)
  ret <8 x i64> %1
}

define <8 x i64> @test_demanded_elts_pclmulqdq_512_undef_1() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_512_undef_1(
; CHECK-NEXT:    ret <8 x i64> zeroinitializer
;
  %1 = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> <i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef>, <8 x i64> <i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1>, i8 1)
  ret <8 x i64> %1
}

define <8 x i64> @test_demanded_elts_pclmulqdq_512_undef_16() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_512_undef_16(
; CHECK-NEXT:    ret <8 x i64> zeroinitializer
;
  %1 = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> <i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1>, <8 x i64> <i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef>, i8 16)
  ret <8 x i64> %1
}

define <8 x i64> @test_demanded_elts_pclmulqdq_512_undef_17() {
; CHECK-LABEL: @test_demanded_elts_pclmulqdq_512_undef_17(
; CHECK-NEXT:    ret <8 x i64> zeroinitializer
;
  %1 = call <8 x i64> @llvm.x86.pclmulqdq.512(<8 x i64> <i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef>, <8 x i64> <i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef, i64 1, i64 undef>, i8 17)
  ret <8 x i64> %1
}
