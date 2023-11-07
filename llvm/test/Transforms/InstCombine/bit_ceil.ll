; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; std::bit_ceil<uint32_t>(x)
define i32 @bit_ceil_32(i32 %x) {
; CHECK-LABEL: @bit_ceil_32(
; CHECK-NEXT:    [[DEC:%.*]] = add i32 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[DEC]], i1 false), !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[TMP1:%.*]] = sub nsw i32 0, [[CTLZ]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], 31
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw i32 1, [[TMP2]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %dec = add i32 %x, -1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %dec, i1 false)
  %sub = sub i32 32, %ctlz
  %shl = shl i32 1, %sub
  %ugt = icmp ugt i32 %x, 1
  %sel = select i1 %ugt, i32 %shl, i32 1
  ret i32 %sel
}

; std::bit_ceil<uint64_t>(x)
define i64 @bit_ceil_64(i64 %x) {
; CHECK-LABEL: @bit_ceil_64(
; CHECK-NEXT:    [[DEC:%.*]] = add i64 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i64 @llvm.ctlz.i64(i64 [[DEC]], i1 false), !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    [[TMP1:%.*]] = sub nsw i64 0, [[CTLZ]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i64 [[TMP1]], 63
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw i64 1, [[TMP2]]
; CHECK-NEXT:    ret i64 [[SEL]]
;
  %dec = add i64 %x, -1
  %ctlz = tail call i64 @llvm.ctlz.i64(i64 %dec, i1 false)
  %sub = sub i64 64, %ctlz
  %shl = shl i64 1, %sub
  %ugt = icmp ugt i64 %x, 1
  %sel = select i1 %ugt, i64 %shl, i64 1
  ret i64 %sel
}

; std::bit_ceil<uint32_t>(x - 1)
define i32 @bit_ceil_32_minus_1(i32 %x) {
; CHECK-LABEL: @bit_ceil_32_minus_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = add i32 [[X:%.*]], -2
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[SUB]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[TMP0:%.*]] = sub nsw i32 0, [[CTLZ]]
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[TMP0]], 31
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw i32 1, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
entry:
  %sub = add i32 %x, -2
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %sub, i1 false)
  %sub2 = sub nuw nsw i32 32, %ctlz
  %shl = shl nuw i32 1, %sub2
  %add = add i32 %x, -3
  %ult = icmp ult i32 %add, -2
  %sel = select i1 %ult, i32 %shl, i32 1
  ret i32 %sel
}

; std::bit_ceil<uint32_t>(x + 1)
define i32 @bit_ceil_32_plus_1(i32 %x) {
; CHECK-LABEL: @bit_ceil_32_plus_1(
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[X:%.*]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[TMP1:%.*]] = sub nsw i32 0, [[CTLZ]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], 31
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw i32 1, [[TMP2]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %x, i1 false)
  %sub = sub i32 32, %ctlz
  %shl = shl i32 1, %sub
  %dec = add i32 %x, -1
  %ult = icmp ult i32 %dec, -2
  %sel = select i1 %ult, i32 %shl, i32 1
  ret i32 %sel
}

; std::bit_ceil<uint32_t>(x + 2)
define i32 @bit_ceil_plus_2(i32 %x) {
; CHECK-LABEL: @bit_ceil_plus_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = add i32 [[X:%.*]], 1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[SUB]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[TMP0:%.*]] = sub nsw i32 0, [[CTLZ]]
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[TMP0]], 31
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw i32 1, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
entry:
  %sub = add i32 %x, 1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %sub, i1 false)
  %sub2 = sub nuw nsw i32 32, %ctlz
  %shl = shl nuw i32 1, %sub2
  %ult = icmp ult i32 %x, -2
  %sel = select i1 %ult, i32 %shl, i32 1
  ret i32 %sel
}

; std::bit_ceil<uint32_t>(-x)
define i32 @bit_ceil_32_neg(i32 %x) {
; CHECK-LABEL: @bit_ceil_32_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = xor i32 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[SUB]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[TMP0:%.*]] = sub nsw i32 0, [[CTLZ]]
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[TMP0]], 31
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw i32 1, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
entry:
  %sub = xor i32 %x, -1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %sub, i1 false)
  %sub2 = sub nuw nsw i32 32, %ctlz
  %shl = shl nuw i32 1, %sub2
  %notsub = add i32 %x, -1
  %ult = icmp ult i32 %notsub, -2
  %sel = select i1 %ult, i32 %shl, i32 1
  ret i32 %sel
}

; std::bit_ceil<uint32_t>(~x)
define i32 @bit_ceil_not(i32 %x) {
; CHECK-LABEL: @bit_ceil_not(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 -2, [[X:%.*]]
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[SUB]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[TMP0:%.*]] = sub nsw i32 0, [[CTLZ]]
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[TMP0]], 31
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw i32 1, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
entry:
  %sub = sub i32 -2, %x
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %sub, i1 false)
  %sub2 = sub nuw nsw i32 32, %ctlz
  %shl = shl nuw i32 1, %sub2
  %ult = icmp ult i32 %x, -2
  %sel = select i1 %ult, i32 %shl, i32 1
  ret i32 %sel
}

; Commuted select operands should still be recognized.
define i32 @bit_ceil_commuted_operands(i32 %x) {
; CHECK-LABEL: @bit_ceil_commuted_operands(
; CHECK-NEXT:    [[DEC:%.*]] = add i32 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[DEC]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[TMP1:%.*]] = sub nsw i32 0, [[CTLZ]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], 31
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw i32 1, [[TMP2]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %dec = add i32 %x, -1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %dec, i1 false)
  %sub = sub i32 32, %ctlz
  %shl = shl i32 1, %sub
  %eq = icmp eq i32 %dec, 0
  %sel = select i1 %eq, i32 1, i32 %shl
  ret i32 %sel
}

; Negative test: wrong select constant
define i32 @bit_ceil_wrong_select_constant(i32 %x) {
; CHECK-LABEL: @bit_ceil_wrong_select_constant(
; CHECK-NEXT:    [[DEC:%.*]] = add i32 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[DEC]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[SUB:%.*]] = sub nuw nsw i32 32, [[CTLZ]]
; CHECK-NEXT:    [[SHL:%.*]] = shl nuw i32 1, [[SUB]]
; CHECK-NEXT:    [[UGT_INV:%.*]] = icmp ult i32 [[X]], 2
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[UGT_INV]], i32 2, i32 [[SHL]]
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %dec = add i32 %x, -1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %dec, i1 false)
  %sub = sub i32 32, %ctlz
  %shl = shl i32 1, %sub
  %ugt = icmp ugt i32 %x, 1
  %sel = select i1 %ugt, i32 %shl, i32 2
  ret i32 %sel
}

; Negative test: select condition != false does not guarantee ctlz being either 0 or 32
define i32 @bit_ceil_32_wrong_cond(i32 %x) {
; CHECK-LABEL: @bit_ceil_32_wrong_cond(
; CHECK-NEXT:    [[DEC:%.*]] = add i32 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[DEC]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[SUB:%.*]] = sub nuw nsw i32 32, [[CTLZ]]
; CHECK-NEXT:    [[SHL:%.*]] = shl nuw i32 1, [[SUB]]
; CHECK-NEXT:    [[UGT:%.*]] = icmp ugt i32 [[X]], 2
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[UGT]], i32 [[SHL]], i32 1
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %dec = add i32 %x, -1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %dec, i1 false)
  %sub = sub i32 32, %ctlz
  %shl = shl i32 1, %sub
  %ugt = icmp ugt i32 %x, 2
  %sel = select i1 %ugt, i32 %shl, i32 1
  ret i32 %sel
}

; Negative test: wrong sub constant
define i32 @bit_ceil_wrong_sub_constant(i32 %x) {
; CHECK-LABEL: @bit_ceil_wrong_sub_constant(
; CHECK-NEXT:    [[DEC:%.*]] = add i32 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[DEC]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[SUB:%.*]] = sub nuw nsw i32 33, [[CTLZ]]
; CHECK-NEXT:    [[SHL:%.*]] = shl nuw i32 1, [[SUB]]
; CHECK-NEXT:    [[UGT:%.*]] = icmp ugt i32 [[X]], 1
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[UGT]], i32 [[SHL]], i32 1
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %dec = add i32 %x, -1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %dec, i1 false)
  %sub = sub i32 33, %ctlz
  %shl = shl i32 1, %sub
  %ugt = icmp ugt i32 %x, 1
  %sel = select i1 %ugt, i32 %shl, i32 1
  ret i32 %sel
}

; Negative test: the shl result used twice
define i32 @bit_ceil_32_shl_used_twice(i32 %x, ptr %p) {
; CHECK-LABEL: @bit_ceil_32_shl_used_twice(
; CHECK-NEXT:    [[DEC:%.*]] = add i32 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[DEC]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[SUB:%.*]] = sub nuw nsw i32 32, [[CTLZ]]
; CHECK-NEXT:    [[SHL:%.*]] = shl nuw i32 1, [[SUB]]
; CHECK-NEXT:    [[UGT:%.*]] = icmp ugt i32 [[X]], 1
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[UGT]], i32 [[SHL]], i32 1
; CHECK-NEXT:    store i32 [[SHL]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %dec = add i32 %x, -1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %dec, i1 false)
  %sub = sub i32 32, %ctlz
  %shl = shl i32 1, %sub
  %ugt = icmp ugt i32 %x, 1
  %sel = select i1 %ugt, i32 %shl, i32 1
  store i32 %shl, ptr %p, align 4
  ret i32 %sel
}

; Negative test: the sub result used twice
define i32 @bit_ceil_32_sub_used_twice(i32 %x, ptr %p) {
; CHECK-LABEL: @bit_ceil_32_sub_used_twice(
; CHECK-NEXT:    [[DEC:%.*]] = add i32 [[X:%.*]], -1
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call i32 @llvm.ctlz.i32(i32 [[DEC]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[SUB:%.*]] = sub nuw nsw i32 32, [[CTLZ]]
; CHECK-NEXT:    [[SHL:%.*]] = shl nuw i32 1, [[SUB]]
; CHECK-NEXT:    [[UGT:%.*]] = icmp ugt i32 [[X]], 1
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[UGT]], i32 [[SHL]], i32 1
; CHECK-NEXT:    store i32 [[SUB]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret i32 [[SEL]]
;
  %dec = add i32 %x, -1
  %ctlz = tail call i32 @llvm.ctlz.i32(i32 %dec, i1 false)
  %sub = sub i32 32, %ctlz
  %shl = shl i32 1, %sub
  %ugt = icmp ugt i32 %x, 1
  %sel = select i1 %ugt, i32 %shl, i32 1
  store i32 %sub, ptr %p, align 4
  ret i32 %sel
}

; a vector version of @bit_ceil_32 above
define <4 x i32> @bit_ceil_v4i32(<4 x i32> %x) {
; CHECK-LABEL: @bit_ceil_v4i32(
; CHECK-NEXT:    [[DEC:%.*]] = add <4 x i32> [[X:%.*]], <i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[CTLZ:%.*]] = tail call <4 x i32> @llvm.ctlz.v4i32(<4 x i32> [[DEC]], i1 false), !range [[RNG0]]
; CHECK-NEXT:    [[TMP1:%.*]] = sub nsw <4 x i32> zeroinitializer, [[CTLZ]]
; CHECK-NEXT:    [[TMP2:%.*]] = and <4 x i32> [[TMP1]], <i32 31, i32 31, i32 31, i32 31>
; CHECK-NEXT:    [[SEL:%.*]] = shl nuw <4 x i32> <i32 1, i32 1, i32 1, i32 1>, [[TMP2]]
; CHECK-NEXT:    ret <4 x i32> [[SEL]]
;
  %dec = add <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %ctlz = tail call <4 x i32> @llvm.ctlz.v4i32(<4 x i32> %dec, i1 false)
  %sub = sub <4 x i32> <i32 32, i32 32, i32 32, i32 32>, %ctlz
  %shl = shl <4 x i32> <i32 1, i32 1, i32 1, i32 1>, %sub
  %ugt = icmp ugt <4 x i32> %x, <i32 1, i32 1, i32 1, i32 1>
  %sel = select <4 x i1> %ugt, <4 x i32> %shl, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %sel
}

declare i32 @llvm.ctlz.i32(i32, i1 immarg)
declare i64 @llvm.ctlz.i64(i64, i1 immarg)
declare <4 x i32> @llvm.ctlz.v4i32(<4 x i32>, i1)
