; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+m,+v,+zfh,+zvfh | FileCheck %s
; RUN: llc < %s -mtriple=riscv64 -mattr=+m,+v,+zfh,+zvfh | FileCheck %s

; Integers

define {<vscale x 16 x i1>, <vscale x 16 x i1>} @vector_deinterleave_nxv16i1_nxv32i1(<vscale x 32 x i1> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv16i1_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v12, v8, 1, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 2
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a0
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmerge.vim v14, v8, 1, v0
; CHECK-NEXT:    vnsrl.wi v8, v12, 0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    vnsrl.wi v10, v12, 8
; CHECK-NEXT:    vmsne.vi v8, v10, 0
; CHECK-NEXT:    ret
%retval = call {<vscale x 16 x i1>, <vscale x 16 x i1>} @llvm.experimental.vector.deinterleave2.nxv32i1(<vscale x 32 x i1> %vec)
ret {<vscale x 16 x i1>, <vscale x 16 x i1>} %retval
}

define {<vscale x 16 x i8>, <vscale x 16 x i8>} @vector_deinterleave_nxv16i8_nxv32i8(<vscale x 32 x i8> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv16i8_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v12, v8, 0
; CHECK-NEXT:    vnsrl.wi v14, v8, 8
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    vmv.v.v v10, v14
; CHECK-NEXT:    ret
%retval = call {<vscale x 16 x i8>, <vscale x 16 x i8>} @llvm.experimental.vector.deinterleave2.nxv32i8(<vscale x 32 x i8> %vec)
ret {<vscale x 16 x i8>, <vscale x 16 x i8>} %retval
}

define {<vscale x 8 x i16>, <vscale x 8 x i16>} @vector_deinterleave_nxv8i16_nxv16i16(<vscale x 16 x i16> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv8i16_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v12, v8, 0
; CHECK-NEXT:    vnsrl.wi v14, v8, 16
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    vmv.v.v v10, v14
; CHECK-NEXT:    ret
%retval = call {<vscale x 8 x i16>, <vscale x 8 x i16>} @llvm.experimental.vector.deinterleave2.nxv16i16(<vscale x 16 x i16> %vec)
ret {<vscale x 8 x i16>, <vscale x 8 x i16>} %retval
}

define {<vscale x 4 x i32>, <vscale x 4 x i32>} @vector_deinterleave_nxv4i32_nxvv8i32(<vscale x 8 x i32> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv4i32_nxvv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vnsrl.wx v12, v8, a0
; CHECK-NEXT:    vnsrl.wi v14, v8, 0
; CHECK-NEXT:    vmv.v.v v8, v14
; CHECK-NEXT:    vmv.v.v v10, v12
; CHECK-NEXT:    ret
%retval = call {<vscale x 4 x i32>, <vscale x 4 x i32>} @llvm.experimental.vector.deinterleave2.nxv8i32(<vscale x 8 x i32> %vec)
ret {<vscale x 4 x i32>, <vscale x 4 x i32>} %retval
}

define {<vscale x 2 x i64>, <vscale x 2 x i64>} @vector_deinterleave_nxv2i64_nxv4i64(<vscale x 4 x i64> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv2i64_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vid.v v12
; CHECK-NEXT:    vadd.vv v16, v12, v12
; CHECK-NEXT:    vrgather.vv v12, v8, v16
; CHECK-NEXT:    vadd.vi v16, v16, 1
; CHECK-NEXT:    vrgather.vv v20, v8, v16
; CHECK-NEXT:    vmv2r.v v8, v12
; CHECK-NEXT:    vmv2r.v v10, v20
; CHECK-NEXT:    ret
%retval = call {<vscale x 2 x i64>, <vscale x 2 x i64>} @llvm.experimental.vector.deinterleave2.nxv4i64(<vscale x 4 x i64> %vec)
ret {<vscale x 2 x i64>, <vscale x 2 x i64>} %retval
}

declare {<vscale x 16 x i1>, <vscale x 16 x i1>} @llvm.experimental.vector.deinterleave2.nxv32i1(<vscale x 32 x i1>)
declare {<vscale x 16 x i8>, <vscale x 16 x i8>} @llvm.experimental.vector.deinterleave2.nxv32i8(<vscale x 32 x i8>)
declare {<vscale x 8 x i16>, <vscale x 8 x i16>} @llvm.experimental.vector.deinterleave2.nxv16i16(<vscale x 16 x i16>)
declare {<vscale x 4 x i32>, <vscale x 4 x i32>} @llvm.experimental.vector.deinterleave2.nxv8i32(<vscale x 8 x i32>)
declare {<vscale x 2 x i64>, <vscale x 2 x i64>} @llvm.experimental.vector.deinterleave2.nxv4i64(<vscale x 4 x i64>)

define {<vscale x 64 x i1>, <vscale x 64 x i1>} @vector_deinterleave_nxv64i1_nxv128i1(<vscale x 128 x i1> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv64i1_nxv128i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v28, v8
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, 1, v0
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v24, v16, 0
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v28
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v28, v8, 0
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vmsne.vi v0, v24, 0
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v24, v16, 8
; CHECK-NEXT:    vnsrl.wi v28, v8, 8
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vmsne.vi v8, v24, 0
; CHECK-NEXT:    ret
%retval = call {<vscale x 64 x i1>, <vscale x 64 x i1>} @llvm.experimental.vector.deinterleave2.nxv128i1(<vscale x 128 x i1> %vec)
ret {<vscale x 64 x i1>, <vscale x 64 x i1>} %retval
}

define {<vscale x 64 x i8>, <vscale x 64 x i8>} @vector_deinterleave_nxv64i8_nxv128i8(<vscale x 128 x i8> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv64i8_nxv128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv8r.v v24, v8
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v24, 0
; CHECK-NEXT:    vnsrl.wi v12, v16, 0
; CHECK-NEXT:    vnsrl.wi v0, v24, 8
; CHECK-NEXT:    vnsrl.wi v4, v16, 8
; CHECK-NEXT:    vmv8r.v v16, v0
; CHECK-NEXT:    ret
%retval = call {<vscale x 64 x i8>, <vscale x 64 x i8>} @llvm.experimental.vector.deinterleave2.nxv128i8(<vscale x 128 x i8> %vec)
ret {<vscale x 64 x i8>, <vscale x 64 x i8>} %retval
}

define {<vscale x 32 x i16>, <vscale x 32 x i16>} @vector_deinterleave_nxv32i16_nxv64i16(<vscale x 64 x i16> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv32i16_nxv64i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv8r.v v24, v8
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v24, 0
; CHECK-NEXT:    vnsrl.wi v12, v16, 0
; CHECK-NEXT:    vnsrl.wi v0, v24, 16
; CHECK-NEXT:    vnsrl.wi v4, v16, 16
; CHECK-NEXT:    vmv8r.v v16, v0
; CHECK-NEXT:    ret
%retval = call {<vscale x 32 x i16>, <vscale x 32 x i16>} @llvm.experimental.vector.deinterleave2.nxv64i16(<vscale x 64 x i16> %vec)
ret {<vscale x 32 x i16>, <vscale x 32 x i16>} %retval
}

define {<vscale x 16 x i32>, <vscale x 16 x i32>} @vector_deinterleave_nxv16i32_nxvv32i32(<vscale x 32 x i32> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv16i32_nxvv32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv8r.v v24, v16
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vnsrl.wx v20, v24, a0
; CHECK-NEXT:    vnsrl.wx v16, v8, a0
; CHECK-NEXT:    vnsrl.wi v0, v8, 0
; CHECK-NEXT:    vnsrl.wi v4, v24, 0
; CHECK-NEXT:    vmv8r.v v8, v0
; CHECK-NEXT:    ret
%retval = call {<vscale x 16 x i32>, <vscale x 16 x i32>} @llvm.experimental.vector.deinterleave2.nxv32i32(<vscale x 32 x i32> %vec)
ret {<vscale x 16 x i32>, <vscale x 16 x i32>} %retval
}

define {<vscale x 8 x i64>, <vscale x 8 x i64>} @vector_deinterleave_nxv8i64_nxv16i64(<vscale x 16 x i64> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv8i64_nxv16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 40
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x28, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 40 * vlenb
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv8r.v v24, v8
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vv v0, v8, v8
; CHECK-NEXT:    vrgather.vv v8, v24, v0
; CHECK-NEXT:    vrgather.vv v24, v16, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 5
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v24, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vadd.vi v16, v0, 1
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vrgather.vv v0, v24, v16
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v0, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v0, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vrgather.vv v16, v24, v0
; CHECK-NEXT:    vmv4r.v v24, v16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 5
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmv4r.v v12, v16
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmv4r.v v20, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 40
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
%retval = call {<vscale x 8 x i64>, <vscale x 8 x i64>} @llvm.experimental.vector.deinterleave2.nxv16i64(<vscale x 16 x i64> %vec)
ret {<vscale x 8 x i64>, <vscale x 8 x i64>} %retval
}

declare {<vscale x 64 x i1>, <vscale x 64 x i1>} @llvm.experimental.vector.deinterleave2.nxv128i1(<vscale x 128 x i1>)
declare {<vscale x 64 x i8>, <vscale x 64 x i8>} @llvm.experimental.vector.deinterleave2.nxv128i8(<vscale x 128 x i8>)
declare {<vscale x 32 x i16>, <vscale x 32 x i16>} @llvm.experimental.vector.deinterleave2.nxv64i16(<vscale x 64 x i16>)
declare {<vscale x 16 x i32>, <vscale x 16 x i32>} @llvm.experimental.vector.deinterleave2.nxv32i32(<vscale x 32 x i32>)
declare {<vscale x 8 x i64>, <vscale x 8 x i64>} @llvm.experimental.vector.deinterleave2.nxv16i64(<vscale x 16 x i64>)

; Floats

define {<vscale x 2 x half>, <vscale x 2 x half>} @vector_deinterleave_nxv2f16_nxv4f16(<vscale x 4 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv2f16_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vnsrl.wi v9, v8, 16
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
%retval = call {<vscale x 2 x half>, <vscale x 2 x half>} @llvm.experimental.vector.deinterleave2.nxv4f16(<vscale x 4 x half> %vec)
ret {<vscale x 2 x half>, <vscale x 2 x half>} %retval
}

define {<vscale x 4 x half>, <vscale x 4 x half>} @vector_deinterleave_nxv4f16_nxv8f16(<vscale x 8 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv4f16_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v10, v8, 0
; CHECK-NEXT:    vnsrl.wi v11, v8, 16
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    vmv.v.v v9, v11
; CHECK-NEXT:    ret
%retval = call {<vscale x 4 x half>, <vscale x 4 x half>} @llvm.experimental.vector.deinterleave2.nxv8f16(<vscale x 8 x half> %vec)
ret {<vscale x 4 x half>, <vscale x 4 x half>} %retval
}

define {<vscale x 2 x float>, <vscale x 2 x float>} @vector_deinterleave_nxv2f32_nxv4f32(<vscale x 4 x float> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv2f32_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vnsrl.wx v10, v8, a0
; CHECK-NEXT:    vnsrl.wi v11, v8, 0
; CHECK-NEXT:    vmv.v.v v8, v11
; CHECK-NEXT:    vmv.v.v v9, v10
; CHECK-NEXT:    ret
%retval = call {<vscale x 2 x float>, <vscale x 2 x float>} @llvm.experimental.vector.deinterleave2.nxv4f32(<vscale x 4 x float> %vec)
ret {<vscale x 2 x float>, <vscale x 2 x float>} %retval
}

define {<vscale x 8 x half>, <vscale x 8 x half>} @vector_deinterleave_nxv8f16_nxv16f16(<vscale x 16 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv8f16_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vnsrl.wi v12, v8, 0
; CHECK-NEXT:    vnsrl.wi v14, v8, 16
; CHECK-NEXT:    vmv.v.v v8, v12
; CHECK-NEXT:    vmv.v.v v10, v14
; CHECK-NEXT:    ret
%retval = call {<vscale x 8 x half>, <vscale x 8 x half>} @llvm.experimental.vector.deinterleave2.nxv16f16(<vscale x 16 x half> %vec)
ret {<vscale x 8 x half>, <vscale x 8 x half>} %retval
}

define {<vscale x 4 x float>, <vscale x 4 x float>} @vector_deinterleave_nxv4f32_nxv8f32(<vscale x 8 x float> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv4f32_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vnsrl.wx v12, v8, a0
; CHECK-NEXT:    vnsrl.wi v14, v8, 0
; CHECK-NEXT:    vmv.v.v v8, v14
; CHECK-NEXT:    vmv.v.v v10, v12
; CHECK-NEXT:    ret
%retval = call {<vscale x 4 x float>, <vscale x 4 x float>} @llvm.experimental.vector.deinterleave2.nxv8f32(<vscale x 8 x float> %vec)
ret  {<vscale x 4 x float>, <vscale x 4 x float>} %retval
}

define {<vscale x 2 x double>, <vscale x 2 x double>} @vector_deinterleave_nxv2f64_nxv4f64(<vscale x 4 x double> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv2f64_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vid.v v12
; CHECK-NEXT:    vadd.vv v16, v12, v12
; CHECK-NEXT:    vrgather.vv v12, v8, v16
; CHECK-NEXT:    vadd.vi v16, v16, 1
; CHECK-NEXT:    vrgather.vv v20, v8, v16
; CHECK-NEXT:    vmv2r.v v8, v12
; CHECK-NEXT:    vmv2r.v v10, v20
; CHECK-NEXT:    ret
%retval = call {<vscale x 2 x double>, <vscale x 2 x double>} @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double> %vec)
ret {<vscale x 2 x double>, <vscale x 2 x double>} %retval
}

declare {<vscale x 2 x half>,<vscale x 2 x half>} @llvm.experimental.vector.deinterleave2.nxv4f16(<vscale x 4 x half>)
declare {<vscale x 4 x half>, <vscale x 4 x half>} @llvm.experimental.vector.deinterleave2.nxv8f16(<vscale x 8 x half>)
declare {<vscale x 2 x float>, <vscale x 2 x float>} @llvm.experimental.vector.deinterleave2.nxv4f32(<vscale x 4 x float>)
declare {<vscale x 8 x half>, <vscale x 8 x half>} @llvm.experimental.vector.deinterleave2.nxv16f16(<vscale x 16 x half>)
declare {<vscale x 4 x float>, <vscale x 4 x float>} @llvm.experimental.vector.deinterleave2.nxv8f32(<vscale x 8 x float>)
declare {<vscale x 2 x double>, <vscale x 2 x double>} @llvm.experimental.vector.deinterleave2.nxv4f64(<vscale x 4 x double>)

define {<vscale x 32 x half>, <vscale x 32 x half>} @vector_deinterleave_nxv32f16_nxv64f16(<vscale x 64 x half> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv32f16_nxv64f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv8r.v v24, v8
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v24, 0
; CHECK-NEXT:    vnsrl.wi v12, v16, 0
; CHECK-NEXT:    vnsrl.wi v0, v24, 16
; CHECK-NEXT:    vnsrl.wi v4, v16, 16
; CHECK-NEXT:    vmv8r.v v16, v0
; CHECK-NEXT:    ret
%retval = call {<vscale x 32 x half>, <vscale x 32 x half>} @llvm.experimental.vector.deinterleave2.nxv64f16(<vscale x 64 x half> %vec)
ret {<vscale x 32 x half>, <vscale x 32 x half>} %retval
}

define {<vscale x 16 x float>, <vscale x 16 x float>} @vector_deinterleave_nxv16f32_nxv32f32(<vscale x 32 x float> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv16f32_nxv32f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv8r.v v24, v16
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vnsrl.wx v20, v24, a0
; CHECK-NEXT:    vnsrl.wx v16, v8, a0
; CHECK-NEXT:    vnsrl.wi v0, v8, 0
; CHECK-NEXT:    vnsrl.wi v4, v24, 0
; CHECK-NEXT:    vmv8r.v v8, v0
; CHECK-NEXT:    ret
%retval = call {<vscale x 16 x float>, <vscale x 16 x float>} @llvm.experimental.vector.deinterleave2.nxv32f32(<vscale x 32 x float> %vec)
ret  {<vscale x 16 x float>, <vscale x 16 x float>} %retval
}

define {<vscale x 8 x double>, <vscale x 8 x double>} @vector_deinterleave_nxv8f64_nxv16f64(<vscale x 16 x double> %vec) {
; CHECK-LABEL: vector_deinterleave_nxv8f64_nxv16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 40
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x28, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 40 * vlenb
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vmv8r.v v24, v8
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vv v0, v8, v8
; CHECK-NEXT:    vrgather.vv v8, v24, v0
; CHECK-NEXT:    vrgather.vv v24, v16, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 5
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v24, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    vadd.vi v16, v0, 1
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vrgather.vv v0, v24, v16
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vs8r.v v0, (a0) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 24
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v0, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vrgather.vv v16, v24, v0
; CHECK-NEXT:    vmv4r.v v24, v16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 5
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmv4r.v v12, v16
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vmv4r.v v20, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    li a1, 40
; CHECK-NEXT:    mul a0, a0, a1
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
%retval = call {<vscale x 8 x double>, <vscale x 8 x double>} @llvm.experimental.vector.deinterleave2.nxv16f64(<vscale x 16 x double> %vec)
ret {<vscale x 8 x double>, <vscale x 8 x double>} %retval
}

declare {<vscale x 32 x half>, <vscale x 32 x half>} @llvm.experimental.vector.deinterleave2.nxv64f16(<vscale x 64 x half>)
declare {<vscale x 16 x float>, <vscale x 16 x float>} @llvm.experimental.vector.deinterleave2.nxv32f32(<vscale x 32 x float>)
declare {<vscale x 8 x double>, <vscale x 8 x double>} @llvm.experimental.vector.deinterleave2.nxv16f64(<vscale x 16 x double>)
