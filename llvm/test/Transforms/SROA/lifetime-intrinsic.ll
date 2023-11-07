; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes='sroa<preserve-cfg>' -S | FileCheck %s --check-prefixes=CHECK,CHECK-PRESERVE-CFG
; RUN: opt < %s -passes='sroa<modify-cfg>' -S | FileCheck %s --check-prefixes=CHECK,CHECK-MODIFY-CFG

%i32x2 = type { [2 x i32] }

; Note %arr is the union
; union {
;   int i[2];
;   short s[4];
; };

define i16 @with_lifetime(i32 %a, i32 %b) #0 {
; CHECK-LABEL: @with_lifetime(
; CHECK-NEXT:    [[ARR_SROA_0_0_EXTRACT_TRUNC:%.*]] = trunc i32 [[A:%.*]] to i16
; CHECK-NEXT:    [[ARR_SROA_4_4_EXTRACT_TRUNC:%.*]] = trunc i32 [[B:%.*]] to i16
; CHECK-NEXT:    [[RET:%.*]] = add i16 [[ARR_SROA_0_0_EXTRACT_TRUNC]], [[ARR_SROA_4_4_EXTRACT_TRUNC]]
; CHECK-NEXT:    ret i16 [[RET]]
;
  %arr = alloca %i32x2, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr %arr)
  %p1 = getelementptr inbounds %i32x2, ptr %arr, i64 0, i32 0, i32 1
  store i32 %a, ptr %arr, align 4
  store i32 %b, ptr %p1, align 4
  %s0 = load i16, ptr %arr, align 4
  %s2 = load i16, ptr %p1, align 4
  %ret = add i16 %s0, %s2
  call void @llvm.lifetime.end.p0(i64 8, ptr %arr)
  ret i16 %ret
}

define i16 @no_lifetime(i32 %a, i32 %b) #0 {
; CHECK-LABEL: @no_lifetime(
; CHECK-NEXT:    [[ARR_SROA_0_0_EXTRACT_TRUNC:%.*]] = trunc i32 [[A:%.*]] to i16
; CHECK-NEXT:    [[ARR_SROA_2_0_EXTRACT_SHIFT:%.*]] = lshr i32 [[A]], 16
; CHECK-NEXT:    [[ARR_SROA_2_0_EXTRACT_TRUNC:%.*]] = trunc i32 [[ARR_SROA_2_0_EXTRACT_SHIFT]] to i16
; CHECK-NEXT:    [[ARR_SROA_21_4_EXTRACT_TRUNC:%.*]] = trunc i32 [[B:%.*]] to i16
; CHECK-NEXT:    [[ARR_SROA_4_4_EXTRACT_SHIFT:%.*]] = lshr i32 [[B]], 16
; CHECK-NEXT:    [[ARR_SROA_4_4_EXTRACT_TRUNC:%.*]] = trunc i32 [[ARR_SROA_4_4_EXTRACT_SHIFT]] to i16
; CHECK-NEXT:    [[RET:%.*]] = add i16 [[ARR_SROA_0_0_EXTRACT_TRUNC]], [[ARR_SROA_21_4_EXTRACT_TRUNC]]
; CHECK-NEXT:    ret i16 [[RET]]
;
  %arr = alloca %i32x2, align 4
  %p1 = getelementptr inbounds %i32x2, ptr %arr, i64 0, i32 0, i32 1
  store i32 %a, ptr %arr, align 4
  store i32 %b, ptr %p1, align 4
  %s0 = load i16, ptr %arr, align 4
  %s2 = load i16, ptr %p1, align 4
  %ret = add i16 %s0, %s2
  ret i16 %ret
}

declare void @llvm.lifetime.start.p0(i64, ptr nocapture) #1

declare void @llvm.lifetime.end.p0(i64, ptr nocapture) #1

attributes #0 = { alwaysinline nounwind }
attributes #1 = { argmemonly nounwind }
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-MODIFY-CFG: {{.*}}
; CHECK-PRESERVE-CFG: {{.*}}
