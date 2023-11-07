; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=armv8-a-linux-gnueabihf -arm-parallel-dsp -dce --verify %s -S -o - | FileCheck %s

define dso_local void @a() align 2 {
; CHECK-LABEL: @a(
; CHECK-NEXT:  for.end:
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[TMP0:%.*]] = load i16, ptr @a, align 2
; CHECK-NEXT:    [[CONV:%.*]] = sext i16 [[TMP0]] to i32
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i32 [[CONV]], [[CONV]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i16, ptr getelementptr (i16, ptr @a, i32 1), align 2
; CHECK-NEXT:    [[CONV3:%.*]] = sext i16 [[TMP1]] to i32
; CHECK-NEXT:    [[MUL6:%.*]] = mul nsw i32 [[CONV3]], [[CONV3]]
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[MUL6]], [[MUL]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i16, ptr getelementptr (i16, ptr @a, i32 2), align 2
; CHECK-NEXT:    [[CONV11:%.*]] = sext i16 [[TMP2]] to i32
; CHECK-NEXT:    [[MUL12:%.*]] = mul nsw i32 [[CONV11]], [[CONV3]]
; CHECK-NEXT:    [[ADD14:%.*]] = add nsw i32 [[MUL12]], [[ADD]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i16, ptr getelementptr (i16, ptr @a, i32 3), align 2
; CHECK-NEXT:    [[CONV17:%.*]] = sext i16 [[TMP3]] to i32
; CHECK-NEXT:    [[ADD19:%.*]] = add nsw i32 [[ADD14]], [[CONV17]]
; CHECK-NEXT:    store i32 [[ADD19]], ptr [[B]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = load i16, ptr getelementptr (i16, ptr @a, i32 4), align 2
; CHECK-NEXT:    [[CONV21:%.*]] = sext i16 [[TMP4]] to i32
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i32, ptr [[B]], i32 [[CONV21]]
; CHECK-NEXT:    [[ARRAYIDX22:%.*]] = getelementptr inbounds i32, ptr [[ADD_PTR]], i32 9
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[ARRAYIDX22]], align 4
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[TMP5]], 1
; CHECK-NEXT:    store i32 [[SHL]], ptr [[ARRAYIDX22]], align 4
; CHECK-NEXT:    br label [[FOR_COND23:%.*]]
; CHECK:       for.cond23:
; CHECK-NEXT:    br label [[FOR_COND23]]
;
for.end:
  %b = alloca i32, align 4
  %0 = load i16, ptr @a, align 2
  %conv = sext i16 %0 to i32
  %mul = mul nsw i32 %conv, %conv
  %1 = load i16, ptr getelementptr (i16, ptr @a, i32 1), align 2
  %conv3 = sext i16 %1 to i32
  %mul6 = mul nsw i32 %conv3, %conv3
  %add = add nuw nsw i32 %mul6, %mul
  %2 = load i16, ptr getelementptr (i16, ptr @a, i32 2), align 2
  %conv11 = sext i16 %2 to i32
  %mul12 = mul nsw i32 %conv11, %conv3
  %add14 = add nsw i32 %mul12, %add
  %3 = load i16, ptr getelementptr (i16, ptr @a, i32 3), align 2
  %conv17 = sext i16 %3 to i32
  %add19 = add nsw i32 %add14, %conv17
  store i32 %add19, ptr %b, align 4
  %4 = load i16, ptr getelementptr (i16, ptr @a, i32 4), align 2
  %conv21 = sext i16 %4 to i32
  %add.ptr = getelementptr inbounds i32, ptr %b, i32 %conv21
  %arrayidx22 = getelementptr inbounds i32, ptr %add.ptr, i32 9
  %5 = load i32, ptr %arrayidx22, align 4
  %shl = shl i32 %5, 1
  store i32 %shl, ptr %arrayidx22, align 4
  br label %for.cond23

for.cond23:                                       ; preds = %for.cond23, %for.end
  br label %for.cond23
}

define i32 @accumulate_square_a0(ptr %a, ptr %b, i32 %acc) {
; CHECK-LABEL: @accumulate_square_a0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADDR_A_1:%.*]] = getelementptr i16, ptr [[A:%.*]], i32 1
; CHECK-NEXT:    [[ADDR_B_1:%.*]] = getelementptr i16, ptr [[B:%.*]], i32 1
; CHECK-NEXT:    [[LD_A_0:%.*]] = load i16, ptr [[A]]
; CHECK-NEXT:    [[SEXT_A_0:%.*]] = sext i16 [[LD_A_0]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ADDR_A_1]], align 2
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i32 [[TMP1]] to i16
; CHECK-NEXT:    [[TMP3:%.*]] = sext i16 [[TMP2]] to i32
; CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[ADDR_B_1]], align 2
; CHECK-NEXT:    [[TMP6:%.*]] = trunc i32 [[TMP5]] to i16
; CHECK-NEXT:    [[TMP7:%.*]] = sext i16 [[TMP6]] to i32
; CHECK-NEXT:    [[MUL_0:%.*]] = mul i32 [[SEXT_A_0]], [[SEXT_A_0]]
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[MUL_0]], [[ACC:%.*]]
; CHECK-NEXT:    [[MUL_1:%.*]] = mul i32 [[TMP3]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = add i32 [[MUL_1]], [[TMP8]]
; CHECK-NEXT:    [[TMP10:%.*]] = call i32 @llvm.arm.smlad(i32 [[TMP1]], i32 [[TMP5]], i32 [[TMP9]])
; CHECK-NEXT:    ret i32 [[TMP10]]
;
entry:
  %addr.a.1 = getelementptr i16, ptr %a, i32 1
  %addr.b.1 = getelementptr i16, ptr %b, i32 1
  %ld.a.0 = load i16, ptr %a
  %sext.a.0 = sext i16 %ld.a.0 to i32
  %ld.b.0 = load i16, ptr %b
  %ld.a.1 = load i16, ptr %addr.a.1
  %ld.b.1 = load i16, ptr %addr.b.1
  %sext.a.1 = sext i16 %ld.a.1 to i32
  %sext.b.1 = sext i16 %ld.b.1 to i32
  %sext.b.0 = sext i16 %ld.b.0 to i32
  %mul.0 = mul i32 %sext.a.0, %sext.a.0
  %mul.1 = mul i32 %sext.a.1, %sext.b.1
  %addr.a.2 = getelementptr i16, ptr %a, i32 2
  %addr.b.2 = getelementptr i16, ptr %b, i32 2
  %ld.a.2 = load i16, ptr %addr.a.2
  %ld.b.2 = load i16, ptr %addr.b.2
  %sext.a.2 = sext i16 %ld.a.2 to i32
  %sext.b.2 = sext i16 %ld.b.2 to i32
  %mul.2 = mul i32 %sext.a.2, %sext.b.2
  %add = add i32 %mul.0, %mul.1
  %add.1 = add i32 %mul.1, %mul.2
  %add.2 = add i32 %add.1, %add
  %res = add i32 %add.2, %acc
  ret i32 %res
}

define i32 @accumulate_square_a2(ptr %a, ptr %b, i32 %acc) {
; CHECK-LABEL: @accumulate_square_a2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[A:%.*]], align 2
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP1]], 16
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i32 [[TMP2]] to i16
; CHECK-NEXT:    [[TMP4:%.*]] = sext i16 [[TMP3]] to i32
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[B:%.*]], align 2
; CHECK-NEXT:    [[TMP7:%.*]] = lshr i32 [[TMP6]], 16
; CHECK-NEXT:    [[TMP8:%.*]] = trunc i32 [[TMP7]] to i16
; CHECK-NEXT:    [[TMP9:%.*]] = sext i16 [[TMP8]] to i32
; CHECK-NEXT:    [[MUL_1:%.*]] = mul i32 [[TMP4]], [[TMP9]]
; CHECK-NEXT:    [[ADDR_A_2:%.*]] = getelementptr i16, ptr [[A]], i32 2
; CHECK-NEXT:    [[ADDR_B_2:%.*]] = getelementptr i16, ptr [[B]], i32 2
; CHECK-NEXT:    [[LD_A_2:%.*]] = load i16, ptr [[ADDR_A_2]]
; CHECK-NEXT:    [[LD_B_2:%.*]] = load i16, ptr [[ADDR_B_2]]
; CHECK-NEXT:    [[SEXT_A_2:%.*]] = sext i16 [[LD_A_2]] to i32
; CHECK-NEXT:    [[SEXT_B_2:%.*]] = sext i16 [[LD_B_2]] to i32
; CHECK-NEXT:    [[MUL_2:%.*]] = mul i32 [[SEXT_A_2]], [[SEXT_A_2]]
; CHECK-NEXT:    [[TMP10:%.*]] = add i32 [[MUL_2]], [[ACC:%.*]]
; CHECK-NEXT:    [[TMP11:%.*]] = add i32 [[MUL_1]], [[TMP10]]
; CHECK-NEXT:    [[TMP12:%.*]] = call i32 @llvm.arm.smlad(i32 [[TMP1]], i32 [[TMP6]], i32 [[TMP11]])
; CHECK-NEXT:    [[RES:%.*]] = add i32 [[TMP12]], [[SEXT_B_2]]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %addr.a.1 = getelementptr i16, ptr %a, i32 1
  %addr.b.1 = getelementptr i16, ptr %b, i32 1
  %ld.a.0 = load i16, ptr %a
  %sext.a.0 = sext i16 %ld.a.0 to i32
  %ld.b.0 = load i16, ptr %b
  %ld.a.1 = load i16, ptr %addr.a.1
  %ld.b.1 = load i16, ptr %addr.b.1
  %sext.a.1 = sext i16 %ld.a.1 to i32
  %sext.b.1 = sext i16 %ld.b.1 to i32
  %sext.b.0 = sext i16 %ld.b.0 to i32
  %mul.0 = mul i32 %sext.a.0, %sext.b.0
  %mul.1 = mul i32 %sext.a.1, %sext.b.1
  %addr.a.2 = getelementptr i16, ptr %a, i32 2
  %addr.b.2 = getelementptr i16, ptr %b, i32 2
  %ld.a.2 = load i16, ptr %addr.a.2
  %ld.b.2 = load i16, ptr %addr.b.2
  %sext.a.2 = sext i16 %ld.a.2 to i32
  %sext.b.2 = sext i16 %ld.b.2 to i32
  %mul.2 = mul i32 %sext.a.2, %sext.a.2
  %add = add i32 %mul.0, %mul.1
  %add.1 = add i32 %mul.1, %mul.2
  %add.2 = add i32 %add.1, %add
  %add.3 = add i32 %add.2, %acc
  %res = add i32 %add.3, %sext.b.2
  ret i32 %res
}

define i32 @accumulate_square_b2(ptr %a, ptr %b, i32 %acc) {
; CHECK-LABEL: @accumulate_square_b2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADDR_A_1:%.*]] = getelementptr i16, ptr [[A:%.*]], i32 1
; CHECK-NEXT:    [[ADDR_B_1:%.*]] = getelementptr i16, ptr [[B:%.*]], i32 1
; CHECK-NEXT:    [[LD_A_0:%.*]] = load i16, ptr [[A]]
; CHECK-NEXT:    [[SEXT_A_0:%.*]] = sext i16 [[LD_A_0]] to i32
; CHECK-NEXT:    [[LD_A_1:%.*]] = load i16, ptr [[ADDR_A_1]]
; CHECK-NEXT:    [[LD_B_1:%.*]] = load i16, ptr [[ADDR_B_1]]
; CHECK-NEXT:    [[SEXT_A_1:%.*]] = sext i16 [[LD_A_1]] to i32
; CHECK-NEXT:    [[SEXT_B_1:%.*]] = sext i16 [[LD_B_1]] to i32
; CHECK-NEXT:    [[MUL_0:%.*]] = mul i32 [[SEXT_A_0]], [[SEXT_A_0]]
; CHECK-NEXT:    [[MUL_1:%.*]] = mul i32 [[SEXT_A_1]], [[SEXT_B_1]]
; CHECK-NEXT:    [[ADDR_B_2:%.*]] = getelementptr i16, ptr [[B]], i32 2
; CHECK-NEXT:    [[LD_B_2:%.*]] = load i16, ptr [[ADDR_B_2]]
; CHECK-NEXT:    [[SEXT_B_2:%.*]] = sext i16 [[LD_B_2]] to i32
; CHECK-NEXT:    [[MUL_2:%.*]] = mul i32 [[SEXT_B_2]], [[SEXT_B_2]]
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[MUL_0]], [[MUL_1]]
; CHECK-NEXT:    [[ADD_1:%.*]] = add i32 [[MUL_1]], [[MUL_2]]
; CHECK-NEXT:    [[ADD_2:%.*]] = add i32 [[ADD_1]], [[ADD]]
; CHECK-NEXT:    [[RES:%.*]] = add i32 [[ADD_2]], [[ACC:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %addr.a.1 = getelementptr i16, ptr %a, i32 1
  %addr.b.1 = getelementptr i16, ptr %b, i32 1
  %ld.a.0 = load i16, ptr %a
  %sext.a.0 = sext i16 %ld.a.0 to i32
  %ld.b.0 = load i16, ptr %b
  %ld.a.1 = load i16, ptr %addr.a.1
  %ld.b.1 = load i16, ptr %addr.b.1
  %sext.a.1 = sext i16 %ld.a.1 to i32
  %sext.b.1 = sext i16 %ld.b.1 to i32
  %sext.b.0 = sext i16 %ld.b.0 to i32
  %mul.0 = mul i32 %sext.a.0, %sext.a.0
  %mul.1 = mul i32 %sext.a.1, %sext.b.1
  %addr.a.2 = getelementptr i16, ptr %a, i32 2
  %addr.b.2 = getelementptr i16, ptr %b, i32 2
  %ld.a.2 = load i16, ptr %addr.a.2
  %ld.b.2 = load i16, ptr %addr.b.2
  %sext.a.2 = sext i16 %ld.a.2 to i32
  %sext.b.2 = sext i16 %ld.b.2 to i32
  %mul.2 = mul i32 %sext.b.2, %sext.b.2
  %add = add i32 %mul.0, %mul.1
  %add.1 = add i32 %mul.1, %mul.2
  %add.2 = add i32 %add.1, %add
  %add.3 = add i32 %add.2, %sext.a.2
  %res = add i32 %add.2, %acc
  ret i32 %res
}

define i32 @accumulate_square_a1(ptr %a, ptr %b, i32 %acc) {
; CHECK-LABEL: @accumulate_square_a1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADDR_A_1:%.*]] = getelementptr i16, ptr [[A:%.*]], i32 1
; CHECK-NEXT:    [[ADDR_B_1:%.*]] = getelementptr i16, ptr [[B:%.*]], i32 1
; CHECK-NEXT:    [[LD_A_0:%.*]] = load i16, ptr [[A]]
; CHECK-NEXT:    [[SEXT_A_0:%.*]] = sext i16 [[LD_A_0]] to i32
; CHECK-NEXT:    [[LD_A_1:%.*]] = load i16, ptr [[ADDR_A_1]]
; CHECK-NEXT:    [[LD_B_1:%.*]] = load i16, ptr [[ADDR_B_1]]
; CHECK-NEXT:    [[SEXT_A_1:%.*]] = sext i16 [[LD_A_1]] to i32
; CHECK-NEXT:    [[SEXT_B_1:%.*]] = sext i16 [[LD_B_1]] to i32
; CHECK-NEXT:    [[MUL_0:%.*]] = mul i32 [[SEXT_A_0]], [[SEXT_A_0]]
; CHECK-NEXT:    [[MUL_1:%.*]] = mul i32 [[SEXT_A_1]], [[SEXT_A_1]]
; CHECK-NEXT:    [[ADDR_A_2:%.*]] = getelementptr i16, ptr [[A]], i32 2
; CHECK-NEXT:    [[ADDR_B_2:%.*]] = getelementptr i16, ptr [[B]], i32 2
; CHECK-NEXT:    [[LD_A_2:%.*]] = load i16, ptr [[ADDR_A_2]]
; CHECK-NEXT:    [[LD_B_2:%.*]] = load i16, ptr [[ADDR_B_2]]
; CHECK-NEXT:    [[SEXT_A_2:%.*]] = sext i16 [[LD_A_2]] to i32
; CHECK-NEXT:    [[SEXT_B_2:%.*]] = sext i16 [[LD_B_2]] to i32
; CHECK-NEXT:    [[MUL_2:%.*]] = mul i32 [[SEXT_A_2]], [[SEXT_B_2]]
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[MUL_1]], [[SEXT_B_1]]
; CHECK-NEXT:    [[ADD_1:%.*]] = add i32 [[MUL_0]], [[ADD]]
; CHECK-NEXT:    [[ADD_2:%.*]] = add i32 [[MUL_1]], [[MUL_2]]
; CHECK-NEXT:    [[ADD_3:%.*]] = add i32 [[ADD_2]], [[ADD_1]]
; CHECK-NEXT:    [[ADD_4:%.*]] = add i32 [[ADD_3]], [[SEXT_A_2]]
; CHECK-NEXT:    [[RES:%.*]] = add i32 [[ADD_4]], [[ACC:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %addr.a.1 = getelementptr i16, ptr %a, i32 1
  %addr.b.1 = getelementptr i16, ptr %b, i32 1
  %ld.a.0 = load i16, ptr %a
  %sext.a.0 = sext i16 %ld.a.0 to i32
  %ld.b.0 = load i16, ptr %b
  %ld.a.1 = load i16, ptr %addr.a.1
  %ld.b.1 = load i16, ptr %addr.b.1
  %sext.a.1 = sext i16 %ld.a.1 to i32
  %sext.b.1 = sext i16 %ld.b.1 to i32
  %sext.b.0 = sext i16 %ld.b.0 to i32
  %mul.0 = mul i32 %sext.a.0, %sext.a.0
  %mul.1 = mul i32 %sext.a.1, %sext.a.1
  %addr.a.2 = getelementptr i16, ptr %a, i32 2
  %addr.b.2 = getelementptr i16, ptr %b, i32 2
  %ld.a.2 = load i16, ptr %addr.a.2
  %ld.b.2 = load i16, ptr %addr.b.2
  %sext.a.2 = sext i16 %ld.a.2 to i32
  %sext.b.2 = sext i16 %ld.b.2 to i32
  %mul.2 = mul i32 %sext.a.2, %sext.b.2
  %add = add i32 %mul.1, %sext.b.1
  %add.1 = add i32 %mul.0, %add
  %add.2 = add i32 %mul.1, %mul.2
  %add.3 = add i32 %add.2, %add.1
  %add.4 = add i32 %add.3, %sext.a.2
  %res = add i32 %add.4, %acc
  ret i32 %res
}
