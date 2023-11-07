; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d -riscv-v-vector-bits-min=128 \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d -riscv-v-vector-bits-min=128 \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

; Test that we can remove trivially-undef VP operations of various kinds.

declare <4 x i32> @llvm.vp.load.v4i32.p0(ptr, <4 x i1>, i32)

define <4 x i32> @vload_v4i32_zero_evl(ptr %ptr, <4 x i1> %m) {
; CHECK-LABEL: vload_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.load.v4i32.p0(ptr %ptr, <4 x i1> %m, i32 0)
  ret <4 x i32> %v
}

define <4 x i32> @vload_v4i32_false_mask(ptr %ptr, i32 %evl) {
; CHECK-LABEL: vload_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.load.v4i32.p0(ptr %ptr, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %v
}

declare <4 x i32> @llvm.vp.gather.v4i32.v4p0(<4 x ptr>, <4 x i1>, i32)

define <4 x i32> @vgather_v4i32_v4i32_zero_evl(<4 x ptr> %ptrs, <4 x i1> %m) {
; CHECK-LABEL: vgather_v4i32_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.gather.v4i32.v4p0(<4 x ptr> %ptrs, <4 x i1> %m, i32 0)
  ret <4 x i32> %v
}

define <4 x i32> @vgather_v4i32_v4i32_false_mask(<4 x ptr> %ptrs, i32 %evl) {
; CHECK-LABEL: vgather_v4i32_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.gather.v4i32.v4p0(<4 x ptr> %ptrs, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %v
}

declare void @llvm.vp.store.v4i32.p0(<4 x i32>, ptr, <4 x i1>, i32)

define void @vstore_v4i32_zero_evl(<4 x i32> %val, ptr %ptr, <4 x i1> %m) {
; CHECK-LABEL: vstore_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  call void @llvm.vp.store.v4i32.p0(<4 x i32> %val, ptr %ptr, <4 x i1> %m, i32 0)
  ret void
}

define void @vstore_v4i32_false_mask(<4 x i32> %val, ptr %ptr, i32 %evl) {
; CHECK-LABEL: vstore_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  call void @llvm.vp.store.v4i32.p0(<4 x i32> %val, ptr %ptr, <4 x i1> zeroinitializer, i32 %evl)
  ret void
}

declare void @llvm.vp.scatter.v4i32.v4p0(<4 x i32>, <4 x ptr>, <4 x i1>, i32)

define void @vscatter_v4i32_zero_evl(<4 x i32> %val, <4 x ptr> %ptrs, <4 x i1> %m) {
; CHECK-LABEL: vscatter_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  call void @llvm.vp.scatter.v4i32.v4p0(<4 x i32> %val, <4 x ptr> %ptrs, <4 x i1> %m, i32 0)
  ret void
}

define void @vscatter_v4i32_false_mask(<4 x i32> %val, <4 x ptr> %ptrs, i32 %evl) {
; CHECK-LABEL: vscatter_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  call void @llvm.vp.scatter.v4i32.v4p0(<4 x i32> %val, <4 x ptr> %ptrs, <4 x i1> zeroinitializer, i32 %evl)
  ret void
}

declare <4 x i32> @llvm.vp.add.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vadd_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vadd_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.add.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vadd_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vadd_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.add.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.and.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vand_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vand_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.and.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vand_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vand_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.and.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.lshr.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vlshr_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vlshr_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.lshr.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vlshr_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vlshr_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.lshr.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.mul.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vmul_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vmul_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.mul.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vmul_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vmul_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.mul.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.or.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vor_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vor_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.or.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vor_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vor_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.or.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.sdiv.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vsdiv_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vsdiv_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.sdiv.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vsdiv_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vsdiv_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.sdiv.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.srem.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vsrem_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vsrem_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.srem.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vsrem_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vsrem_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.srem.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.sub.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vsub_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vsub_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.sub.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vsub_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vsub_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.sub.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.udiv.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vudiv_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vudiv_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.udiv.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vudiv_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vudiv_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.udiv.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.urem.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vurem_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vurem_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.urem.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vurem_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vurem_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.urem.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.vp.xor.v4i32(<4 x i32>, <4 x i32>, <4 x i1>, i32)

define <4 x i32> @vxor_v4i32_zero_evl(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m) {
; CHECK-LABEL: vxor_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.xor.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> %m, i32 0)
  ret <4 x i32> %s
}

define <4 x i32> @vxor_v4i32_false_mask(<4 x i32> %va, <4 x i32> %vb, i32 %evl) {
; CHECK-LABEL: vxor_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x i32> @llvm.vp.xor.v4i32(<4 x i32> %va, <4 x i32> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x i32> %s
}

declare <4 x float> @llvm.vp.fadd.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define <4 x float> @vfadd_v4f32_zero_evl(<4 x float> %va, <4 x float> %vb, <4 x i1> %m) {
; CHECK-LABEL: vfadd_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.fadd.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> %m, i32 0)
  ret <4 x float> %s
}

define <4 x float> @vfadd_v4f32_false_mask(<4 x float> %va, <4 x float> %vb, i32 %evl) {
; CHECK-LABEL: vfadd_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.fadd.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x float> %s
}

declare <4 x float> @llvm.vp.fsub.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define <4 x float> @vfsub_v4f32_zero_evl(<4 x float> %va, <4 x float> %vb, <4 x i1> %m) {
; CHECK-LABEL: vfsub_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.fsub.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> %m, i32 0)
  ret <4 x float> %s
}

define <4 x float> @vfsub_v4f32_false_mask(<4 x float> %va, <4 x float> %vb, i32 %evl) {
; CHECK-LABEL: vfsub_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.fsub.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x float> %s
}

declare <4 x float> @llvm.vp.fmul.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define <4 x float> @vfmul_v4f32_zero_evl(<4 x float> %va, <4 x float> %vb, <4 x i1> %m) {
; CHECK-LABEL: vfmul_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.fmul.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> %m, i32 0)
  ret <4 x float> %s
}

define <4 x float> @vfmul_v4f32_false_mask(<4 x float> %va, <4 x float> %vb, i32 %evl) {
; CHECK-LABEL: vfmul_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.fmul.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x float> %s
}

declare <4 x float> @llvm.vp.fdiv.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define <4 x float> @vfdiv_v4f32_zero_evl(<4 x float> %va, <4 x float> %vb, <4 x i1> %m) {
; CHECK-LABEL: vfdiv_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.fdiv.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> %m, i32 0)
  ret <4 x float> %s
}

define <4 x float> @vfdiv_v4f32_false_mask(<4 x float> %va, <4 x float> %vb, i32 %evl) {
; CHECK-LABEL: vfdiv_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.fdiv.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x float> %s
}

declare <4 x float> @llvm.vp.frem.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

define <4 x float> @vfrem_v4f32_zero_evl(<4 x float> %va, <4 x float> %vb, <4 x i1> %m) {
; CHECK-LABEL: vfrem_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.frem.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> %m, i32 0)
  ret <4 x float> %s
}

define <4 x float> @vfrem_v4f32_false_mask(<4 x float> %va, <4 x float> %vb, i32 %evl) {
; CHECK-LABEL: vfrem_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call <4 x float> @llvm.vp.frem.v4f32(<4 x float> %va, <4 x float> %vb, <4 x i1> zeroinitializer, i32 %evl)
  ret <4 x float> %s
}

declare i32 @llvm.vp.reduce.add.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_add_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_add_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.add.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_add_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_add_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.add.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare i32 @llvm.vp.reduce.mul.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_mul_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_mul_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.mul.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_mul_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_mul_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.mul.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare i32 @llvm.vp.reduce.and.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_and_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_and_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.and.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_and_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_and_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.and.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare i32 @llvm.vp.reduce.or.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_or_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_or_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.or.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_or_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_or_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.or.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare i32 @llvm.vp.reduce.xor.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_xor_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_xor_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.xor.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_xor_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_xor_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.xor.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare i32 @llvm.vp.reduce.smax.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_smax_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_smax_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.smax.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_smax_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_smax_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.smax.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare i32 @llvm.vp.reduce.smin.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_smin_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_smin_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.smin.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_smin_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_smin_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.smin.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare i32 @llvm.vp.reduce.umax.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_umax_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_umax_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.umax.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_umax_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_umax_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.umax.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare i32 @llvm.vp.reduce.umin.v4i32(i32, <4 x i32>, <4 x i1>, i32)

define i32 @vreduce_umin_v4i32_zero_evl(i32 %start, <4 x i32> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_umin_v4i32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.umin.v4i32(i32 %start, <4 x i32> %val, <4 x i1> %m, i32 0)
  ret i32 %s
}

define i32 @vreduce_umin_v4i32_false_mask(i32 %start, <4 x i32> %val, i32 %evl) {
; CHECK-LABEL: vreduce_umin_v4i32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call i32 @llvm.vp.reduce.umin.v4i32(i32 %start, <4 x i32> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret i32 %s
}

declare float @llvm.vp.reduce.fadd.v4f32(float, <4 x float>, <4 x i1>, i32)

define float @vreduce_seq_fadd_v4f32_zero_evl(float %start, <4 x float> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_seq_fadd_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call float @llvm.vp.reduce.fadd.v4f32(float %start, <4 x float> %val, <4 x i1> %m, i32 0)
  ret float %s
}

define float @vreduce_seq_fadd_v4f32_false_mask(float %start, <4 x float> %val, i32 %evl) {
; CHECK-LABEL: vreduce_seq_fadd_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call float @llvm.vp.reduce.fadd.v4f32(float %start, <4 x float> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret float %s
}

define float @vreduce_fadd_v4f32_zero_evl(float %start, <4 x float> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_fadd_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call reassoc float @llvm.vp.reduce.fadd.v4f32(float %start, <4 x float> %val, <4 x i1> %m, i32 0)
  ret float %s
}

define float @vreduce_fadd_v4f32_false_mask(float %start, <4 x float> %val, i32 %evl) {
; CHECK-LABEL: vreduce_fadd_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call reassoc float @llvm.vp.reduce.fadd.v4f32(float %start, <4 x float> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret float %s
}

declare float @llvm.vp.reduce.fmul.v4f32(float, <4 x float>, <4 x i1>, i32)

define float @vreduce_seq_fmul_v4f32_zero_evl(float %start, <4 x float> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_seq_fmul_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call float @llvm.vp.reduce.fmul.v4f32(float %start, <4 x float> %val, <4 x i1> %m, i32 0)
  ret float %s
}

define float @vreduce_seq_fmul_v4f32_false_mask(float %start, <4 x float> %val, i32 %evl) {
; CHECK-LABEL: vreduce_seq_fmul_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call float @llvm.vp.reduce.fmul.v4f32(float %start, <4 x float> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret float %s
}

define float @vreduce_fmul_v4f32_zero_evl(float %start, <4 x float> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_fmul_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call reassoc float @llvm.vp.reduce.fmul.v4f32(float %start, <4 x float> %val, <4 x i1> %m, i32 0)
  ret float %s
}

define float @vreduce_fmul_v4f32_false_mask(float %start, <4 x float> %val, i32 %evl) {
; CHECK-LABEL: vreduce_fmul_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call reassoc float @llvm.vp.reduce.fmul.v4f32(float %start, <4 x float> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret float %s
}

declare float @llvm.vp.reduce.fmin.v4f32(float, <4 x float>, <4 x i1>, i32)

define float @vreduce_fmin_v4f32_zero_evl(float %start, <4 x float> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_fmin_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call float @llvm.vp.reduce.fmin.v4f32(float %start, <4 x float> %val, <4 x i1> %m, i32 0)
  ret float %s
}

define float @vreduce_fmin_v4f32_false_mask(float %start, <4 x float> %val, i32 %evl) {
; CHECK-LABEL: vreduce_fmin_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call float @llvm.vp.reduce.fmin.v4f32(float %start, <4 x float> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret float %s
}

declare float @llvm.vp.reduce.fmax.v4f32(float, <4 x float>, <4 x i1>, i32)

define float @vreduce_fmax_v4f32_zero_evl(float %start, <4 x float> %val, <4 x i1> %m) {
; CHECK-LABEL: vreduce_fmax_v4f32_zero_evl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call float @llvm.vp.reduce.fmax.v4f32(float %start, <4 x float> %val, <4 x i1> %m, i32 0)
  ret float %s
}

define float @vreduce_fmax_v4f32_false_mask(float %start, <4 x float> %val, i32 %evl) {
; CHECK-LABEL: vreduce_fmax_v4f32_false_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %s = call float @llvm.vp.reduce.fmax.v4f32(float %start, <4 x float> %val, <4 x i1> zeroinitializer, i32 %evl)
  ret float %s
}
