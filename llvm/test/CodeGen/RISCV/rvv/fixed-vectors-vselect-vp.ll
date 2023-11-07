; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v,+m -target-abi=ilp32d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v,+m -target-abi=lp64d -riscv-v-vector-bits-min=128 \
; RUN:   -verify-machineinstrs < %s | FileCheck %s

declare <1 x i1> @llvm.vp.select.v1i1(<1 x i1>, <1 x i1>, <1 x i1>, i32)

define <1 x i1> @select_v1i1(<1 x i1> %a, <1 x i1> %b, <1 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <1 x i1> @llvm.vp.select.v1i1(<1 x i1> %a, <1 x i1> %b, <1 x i1> %c, i32 %evl)
  ret <1 x i1> %v
}

declare <2 x i1> @llvm.vp.select.v2i1(<2 x i1>, <2 x i1>, <2 x i1>, i32)

define <2 x i1> @select_v2i1(<2 x i1> %a, <2 x i1> %b, <2 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x i1> @llvm.vp.select.v2i1(<2 x i1> %a, <2 x i1> %b, <2 x i1> %c, i32 %evl)
  ret <2 x i1> %v
}

declare <4 x i1> @llvm.vp.select.v4i1(<4 x i1>, <4 x i1>, <4 x i1>, i32)

define <4 x i1> @select_v4i1(<4 x i1> %a, <4 x i1> %b, <4 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i1> @llvm.vp.select.v4i1(<4 x i1> %a, <4 x i1> %b, <4 x i1> %c, i32 %evl)
  ret <4 x i1> %v
}

declare <8 x i1> @llvm.vp.select.v8i1(<8 x i1>, <8 x i1>, <8 x i1>, i32)

define <8 x i1> @select_v8i1(<8 x i1> %a, <8 x i1> %b, <8 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <8 x i1> @llvm.vp.select.v8i1(<8 x i1> %a, <8 x i1> %b, <8 x i1> %c, i32 %evl)
  ret <8 x i1> %v
}

declare <16 x i1> @llvm.vp.select.v16i1(<16 x i1>, <16 x i1>, <16 x i1>, i32)

define <16 x i1> @select_v16i1(<16 x i1> %a, <16 x i1> %b, <16 x i1> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vmandn.mm v9, v9, v0
; CHECK-NEXT:    vmand.mm v8, v8, v0
; CHECK-NEXT:    vmor.mm v0, v8, v9
; CHECK-NEXT:    ret
  %v = call <16 x i1> @llvm.vp.select.v16i1(<16 x i1> %a, <16 x i1> %b, <16 x i1> %c, i32 %evl)
  ret <16 x i1> %v
}

declare <8 x i7> @llvm.vp.select.v8i7(<8 x i1>, <8 x i7>, <8 x i7>, i32)

define <8 x i7> @select_v8i7(<8 x i1> %a, <8 x i7> %b, <8 x i7> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8i7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <8 x i7> @llvm.vp.select.v8i7(<8 x i1> %a, <8 x i7> %b, <8 x i7> %c, i32 %evl)
  ret <8 x i7> %v
}

declare <2 x i8> @llvm.vp.select.v2i8(<2 x i1>, <2 x i8>, <2 x i8>, i32)

define <2 x i8> @select_v2i8(<2 x i1> %a, <2 x i8> %b, <2 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.vp.select.v2i8(<2 x i1> %a, <2 x i8> %b, <2 x i8> %c, i32 %evl)
  ret <2 x i8> %v
}

declare <4 x i8> @llvm.vp.select.v4i8(<4 x i1>, <4 x i8>, <4 x i8>, i32)

define <4 x i8> @select_v4i8(<4 x i1> %a, <4 x i8> %b, <4 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <4 x i8> @llvm.vp.select.v4i8(<4 x i1> %a, <4 x i8> %b, <4 x i8> %c, i32 %evl)
  ret <4 x i8> %v
}

declare <5 x i8> @llvm.vp.select.v5i8(<5 x i1>, <5 x i8>, <5 x i8>, i32)

define <5 x i8> @select_v5i8(<5 x i1> %a, <5 x i8> %b, <5 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v5i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <5 x i8> @llvm.vp.select.v5i8(<5 x i1> %a, <5 x i8> %b, <5 x i8> %c, i32 %evl)
  ret <5 x i8> %v
}

declare <8 x i8> @llvm.vp.select.v8i8(<8 x i1>, <8 x i8>, <8 x i8>, i32)

define <8 x i8> @select_v8i8(<8 x i1> %a, <8 x i8> %b, <8 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <8 x i8> @llvm.vp.select.v8i8(<8 x i1> %a, <8 x i8> %b, <8 x i8> %c, i32 %evl)
  ret <8 x i8> %v
}

declare <16 x i8> @llvm.vp.select.v16i8(<16 x i1>, <16 x i8>, <16 x i8>, i32)

define <16 x i8> @select_v16i8(<16 x i1> %a, <16 x i8> %b, <16 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <16 x i8> @llvm.vp.select.v16i8(<16 x i1> %a, <16 x i8> %b, <16 x i8> %c, i32 %evl)
  ret <16 x i8> %v
}

declare <256 x i8> @llvm.vp.select.v256i8(<256 x i1>, <256 x i8>, <256 x i8>, i32)

define <256 x i8> @select_v256i8(<256 x i1> %a, <256 x i8> %b, <256 x i8> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v256i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 3
; CHECK-NEXT:    sub sp, sp, a2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; CHECK-NEXT:    addi a2, sp, 16
; CHECK-NEXT:    vs8r.v v16, (a2) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v2, v8
; CHECK-NEXT:    vmv1r.v v1, v0
; CHECK-NEXT:    li a2, 128
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v24, (a0)
; CHECK-NEXT:    addi a0, a1, 128
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    addi a0, a3, -128
; CHECK-NEXT:    sltu a4, a3, a0
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    vle8.v v16, (a1)
; CHECK-NEXT:    and a0, a4, a0
; CHECK-NEXT:    vsetvli zero, a0, e8, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v2
; CHECK-NEXT:    vmerge.vvm v24, v8, v24, v0
; CHECK-NEXT:    bltu a3, a2, .LBB11_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a3, 128
; CHECK-NEXT:  .LBB11_2:
; CHECK-NEXT:    vsetvli zero, a3, e8, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v1
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    vmv8r.v v16, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <256 x i8> @llvm.vp.select.v256i8(<256 x i1> %a, <256 x i8> %b, <256 x i8> %c, i32 %evl)
  ret <256 x i8> %v
}

define <256 x i8> @select_evl_v256i8(<256 x i1> %a, <256 x i8> %b, <256 x i8> %c) {
; CHECK-LABEL: select_evl_v256i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    li a3, 24
; CHECK-NEXT:    mul a2, a2, a3
; CHECK-NEXT:    sub sp, sp, a2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x18, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 24 * vlenb
; CHECK-NEXT:    li a2, 128
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v24, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v24, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    addi a0, a1, 128
; CHECK-NEXT:    vle8.v v24, (a0)
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv1r.v v9, v0
; CHECK-NEXT:    vle8.v v16, (a1)
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetivli zero, 1, e8, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v24, v24, v16, v0
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    vmv8r.v v16, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <256 x i8> @llvm.vp.select.v256i8(<256 x i1> %a, <256 x i8> %b, <256 x i8> %c, i32 129)
  ret <256 x i8> %v
}

declare <2 x i16> @llvm.vp.select.v2i16(<2 x i1>, <2 x i16>, <2 x i16>, i32)

define <2 x i16> @select_v2i16(<2 x i1> %a, <2 x i16> %b, <2 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.vp.select.v2i16(<2 x i1> %a, <2 x i16> %b, <2 x i16> %c, i32 %evl)
  ret <2 x i16> %v
}

declare <4 x i16> @llvm.vp.select.v4i16(<4 x i1>, <4 x i16>, <4 x i16>, i32)

define <4 x i16> @select_v4i16(<4 x i1> %a, <4 x i16> %b, <4 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.vp.select.v4i16(<4 x i1> %a, <4 x i16> %b, <4 x i16> %c, i32 %evl)
  ret <4 x i16> %v
}

declare <8 x i16> @llvm.vp.select.v8i16(<8 x i1>, <8 x i16>, <8 x i16>, i32)

define <8 x i16> @select_v8i16(<8 x i1> %a, <8 x i16> %b, <8 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <8 x i16> @llvm.vp.select.v8i16(<8 x i1> %a, <8 x i16> %b, <8 x i16> %c, i32 %evl)
  ret <8 x i16> %v
}

declare <16 x i16> @llvm.vp.select.v16i16(<16 x i1>, <16 x i16>, <16 x i16>, i32)

define <16 x i16> @select_v16i16(<16 x i1> %a, <16 x i16> %b, <16 x i16> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <16 x i16> @llvm.vp.select.v16i16(<16 x i1> %a, <16 x i16> %b, <16 x i16> %c, i32 %evl)
  ret <16 x i16> %v
}

declare <2 x i32> @llvm.vp.select.v2i32(<2 x i1>, <2 x i32>, <2 x i32>, i32)

define <2 x i32> @select_v2i32(<2 x i1> %a, <2 x i32> %b, <2 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <2 x i32> @llvm.vp.select.v2i32(<2 x i1> %a, <2 x i32> %b, <2 x i32> %c, i32 %evl)
  ret <2 x i32> %v
}

declare <4 x i32> @llvm.vp.select.v4i32(<4 x i1>, <4 x i32>, <4 x i32>, i32)

define <4 x i32> @select_v4i32(<4 x i1> %a, <4 x i32> %b, <4 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.select.v4i32(<4 x i1> %a, <4 x i32> %b, <4 x i32> %c, i32 %evl)
  ret <4 x i32> %v
}

declare <8 x i32> @llvm.vp.select.v8i32(<8 x i1>, <8 x i32>, <8 x i32>, i32)

define <8 x i32> @select_v8i32(<8 x i1> %a, <8 x i32> %b, <8 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <8 x i32> @llvm.vp.select.v8i32(<8 x i1> %a, <8 x i32> %b, <8 x i32> %c, i32 %evl)
  ret <8 x i32> %v
}

declare <16 x i32> @llvm.vp.select.v16i32(<16 x i1>, <16 x i32>, <16 x i32>, i32)

define <16 x i32> @select_v16i32(<16 x i1> %a, <16 x i32> %b, <16 x i32> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <16 x i32> @llvm.vp.select.v16i32(<16 x i1> %a, <16 x i32> %b, <16 x i32> %c, i32 %evl)
  ret <16 x i32> %v
}

declare <2 x i64> @llvm.vp.select.v2i64(<2 x i1>, <2 x i64>, <2 x i64>, i32)

define <2 x i64> @select_v2i64(<2 x i1> %a, <2 x i64> %b, <2 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <2 x i64> @llvm.vp.select.v2i64(<2 x i1> %a, <2 x i64> %b, <2 x i64> %c, i32 %evl)
  ret <2 x i64> %v
}

declare <4 x i64> @llvm.vp.select.v4i64(<4 x i1>, <4 x i64>, <4 x i64>, i32)

define <4 x i64> @select_v4i64(<4 x i1> %a, <4 x i64> %b, <4 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.select.v4i64(<4 x i1> %a, <4 x i64> %b, <4 x i64> %c, i32 %evl)
  ret <4 x i64> %v
}

declare <8 x i64> @llvm.vp.select.v8i64(<8 x i1>, <8 x i64>, <8 x i64>, i32)

define <8 x i64> @select_v8i64(<8 x i1> %a, <8 x i64> %b, <8 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <8 x i64> @llvm.vp.select.v8i64(<8 x i1> %a, <8 x i64> %b, <8 x i64> %c, i32 %evl)
  ret <8 x i64> %v
}

declare <16 x i64> @llvm.vp.select.v16i64(<16 x i1>, <16 x i64>, <16 x i64>, i32)

define <16 x i64> @select_v16i64(<16 x i1> %a, <16 x i64> %b, <16 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <16 x i64> @llvm.vp.select.v16i64(<16 x i1> %a, <16 x i64> %b, <16 x i64> %c, i32 %evl)
  ret <16 x i64> %v
}

declare <32 x i64> @llvm.vp.select.v32i64(<32 x i1>, <32 x i64>, <32 x i64>, i32)

define <32 x i64> @select_v32i64(<32 x i1> %a, <32 x i64> %b, <32 x i64> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v32i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; CHECK-NEXT:    addi a1, a0, 128
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v24, (a1)
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v24, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vle64.v v24, (a0)
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    bltu a2, a1, .LBB25_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:  .LBB25_2:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v24, v8, v0
; CHECK-NEXT:    addi a0, a2, -16
; CHECK-NEXT:    sltu a1, a2, a0
; CHECK-NEXT:    addi a1, a1, -1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v0, 2
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v16, v24, v16, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <32 x i64> @llvm.vp.select.v32i64(<32 x i1> %a, <32 x i64> %b, <32 x i64> %c, i32 %evl)
  ret <32 x i64> %v
}

define <32 x i64> @select_evl_v32i64(<32 x i1> %a, <32 x i64> %b, <32 x i64> %c) {
; CHECK-LABEL: select_evl_v32i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v24, (a0)
; CHECK-NEXT:    vmerge.vvm v8, v24, v8, v0
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    vle64.v v24, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v0, 2
; CHECK-NEXT:    vsetivli zero, 1, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v16, v24, v16, v0
; CHECK-NEXT:    ret
  %v = call <32 x i64> @llvm.vp.select.v32i64(<32 x i1> %a, <32 x i64> %b, <32 x i64> %c, i32 17)
  ret <32 x i64> %v
}

declare <2 x half> @llvm.vp.select.v2f16(<2 x i1>, <2 x half>, <2 x half>, i32)

define <2 x half> @select_v2f16(<2 x i1> %a, <2 x half> %b, <2 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <2 x half> @llvm.vp.select.v2f16(<2 x i1> %a, <2 x half> %b, <2 x half> %c, i32 %evl)
  ret <2 x half> %v
}

declare <4 x half> @llvm.vp.select.v4f16(<4 x i1>, <4 x half>, <4 x half>, i32)

define <4 x half> @select_v4f16(<4 x i1> %a, <4 x half> %b, <4 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <4 x half> @llvm.vp.select.v4f16(<4 x i1> %a, <4 x half> %b, <4 x half> %c, i32 %evl)
  ret <4 x half> %v
}

declare <8 x half> @llvm.vp.select.v8f16(<8 x i1>, <8 x half>, <8 x half>, i32)

define <8 x half> @select_v8f16(<8 x i1> %a, <8 x half> %b, <8 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <8 x half> @llvm.vp.select.v8f16(<8 x i1> %a, <8 x half> %b, <8 x half> %c, i32 %evl)
  ret <8 x half> %v
}

declare <16 x half> @llvm.vp.select.v16f16(<16 x i1>, <16 x half>, <16 x half>, i32)

define <16 x half> @select_v16f16(<16 x i1> %a, <16 x half> %b, <16 x half> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <16 x half> @llvm.vp.select.v16f16(<16 x i1> %a, <16 x half> %b, <16 x half> %c, i32 %evl)
  ret <16 x half> %v
}

declare <2 x float> @llvm.vp.select.v2f32(<2 x i1>, <2 x float>, <2 x float>, i32)

define <2 x float> @select_v2f32(<2 x i1> %a, <2 x float> %b, <2 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <2 x float> @llvm.vp.select.v2f32(<2 x i1> %a, <2 x float> %b, <2 x float> %c, i32 %evl)
  ret <2 x float> %v
}

declare <4 x float> @llvm.vp.select.v4f32(<4 x i1>, <4 x float>, <4 x float>, i32)

define <4 x float> @select_v4f32(<4 x i1> %a, <4 x float> %b, <4 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <4 x float> @llvm.vp.select.v4f32(<4 x i1> %a, <4 x float> %b, <4 x float> %c, i32 %evl)
  ret <4 x float> %v
}

declare <8 x float> @llvm.vp.select.v8f32(<8 x i1>, <8 x float>, <8 x float>, i32)

define <8 x float> @select_v8f32(<8 x i1> %a, <8 x float> %b, <8 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <8 x float> @llvm.vp.select.v8f32(<8 x i1> %a, <8 x float> %b, <8 x float> %c, i32 %evl)
  ret <8 x float> %v
}

declare <16 x float> @llvm.vp.select.v16f32(<16 x i1>, <16 x float>, <16 x float>, i32)

define <16 x float> @select_v16f32(<16 x i1> %a, <16 x float> %b, <16 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <16 x float> @llvm.vp.select.v16f32(<16 x i1> %a, <16 x float> %b, <16 x float> %c, i32 %evl)
  ret <16 x float> %v
}

declare <64 x float> @llvm.vp.select.v64f32(<64 x i1>, <64 x float>, <64 x float>, i32)

define <64 x float> @select_v64f32(<64 x i1> %a, <64 x float> %b, <64 x float> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v64f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; CHECK-NEXT:    addi a1, a0, 128
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; CHECK-NEXT:    vle32.v v24, (a1)
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v24, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    vle32.v v24, (a0)
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    bltu a2, a3, .LBB35_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:  .LBB35_2:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v24, v8, v0
; CHECK-NEXT:    addi a0, a2, -32
; CHECK-NEXT:    sltu a1, a2, a0
; CHECK-NEXT:    addi a1, a1, -1
; CHECK-NEXT:    and a0, a1, a0
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v0, 4
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmerge.vvm v16, v24, v16, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <64 x float> @llvm.vp.select.v64f32(<64 x i1> %a, <64 x float> %b, <64 x float> %c, i32 %evl)
  ret <64 x float> %v
}

declare <2 x double> @llvm.vp.select.v2f64(<2 x i1>, <2 x double>, <2 x double>, i32)

define <2 x double> @select_v2f64(<2 x i1> %a, <2 x double> %b, <2 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <2 x double> @llvm.vp.select.v2f64(<2 x i1> %a, <2 x double> %b, <2 x double> %c, i32 %evl)
  ret <2 x double> %v
}

declare <4 x double> @llvm.vp.select.v4f64(<4 x i1>, <4 x double>, <4 x double>, i32)

define <4 x double> @select_v4f64(<4 x i1> %a, <4 x double> %b, <4 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <4 x double> @llvm.vp.select.v4f64(<4 x i1> %a, <4 x double> %b, <4 x double> %c, i32 %evl)
  ret <4 x double> %v
}

declare <8 x double> @llvm.vp.select.v8f64(<8 x i1>, <8 x double>, <8 x double>, i32)

define <8 x double> @select_v8f64(<8 x i1> %a, <8 x double> %b, <8 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <8 x double> @llvm.vp.select.v8f64(<8 x i1> %a, <8 x double> %b, <8 x double> %c, i32 %evl)
  ret <8 x double> %v
}

declare <16 x double> @llvm.vp.select.v16f64(<16 x i1>, <16 x double>, <16 x double>, i32)

define <16 x double> @select_v16f64(<16 x i1> %a, <16 x double> %b, <16 x double> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <16 x double> @llvm.vp.select.v16f64(<16 x i1> %a, <16 x double> %b, <16 x double> %c, i32 %evl)
  ret <16 x double> %v
}