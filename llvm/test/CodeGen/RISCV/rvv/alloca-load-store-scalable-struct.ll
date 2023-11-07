; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=riscv64 -mattr=+m,+d,+v -verify-machineinstrs \
; RUN:   --riscv-no-aliases < %s | FileCheck %s

target triple = "riscv64-unknown-unknown-elf"

%struct.test = type { <vscale x 1 x double>, <vscale x 1 x double> }

define <vscale x 1 x double> @test(%struct.test* %addr, i64 %vl) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrrs a2, vlenb, zero
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    sub sp, sp, a2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x02, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 2 * vlenb
; CHECK-NEXT:    csrrs a2, vlenb, zero
; CHECK-NEXT:    vl1re64.v v8, (a0)
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    vl1re64.v v9, (a0)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs1r.v v8, (a0)
; CHECK-NEXT:    add a2, a0, a2
; CHECK-NEXT:    vs1r.v v9, (a2)
; CHECK-NEXT:    vl1re64.v v8, (a2)
; CHECK-NEXT:    vl1re64.v v9, (a0)
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; CHECK-NEXT:    vfadd.vv v8, v9, v8
; CHECK-NEXT:    csrrs a0, vlenb, zero
; CHECK-NEXT:    slli a0, a0, 1
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %ret = alloca %struct.test, align 8
  %val = load %struct.test, %struct.test* %addr
  store %struct.test %val, %struct.test* %ret, align 8
  %0 = load %struct.test, %struct.test* %ret, align 8
  %1 = extractvalue %struct.test %0, 0
  %2 = extractvalue %struct.test %0, 1
  %3 = call <vscale x 1 x double> @llvm.riscv.vfadd.nxv1f64.nxv1f64.i64(
    <vscale x 1 x double> poison,
    <vscale x 1 x double> %1,
    <vscale x 1 x double> %2, i64 7, i64 %vl)
  ret <vscale x 1 x double> %3
}

declare <vscale x 1 x double> @llvm.riscv.vfadd.nxv1f64.nxv1f64.i64(
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  i64, i64)