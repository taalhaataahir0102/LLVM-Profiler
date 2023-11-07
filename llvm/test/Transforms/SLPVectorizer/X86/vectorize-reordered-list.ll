; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown %s | FileCheck %s

define void @test(ptr %isec) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds double, ptr [[ISEC:%.*]], i64 2
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, ptr [[ISEC]], align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x double>, ptr [[ARRAYIDX2]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = fadd <2 x double> [[TMP1]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = fsub <2 x double> [[TMP1]], [[TMP3]]
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <2 x double> [[TMP4]], <2 x double> [[TMP5]], <2 x i32> <i32 1, i32 2>
; CHECK-NEXT:    store <2 x double> [[TMP6]], ptr [[ISEC]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx5 = getelementptr inbounds double, ptr %isec, i64 1
  %0 = load double, ptr %arrayidx5, align 8
  %1 = load double, ptr %isec, align 8
  %arrayidx3 = getelementptr inbounds double, ptr %isec, i64 3
  %2 = load double, ptr %arrayidx3, align 8
  %arrayidx2 = getelementptr inbounds double, ptr %isec, i64 2
  %3 = load double, ptr %arrayidx2, align 8
  %4 = fadd double %0, %2
  %5 = fsub double %1, %3
  store double %4, ptr %isec
  store double %5, ptr %arrayidx5
  ret void
}
