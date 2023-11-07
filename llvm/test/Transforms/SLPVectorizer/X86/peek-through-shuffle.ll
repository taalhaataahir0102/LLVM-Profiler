; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=slp-vectorizer < %s -mtriple=x86_64-unknown-linux-gnu -o - | FileCheck %s

define void @foo(ptr %0, <4 x float> %1) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, ptr null, i64 22
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x float>, ptr [[TMP2]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <2 x float> [[TMP3]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <4 x float> zeroinitializer, <4 x float> [[TMP4]], <4 x i32> <i32 4, i32 5, i32 2, i32 3>
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <4 x float> [[TMP1:%.*]], <4 x float> zeroinitializer, <4 x i32> <i32 0, i32 5, i32 6, i32 poison>
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <4 x float> [[TMP6]], <4 x float> [[TMP4]], <4 x i32> <i32 0, i32 1, i32 2, i32 4>
; CHECK-NEXT:    [[TMP8:%.*]] = fpext <4 x float> [[TMP7]] to <4 x double>
; CHECK-NEXT:    store <4 x double> [[TMP8]], ptr [[TMP0:%.*]], align 32
; CHECK-NEXT:    ret void
;
entry:
  %2 = getelementptr float, ptr null, i64 22
  %3 = load float, ptr %2, align 8
  %4 = insertelement <4 x float> zeroinitializer, float %3, i64 0
  %5 = getelementptr float, ptr null, i64 23
  %6 = load float, ptr %5, align 4
  %7 = insertelement <4 x float> %4, float %6, i64 1
  %8 = shufflevector <4 x float> %1, <4 x float> zeroinitializer, <4 x i32> <i32 0, i32 5, i32 6, i32 undef>
  %9 = insertelement <4 x float> %8, float %3, i64 3
  %10 = fpext <4 x float> %9 to <4 x double>
  store <4 x double> %10, ptr %0, align 32
  ret void
}
