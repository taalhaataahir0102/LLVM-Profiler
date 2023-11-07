; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v,+zfh,+zvfh,+f,+d -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+m,+v,+zfh,+zvfh,+f,+d -verify-machineinstrs < %s | FileCheck %s

; Check that we are able to legalize scalable-vector stores that require widening.

define void @store_nxv3i8(<vscale x 3 x i8> %val, <vscale x 3 x i8>* %ptr) {
; CHECK-LABEL: store_nxv3i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a1, a1, 3
; CHECK-NEXT:    slli a2, a1, 1
; CHECK-NEXT:    add a1, a2, a1
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  store <vscale x 3 x i8> %val, <vscale x 3 x i8>* %ptr
  ret void
}

define void @store_nxv7f64(<vscale x 7 x double> %val, <vscale x 7 x double>* %ptr) {
; CHECK-LABEL: store_nxv7f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 3
; CHECK-NEXT:    sub a1, a1, a2
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0)
; CHECK-NEXT:    ret
  store <vscale x 7 x double> %val, <vscale x 7 x double>* %ptr
  ret void
}
