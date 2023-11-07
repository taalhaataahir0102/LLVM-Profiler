; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 -mattr=+sve < %s | FileCheck %s

define <vscale x 2 x i64> @add_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: add_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = add <vscale x 2 x i64> %a, %b
  ret <vscale x 2 x i64> %res
}

define <vscale x 4 x i32> @add_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: add_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = add <vscale x 4 x i32> %a, %b
  ret <vscale x 4 x i32> %res
}

define <vscale x 8 x i16> @add_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: add_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = add <vscale x 8 x i16> %a, %b
  ret <vscale x 8 x i16> %res
}

define <vscale x 16 x i8> @add_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: add_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    add z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = add <vscale x 16 x i8> %a, %b
  ret <vscale x 16 x i8> %res
}

define <vscale x 16 x i8> @add_i8_zero(<vscale x 16 x i8> %a) {
; CHECK-LABEL: add_i8_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %res = add <vscale x 16 x i8> %a, zeroinitializer
  ret <vscale x 16 x i8> %res
}

define <vscale x 1 x i32> @add_nxv1i32(<vscale x 1 x i32> %a, <vscale x 1 x i32> %b) {
; CHECK-LABEL: add_nxv1i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    add z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
entry:
  %c = add <vscale x 1 x i32> %a, %b
  ret <vscale x 1 x i32> %c
}

define <vscale x 2 x i64> @sub_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: sub_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = sub <vscale x 2 x i64> %a, %b
  ret <vscale x 2 x i64> %res
}

define <vscale x 4 x i32> @sub_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: sub_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = sub <vscale x 4 x i32> %a, %b
  ret <vscale x 4 x i32> %res
}

define <vscale x 8 x i16> @sub_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: sub_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = sub <vscale x 8 x i16> %a, %b
  ret <vscale x 8 x i16> %res
}

define <vscale x 16 x i8> @sub_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: sub_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = sub <vscale x 16 x i8> %a, %b
  ret <vscale x 16 x i8> %res
}

define <vscale x 16 x i8> @sub_i8_zero(<vscale x 16 x i8> %a) {
; CHECK-LABEL: sub_i8_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %res = sub <vscale x 16 x i8> %a, zeroinitializer
  ret <vscale x 16 x i8> %res
}

define <vscale x 16 x i8> @abs_nxv16i8(<vscale x 16 x i8> %a) {
; CHECK-LABEL: abs_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    abs z0.b, p0/m, z0.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.abs.nxv16i8(<vscale x 16 x i8> %a, i1 false)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @abs_nxv8i16(<vscale x 8 x i16> %a) {
; CHECK-LABEL: abs_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    abs z0.h, p0/m, z0.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.abs.nxv8i16(<vscale x 8 x i16> %a, i1 false)
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @abs_nxv4i32(<vscale x 4 x i32> %a) {
; CHECK-LABEL: abs_nxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    abs z0.s, p0/m, z0.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.abs.nxv4i32(<vscale x 4 x i32> %a, i1 false)
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @abs_nxv2i64(<vscale x 2 x i64> %a) {
; CHECK-LABEL: abs_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    abs z0.d, p0/m, z0.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.abs.nxv2i64(<vscale x 2 x i64> %a, i1 false)
  ret <vscale x 2 x i64> %res
}

define <vscale x 4 x i16> @abs_nxv4i16(<vscale x 4 x i16> %a) {
; CHECK-LABEL: abs_nxv4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    sxth z0.s, p0/m, z0.s
; CHECK-NEXT:    abs z0.s, p0/m, z0.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i16> @llvm.abs.nxv4i16(<vscale x 4 x i16> %a, i1 false)
  ret <vscale x 4 x i16> %res
}

define <vscale x 32 x i8> @abs_nxv32i8(<vscale x 32 x i8> %a) {
; CHECK-LABEL: abs_nxv32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    abs z0.b, p0/m, z0.b
; CHECK-NEXT:    abs z1.b, p0/m, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 32 x i8> @llvm.abs.nxv32i8(<vscale x 32 x i8> %a, i1 false)
  ret <vscale x 32 x i8> %res
}

define <vscale x 8 x i64> @abs_nxv8i64(<vscale x 8 x i64> %a) {
; CHECK-LABEL: abs_nxv8i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    abs z0.d, p0/m, z0.d
; CHECK-NEXT:    abs z1.d, p0/m, z1.d
; CHECK-NEXT:    abs z2.d, p0/m, z2.d
; CHECK-NEXT:    abs z3.d, p0/m, z3.d
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i64> @llvm.abs.nxv8i64(<vscale x 8 x i64> %a, i1 false)
  ret <vscale x 8 x i64> %res
}

define <vscale x 2 x i64> @sqadd_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: sqadd_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.sadd.sat.nxv2i64(<vscale x 2 x i64>  %a, <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %res
}

define <vscale x 4 x i32> @sqadd_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: sqadd_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.sadd.sat.nxv4i32(<vscale x 4 x i32>  %a, <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %res
}

define <vscale x 4 x i32> @sqadd_i32_zero(<vscale x 4 x i32> %a) {
; CHECK-LABEL: sqadd_i32_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.sadd.sat.nxv4i32(<vscale x 4 x i32>  %a, <vscale x 4 x i32> zeroinitializer)
  ret <vscale x 4 x i32> %res
}

define <vscale x 8 x i16> @sqadd_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: sqadd_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.sadd.sat.nxv8i16(<vscale x 8 x i16>  %a, <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %res
}

define <vscale x 16 x i8> @sqadd_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: sqadd_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqadd z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.sadd.sat.nxv16i8(<vscale x 16 x i8>  %a, <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}


define <vscale x 2 x i64> @sqsub_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: sqsub_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.ssub.sat.nxv2i64(<vscale x 2 x i64>  %a, <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %res
}

define <vscale x 2 x i64> @sqsub_i64_zero(<vscale x 2 x i64> %a) {
; CHECK-LABEL: sqsub_i64_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.ssub.sat.nxv2i64(<vscale x 2 x i64>  %a, <vscale x 2 x i64> zeroinitializer)
  ret <vscale x 2 x i64> %res
}

define <vscale x 4 x i32> @sqsub_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: sqsub_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.ssub.sat.nxv4i32(<vscale x 4 x i32>  %a, <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %res
}

define <vscale x 8 x i16> @sqsub_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: sqsub_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.ssub.sat.nxv8i16(<vscale x 8 x i16>  %a, <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %res
}

define <vscale x 16 x i8> @sqsub_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: sqsub_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sqsub z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.ssub.sat.nxv16i8(<vscale x 16 x i8>  %a, <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}


define <vscale x 2 x i64> @uqadd_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: uqadd_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.uadd.sat.nxv2i64(<vscale x 2 x i64>  %a, <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %res
}

define <vscale x 4 x i32> @uqadd_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: uqadd_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.uadd.sat.nxv4i32(<vscale x 4 x i32>  %a, <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %res
}

define <vscale x 8 x i16> @uqadd_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: uqadd_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.uadd.sat.nxv8i16(<vscale x 8 x i16>  %a, <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %res
}

define <vscale x 16 x i8> @uqadd_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: uqadd_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqadd z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.uadd.sat.nxv16i8(<vscale x 16 x i8>  %a, <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}


define <vscale x 2 x i64> @uqsub_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: uqsub_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.usub.sat.nxv2i64(<vscale x 2 x i64>  %a, <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %res
}

define <vscale x 4 x i32> @uqsub_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: uqsub_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.usub.sat.nxv4i32(<vscale x 4 x i32>  %a, <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %res
}

define <vscale x 8 x i16> @uqsub_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: uqsub_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.usub.sat.nxv8i16(<vscale x 8 x i16>  %a, <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %res
}

define <vscale x 16 x i8> @uqsub_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: uqsub_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uqsub z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.usub.sat.nxv16i8(<vscale x 16 x i8>  %a, <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %res
}

define <vscale x 16 x i8> @mad_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c) {
; CHECK-LABEL: mad_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    mad z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    ret
  %prod = mul <vscale x 16 x i8> %a, %b
  %res = add <vscale x 16 x i8> %c, %prod
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @mad_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i16> %c) {
; CHECK-LABEL: mad_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    ret
  %prod = mul <vscale x 8 x i16> %a, %b
  %res = add <vscale x 8 x i16> %c, %prod
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @mad_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i32> %c) {
; CHECK-LABEL: mad_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    ret
  %prod = mul <vscale x 4 x i32> %a, %b
  %res = add <vscale x 4 x i32> %c, %prod
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @mad_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b, <vscale x 2 x i64> %c) {
; CHECK-LABEL: mad_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
  %prod = mul <vscale x 2 x i64> %a, %b
  %res = add <vscale x 2 x i64> %c, %prod
  ret <vscale x 2 x i64> %res
}

define <vscale x 16 x i8> @mla_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c) {
; CHECK-LABEL: mla_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    mla z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    ret
  %prod = mul <vscale x 16 x i8> %b, %c
  %res = add <vscale x 16 x i8> %a, %prod
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @mla_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i16> %c) {
; CHECK-LABEL: mla_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mla z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    ret
  %prod = mul <vscale x 8 x i16> %b, %c
  %res = add <vscale x 8 x i16> %a, %prod
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @mla_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i32> %c) {
; CHECK-LABEL: mla_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mla z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    ret
  %prod = mul <vscale x 4 x i32> %b, %c
  %res = add <vscale x 4 x i32> %a, %prod
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @mla_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b, <vscale x 2 x i64> %c) {
; CHECK-LABEL: mla_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mla z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
  %prod = mul <vscale x 2 x i64> %b, %c
  %res = add <vscale x 2 x i64> %a, %prod
  ret <vscale x 2 x i64> %res
}

define <vscale x 16 x i8> @mla_i8_multiuse(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c, <vscale x 16 x i8>* %p) {
; CHECK-LABEL: mla_i8_multiuse:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z0.b
; CHECK-NEXT:    add z0.b, z2.b, z1.b
; CHECK-NEXT:    st1b { z1.b }, p0, [x0]
; CHECK-NEXT:    ret
  %prod = mul <vscale x 16 x i8> %a, %b
  store <vscale x 16 x i8> %prod, <vscale x 16 x i8>* %p
  %res = add <vscale x 16 x i8> %c, %prod
  ret <vscale x 16 x i8> %res
}

define <vscale x 16 x i8> @msb_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c) {
; CHECK-LABEL: msb_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    msb z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    ret
  %prod = mul <vscale x 16 x i8> %a, %b
  %res = sub <vscale x 16 x i8> %c, %prod
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @msb_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i16> %c) {
; CHECK-LABEL: msb_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    msb z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    ret
  %prod = mul <vscale x 8 x i16> %a, %b
  %res = sub <vscale x 8 x i16> %c, %prod
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @msb_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i32> %c) {
; CHECK-LABEL: msb_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    msb z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    ret
  %prod = mul <vscale x 4 x i32> %a, %b
  %res = sub <vscale x 4 x i32> %c, %prod
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @msb_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b, <vscale x 2 x i64> %c) {
; CHECK-LABEL: msb_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    msb z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
  %prod = mul <vscale x 2 x i64> %a, %b
  %res = sub <vscale x 2 x i64> %c, %prod
  ret <vscale x 2 x i64> %res
}

define <vscale x 16 x i8> @mls_i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b, <vscale x 16 x i8> %c) {
; CHECK-LABEL: mls_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    mls z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    ret
  %prod = mul <vscale x 16 x i8> %b, %c
  %res = sub <vscale x 16 x i8> %a, %prod
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @mls_i16(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b, <vscale x 8 x i16> %c) {
; CHECK-LABEL: mls_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mls z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    ret
  %prod = mul <vscale x 8 x i16> %b, %c
  %res = sub <vscale x 8 x i16> %a, %prod
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @mls_i32(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b, <vscale x 4 x i32> %c) {
; CHECK-LABEL: mls_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mls z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    ret
  %prod = mul <vscale x 4 x i32> %b, %c
  %res = sub <vscale x 4 x i32> %a, %prod
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @mls_i64(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b, <vscale x 2 x i64> %c) {
; CHECK-LABEL: mls_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mls z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
  %prod = mul <vscale x 2 x i64> %b, %c
  %res = sub <vscale x 2 x i64> %a, %prod
  ret <vscale x 2 x i64> %res
}

; Test cases below have one of the add/sub operands as constant splat

 define <vscale x 2 x i64> @muladd_i64_positiveAddend(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b)
; CHECK-LABEL: muladd_i64_positiveAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov z2.d, #0xffffffff
; CHECK-NEXT:    mad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 2 x i64> %a, %b
  %2 = add <vscale x 2 x i64> %1, shufflevector (<vscale x 2 x i64> insertelement (<vscale x 2 x i64> poison, i64 4294967295, i64 0), <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i64> %2
}

define <vscale x 2 x i64> @muladd_i64_negativeAddend(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b)
; CHECK-LABEL: muladd_i64_negativeAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov z2.d, #0xffffffff00000001
; CHECK-NEXT:    mad z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 2 x i64> %a, %b
  %2 = add <vscale x 2 x i64> %1, shufflevector (<vscale x 2 x i64> insertelement (<vscale x 2 x i64> poison, i64 -4294967295, i64 0), <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i64> %2
}


define <vscale x 4 x i32> @muladd_i32_positiveAddend(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b)
; CHECK-LABEL: muladd_i32_positiveAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov z2.s, #0x10000
; CHECK-NEXT:    mad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 4 x i32> %a, %b
  %2 = add <vscale x 4 x i32> %1, shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 65536, i32 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
  ret <vscale x 4 x i32> %2
}

define <vscale x 4 x i32> @muladd_i32_negativeAddend(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b)
; CHECK-LABEL: muladd_i32_negativeAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov z2.s, #0xffff0000
; CHECK-NEXT:    mad z0.s, p0/m, z1.s, z2.s
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 4 x i32> %a, %b
  %2 = add <vscale x 4 x i32> %1, shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 -65536, i32 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
  ret <vscale x 4 x i32> %2
}

define <vscale x 8 x i16> @muladd_i16_positiveAddend(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b)
; CHECK-LABEL: muladd_i16_positiveAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mov z2.h, #255 // =0xff
; CHECK-NEXT:    mad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 8 x i16> %a, %b
  %2 = add <vscale x 8 x i16> %1, shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 255, i16 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer)
  ret <vscale x 8 x i16> %2
}

define <vscale x 8 x i16> @muladd_i16_negativeAddend(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b)
; CHECK-LABEL: muladd_i16_negativeAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mov z2.h, #-255 // =0xffffffffffffff01
; CHECK-NEXT:    mad z0.h, p0/m, z1.h, z2.h
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 8 x i16> %a, %b
  %2 = add <vscale x 8 x i16> %1, shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 -255, i16 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer)
  ret <vscale x 8 x i16> %2
}

define <vscale x 16 x i8> @muladd_i8_positiveAddend(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b)
; CHECK-LABEL: muladd_i8_positiveAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    mov z2.b, #15 // =0xf
; CHECK-NEXT:    mad z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 16 x i8> %a, %b
  %2 = add <vscale x 16 x i8> %1, shufflevector (<vscale x 16 x i8> insertelement (<vscale x 16 x i8> poison, i8 15, i8 0), <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer)
  ret <vscale x 16 x i8> %2
}

define <vscale x 16 x i8> @muladd_i8_negativeAddend(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b)
; CHECK-LABEL: muladd_i8_negativeAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    mov z2.b, #-15 // =0xfffffffffffffff1
; CHECK-NEXT:    mad z0.b, p0/m, z1.b, z2.b
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 16 x i8> %a, %b
  %2 = add <vscale x 16 x i8> %1, shufflevector (<vscale x 16 x i8> insertelement (<vscale x 16 x i8> poison, i8 -15, i8 0), <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer)
  ret <vscale x 16 x i8> %2
}

define <vscale x 2 x i64> @mulsub_i64_positiveAddend(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b)
; CHECK-LABEL: mulsub_i64_positiveAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    mov z1.d, #0xffffffff
; CHECK-NEXT:    sub z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 2 x i64> %a, %b
  %2 = sub <vscale x 2 x i64> %1, shufflevector (<vscale x 2 x i64> insertelement (<vscale x 2 x i64> poison, i64 4294967295, i64 0), <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i64> %2
}

define <vscale x 2 x i64> @mulsub_i64_negativeAddend(<vscale x 2 x i64> %a, <vscale x 2 x i64> %b)
; CHECK-LABEL: mulsub_i64_negativeAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    mov z1.d, #0xffffffff00000001
; CHECK-NEXT:    sub z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 2 x i64> %a, %b
  %2 = sub <vscale x 2 x i64> %1, shufflevector (<vscale x 2 x i64> insertelement (<vscale x 2 x i64> poison, i64 -4294967295, i64 0), <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer)
  ret <vscale x 2 x i64> %2
}


define <vscale x 4 x i32> @mulsub_i32_positiveAddend(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b)
; CHECK-LABEL: mulsub_i32_positiveAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    mov z1.s, #0x10000
; CHECK-NEXT:    sub z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 4 x i32> %a, %b
  %2 = sub <vscale x 4 x i32> %1, shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 65536, i32 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
  ret <vscale x 4 x i32> %2
}

define <vscale x 4 x i32> @mulsub_i32_negativeAddend(<vscale x 4 x i32> %a, <vscale x 4 x i32> %b)
; CHECK-LABEL: mulsub_i32_negativeAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    mov z1.s, #0xffff0000
; CHECK-NEXT:    sub z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 4 x i32> %a, %b
  %2 = sub <vscale x 4 x i32> %1, shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 -65536, i32 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
  ret <vscale x 4 x i32> %2
}

define <vscale x 8 x i16> @mulsub_i16_positiveAddend(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b)
; CHECK-LABEL: mulsub_i16_positiveAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mul z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    sub z0.h, z0.h, #255 // =0xff
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 8 x i16> %a, %b
  %2 = sub <vscale x 8 x i16> %1, shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 255, i16 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer)
  ret <vscale x 8 x i16> %2
}

define <vscale x 8 x i16> @mulsub_i16_negativeAddend(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b)
; CHECK-LABEL: mulsub_i16_negativeAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mul z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    mov z1.h, #-255 // =0xffffffffffffff01
; CHECK-NEXT:    sub z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 8 x i16> %a, %b
  %2 = sub <vscale x 8 x i16> %1, shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 -255, i16 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer)
  ret <vscale x 8 x i16> %2
}

define <vscale x 16 x i8> @mulsub_i8_positiveAddend(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b)
; CHECK-LABEL: mulsub_i8_positiveAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    mul z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT:    sub z0.b, z0.b, #15 // =0xf
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 16 x i8> %a, %b
  %2 = sub <vscale x 16 x i8> %1, shufflevector (<vscale x 16 x i8> insertelement (<vscale x 16 x i8> poison, i8 15, i8 0), <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer)
  ret <vscale x 16 x i8> %2
}

define <vscale x 16 x i8> @mulsub_i8_negativeAddend(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b)
; CHECK-LABEL: mulsub_i8_negativeAddend:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    mul z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT:    sub z0.b, z0.b, #241 // =0xf1
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 16 x i8> %a, %b
  %2 = sub <vscale x 16 x i8> %1, shufflevector (<vscale x 16 x i8> insertelement (<vscale x 16 x i8> poison, i8 -15, i8 0), <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer)
  ret <vscale x 16 x i8> %2
}

; TOFIX: Should generate msb for mul+sub in this case. Shuffling operand of sub generates the required msb instruction.
define <vscale x 8 x i16> @multiple_fused_ops(<vscale x 8 x i16> %a, <vscale x 8 x i16> %b)
; CHECK-LABEL: multiple_fused_ops:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mov w8, #200 // =0xc8
; CHECK-NEXT:    mov z2.h, w8
; CHECK-NEXT:    mla z2.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    mul z0.h, p0/m, z0.h, z2.h
; CHECK-NEXT:    sub z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
{
  %1 = mul <vscale x 8 x i16> %a, %b
  %2 = add  <vscale x 8 x i16> %1, shufflevector (<vscale x 8 x i16> insertelement (<vscale x 8 x i16> poison, i16 200, i16 0), <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer)
  %3 = mul <vscale x 8 x i16> %2, %a
  %4 = sub <vscale x 8 x i16> %3, %b
  ret <vscale x 8 x i16> %4
}

define void @mad_in_loop(ptr %dst, ptr %src1, ptr %src2, i32 %n) {
; CHECK-LABEL: mad_in_loop:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cmp w3, #1
; CHECK-NEXT:    b.lt .LBB70_3
; CHECK-NEXT:  // %bb.1: // %for.body.preheader
; CHECK-NEXT:    mov w9, w3
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    mov z0.s, #1 // =0x1
; CHECK-NEXT:    whilelo p0.s, xzr, x9
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    cntw x10
; CHECK-NEXT:  .LBB70_2: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1, x8, lsl #2]
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x2, x8, lsl #2]
; CHECK-NEXT:    mad z1.s, p1/m, z2.s, z0.s
; CHECK-NEXT:    st1w { z1.s }, p0, [x0, x8, lsl #2]
; CHECK-NEXT:    add x8, x8, x10
; CHECK-NEXT:    whilelo p0.s, x8, x9
; CHECK-NEXT:    b.mi .LBB70_2
; CHECK-NEXT:  .LBB70_3: // %for.cond.cleanup
; CHECK-NEXT:    ret
entry:
  %cmp9 = icmp sgt i32 %n, 0
  br i1 %cmp9, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %n to i64
  %active.lane.mask.entry = tail call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 0, i64 %wide.trip.count)
  %0 = tail call i64 @llvm.vscale.i64()
  %1 = shl nuw nsw i64 %0, 2
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %for.body.preheader
  %index = phi i64 [ 0, %for.body.preheader ], [ %index.next, %vector.body ]
  %active.lane.mask = phi <vscale x 4 x i1> [ %active.lane.mask.entry, %for.body.preheader ], [ %active.lane.mask.next, %vector.body ]
  %2 = getelementptr inbounds i32, ptr %src1, i64 %index
  %wide.masked.load = tail call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr %2, i32 4, <vscale x 4 x i1> %active.lane.mask, <vscale x 4 x i32> poison)
  %3 = getelementptr inbounds i32, ptr %src2, i64 %index
  %wide.masked.load12 = tail call <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr %3, i32 4, <vscale x 4 x i1> %active.lane.mask, <vscale x 4 x i32> poison)
  %4 = mul nsw <vscale x 4 x i32> %wide.masked.load12, %wide.masked.load
  %5 = add nsw <vscale x 4 x i32> %4, shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 1, i64 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
  %6 = getelementptr inbounds i32, ptr %dst, i64 %index
  tail call void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32> %5, ptr %6, i32 4, <vscale x 4 x i1> %active.lane.mask)
  %index.next = add i64 %index, %1
  %active.lane.mask.next = tail call <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64 %index.next, i64 %wide.trip.count)
  %7 = extractelement <vscale x 4 x i1> %active.lane.mask.next, i64 0
  br i1 %7, label %vector.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %vector.body, %entry
  ret void
}

declare i64 @llvm.vscale.i64()
declare <vscale x 4 x i1> @llvm.get.active.lane.mask.nxv4i1.i64(i64, i64)
declare <vscale x 4 x i32> @llvm.masked.load.nxv4i32.p0(ptr nocapture, i32 immarg, <vscale x 4 x i1>, <vscale x 4 x i32>)
declare void @llvm.masked.store.nxv4i32.p0(<vscale x 4 x i32>, ptr nocapture, i32 immarg, <vscale x 4 x i1>)

declare <vscale x 16 x i8> @llvm.sadd.sat.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.sadd.sat.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.sadd.sat.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.sadd.sat.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 16 x i8> @llvm.ssub.sat.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.ssub.sat.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.ssub.sat.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.ssub.sat.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 16 x i8> @llvm.uadd.sat.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.uadd.sat.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.uadd.sat.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.uadd.sat.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 16 x i8> @llvm.usub.sat.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.usub.sat.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.usub.sat.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.usub.sat.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 32 x i8> @llvm.abs.nxv32i8(<vscale x 32 x i8>, i1)
declare <vscale x 16 x i8> @llvm.abs.nxv16i8(<vscale x 16 x i8>, i1)
declare <vscale x 4 x i16> @llvm.abs.nxv4i16(<vscale x 4 x i16>, i1)
declare <vscale x 8 x i16> @llvm.abs.nxv8i16(<vscale x 8 x i16>, i1)
declare <vscale x 4 x i32> @llvm.abs.nxv4i32(<vscale x 4 x i32>, i1)
declare <vscale x 8 x i64> @llvm.abs.nxv8i64(<vscale x 8 x i64>, i1)
declare <vscale x 2 x i64> @llvm.abs.nxv2i64(<vscale x 2 x i64>, i1)
