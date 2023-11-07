; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64
; RUN: llc -mtriple=riscv32 -mattr=+v,+experimental-zvbb -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK-ZVBB
; RUN: llc -mtriple=riscv64 -mattr=+v,+experimental-zvbb -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK-ZVBB

define <vscale x 1 x i16> @bswap_nxv1i16(<vscale x 1 x i16> %va) {
; CHECK-LABEL: bswap_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vsrl.vi v9, v8, 8
; CHECK-NEXT:    vsll.vi v8, v8, 8
; CHECK-NEXT:    vor.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv1i16:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 1 x i16> @llvm.bswap.nxv1i16(<vscale x 1 x i16> %va)
  ret <vscale x 1 x i16> %a
}
declare <vscale x 1 x i16> @llvm.bswap.nxv1i16(<vscale x 1 x i16>)

define <vscale x 2 x i16> @bswap_nxv2i16(<vscale x 2 x i16> %va) {
; CHECK-LABEL: bswap_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vsrl.vi v9, v8, 8
; CHECK-NEXT:    vsll.vi v8, v8, 8
; CHECK-NEXT:    vor.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv2i16:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 2 x i16> @llvm.bswap.nxv2i16(<vscale x 2 x i16> %va)
  ret <vscale x 2 x i16> %a
}
declare <vscale x 2 x i16> @llvm.bswap.nxv2i16(<vscale x 2 x i16>)

define <vscale x 4 x i16> @bswap_nxv4i16(<vscale x 4 x i16> %va) {
; CHECK-LABEL: bswap_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vsrl.vi v9, v8, 8
; CHECK-NEXT:    vsll.vi v8, v8, 8
; CHECK-NEXT:    vor.vv v8, v8, v9
; CHECK-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv4i16:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 4 x i16> @llvm.bswap.nxv4i16(<vscale x 4 x i16> %va)
  ret <vscale x 4 x i16> %a
}
declare <vscale x 4 x i16> @llvm.bswap.nxv4i16(<vscale x 4 x i16>)

define <vscale x 8 x i16> @bswap_nxv8i16(<vscale x 8 x i16> %va) {
; CHECK-LABEL: bswap_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vsrl.vi v10, v8, 8
; CHECK-NEXT:    vsll.vi v8, v8, 8
; CHECK-NEXT:    vor.vv v8, v8, v10
; CHECK-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv8i16:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 8 x i16> @llvm.bswap.nxv8i16(<vscale x 8 x i16> %va)
  ret <vscale x 8 x i16> %a
}
declare <vscale x 8 x i16> @llvm.bswap.nxv8i16(<vscale x 8 x i16>)

define <vscale x 16 x i16> @bswap_nxv16i16(<vscale x 16 x i16> %va) {
; CHECK-LABEL: bswap_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vsrl.vi v12, v8, 8
; CHECK-NEXT:    vsll.vi v8, v8, 8
; CHECK-NEXT:    vor.vv v8, v8, v12
; CHECK-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv16i16:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 16 x i16> @llvm.bswap.nxv16i16(<vscale x 16 x i16> %va)
  ret <vscale x 16 x i16> %a
}
declare <vscale x 16 x i16> @llvm.bswap.nxv16i16(<vscale x 16 x i16>)

define <vscale x 32 x i16> @bswap_nxv32i16(<vscale x 32 x i16> %va) {
; CHECK-LABEL: bswap_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    vsrl.vi v16, v8, 8
; CHECK-NEXT:    vsll.vi v8, v8, 8
; CHECK-NEXT:    vor.vv v8, v8, v16
; CHECK-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv32i16:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 32 x i16> @llvm.bswap.nxv32i16(<vscale x 32 x i16> %va)
  ret <vscale x 32 x i16> %a
}
declare <vscale x 32 x i16> @llvm.bswap.nxv32i16(<vscale x 32 x i16>)

define <vscale x 1 x i32> @bswap_nxv1i32(<vscale x 1 x i32> %va) {
; RV32-LABEL: bswap_nxv1i32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; RV32-NEXT:    vsrl.vi v9, v8, 8
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    addi a0, a0, -256
; RV32-NEXT:    vand.vx v9, v9, a0
; RV32-NEXT:    vsrl.vi v10, v8, 24
; RV32-NEXT:    vor.vv v9, v9, v10
; RV32-NEXT:    vand.vx v10, v8, a0
; RV32-NEXT:    vsll.vi v10, v10, 8
; RV32-NEXT:    vsll.vi v8, v8, 24
; RV32-NEXT:    vor.vv v8, v8, v10
; RV32-NEXT:    vor.vv v8, v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv1i32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; RV64-NEXT:    vsrl.vi v9, v8, 8
; RV64-NEXT:    lui a0, 16
; RV64-NEXT:    addiw a0, a0, -256
; RV64-NEXT:    vand.vx v9, v9, a0
; RV64-NEXT:    vsrl.vi v10, v8, 24
; RV64-NEXT:    vor.vv v9, v9, v10
; RV64-NEXT:    vand.vx v10, v8, a0
; RV64-NEXT:    vsll.vi v10, v10, 8
; RV64-NEXT:    vsll.vi v8, v8, 24
; RV64-NEXT:    vor.vv v8, v8, v10
; RV64-NEXT:    vor.vv v8, v8, v9
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv1i32:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 1 x i32> @llvm.bswap.nxv1i32(<vscale x 1 x i32> %va)
  ret <vscale x 1 x i32> %a
}
declare <vscale x 1 x i32> @llvm.bswap.nxv1i32(<vscale x 1 x i32>)

define <vscale x 2 x i32> @bswap_nxv2i32(<vscale x 2 x i32> %va) {
; RV32-LABEL: bswap_nxv2i32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; RV32-NEXT:    vsrl.vi v9, v8, 8
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    addi a0, a0, -256
; RV32-NEXT:    vand.vx v9, v9, a0
; RV32-NEXT:    vsrl.vi v10, v8, 24
; RV32-NEXT:    vor.vv v9, v9, v10
; RV32-NEXT:    vand.vx v10, v8, a0
; RV32-NEXT:    vsll.vi v10, v10, 8
; RV32-NEXT:    vsll.vi v8, v8, 24
; RV32-NEXT:    vor.vv v8, v8, v10
; RV32-NEXT:    vor.vv v8, v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv2i32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; RV64-NEXT:    vsrl.vi v9, v8, 8
; RV64-NEXT:    lui a0, 16
; RV64-NEXT:    addiw a0, a0, -256
; RV64-NEXT:    vand.vx v9, v9, a0
; RV64-NEXT:    vsrl.vi v10, v8, 24
; RV64-NEXT:    vor.vv v9, v9, v10
; RV64-NEXT:    vand.vx v10, v8, a0
; RV64-NEXT:    vsll.vi v10, v10, 8
; RV64-NEXT:    vsll.vi v8, v8, 24
; RV64-NEXT:    vor.vv v8, v8, v10
; RV64-NEXT:    vor.vv v8, v8, v9
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv2i32:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 2 x i32> @llvm.bswap.nxv2i32(<vscale x 2 x i32> %va)
  ret <vscale x 2 x i32> %a
}
declare <vscale x 2 x i32> @llvm.bswap.nxv2i32(<vscale x 2 x i32>)

define <vscale x 4 x i32> @bswap_nxv4i32(<vscale x 4 x i32> %va) {
; RV32-LABEL: bswap_nxv4i32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; RV32-NEXT:    vsrl.vi v10, v8, 8
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    addi a0, a0, -256
; RV32-NEXT:    vand.vx v10, v10, a0
; RV32-NEXT:    vsrl.vi v12, v8, 24
; RV32-NEXT:    vor.vv v10, v10, v12
; RV32-NEXT:    vand.vx v12, v8, a0
; RV32-NEXT:    vsll.vi v12, v12, 8
; RV32-NEXT:    vsll.vi v8, v8, 24
; RV32-NEXT:    vor.vv v8, v8, v12
; RV32-NEXT:    vor.vv v8, v8, v10
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv4i32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; RV64-NEXT:    vsrl.vi v10, v8, 8
; RV64-NEXT:    lui a0, 16
; RV64-NEXT:    addiw a0, a0, -256
; RV64-NEXT:    vand.vx v10, v10, a0
; RV64-NEXT:    vsrl.vi v12, v8, 24
; RV64-NEXT:    vor.vv v10, v10, v12
; RV64-NEXT:    vand.vx v12, v8, a0
; RV64-NEXT:    vsll.vi v12, v12, 8
; RV64-NEXT:    vsll.vi v8, v8, 24
; RV64-NEXT:    vor.vv v8, v8, v12
; RV64-NEXT:    vor.vv v8, v8, v10
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv4i32:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 4 x i32> @llvm.bswap.nxv4i32(<vscale x 4 x i32> %va)
  ret <vscale x 4 x i32> %a
}
declare <vscale x 4 x i32> @llvm.bswap.nxv4i32(<vscale x 4 x i32>)

define <vscale x 8 x i32> @bswap_nxv8i32(<vscale x 8 x i32> %va) {
; RV32-LABEL: bswap_nxv8i32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; RV32-NEXT:    vsrl.vi v12, v8, 8
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    addi a0, a0, -256
; RV32-NEXT:    vand.vx v12, v12, a0
; RV32-NEXT:    vsrl.vi v16, v8, 24
; RV32-NEXT:    vor.vv v12, v12, v16
; RV32-NEXT:    vand.vx v16, v8, a0
; RV32-NEXT:    vsll.vi v16, v16, 8
; RV32-NEXT:    vsll.vi v8, v8, 24
; RV32-NEXT:    vor.vv v8, v8, v16
; RV32-NEXT:    vor.vv v8, v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv8i32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; RV64-NEXT:    vsrl.vi v12, v8, 8
; RV64-NEXT:    lui a0, 16
; RV64-NEXT:    addiw a0, a0, -256
; RV64-NEXT:    vand.vx v12, v12, a0
; RV64-NEXT:    vsrl.vi v16, v8, 24
; RV64-NEXT:    vor.vv v12, v12, v16
; RV64-NEXT:    vand.vx v16, v8, a0
; RV64-NEXT:    vsll.vi v16, v16, 8
; RV64-NEXT:    vsll.vi v8, v8, 24
; RV64-NEXT:    vor.vv v8, v8, v16
; RV64-NEXT:    vor.vv v8, v8, v12
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv8i32:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 8 x i32> @llvm.bswap.nxv8i32(<vscale x 8 x i32> %va)
  ret <vscale x 8 x i32> %a
}
declare <vscale x 8 x i32> @llvm.bswap.nxv8i32(<vscale x 8 x i32>)

define <vscale x 16 x i32> @bswap_nxv16i32(<vscale x 16 x i32> %va) {
; RV32-LABEL: bswap_nxv16i32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; RV32-NEXT:    vsrl.vi v16, v8, 8
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    addi a0, a0, -256
; RV32-NEXT:    vand.vx v16, v16, a0
; RV32-NEXT:    vsrl.vi v24, v8, 24
; RV32-NEXT:    vor.vv v16, v16, v24
; RV32-NEXT:    vand.vx v24, v8, a0
; RV32-NEXT:    vsll.vi v24, v24, 8
; RV32-NEXT:    vsll.vi v8, v8, 24
; RV32-NEXT:    vor.vv v8, v8, v24
; RV32-NEXT:    vor.vv v8, v8, v16
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv16i32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; RV64-NEXT:    vsrl.vi v16, v8, 8
; RV64-NEXT:    lui a0, 16
; RV64-NEXT:    addiw a0, a0, -256
; RV64-NEXT:    vand.vx v16, v16, a0
; RV64-NEXT:    vsrl.vi v24, v8, 24
; RV64-NEXT:    vor.vv v16, v16, v24
; RV64-NEXT:    vand.vx v24, v8, a0
; RV64-NEXT:    vsll.vi v24, v24, 8
; RV64-NEXT:    vsll.vi v8, v8, 24
; RV64-NEXT:    vor.vv v8, v8, v24
; RV64-NEXT:    vor.vv v8, v8, v16
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv16i32:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 16 x i32> @llvm.bswap.nxv16i32(<vscale x 16 x i32> %va)
  ret <vscale x 16 x i32> %a
}
declare <vscale x 16 x i32> @llvm.bswap.nxv16i32(<vscale x 16 x i32>)

define <vscale x 1 x i64> @bswap_nxv1i64(<vscale x 1 x i64> %va) {
; RV32-LABEL: bswap_nxv1i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw zero, 12(sp)
; RV32-NEXT:    lui a0, 1044480
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    li a0, 56
; RV32-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; RV32-NEXT:    vsrl.vx v9, v8, a0
; RV32-NEXT:    li a1, 40
; RV32-NEXT:    vsrl.vx v10, v8, a1
; RV32-NEXT:    lui a2, 16
; RV32-NEXT:    addi a2, a2, -256
; RV32-NEXT:    vand.vx v10, v10, a2
; RV32-NEXT:    vor.vv v9, v10, v9
; RV32-NEXT:    vsrl.vi v10, v8, 24
; RV32-NEXT:    addi a3, sp, 8
; RV32-NEXT:    vlse64.v v11, (a3), zero
; RV32-NEXT:    lui a3, 4080
; RV32-NEXT:    vand.vx v10, v10, a3
; RV32-NEXT:    vsrl.vi v12, v8, 8
; RV32-NEXT:    vand.vv v12, v12, v11
; RV32-NEXT:    vor.vv v10, v12, v10
; RV32-NEXT:    vor.vv v9, v10, v9
; RV32-NEXT:    vsll.vx v10, v8, a0
; RV32-NEXT:    vand.vx v12, v8, a2
; RV32-NEXT:    vsll.vx v12, v12, a1
; RV32-NEXT:    vor.vv v10, v10, v12
; RV32-NEXT:    vand.vx v12, v8, a3
; RV32-NEXT:    vsll.vi v12, v12, 24
; RV32-NEXT:    vand.vv v8, v8, v11
; RV32-NEXT:    vsll.vi v8, v8, 8
; RV32-NEXT:    vor.vv v8, v12, v8
; RV32-NEXT:    vor.vv v8, v10, v8
; RV32-NEXT:    vor.vv v8, v8, v9
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv1i64:
; RV64:       # %bb.0:
; RV64-NEXT:    li a0, 56
; RV64-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; RV64-NEXT:    vsrl.vx v9, v8, a0
; RV64-NEXT:    li a1, 40
; RV64-NEXT:    vsrl.vx v10, v8, a1
; RV64-NEXT:    lui a2, 16
; RV64-NEXT:    addiw a2, a2, -256
; RV64-NEXT:    vand.vx v10, v10, a2
; RV64-NEXT:    vor.vv v9, v10, v9
; RV64-NEXT:    vsrl.vi v10, v8, 24
; RV64-NEXT:    lui a3, 4080
; RV64-NEXT:    vand.vx v10, v10, a3
; RV64-NEXT:    vsrl.vi v11, v8, 8
; RV64-NEXT:    li a4, 255
; RV64-NEXT:    slli a4, a4, 24
; RV64-NEXT:    vand.vx v11, v11, a4
; RV64-NEXT:    vor.vv v10, v11, v10
; RV64-NEXT:    vor.vv v9, v10, v9
; RV64-NEXT:    vand.vx v10, v8, a3
; RV64-NEXT:    vsll.vi v10, v10, 24
; RV64-NEXT:    vand.vx v11, v8, a4
; RV64-NEXT:    vsll.vi v11, v11, 8
; RV64-NEXT:    vor.vv v10, v10, v11
; RV64-NEXT:    vsll.vx v11, v8, a0
; RV64-NEXT:    vand.vx v8, v8, a2
; RV64-NEXT:    vsll.vx v8, v8, a1
; RV64-NEXT:    vor.vv v8, v11, v8
; RV64-NEXT:    vor.vv v8, v8, v10
; RV64-NEXT:    vor.vv v8, v8, v9
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv1i64:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 1 x i64> @llvm.bswap.nxv1i64(<vscale x 1 x i64> %va)
  ret <vscale x 1 x i64> %a
}
declare <vscale x 1 x i64> @llvm.bswap.nxv1i64(<vscale x 1 x i64>)

define <vscale x 2 x i64> @bswap_nxv2i64(<vscale x 2 x i64> %va) {
; RV32-LABEL: bswap_nxv2i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw zero, 12(sp)
; RV32-NEXT:    lui a0, 1044480
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    li a0, 56
; RV32-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; RV32-NEXT:    vsrl.vx v10, v8, a0
; RV32-NEXT:    li a1, 40
; RV32-NEXT:    vsrl.vx v12, v8, a1
; RV32-NEXT:    lui a2, 16
; RV32-NEXT:    addi a2, a2, -256
; RV32-NEXT:    vand.vx v12, v12, a2
; RV32-NEXT:    vor.vv v10, v12, v10
; RV32-NEXT:    vsrl.vi v12, v8, 24
; RV32-NEXT:    addi a3, sp, 8
; RV32-NEXT:    vlse64.v v14, (a3), zero
; RV32-NEXT:    lui a3, 4080
; RV32-NEXT:    vand.vx v12, v12, a3
; RV32-NEXT:    vsrl.vi v16, v8, 8
; RV32-NEXT:    vand.vv v16, v16, v14
; RV32-NEXT:    vor.vv v12, v16, v12
; RV32-NEXT:    vor.vv v10, v12, v10
; RV32-NEXT:    vsll.vx v12, v8, a0
; RV32-NEXT:    vand.vx v16, v8, a2
; RV32-NEXT:    vsll.vx v16, v16, a1
; RV32-NEXT:    vor.vv v12, v12, v16
; RV32-NEXT:    vand.vx v16, v8, a3
; RV32-NEXT:    vsll.vi v16, v16, 24
; RV32-NEXT:    vand.vv v8, v8, v14
; RV32-NEXT:    vsll.vi v8, v8, 8
; RV32-NEXT:    vor.vv v8, v16, v8
; RV32-NEXT:    vor.vv v8, v12, v8
; RV32-NEXT:    vor.vv v8, v8, v10
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv2i64:
; RV64:       # %bb.0:
; RV64-NEXT:    li a0, 56
; RV64-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; RV64-NEXT:    vsrl.vx v10, v8, a0
; RV64-NEXT:    li a1, 40
; RV64-NEXT:    vsrl.vx v12, v8, a1
; RV64-NEXT:    lui a2, 16
; RV64-NEXT:    addiw a2, a2, -256
; RV64-NEXT:    vand.vx v12, v12, a2
; RV64-NEXT:    vor.vv v10, v12, v10
; RV64-NEXT:    vsrl.vi v12, v8, 24
; RV64-NEXT:    lui a3, 4080
; RV64-NEXT:    vand.vx v12, v12, a3
; RV64-NEXT:    vsrl.vi v14, v8, 8
; RV64-NEXT:    li a4, 255
; RV64-NEXT:    slli a4, a4, 24
; RV64-NEXT:    vand.vx v14, v14, a4
; RV64-NEXT:    vor.vv v12, v14, v12
; RV64-NEXT:    vor.vv v10, v12, v10
; RV64-NEXT:    vand.vx v12, v8, a3
; RV64-NEXT:    vsll.vi v12, v12, 24
; RV64-NEXT:    vand.vx v14, v8, a4
; RV64-NEXT:    vsll.vi v14, v14, 8
; RV64-NEXT:    vor.vv v12, v12, v14
; RV64-NEXT:    vsll.vx v14, v8, a0
; RV64-NEXT:    vand.vx v8, v8, a2
; RV64-NEXT:    vsll.vx v8, v8, a1
; RV64-NEXT:    vor.vv v8, v14, v8
; RV64-NEXT:    vor.vv v8, v8, v12
; RV64-NEXT:    vor.vv v8, v8, v10
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv2i64:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 2 x i64> @llvm.bswap.nxv2i64(<vscale x 2 x i64> %va)
  ret <vscale x 2 x i64> %a
}
declare <vscale x 2 x i64> @llvm.bswap.nxv2i64(<vscale x 2 x i64>)

define <vscale x 4 x i64> @bswap_nxv4i64(<vscale x 4 x i64> %va) {
; RV32-LABEL: bswap_nxv4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw zero, 12(sp)
; RV32-NEXT:    lui a0, 1044480
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    li a0, 56
; RV32-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; RV32-NEXT:    vsrl.vx v12, v8, a0
; RV32-NEXT:    li a1, 40
; RV32-NEXT:    vsrl.vx v16, v8, a1
; RV32-NEXT:    lui a2, 16
; RV32-NEXT:    addi a2, a2, -256
; RV32-NEXT:    vand.vx v16, v16, a2
; RV32-NEXT:    vor.vv v12, v16, v12
; RV32-NEXT:    vsrl.vi v16, v8, 24
; RV32-NEXT:    addi a3, sp, 8
; RV32-NEXT:    vlse64.v v20, (a3), zero
; RV32-NEXT:    lui a3, 4080
; RV32-NEXT:    vand.vx v16, v16, a3
; RV32-NEXT:    vsrl.vi v24, v8, 8
; RV32-NEXT:    vand.vv v24, v24, v20
; RV32-NEXT:    vor.vv v16, v24, v16
; RV32-NEXT:    vor.vv v12, v16, v12
; RV32-NEXT:    vsll.vx v16, v8, a0
; RV32-NEXT:    vand.vx v24, v8, a2
; RV32-NEXT:    vsll.vx v24, v24, a1
; RV32-NEXT:    vor.vv v16, v16, v24
; RV32-NEXT:    vand.vx v24, v8, a3
; RV32-NEXT:    vsll.vi v24, v24, 24
; RV32-NEXT:    vand.vv v8, v8, v20
; RV32-NEXT:    vsll.vi v8, v8, 8
; RV32-NEXT:    vor.vv v8, v24, v8
; RV32-NEXT:    vor.vv v8, v16, v8
; RV32-NEXT:    vor.vv v8, v8, v12
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    li a0, 56
; RV64-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; RV64-NEXT:    vsrl.vx v12, v8, a0
; RV64-NEXT:    li a1, 40
; RV64-NEXT:    vsrl.vx v16, v8, a1
; RV64-NEXT:    lui a2, 16
; RV64-NEXT:    addiw a2, a2, -256
; RV64-NEXT:    vand.vx v16, v16, a2
; RV64-NEXT:    vor.vv v12, v16, v12
; RV64-NEXT:    vsrl.vi v16, v8, 24
; RV64-NEXT:    lui a3, 4080
; RV64-NEXT:    vand.vx v16, v16, a3
; RV64-NEXT:    vsrl.vi v20, v8, 8
; RV64-NEXT:    li a4, 255
; RV64-NEXT:    slli a4, a4, 24
; RV64-NEXT:    vand.vx v20, v20, a4
; RV64-NEXT:    vor.vv v16, v20, v16
; RV64-NEXT:    vor.vv v12, v16, v12
; RV64-NEXT:    vand.vx v16, v8, a3
; RV64-NEXT:    vsll.vi v16, v16, 24
; RV64-NEXT:    vand.vx v20, v8, a4
; RV64-NEXT:    vsll.vi v20, v20, 8
; RV64-NEXT:    vor.vv v16, v16, v20
; RV64-NEXT:    vsll.vx v20, v8, a0
; RV64-NEXT:    vand.vx v8, v8, a2
; RV64-NEXT:    vsll.vx v8, v8, a1
; RV64-NEXT:    vor.vv v8, v20, v8
; RV64-NEXT:    vor.vv v8, v8, v16
; RV64-NEXT:    vor.vv v8, v8, v12
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv4i64:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 4 x i64> @llvm.bswap.nxv4i64(<vscale x 4 x i64> %va)
  ret <vscale x 4 x i64> %a
}
declare <vscale x 4 x i64> @llvm.bswap.nxv4i64(<vscale x 4 x i64>)

define <vscale x 8 x i64> @bswap_nxv8i64(<vscale x 8 x i64> %va) {
; RV32-LABEL: bswap_nxv8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 3
; RV32-NEXT:    sub sp, sp, a0
; RV32-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; RV32-NEXT:    sw zero, 12(sp)
; RV32-NEXT:    lui a0, 1044480
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    li a0, 56
; RV32-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV32-NEXT:    vsrl.vx v16, v8, a0
; RV32-NEXT:    li a1, 40
; RV32-NEXT:    vsrl.vx v24, v8, a1
; RV32-NEXT:    lui a2, 16
; RV32-NEXT:    addi a2, a2, -256
; RV32-NEXT:    vand.vx v24, v24, a2
; RV32-NEXT:    vor.vv v16, v24, v16
; RV32-NEXT:    addi a3, sp, 16
; RV32-NEXT:    vs8r.v v16, (a3) # Unknown-size Folded Spill
; RV32-NEXT:    vsrl.vi v0, v8, 24
; RV32-NEXT:    addi a3, sp, 8
; RV32-NEXT:    vlse64.v v24, (a3), zero
; RV32-NEXT:    lui a3, 4080
; RV32-NEXT:    vand.vx v0, v0, a3
; RV32-NEXT:    vsrl.vi v16, v8, 8
; RV32-NEXT:    vand.vv v16, v16, v24
; RV32-NEXT:    vor.vv v16, v16, v0
; RV32-NEXT:    addi a4, sp, 16
; RV32-NEXT:    vl8r.v v0, (a4) # Unknown-size Folded Reload
; RV32-NEXT:    vor.vv v16, v16, v0
; RV32-NEXT:    vs8r.v v16, (a4) # Unknown-size Folded Spill
; RV32-NEXT:    vand.vx v0, v8, a2
; RV32-NEXT:    vsll.vx v0, v0, a1
; RV32-NEXT:    vsll.vx v16, v8, a0
; RV32-NEXT:    vor.vv v16, v16, v0
; RV32-NEXT:    vand.vv v24, v8, v24
; RV32-NEXT:    vand.vx v8, v8, a3
; RV32-NEXT:    vsll.vi v8, v8, 24
; RV32-NEXT:    vsll.vi v24, v24, 8
; RV32-NEXT:    vor.vv v8, v8, v24
; RV32-NEXT:    vor.vv v8, v16, v8
; RV32-NEXT:    addi a0, sp, 16
; RV32-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; RV32-NEXT:    vor.vv v8, v8, v16
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 3
; RV32-NEXT:    add sp, sp, a0
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: bswap_nxv8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    li a0, 56
; RV64-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV64-NEXT:    vsrl.vx v16, v8, a0
; RV64-NEXT:    li a1, 40
; RV64-NEXT:    vsrl.vx v24, v8, a1
; RV64-NEXT:    lui a2, 16
; RV64-NEXT:    addiw a2, a2, -256
; RV64-NEXT:    vand.vx v24, v24, a2
; RV64-NEXT:    vor.vv v16, v24, v16
; RV64-NEXT:    vsrl.vi v24, v8, 24
; RV64-NEXT:    lui a3, 4080
; RV64-NEXT:    vand.vx v24, v24, a3
; RV64-NEXT:    vsrl.vi v0, v8, 8
; RV64-NEXT:    li a4, 255
; RV64-NEXT:    slli a4, a4, 24
; RV64-NEXT:    vand.vx v0, v0, a4
; RV64-NEXT:    vor.vv v24, v0, v24
; RV64-NEXT:    vor.vv v16, v24, v16
; RV64-NEXT:    vand.vx v24, v8, a3
; RV64-NEXT:    vsll.vi v24, v24, 24
; RV64-NEXT:    vand.vx v0, v8, a4
; RV64-NEXT:    vsll.vi v0, v0, 8
; RV64-NEXT:    vor.vv v24, v24, v0
; RV64-NEXT:    vsll.vx v0, v8, a0
; RV64-NEXT:    vand.vx v8, v8, a2
; RV64-NEXT:    vsll.vx v8, v8, a1
; RV64-NEXT:    vor.vv v8, v0, v8
; RV64-NEXT:    vor.vv v8, v8, v24
; RV64-NEXT:    vor.vv v8, v8, v16
; RV64-NEXT:    ret
;
; CHECK-ZVBB-LABEL: bswap_nxv8i64:
; CHECK-ZVBB:       # %bb.0:
; CHECK-ZVBB-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-ZVBB-NEXT:    vrev8.v v8, v8
; CHECK-ZVBB-NEXT:    ret
  %a = call <vscale x 8 x i64> @llvm.bswap.nxv8i64(<vscale x 8 x i64> %va)
  ret <vscale x 8 x i64> %a
}
declare <vscale x 8 x i64> @llvm.bswap.nxv8i64(<vscale x 8 x i64>)
