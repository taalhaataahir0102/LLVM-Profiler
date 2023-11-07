; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -S -passes=memcpyopt -verify-memoryssa | FileCheck %s

; Check that we don't introduce llvm.lifetime.end.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-grtev4-linux-gnu"

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #0
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg)

define void @test() {
; CHECK-LABEL: define void @test() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[AGG_TMP_SROA_14:%.*]] = alloca [20 x i8], align 4
; CHECK-NEXT:    [[AGG_TMP_SROA_14_128_SROA_IDX:%.*]] = getelementptr i8, ptr [[AGG_TMP_SROA_14]], i64 4
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 20, ptr [[AGG_TMP_SROA_14]])
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr [[AGG_TMP_SROA_14_128_SROA_IDX]], i8 0, i64 1, i1 false)
; CHECK-NEXT:    [[AGG_TMP3_SROA_35_128_SROA_IDX:%.*]] = getelementptr i8, ptr [[AGG_TMP_SROA_14]], i64 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr inttoptr (i64 4 to ptr), i8 0, i64 1, i1 false)
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 20, ptr [[AGG_TMP_SROA_14]])
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr null, i8 0, i64 1, i1 false)
; CHECK-NEXT:    ret void
;
entry:
  %agg.tmp3.sroa.35 = alloca [20 x i8], align 4
  %agg.tmp.sroa.14 = alloca [20 x i8], align 4
  %agg.tmp.sroa.14.128.sroa_idx = getelementptr i8, ptr %agg.tmp.sroa.14, i64 4
  call void @llvm.memset.p0.i64(ptr %agg.tmp.sroa.14.128.sroa_idx, i8 0, i64 1, i1 false)
  call void @llvm.lifetime.start.p0(i64 20, ptr %agg.tmp3.sroa.35)
  call void @llvm.memcpy.p0.p0.i64(ptr %agg.tmp3.sroa.35, ptr %agg.tmp.sroa.14, i64 20, i1 false)
  %agg.tmp3.sroa.35.128.sroa_idx = getelementptr i8, ptr %agg.tmp3.sroa.35, i64 4
  call void @llvm.memcpy.p0.p0.i64(ptr inttoptr (i64 4 to ptr), ptr %agg.tmp3.sroa.35.128.sroa_idx, i64 1, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr null, ptr inttoptr (i64 4 to ptr), i64 1, i1 false)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; uselistorder directives
uselistorder i64 4, { 2, 0, 1 }
uselistorder ptr @llvm.memcpy.p0.p0.i64, { 2, 1, 0 }

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
