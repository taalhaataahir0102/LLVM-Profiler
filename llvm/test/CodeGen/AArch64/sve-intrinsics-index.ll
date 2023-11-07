; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; INDEX (IMMEDIATES)
;

define <vscale x 16 x i8> @index_ii_i8() {
; CHECK-LABEL: index_ii_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.b, #-16, #15
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.index.nxv16i8(i8 -16, i8 15)
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @index_ii_i16() {
; CHECK-LABEL: index_ii_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.h, #15, #-16
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.index.nxv8i16(i16 15, i16 -16)
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @index_ii_i32() {
; CHECK-LABEL: index_ii_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.s, #-16, #15
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32 -16, i32 15)
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @index_ii_i64() {
; CHECK-LABEL: index_ii_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.d, #15, #-16
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.index.nxv2i64(i64 15, i64 -16)
  ret <vscale x 2 x i64> %out
}

define <vscale x 2 x i64> @index_ii_range() {
; CHECK-LABEL: index_ii_range:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #16 // =0x10
; CHECK-NEXT:    mov x9, #-17 // =0xffffffffffffffef
; CHECK-NEXT:    index z0.d, x9, x8
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.index.nxv2i64(i64 -17, i64 16)
  ret <vscale x 2 x i64> %out
}

define <vscale x 8 x i16> @index_ii_range_combine(i16 %a) {
; CHECK-LABEL: index_ii_range_combine:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.h, #0, #8
; CHECK-NEXT:    orr z0.h, z0.h, #0x2
; CHECK-NEXT:    ret
  %val = insertelement <vscale x 8 x i16> poison, i16 2, i32 0
  %val1 = shufflevector <vscale x 8 x i16> %val, <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
  %val2 = call <vscale x 8 x i16> @llvm.aarch64.sve.index.nxv8i16(i16 0, i16 2)
  %val3 = shl <vscale x 8 x i16> %val2, %val1
  %out = add <vscale x 8 x i16> %val3, %val1
  ret <vscale x 8 x i16> %out
}

;
; INDEX (IMMEDIATE, SCALAR)
;

define <vscale x 16 x i8> @index_ir_i8(i8 %a) {
; CHECK-LABEL: index_ir_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.b, #15, w0
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.index.nxv16i8(i8 15, i8 %a)
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @index_ir_i16(i16 %a) {
; CHECK-LABEL: index_ir_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.h, #-16, w0
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.index.nxv8i16(i16 -16, i16 %a)
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @index_ir_i32(i32 %a) {
; CHECK-LABEL: index_ir_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.s, #15, w0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32 15, i32 %a)
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @index_ir_i64(i64 %a) {
; CHECK-LABEL: index_ir_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.d, #-16, x0
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.index.nxv2i64(i64 -16, i64 %a)
  ret <vscale x 2 x i64> %out
}

define <vscale x 4 x i32> @index_ir_range(i32 %a) {
; CHECK-LABEL: index_ir_range:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-17 // =0xffffffef
; CHECK-NEXT:    index z0.s, w8, w0
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32 -17, i32 %a)
  ret <vscale x 4 x i32> %out
}

define <vscale x 4 x i32> @index_ir_range_combine(i32 %a) {
; CHECK-LABEL: index_ir_range_combine:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.s, #0, w0
; CHECK-NEXT:    ret
  %val = insertelement <vscale x 4 x i32> poison, i32 2, i32 0
  %val1 = shufflevector <vscale x 4 x i32> %val, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %tmp = call <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32 2, i32 1)
  %tmp1 = sub <vscale x 4 x i32> %tmp, %val1
  %val2 = insertelement <vscale x 4 x i32> poison, i32 %a, i32 0
  %val3 = shufflevector <vscale x 4 x i32> %val2, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %out = mul <vscale x 4 x i32> %tmp1, %val3
  ret <vscale x 4 x i32> %out
}

;
; INDEX (SCALAR, IMMEDIATE)
;

define <vscale x 16 x i8> @index_ri_i8(i8 %a) {
; CHECK-LABEL: index_ri_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.b, w0, #-16
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.index.nxv16i8(i8 %a, i8 -16)
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @index_ri_i16(i16 %a) {
; CHECK-LABEL: index_ri_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.h, w0, #15
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.index.nxv8i16(i16 %a, i16 15)
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @index_ri_i32(i32 %a) {
; CHECK-LABEL: index_ri_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.s, w0, #-16
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32 %a, i32 -16)
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @index_ri_i64(i64 %a) {
; CHECK-LABEL: index_ri_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.d, x0, #15
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.index.nxv2i64(i64 %a, i64 15)
  ret <vscale x 2 x i64> %out
}

define <vscale x 8 x i16> @index_ri_range(i16 %a) {
; CHECK-LABEL: index_ri_range:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #16 // =0x10
; CHECK-NEXT:    index z0.h, w0, w8
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.index.nxv8i16(i16 %a, i16 16)
  ret <vscale x 8 x i16> %out
}

;
; INDEX (SCALARS)
;

define <vscale x 16 x i8> @index_rr_i8(i8 %a, i8 %b) {
; CHECK-LABEL: index_rr_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.b, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.index.nxv16i8(i8 %a, i8 %b)
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @index_rr_i16(i16 %a, i16 %b) {
; CHECK-LABEL: index_rr_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.h, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.index.nxv8i16(i16 %a, i16 %b)
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @index_rr_i32(i32 %a, i32 %b) {
; CHECK-LABEL: index_rr_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.s, w0, w1
; CHECK-NEXT:    ret
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32 %a, i32 %b)
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @index_rr_i64(i64 %a, i64 %b) {
; CHECK-LABEL: index_rr_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.d, x0, x1
; CHECK-NEXT:    ret
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.index.nxv2i64(i64 %a, i64 %b)
  ret <vscale x 2 x i64> %out
}

define <vscale x 4 x i32> @index_rr_i32_combine(i32 %a, i32 %b) {
; CHECK-LABEL: index_rr_i32_combine:
; CHECK:       // %bb.0:
; CHECK-NEXT:    index z0.s, w0, w1
; CHECK-NEXT:    ret
  %val = insertelement <vscale x 4 x i32> poison, i32 %a, i32 0
  %val1 = shufflevector <vscale x 4 x i32> %val, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %val2 = insertelement <vscale x 4 x i32> poison, i32 %b, i32 0
  %val3 = shufflevector <vscale x 4 x i32> %val2, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %tmp = call <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32 0, i32 1)
  %tmp1 = mul <vscale x 4 x i32> %tmp, %val3
  %out = add <vscale x 4 x i32> %tmp1, %val1
  ret <vscale x 4 x i32> %out
}

define <vscale x 4 x i32> @index_rr_i32_not_combine(i32 %a, i32 %b) {
; CHECK-LABEL: index_rr_i32_not_combine:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    mov z1.s, w0
; CHECK-NEXT:    mov z2.s, w1
; CHECK-NEXT:    mla z1.s, p0/m, z0.s, z2.s
; CHECK-NEXT:    add z0.s, z1.s, z0.s
; CHECK-NEXT:    ret
  %val = insertelement <vscale x 4 x i32> poison, i32 %a, i32 0
  %val1 = shufflevector <vscale x 4 x i32> %val, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %val2 = insertelement <vscale x 4 x i32> poison, i32 %b, i32 0
  %val3 = shufflevector <vscale x 4 x i32> %val2, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %tmp = call <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32 0, i32 1)
  %tmp1 = mul <vscale x 4 x i32> %tmp, %val3
  %tmp2 = add <vscale x 4 x i32> %tmp1, %val1
  %out = add <vscale x 4 x i32> %tmp2, %tmp
  ret <vscale x 4 x i32> %out
}

declare <vscale x 16 x i8> @llvm.aarch64.sve.index.nxv16i8(i8, i8)
declare <vscale x 8 x i16> @llvm.aarch64.sve.index.nxv8i16(i16, i16)
declare <vscale x 4 x i32> @llvm.aarch64.sve.index.nxv4i32(i32, i32)
declare <vscale x 2 x i64> @llvm.aarch64.sve.index.nxv2i64(i64, i64)
