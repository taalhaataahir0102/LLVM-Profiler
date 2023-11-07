; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -codegenprepare < %s | FileCheck %s

target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; No bypassing should be done in apparently unsuitable cases.
define void @Test_no_bypassing(i32 %a, i64 %b, ptr %retptr) {
; CHECK-LABEL: @Test_no_bypassing(
; CHECK-NEXT:    [[A_1:%.*]] = zext i32 [[A:%.*]] to i64
; CHECK-NEXT:    [[A_2:%.*]] = sub i64 -1, [[A_1]]
; CHECK-NEXT:    [[RES:%.*]] = srem i64 [[A_2]], [[B:%.*]]
; CHECK-NEXT:    store i64 [[RES]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
  %a.1 = zext i32 %a to i64
  ; %a.2 is always negative so the division cannot be bypassed.
  %a.2 = sub i64 -1, %a.1
  %res = srem i64 %a.2, %b
  store i64 %res, ptr %retptr
  ret void
}

; No OR instruction is needed if one of the operands (divisor) is known
; to fit into 32 bits.
define void @Test_check_one_operand(i64 %a, i32 %b, ptr %retptr) {
; CHECK-LABEL: @Test_check_one_operand(
; CHECK-NEXT:    [[B_1:%.*]] = zext i32 [[B:%.*]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[A:%.*]], -4294967296
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP8:%.*]]
; CHECK:         [[TMP4:%.*]] = trunc i64 [[B_1]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i64 [[A]] to i32
; CHECK-NEXT:    [[TMP6:%.*]] = udiv i32 [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[TMP7:%.*]] = zext i32 [[TMP6]] to i64
; CHECK-NEXT:    br label [[TMP10:%.*]]
; CHECK:         [[TMP9:%.*]] = sdiv i64 [[A]], [[B_1]]
; CHECK-NEXT:    br label [[TMP10]]
; CHECK:         [[TMP11:%.*]] = phi i64 [ [[TMP7]], [[TMP3]] ], [ [[TMP9]], [[TMP8]] ]
; CHECK-NEXT:    store i64 [[TMP11]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
  %b.1 = zext i32 %b to i64
  %res = sdiv i64 %a, %b.1
  store i64 %res, ptr %retptr
  ret void
}

; If both operands are known to fit into 32 bits, then replace the division
; in-place without CFG modification.
define void @Test_check_none(i64 %a, i32 %b, ptr %retptr) {
; CHECK-LABEL: @Test_check_none(
; CHECK-NEXT:    [[A_1:%.*]] = and i64 [[A:%.*]], 4294967295
; CHECK-NEXT:    [[B_1:%.*]] = zext i32 [[B:%.*]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[A_1]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[B_1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = udiv i32 [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[TMP4:%.*]] = zext i32 [[TMP3]] to i64
; CHECK-NEXT:    store i64 [[TMP4]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
  %a.1 = and i64 %a, 4294967295
  %b.1 = zext i32 %b to i64
  %res = udiv i64 %a.1, %b.1
  store i64 %res, ptr %retptr
  ret void
}

; In case of unsigned long division with a short dividend,
; the long division is not needed any more.
define void @Test_special_case(i32 %a, i64 %b, ptr %retptr) {
; CHECK-LABEL: @Test_special_case(
; CHECK-NEXT:    [[A_1:%.*]] = zext i32 [[A:%.*]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i64 [[A_1]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[TMP1]], label [[TMP2:%.*]], label [[TMP9:%.*]]
; CHECK:         [[TMP3:%.*]] = trunc i64 [[B]] to i32
; CHECK-NEXT:    [[TMP4:%.*]] = trunc i64 [[A_1]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = udiv i32 [[TMP4]], [[TMP3]]
; CHECK-NEXT:    [[TMP6:%.*]] = urem i32 [[TMP4]], [[TMP3]]
; CHECK-NEXT:    [[TMP7:%.*]] = zext i32 [[TMP5]] to i64
; CHECK-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP6]] to i64
; CHECK-NEXT:    br label [[TMP9]]
; CHECK:         [[TMP10:%.*]] = phi i64 [ [[TMP7]], [[TMP2]] ], [ 0, [[TMP0:%.*]] ]
; CHECK-NEXT:    [[TMP11:%.*]] = phi i64 [ [[TMP8]], [[TMP2]] ], [ [[A_1]], [[TMP0]] ]
; CHECK-NEXT:    [[RES:%.*]] = add i64 [[TMP10]], [[TMP11]]
; CHECK-NEXT:    store i64 [[RES]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
  %a.1 = zext i32 %a to i64
  %div = udiv i64 %a.1, %b
  %rem = urem i64 %a.1, %b
  %res = add i64 %div, %rem
  store i64 %res, ptr %retptr
  ret void
}


; Do not bypass a division if one of the operands looks like a hash value.
define void @Test_dont_bypass_xor(i64 %a, i64 %b, i64 %l, ptr %retptr) {
; CHECK-LABEL: @Test_dont_bypass_xor(
; CHECK-NEXT:    [[C:%.*]] = xor i64 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[RES:%.*]] = udiv i64 [[C]], [[L:%.*]]
; CHECK-NEXT:    store i64 [[RES]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
  %c = xor i64 %a, %b
  %res = udiv i64 %c, %l
  store i64 %res, ptr %retptr
  ret void
}

define void @Test_dont_bypass_phi_xor(i64 %a, i64 %b, i64 %l, ptr %retptr) {
; CHECK-LABEL: @Test_dont_bypass_phi_xor(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[B:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[MERGE:%.*]], label [[XORPATH:%.*]]
; CHECK:       xorpath:
; CHECK-NEXT:    [[C:%.*]] = xor i64 [[A:%.*]], [[B]]
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    [[E:%.*]] = phi i64 [ undef, [[ENTRY:%.*]] ], [ [[C]], [[XORPATH]] ]
; CHECK-NEXT:    [[RES:%.*]] = sdiv i64 [[E]], [[L:%.*]]
; CHECK-NEXT:    store i64 [[RES]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp eq i64 %b, 0
  br i1 %cmp, label %merge, label %xorpath

xorpath:
  %c = xor i64 %a, %b
  br label %merge

merge:
  %e = phi i64 [ undef, %entry ], [ %c, %xorpath ]
  %res = sdiv i64 %e, %l
  store i64 %res, ptr %retptr
  ret void
}

define void @Test_dont_bypass_mul_long_const(i64 %a, i64 %l, ptr %retptr) {
; CHECK-LABEL: @Test_dont_bypass_mul_long_const(
; CHECK-NEXT:    [[C:%.*]] = mul i64 [[A:%.*]], 5229553307
; CHECK-NEXT:    [[RES:%.*]] = urem i64 [[C]], [[L:%.*]]
; CHECK-NEXT:    store i64 [[RES]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
  %c = mul i64 %a, 5229553307 ; the constant doesn't fit 32 bits
  %res = urem i64 %c, %l
  store i64 %res, ptr %retptr
  ret void
}

define void @Test_bypass_phi_mul_const(i64 %a, i64 %b, ptr %retptr) {
; CHECK-LABEL: @Test_bypass_phi_mul_const(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_MUL:%.*]] = mul nsw i64 [[A:%.*]], 34806414968801
; CHECK-NEXT:    [[P:%.*]] = icmp sgt i64 [[A]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[P]], label [[BRANCH:%.*]], label [[MERGE:%.*]]
; CHECK:       branch:
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    [[LHS:%.*]] = phi i64 [ 42, [[BRANCH]] ], [ [[A_MUL]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = or i64 [[LHS]], [[B]]
; CHECK-NEXT:    [[TMP1:%.*]] = and i64 [[TMP0]], -4294967296
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i64 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP8:%.*]]
; CHECK:         [[TMP4:%.*]] = trunc i64 [[B]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = trunc i64 [[LHS]] to i32
; CHECK-NEXT:    [[TMP6:%.*]] = udiv i32 [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[TMP7:%.*]] = zext i32 [[TMP6]] to i64
; CHECK-NEXT:    br label [[TMP10:%.*]]
; CHECK:         [[TMP9:%.*]] = sdiv i64 [[LHS]], [[B]]
; CHECK-NEXT:    br label [[TMP10]]
; CHECK:         [[TMP11:%.*]] = phi i64 [ [[TMP7]], [[TMP3]] ], [ [[TMP9]], [[TMP8]] ]
; CHECK-NEXT:    store i64 [[TMP11]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
entry:
  %a.mul = mul nsw i64 %a, 34806414968801
  %p = icmp sgt i64 %a, %b
  br i1 %p, label %branch, label %merge

branch:
  br label %merge

merge:
  %lhs = phi i64 [ 42, %branch ], [ %a.mul, %entry ]
  %res = sdiv i64 %lhs, %b
  store i64 %res, ptr %retptr
  ret void
}

define void @Test_bypass_mul_short_const(i64 %a, i64 %l, ptr %retptr) {
; CHECK-LABEL: @Test_bypass_mul_short_const(
; CHECK-NEXT:    [[C:%.*]] = mul i64 [[A:%.*]], -42
; CHECK-NEXT:    [[TMP1:%.*]] = or i64 [[C]], [[L:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[TMP1]], -4294967296
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i64 [[TMP2]], 0
; CHECK-NEXT:    br i1 [[TMP3]], label [[TMP4:%.*]], label [[TMP9:%.*]]
; CHECK:         [[TMP5:%.*]] = trunc i64 [[L]] to i32
; CHECK-NEXT:    [[TMP6:%.*]] = trunc i64 [[C]] to i32
; CHECK-NEXT:    [[TMP7:%.*]] = urem i32 [[TMP6]], [[TMP5]]
; CHECK-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
; CHECK-NEXT:    br label [[TMP11:%.*]]
; CHECK:         [[TMP10:%.*]] = urem i64 [[C]], [[L]]
; CHECK-NEXT:    br label [[TMP11]]
; CHECK:         [[TMP12:%.*]] = phi i64 [ [[TMP8]], [[TMP4]] ], [ [[TMP10]], [[TMP9]] ]
; CHECK-NEXT:    store i64 [[TMP12]], ptr [[RETPTR:%.*]]
; CHECK-NEXT:    ret void
;
  %c = mul i64 %a, -42
  %res = urem i64 %c, %l
  store i64 %res, ptr %retptr
  ret void
}
