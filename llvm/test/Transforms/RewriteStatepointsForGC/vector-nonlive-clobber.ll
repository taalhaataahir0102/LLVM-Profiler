; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=rewrite-statepoints-for-gc -rs4gc-clobber-non-live %s | FileCheck %s
; Make sure that clobber-non-live correctly handles vector types

define void @test_vector_clobber(ptr addrspace(1) %ptr) gc "statepoint-example" {
; CHECK-LABEL: @test_vector_clobber(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 0, ptr elementtype(void ()) @foo, i32 0, i32 0, i32 0, i32 0) [ "deopt"(i32 0, i32 2, i32 0, i32 62, i32 0, i32 13, i32 0, i32 7, ptr null, i32 7, ptr null, i32 7, ptr null, i32 3, i32 14, i32 3, i32 -2406, i32 3, i32 28963, i32 3, i32 30401, i32 3, i32 -11, i32 3, i32 -5, i32 3, i32 1, i32 0, ptr addrspace(1) [[PTR:%.*]], i32 0, ptr addrspace(1) [[PTR]], i32 7, ptr null), "gc-live"(ptr addrspace(1) [[PTR]]) ]
; CHECK-NEXT:    [[PTR_RELOCATED:%.*]] = call coldcc ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token [[STATEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    [[DOTSPLATINSERT_BASE:%.*]] = insertelement <8 x ptr addrspace(1)> zeroinitializer, ptr addrspace(1) [[PTR_RELOCATED]], i64 0, !is_base_value !0
; CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <8 x ptr addrspace(1)> poison, ptr addrspace(1) [[PTR_RELOCATED]], i64 0
; CHECK-NEXT:    [[DOTSPLAT_BASE:%.*]] = shufflevector <8 x ptr addrspace(1)> [[DOTSPLATINSERT_BASE]], <8 x ptr addrspace(1)> poison, <8 x i32> zeroinitializer, !is_base_value !0
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <8 x ptr addrspace(1)> [[DOTSPLATINSERT]], <8 x ptr addrspace(1)> poison, <8 x i32> zeroinitializer
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds float, <8 x ptr addrspace(1)> [[DOTSPLAT]], <8 x i64> <i64 83, i64 81, i64 79, i64 77, i64 75, i64 73, i64 71, i64 69>
; CHECK-NEXT:    [[STATEPOINT_TOKEN1:%.*]] = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 0, ptr elementtype(void ()) @bar, i32 0, i32 0, i32 0, i32 0) [ "deopt"(i32 0, i32 1, i32 0, i32 112, i32 0, i32 13, i32 0, i32 7, ptr null, i32 7, ptr null, i32 3, i32 poison, i32 3, i32 14, i32 3, i32 -2406, i32 3, i32 28963, i32 3, i32 30401, i32 3, i32 -11, i32 3, i32 -5, i32 3, i32 1, i32 0, ptr addrspace(1) [[PTR_RELOCATED]], i32 0, ptr addrspace(1) [[PTR_RELOCATED]], i32 7, ptr null), "gc-live"(<8 x ptr addrspace(1)> [[GEP]], ptr addrspace(1) [[PTR_RELOCATED]], <8 x ptr addrspace(1)> [[DOTSPLAT_BASE]]) ]
; CHECK-NEXT:    [[GEP_RELOCATED:%.*]] = call coldcc <8 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v8p1(token [[STATEPOINT_TOKEN1]], i32 2, i32 0)
; CHECK-NEXT:    [[PTR_RELOCATED2:%.*]] = call coldcc ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token [[STATEPOINT_TOKEN1]], i32 1, i32 1)
; CHECK-NEXT:    [[DOTSPLAT_BASE_RELOCATED:%.*]] = call coldcc <8 x ptr addrspace(1)> @llvm.experimental.gc.relocate.v8p1(token [[STATEPOINT_TOKEN1]], i32 2, i32 2)
; CHECK-NEXT:    [[RES:%.*]] = call <8 x float> @llvm.masked.gather.v8f32.v8p1(<8 x ptr addrspace(1)> [[GEP_RELOCATED]], i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> poison)
; CHECK-NEXT:    unreachable
;
entry:
  call void @foo() [ "deopt"(i32 0, i32 2, i32 0, i32 62, i32 0, i32 13, i32 0, i32 7, ptr null, i32 7, ptr null, i32 7, ptr null, i32 3, i32 14, i32 3, i32 -2406, i32 3, i32 28963, i32 3, i32 30401, i32 3, i32 -11, i32 3, i32 -5, i32 3, i32 1, i32 0, ptr addrspace(1) %ptr, i32 0, ptr addrspace(1) %ptr, i32 7, ptr null) ]
  %gep = getelementptr inbounds float, ptr addrspace(1) %ptr, <8 x i64> <i64 83, i64 81, i64 79, i64 77, i64 75, i64 73, i64 71, i64 69>
  call void @bar() [ "deopt"(i32 0, i32 1, i32 0, i32 112, i32 0, i32 13, i32 0, i32 7, ptr null, i32 7, ptr null, i32 3, i32 poison, i32 3, i32 14, i32 3, i32 -2406, i32 3, i32 28963, i32 3, i32 30401, i32 3, i32 -11, i32 3, i32 -5, i32 3, i32 1, i32 0, ptr addrspace(1) %ptr, i32 0, ptr addrspace(1) %ptr, i32 7, ptr null) ]
  %res = call <8 x float> @llvm.masked.gather.v8f32.v8p1(<8 x ptr addrspace(1)> %gep, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x float> poison)
  unreachable
}


declare void @foo() gc "statepoint-example"

; Function Attrs: nocallback nofree nosync nounwind readonly willreturn
declare <8 x float> @llvm.masked.gather.v8f32.v8p1(<8 x ptr addrspace(1)>, i32 immarg, <8 x i1>, <8 x float>) #1

declare void @bar()

attributes #1 = { nocallback nofree nosync nounwind readonly willreturn }
