; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -passes=amdgpu-simplifylib %s | FileCheck %s

target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8"

declare float @_Z4fminff(float, float)
declare <2 x float> @_Z4fminDv2_fS_(<2 x float>, <2 x float>)
declare <3 x float> @_Z4fminDv3_fS_(<3 x float>, <3 x float>)
declare <4 x float> @_Z4fminDv4_fS_(<4 x float>, <4 x float>)
declare <8 x float> @_Z4fminDv8_fS_(<8 x float>, <8 x float>)
declare <16 x float> @_Z4fminDv16_fS_(<16 x float>, <16 x float>)
declare double @_Z4fmindd(double, double)
declare <2 x double> @_Z4fminDv2_dS_(<2 x double>, <2 x double>)
declare <3 x double> @_Z4fminDv3_dS_(<3 x double>, <3 x double>)
declare <4 x double> @_Z4fminDv4_dS_(<4 x double>, <4 x double>)
declare <8 x double> @_Z4fminDv8_dS_(<8 x double>, <8 x double>)
declare <16 x double> @_Z4fminDv16_dS_(<16 x double>, <16 x double>)
declare half @_Z4fminDhDh(half, half)
declare <2 x half> @_Z4fminDv2_DhS_(<2 x half>, <2 x half>)
declare <3 x half> @_Z4fminDv3_DhS_(<3 x half>, <3 x half>)
declare <4 x half> @_Z4fminDv4_DhS_(<4 x half>, <4 x half>)
declare <8 x half> @_Z4fminDv8_DhS_(<8 x half>, <8 x half>)
declare <16 x half> @_Z4fminDv16_DhS_(<16 x half>, <16 x half>)

define float @test_fmin_f32(float %x, float %y) {
; CHECK-LABEL: define float @test_fmin_f32
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call float @llvm.minnum.f32(float [[X]], float [[Y]])
; CHECK-NEXT:    ret float [[FMIN]]
;
  %fmin = tail call float @_Z4fminff(float %x, float %y)
  ret float %fmin
}

define float @test_fmin_f32_nnan(float %x, float %y) {
; CHECK-LABEL: define float @test_fmin_f32_nnan
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call nnan float @llvm.minnum.f32(float [[X]], float [[Y]])
; CHECK-NEXT:    ret float [[FMIN]]
;
  %fmin = tail call nnan float @_Z4fminff(float %x, float %y)
  ret float %fmin
}

define <2 x float> @test_fmin_v2f32(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: define <2 x float> @test_fmin_v2f32
; CHECK-SAME: (<2 x float> [[X:%.*]], <2 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <2 x float> @llvm.minnum.v2f32(<2 x float> [[X]], <2 x float> [[Y]])
; CHECK-NEXT:    ret <2 x float> [[FMIN]]
;
  %fmin = tail call <2 x float> @_Z4fminDv2_fS_(<2 x float> %x, <2 x float> %y)
  ret <2 x float> %fmin
}

define <3 x float> @test_fmin_v3f32(<3 x float> %x, <3 x float> %y) {
; CHECK-LABEL: define <3 x float> @test_fmin_v3f32
; CHECK-SAME: (<3 x float> [[X:%.*]], <3 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <3 x float> @llvm.minnum.v3f32(<3 x float> [[X]], <3 x float> [[Y]])
; CHECK-NEXT:    ret <3 x float> [[FMIN]]
;
  %fmin = tail call <3 x float> @_Z4fminDv3_fS_(<3 x float> %x, <3 x float> %y)
  ret <3 x float> %fmin
}

define <4 x float> @test_fmin_v4f32(<4 x float> %x, <4 x float> %y) {
; CHECK-LABEL: define <4 x float> @test_fmin_v4f32
; CHECK-SAME: (<4 x float> [[X:%.*]], <4 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <4 x float> @llvm.minnum.v4f32(<4 x float> [[X]], <4 x float> [[Y]])
; CHECK-NEXT:    ret <4 x float> [[FMIN]]
;
  %fmin = tail call <4 x float> @_Z4fminDv4_fS_(<4 x float> %x, <4 x float> %y)
  ret <4 x float> %fmin
}

define <8 x float> @test_fmin_v8f32(<8 x float> %x, <8 x float> %y) {
; CHECK-LABEL: define <8 x float> @test_fmin_v8f32
; CHECK-SAME: (<8 x float> [[X:%.*]], <8 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <8 x float> @llvm.minnum.v8f32(<8 x float> [[X]], <8 x float> [[Y]])
; CHECK-NEXT:    ret <8 x float> [[FMIN]]
;
  %fmin = tail call <8 x float> @_Z4fminDv8_fS_(<8 x float> %x, <8 x float> %y)
  ret <8 x float> %fmin
}

define <16 x float> @test_fmin_v16f32(<16 x float> %x, <16 x float> %y) {
; CHECK-LABEL: define <16 x float> @test_fmin_v16f32
; CHECK-SAME: (<16 x float> [[X:%.*]], <16 x float> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <16 x float> @llvm.minnum.v16f32(<16 x float> [[X]], <16 x float> [[Y]])
; CHECK-NEXT:    ret <16 x float> [[FMIN]]
;
  %fmin = tail call <16 x float> @_Z4fminDv16_fS_(<16 x float> %x, <16 x float> %y)
  ret <16 x float> %fmin
}

define double @test_fmin_f64(double %x, double %y) {
; CHECK-LABEL: define double @test_fmin_f64
; CHECK-SAME: (double [[X:%.*]], double [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call double @llvm.minnum.f64(double [[X]], double [[Y]])
; CHECK-NEXT:    ret double [[FMIN]]
;
  %fmin = tail call double @_Z4fmindd(double %x, double %y)
  ret double %fmin
}

define <2 x double> @test_fmin_v2f64(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: define <2 x double> @test_fmin_v2f64
; CHECK-SAME: (<2 x double> [[X:%.*]], <2 x double> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <2 x double> @llvm.minnum.v2f64(<2 x double> [[X]], <2 x double> [[Y]])
; CHECK-NEXT:    ret <2 x double> [[FMIN]]
;
  %fmin = tail call <2 x double> @_Z4fminDv2_dS_(<2 x double> %x, <2 x double> %y)
  ret <2 x double> %fmin
}

define <3 x double> @test_fmin_v3f64(<3 x double> %x, <3 x double> %y) {
; CHECK-LABEL: define <3 x double> @test_fmin_v3f64
; CHECK-SAME: (<3 x double> [[X:%.*]], <3 x double> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <3 x double> @llvm.minnum.v3f64(<3 x double> [[X]], <3 x double> [[Y]])
; CHECK-NEXT:    ret <3 x double> [[FMIN]]
;
  %fmin = tail call <3 x double> @_Z4fminDv3_dS_(<3 x double> %x, <3 x double> %y)
  ret <3 x double> %fmin
}

define <4 x double> @test_fmin_v4f64(<4 x double> %x, <4 x double> %y) {
; CHECK-LABEL: define <4 x double> @test_fmin_v4f64
; CHECK-SAME: (<4 x double> [[X:%.*]], <4 x double> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <4 x double> @llvm.minnum.v4f64(<4 x double> [[X]], <4 x double> [[Y]])
; CHECK-NEXT:    ret <4 x double> [[FMIN]]
;
  %fmin = tail call <4 x double> @_Z4fminDv4_dS_(<4 x double> %x, <4 x double> %y)
  ret <4 x double> %fmin
}

define <8 x double> @test_fmin_v8f64(<8 x double> %x, <8 x double> %y) {
; CHECK-LABEL: define <8 x double> @test_fmin_v8f64
; CHECK-SAME: (<8 x double> [[X:%.*]], <8 x double> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <8 x double> @llvm.minnum.v8f64(<8 x double> [[X]], <8 x double> [[Y]])
; CHECK-NEXT:    ret <8 x double> [[FMIN]]
;
  %fmin = tail call <8 x double> @_Z4fminDv8_dS_(<8 x double> %x, <8 x double> %y)
  ret <8 x double> %fmin
}

define <16 x double> @test_fmin_v16f64(<16 x double> %x, <16 x double> %y) {
; CHECK-LABEL: define <16 x double> @test_fmin_v16f64
; CHECK-SAME: (<16 x double> [[X:%.*]], <16 x double> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <16 x double> @llvm.minnum.v16f64(<16 x double> [[X]], <16 x double> [[Y]])
; CHECK-NEXT:    ret <16 x double> [[FMIN]]
;
  %fmin = tail call <16 x double> @_Z4fminDv16_dS_(<16 x double> %x, <16 x double> %y)
  ret <16 x double> %fmin
}

define half @test_fmin_f16(half %x, half %y) {
; CHECK-LABEL: define half @test_fmin_f16
; CHECK-SAME: (half [[X:%.*]], half [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call half @llvm.minnum.f16(half [[X]], half [[Y]])
; CHECK-NEXT:    ret half [[FMIN]]
;
  %fmin = tail call half @_Z4fminDhDh(half %x, half %y)
  ret half %fmin
}

define <2 x half> @test_fmin_v2f16(<2 x half> %x, <2 x half> %y) {
; CHECK-LABEL: define <2 x half> @test_fmin_v2f16
; CHECK-SAME: (<2 x half> [[X:%.*]], <2 x half> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <2 x half> @llvm.minnum.v2f16(<2 x half> [[X]], <2 x half> [[Y]])
; CHECK-NEXT:    ret <2 x half> [[FMIN]]
;
  %fmin = tail call <2 x half> @_Z4fminDv2_DhS_(<2 x half> %x, <2 x half> %y)
  ret <2 x half> %fmin
}

define <3 x half> @test_fmin_v3f16(<3 x half> %x, <3 x half> %y) {
; CHECK-LABEL: define <3 x half> @test_fmin_v3f16
; CHECK-SAME: (<3 x half> [[X:%.*]], <3 x half> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <3 x half> @llvm.minnum.v3f16(<3 x half> [[X]], <3 x half> [[Y]])
; CHECK-NEXT:    ret <3 x half> [[FMIN]]
;
  %fmin = tail call <3 x half> @_Z4fminDv3_DhS_(<3 x half> %x, <3 x half> %y)
  ret <3 x half> %fmin
}

define <4 x half> @test_fmin_v4f16(<4 x half> %x, <4 x half> %y) {
; CHECK-LABEL: define <4 x half> @test_fmin_v4f16
; CHECK-SAME: (<4 x half> [[X:%.*]], <4 x half> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <4 x half> @llvm.minnum.v4f16(<4 x half> [[X]], <4 x half> [[Y]])
; CHECK-NEXT:    ret <4 x half> [[FMIN]]
;
  %fmin = tail call <4 x half> @_Z4fminDv4_DhS_(<4 x half> %x, <4 x half> %y)
  ret <4 x half> %fmin
}

define <8 x half> @test_fmin_v8f16(<8 x half> %x, <8 x half> %y) {
; CHECK-LABEL: define <8 x half> @test_fmin_v8f16
; CHECK-SAME: (<8 x half> [[X:%.*]], <8 x half> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <8 x half> @llvm.minnum.v8f16(<8 x half> [[X]], <8 x half> [[Y]])
; CHECK-NEXT:    ret <8 x half> [[FMIN]]
;
  %fmin = tail call <8 x half> @_Z4fminDv8_DhS_(<8 x half> %x, <8 x half> %y)
  ret <8 x half> %fmin
}

define <16 x half> @test_fmin_v16f16(<16 x half> %x, <16 x half> %y) {
; CHECK-LABEL: define <16 x half> @test_fmin_v16f16
; CHECK-SAME: (<16 x half> [[X:%.*]], <16 x half> [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call <16 x half> @llvm.minnum.v16f16(<16 x half> [[X]], <16 x half> [[Y]])
; CHECK-NEXT:    ret <16 x half> [[FMIN]]
;
  %fmin = tail call <16 x half> @_Z4fminDv16_DhS_(<16 x half> %x, <16 x half> %y)
  ret <16 x half> %fmin
}

define float @test_fmin_f32_minsize(float %x, float %y) #0 {
; CHECK-LABEL: define float @test_fmin_f32_minsize
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call float @llvm.minnum.f32(float [[X]], float [[Y]])
; CHECK-NEXT:    ret float [[FMIN]]
;
  %fmin = tail call float @_Z4fminff(float %x, float %y)
  ret float %fmin
}

define float @test_fmin_f32_nnan_minsize(float %x, float %y) #0 {
; CHECK-LABEL: define float @test_fmin_f32_nnan_minsize
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call nnan float @llvm.minnum.f32(float [[X]], float [[Y]])
; CHECK-NEXT:    ret float [[FMIN]]
;
  %fmin = tail call nnan float @_Z4fminff(float %x, float %y)
  ret float %fmin
}

define float @test_fmin_f32_noinline(float %x, float %y) {
; CHECK-LABEL: define float @test_fmin_f32_noinline
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call float @_Z4fminff(float [[X]], float [[Y]]) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    ret float [[FMIN]]
;
  %fmin = tail call float @_Z4fminff(float %x, float %y) #1
  ret float %fmin
}

define float @test_fmin_f32_nnan_noinline(float %x, float %y) {
; CHECK-LABEL: define float @test_fmin_f32_nnan_noinline
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call nnan float @_Z4fminff(float [[X]], float [[Y]]) #[[ATTR3]]
; CHECK-NEXT:    ret float [[FMIN]]
;
  %fmin = tail call nnan float @_Z4fminff(float %x, float %y) #1
  ret float %fmin
}

define float @test_fmin_f32_strictfp(float %x, float %y) #2 {
; CHECK-LABEL: define float @test_fmin_f32_strictfp
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call nnan nsz float @_Z4fminff(float [[X]], float [[Y]]) #[[ATTR1]]
; CHECK-NEXT:    ret float [[FMIN]]
;
  %fmin = tail call nsz nnan float @_Z4fminff(float %x, float %y) #2
  ret float %fmin
}

define float @test_fmin_f32_fast_nobuiltin(float %x, float %y) {
; CHECK-LABEL: define float @test_fmin_f32_fast_nobuiltin
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:    [[FMIN:%.*]] = tail call fast float @_Z4fminff(float [[X]], float [[Y]]) #[[ATTR4:[0-9]+]]
; CHECK-NEXT:    ret float [[FMIN]]
;
  %fmin = tail call fast float @_Z4fminff(float %x, float %y) #3
  ret float %fmin
}

attributes #0 = { minsize }
attributes #1 = { noinline }
attributes #2 = { strictfp }
attributes #3 = { nobuiltin }
