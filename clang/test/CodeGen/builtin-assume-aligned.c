// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple x86_64-unknown-unknown -emit-llvm -o - %s | FileCheck %s

// CHECK-LABEL: @test1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(ptr [[TMP0]], i64 32, i64 0) ]
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[TMP3]], i64 0
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
// CHECK-NEXT:    ret i32 [[TMP4]]
//
int test1(int *a) {
  a = __builtin_assume_aligned(a, 32, 0ull);
  return a[0];
}

// CHECK-LABEL: @test2(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(ptr [[TMP0]], i64 32, i64 0) ]
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[TMP3]], i64 0
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
// CHECK-NEXT:    ret i32 [[TMP4]]
//
int test2(int *a) {
  a = __builtin_assume_aligned(a, 32, 0);
  return a[0];
}

// CHECK-LABEL: @test3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(ptr [[TMP0]], i64 32) ]
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[TMP3]], i64 0
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
// CHECK-NEXT:    ret i32 [[TMP4]]
//
int test3(int *a) {
  a = __builtin_assume_aligned(a, 32);
  return a[0];
}

// CHECK-LABEL: @test4(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store ptr [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    store i32 [[B:%.*]], ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[CONV:%.*]] = sext i32 [[TMP2]] to i64
// CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(ptr [[TMP0]], i64 32, i64 [[CONV]]) ]
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[TMP4]], i64 0
// CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
// CHECK-NEXT:    ret i32 [[TMP5]]
//
int test4(int *a, int b) {
  a = __builtin_assume_aligned(a, 32, b);
  return a[0];
}

int *m1(void) __attribute__((assume_aligned(64)));

// CHECK-LABEL: @test5(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = call align 64 ptr @m1()
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[CALL]], align 4
// CHECK-NEXT:    ret i32 [[TMP0]]
//
int test5(void) {
  return *m1();
}

int *m2(void) __attribute__((assume_aligned(64, 12)));

// CHECK-LABEL: @test6(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = call ptr @m2()
// CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(ptr [[CALL]], i64 64, i64 12) ]
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[CALL]], align 4
// CHECK-NEXT:    ret i32 [[TMP0]]
//
int test6(void) {
  return *m2();
}

// CHECK-LABEL: @pr43638(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    store ptr [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    call void @llvm.assume(i1 true) [ "align"(ptr [[TMP0]], i64 4294967296) ]
// CHECK-NEXT:    store ptr [[TMP0]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[A_ADDR]], align 8
// CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[TMP3]], i64 0
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
// CHECK-NEXT:    ret i32 [[TMP4]]
//
int pr43638(int *a) {
  a = __builtin_assume_aligned(a, 4294967296);
return a[0];
}