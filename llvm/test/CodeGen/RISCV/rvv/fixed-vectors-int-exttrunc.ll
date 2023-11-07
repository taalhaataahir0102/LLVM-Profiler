; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv32 -mattr=+m,+v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv32 -mattr=+m,+v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1

define void @sext_v4i8_v4i32(ptr %x, ptr %z) {
; CHECK-LABEL: sext_v4i8_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vsext.vf4 v9, v8
; CHECK-NEXT:    vse32.v v9, (a1)
; CHECK-NEXT:    ret
  %a = load <4 x i8>, ptr %x
  %b = sext <4 x i8> %a to <4 x i32>
  store <4 x i32> %b, ptr %z
  ret void
}

define void @zext_v4i8_v4i32(ptr %x, ptr %z) {
; CHECK-LABEL: zext_v4i8_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vzext.vf4 v9, v8
; CHECK-NEXT:    vse32.v v9, (a1)
; CHECK-NEXT:    ret
  %a = load <4 x i8>, ptr %x
  %b = zext <4 x i8> %a to <4 x i32>
  store <4 x i32> %b, ptr %z
  ret void
}

define void @sext_v8i8_v8i32(ptr %x, ptr %z) {
; LMULMAX8-LABEL: sext_v8i8_v8i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX8-NEXT:    vle8.v v8, (a0)
; LMULMAX8-NEXT:    vsext.vf4 v10, v8
; LMULMAX8-NEXT:    vse32.v v10, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX2-LABEL: sext_v8i8_v8i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX2-NEXT:    vle8.v v8, (a0)
; LMULMAX2-NEXT:    vsext.vf4 v10, v8
; LMULMAX2-NEXT:    vse32.v v10, (a1)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: sext_v8i8_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vle8.v v8, (a0)
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    vsext.vf4 v9, v8
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v8, v8, 4
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    vsext.vf4 v10, v8
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vse32.v v10, (a0)
; LMULMAX1-NEXT:    vse32.v v9, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %b = sext <8 x i8> %a to <8 x i32>
  store <8 x i32> %b, ptr %z
  ret void
}

define void @sext_v32i8_v32i32(ptr %x, ptr %z) {
; LMULMAX8-LABEL: sext_v32i8_v32i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    li a2, 32
; LMULMAX8-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; LMULMAX8-NEXT:    vle8.v v8, (a0)
; LMULMAX8-NEXT:    vsext.vf4 v16, v8
; LMULMAX8-NEXT:    vse32.v v16, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX2-LABEL: sext_v32i8_v32i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    li a2, 32
; LMULMAX2-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; LMULMAX2-NEXT:    vle8.v v8, (a0)
; LMULMAX2-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; LMULMAX2-NEXT:    vslidedown.vi v10, v8, 8
; LMULMAX2-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX2-NEXT:    vsext.vf4 v12, v10
; LMULMAX2-NEXT:    vsext.vf4 v10, v8
; LMULMAX2-NEXT:    vsetivli zero, 16, e8, m2, ta, ma
; LMULMAX2-NEXT:    vslidedown.vi v8, v8, 16
; LMULMAX2-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX2-NEXT:    vsext.vf4 v14, v8
; LMULMAX2-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; LMULMAX2-NEXT:    vslidedown.vi v8, v8, 8
; LMULMAX2-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; LMULMAX2-NEXT:    vsext.vf4 v16, v8
; LMULMAX2-NEXT:    addi a0, a1, 96
; LMULMAX2-NEXT:    vse32.v v16, (a0)
; LMULMAX2-NEXT:    addi a0, a1, 64
; LMULMAX2-NEXT:    vse32.v v14, (a0)
; LMULMAX2-NEXT:    vse32.v v10, (a1)
; LMULMAX2-NEXT:    addi a0, a1, 32
; LMULMAX2-NEXT:    vse32.v v12, (a0)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: sext_v32i8_v32i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle8.v v8, (a2)
; LMULMAX1-NEXT:    vle8.v v9, (a0)
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v10, v8, 4
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    vsext.vf4 v11, v10
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v10, v9, 4
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    vsext.vf4 v12, v10
; LMULMAX1-NEXT:    vsext.vf4 v10, v8
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v8, v8, 8
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    vsext.vf4 v13, v8
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v8, v8, 4
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    vsext.vf4 v14, v8
; LMULMAX1-NEXT:    vsext.vf4 v8, v9
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, m1, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v9, v9, 8
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    vsext.vf4 v15, v9
; LMULMAX1-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslidedown.vi v9, v9, 4
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; LMULMAX1-NEXT:    vsext.vf4 v16, v9
; LMULMAX1-NEXT:    addi a0, a1, 48
; LMULMAX1-NEXT:    vse32.v v16, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 32
; LMULMAX1-NEXT:    vse32.v v15, (a0)
; LMULMAX1-NEXT:    vse32.v v8, (a1)
; LMULMAX1-NEXT:    addi a0, a1, 112
; LMULMAX1-NEXT:    vse32.v v14, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 96
; LMULMAX1-NEXT:    vse32.v v13, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 64
; LMULMAX1-NEXT:    vse32.v v10, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vse32.v v12, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 80
; LMULMAX1-NEXT:    vse32.v v11, (a0)
; LMULMAX1-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %b = sext <32 x i8> %a to <32 x i32>
  store <32 x i32> %b, ptr %z
  ret void
}

define void @trunc_v4i8_v4i32(ptr %x, ptr %z) {
; CHECK-LABEL: trunc_v4i8_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <4 x i32>, ptr %x
  %b = trunc <4 x i32> %a to <4 x i8>
  store <4 x i8> %b, ptr %z
  ret void
}

define void @trunc_v8i8_v8i32(ptr %x, ptr %z) {
; LMULMAX8-LABEL: trunc_v8i8_v8i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; LMULMAX8-NEXT:    vle32.v v8, (a0)
; LMULMAX8-NEXT:    vnsrl.wi v10, v8, 0
; LMULMAX8-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; LMULMAX8-NEXT:    vnsrl.wi v8, v10, 0
; LMULMAX8-NEXT:    vse8.v v8, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX2-LABEL: trunc_v8i8_v8i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; LMULMAX2-NEXT:    vle32.v v8, (a0)
; LMULMAX2-NEXT:    vnsrl.wi v10, v8, 0
; LMULMAX2-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; LMULMAX2-NEXT:    vnsrl.wi v8, v10, 0
; LMULMAX2-NEXT:    vse8.v v8, (a1)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: trunc_v8i8_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; LMULMAX1-NEXT:    vle32.v v8, (a0)
; LMULMAX1-NEXT:    addi a0, a0, 16
; LMULMAX1-NEXT:    vle32.v v9, (a0)
; LMULMAX1-NEXT:    vnsrl.wi v8, v8, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v8, v8, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v9, v9, 0
; LMULMAX1-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; LMULMAX1-NEXT:    vnsrl.wi v9, v9, 0
; LMULMAX1-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; LMULMAX1-NEXT:    vslideup.vi v8, v9, 4
; LMULMAX1-NEXT:    vse8.v v8, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x i32>, ptr %x
  %b = trunc <8 x i32> %a to <8 x i8>
  store <8 x i8> %b, ptr %z
  ret void
}
