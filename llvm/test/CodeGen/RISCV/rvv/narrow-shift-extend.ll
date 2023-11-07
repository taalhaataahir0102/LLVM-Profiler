; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s

declare <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i64(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  i64);

define <vscale x 4 x i32> @test_vloxei(<vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, i64 %vl) {
; CHECK-LABEL: test_vloxei:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vsll.vi v10, v9, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vloxei16.v v8, (a0), v10
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @test_vloxei2(<vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, i64 %vl) {
; CHECK-LABEL: test_vloxei2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e32, m2, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8
; CHECK-NEXT:    vsll.vi v8, v10, 14
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vloxei32.v v8, (a0), v8
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 14, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @test_vloxei3(<vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, i64 %vl) {
; CHECK-LABEL: test_vloxei3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e64, m4, ta, ma
; CHECK-NEXT:    vzext.vf8 v12, v8
; CHECK-NEXT:    vsll.vi v12, v12, 26
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vloxei64.v v8, (a0), v12
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 26, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl)
  ret <vscale x 4 x i32> %res
}

; Test use vp.zext to extend.
declare <vscale x 4 x i64> @llvm.vp.zext.nxvi64.nxv1i8(<vscale x 4 x i8>, <vscale x 4 x i1>, i32)
define <vscale x 4 x i32> @test_vloxei4(<vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, <vscale x 4 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: test_vloxei4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vsll.vi v10, v9, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vloxei16.v v8, (a0), v10
; CHECK-NEXT:    ret
entry:
  %offset.ext = call <vscale x 4 x i64> @llvm.vp.zext.nxvi64.nxv1i8(<vscale x 4 x i8> %offset, <vscale x 4 x i1> %m, i32 %vl)
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %vl.i64 = zext i32 %vl to i64
  %res = call <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl.i64)
  ret <vscale x 4 x i32> %res
}

; Test orignal extnened type is enough narrow.
declare <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i16(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i16>,
  i64);
define <vscale x 4 x i32> @test_vloxei5(<vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, i64 %vl) {
; CHECK-LABEL: test_vloxei5:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vsll.vi v10, v9, 12
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vloxei16.v v8, (a0), v10
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i16>
  %shamt = insertelement <vscale x 4 x i16> undef, i16 12, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i16> %shamt, <vscale x 4 x i16> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i16> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i16(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i16> %shl,
    i64 %vl)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @test_vloxei6(<vscale x 4 x i32>* %ptr, <vscale x 4 x i7> %offset, i64 %vl) {
; CHECK-LABEL: test_vloxei6:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li a2, 127
; CHECK-NEXT:    vsetvli a3, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vand.vx v8, v8, a2
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vsll.vi v10, v9, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vloxei16.v v8, (a0), v10
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i7> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @test_vloxei7(<vscale x 4 x i32>* %ptr, <vscale x 4 x i1> %offset, i64 %vl) {
; CHECK-LABEL: test_vloxei7:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vsll.vi v10, v8, 2
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vloxei8.v v8, (a0), v10
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i1> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 2, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vloxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl)
  ret <vscale x 4 x i32> %res
}

declare <vscale x 4 x i32> @llvm.riscv.vloxei.mask.nxv4i32.nxv4i64(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64,
  i64);

define <vscale x 4 x i32> @test_vloxei_mask(<vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, <vscale x 4 x i1> %m, i64 %vl) {
; CHECK-LABEL: test_vloxei_mask:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vsll.vi v10, v9, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vloxei16.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vloxei.mask.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    <vscale x 4 x i1> %m,
    i64 %vl, i64 1)
  ret <vscale x 4 x i32> %res
}

declare <vscale x 4 x i32> @llvm.riscv.vluxei.nxv4i32.nxv4i64(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  i64);

define <vscale x 4 x i32> @test_vluxei(<vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, i64 %vl) {
; CHECK-LABEL: test_vluxei:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vsll.vi v10, v9, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vluxei16.v v8, (a0), v10
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vluxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl)
  ret <vscale x 4 x i32> %res
}

declare <vscale x 4 x i32> @llvm.riscv.vluxei.mask.nxv4i32.nxv4i64(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64,
  i64);

define <vscale x 4 x i32> @test_vluxei_mask(<vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, <vscale x 4 x i1> %m, i64 %vl) {
; CHECK-LABEL: test_vluxei_mask:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vsll.vi v10, v9, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vluxei16.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  %res = call <vscale x 4 x i32> @llvm.riscv.vluxei.mask.nxv4i32.nxv4i64(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    <vscale x 4 x i1> %m,
    i64 %vl, i64 1)
  ret <vscale x 4 x i32> %res
}

declare void @llvm.riscv.vsoxei.nxv4i32.nxv4i64(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  i64);

define void @test_vsoxei(<vscale x 4 x i32> %val, <vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, i64 %vl) {
; CHECK-LABEL: test_vsoxei:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v11, v10
; CHECK-NEXT:    vsll.vi v10, v11, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vsoxei16.v v8, (a0), v10
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  call void @llvm.riscv.vsoxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> %val,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl)
  ret void
}

declare void @llvm.riscv.vsoxei.mask.nxv4i32.nxv4i64(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64);

define void @test_vsoxei_mask(<vscale x 4 x i32> %val, <vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, <vscale x 4 x i1> %m, i64 %vl) {
; CHECK-LABEL: test_vsoxei_mask:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v11, v10
; CHECK-NEXT:    vsll.vi v10, v11, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vsoxei16.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  call void @llvm.riscv.vsoxei.mask.nxv4i32.nxv4i64(
    <vscale x 4 x i32> %val,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    <vscale x 4 x i1> %m,
    i64 %vl)
  ret void
}

declare void @llvm.riscv.vsuxei.nxv4i32.nxv4i64(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  i64);

define void @test_vsuxei(<vscale x 4 x i32> %val, <vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, i64 %vl) {
; CHECK-LABEL: test_vsuxei:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v11, v10
; CHECK-NEXT:    vsll.vi v10, v11, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vsuxei16.v v8, (a0), v10
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  call void @llvm.riscv.vsuxei.nxv4i32.nxv4i64(
    <vscale x 4 x i32> %val,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    i64 %vl)
  ret void
}

declare void @llvm.riscv.vsuxei.mask.nxv4i32.nxv4i64(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64);

define void @test_vsuxei_mask(<vscale x 4 x i32> %val, <vscale x 4 x i32>* %ptr, <vscale x 4 x i8> %offset, <vscale x 4 x i1> %m, i64 %vl) {
; CHECK-LABEL: test_vsuxei_mask:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v11, v10
; CHECK-NEXT:    vsll.vi v10, v11, 4
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vsuxei16.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret
entry:
  %offset.ext = zext <vscale x 4 x i8> %offset to <vscale x 4 x i64>
  %shamt = insertelement <vscale x 4 x i64> undef, i64 4, i32 0
  %shamt.vec = shufflevector <vscale x 4 x i64> %shamt, <vscale x 4 x i64> poison, <vscale x 4 x i32> zeroinitializer
  %shl = shl <vscale x 4 x i64> %offset.ext, %shamt.vec
  call void @llvm.riscv.vsuxei.mask.nxv4i32.nxv4i64(
    <vscale x 4 x i32> %val,
    <vscale x 4 x i32>* %ptr,
    <vscale x 4 x i64> %shl,
    <vscale x 4 x i1> %m,
    i64 %vl)
  ret void
}
