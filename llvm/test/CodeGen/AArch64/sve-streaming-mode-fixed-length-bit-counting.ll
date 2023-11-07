; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve -force-streaming-compatible-sve < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

;
; CLZ
;

define <4 x i8> @ctlz_v4i8(<4 x i8> %op) {
; CHECK-LABEL: ctlz_v4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    and z0.h, z0.h, #0xff
; CHECK-NEXT:    clz z0.h, p0/m, z0.h
; CHECK-NEXT:    sub z0.h, z0.h, #8 // =0x8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i8> @llvm.ctlz.v4i8(<4 x i8> %op)
  ret <4 x i8> %res
}

define <8 x i8> @ctlz_v8i8(<8 x i8> %op) {
; CHECK-LABEL: ctlz_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    clz z0.b, p0/m, z0.b
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i8> @llvm.ctlz.v8i8(<8 x i8> %op)
  ret <8 x i8> %res
}

define <16 x i8> @ctlz_v16i8(<16 x i8> %op) {
; CHECK-LABEL: ctlz_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    clz z0.b, p0/m, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <16 x i8> @llvm.ctlz.v16i8(<16 x i8> %op)
  ret <16 x i8> %res
}

define void @ctlz_v32i8(ptr %a) {
; CHECK-LABEL: ctlz_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    clz z0.b, p0/m, z0.b
; CHECK-NEXT:    clz z1.b, p0/m, z1.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call <32 x i8> @llvm.ctlz.v32i8(<32 x i8> %op)
  store <32 x i8> %res, ptr %a
  ret void
}

define <2 x i16> @ctlz_v2i16(<2 x i16> %op) {
; CHECK-LABEL: ctlz_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    and z0.s, z0.s, #0xffff
; CHECK-NEXT:    clz z0.s, p0/m, z0.s
; CHECK-NEXT:    sub z0.s, z0.s, #16 // =0x10
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i16> @llvm.ctlz.v2i16(<2 x i16> %op)
  ret <2 x i16> %res
}

define <4 x i16> @ctlz_v4i16(<4 x i16> %op) {
; CHECK-LABEL: ctlz_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    clz z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i16> @llvm.ctlz.v4i16(<4 x i16> %op)
  ret <4 x i16> %res
}

define <8 x i16> @ctlz_v8i16(<8 x i16> %op) {
; CHECK-LABEL: ctlz_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    clz z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i16> @llvm.ctlz.v8i16(<8 x i16> %op)
  ret <8 x i16> %res
}

define void @ctlz_v16i16(ptr %a) {
; CHECK-LABEL: ctlz_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    clz z0.h, p0/m, z0.h
; CHECK-NEXT:    clz z1.h, p0/m, z1.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call <16 x i16> @llvm.ctlz.v16i16(<16 x i16> %op)
  store <16 x i16> %res, ptr %a
  ret void
}

define <2 x i32> @ctlz_v2i32(<2 x i32> %op) {
; CHECK-LABEL: ctlz_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    clz z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i32> @llvm.ctlz.v2i32(<2 x i32> %op)
  ret <2 x i32> %res
}

define <4 x i32> @ctlz_v4i32(<4 x i32> %op) {
; CHECK-LABEL: ctlz_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    clz z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i32> @llvm.ctlz.v4i32(<4 x i32> %op)
  ret <4 x i32> %res
}

define void @ctlz_v8i32(ptr %a) {
; CHECK-LABEL: ctlz_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    clz z0.s, p0/m, z0.s
; CHECK-NEXT:    clz z1.s, p0/m, z1.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call <8 x i32> @llvm.ctlz.v8i32(<8 x i32> %op)
  store <8 x i32> %res, ptr %a
  ret void
}

define <1 x i64> @ctlz_v1i64(<1 x i64> %op) {
; CHECK-LABEL: ctlz_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    clz z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <1 x i64> @llvm.ctlz.v1i64(<1 x i64> %op)
  ret <1 x i64> %res
}

define <2 x i64> @ctlz_v2i64(<2 x i64> %op) {
; CHECK-LABEL: ctlz_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    clz z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i64> @llvm.ctlz.v2i64(<2 x i64> %op)
  ret <2 x i64> %res
}

define void @ctlz_v4i64(ptr %a) {
; CHECK-LABEL: ctlz_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    clz z0.d, p0/m, z0.d
; CHECK-NEXT:    clz z1.d, p0/m, z1.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call <4 x i64> @llvm.ctlz.v4i64(<4 x i64> %op)
  store <4 x i64> %res, ptr %a
  ret void
}

;
; CNT
;

define <4 x i8> @ctpop_v4i8(<4 x i8> %op) {
; CHECK-LABEL: ctpop_v4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    and z0.h, z0.h, #0xff
; CHECK-NEXT:    cnt z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i8> @llvm.ctpop.v4i8(<4 x i8> %op)
  ret <4 x i8> %res
}

define <8 x i8> @ctpop_v8i8(<8 x i8> %op) {
; CHECK-LABEL: ctpop_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    cnt z0.b, p0/m, z0.b
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i8> @llvm.ctpop.v8i8(<8 x i8> %op)
  ret <8 x i8> %res
}

define <16 x i8> @ctpop_v16i8(<16 x i8> %op) {
; CHECK-LABEL: ctpop_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    cnt z0.b, p0/m, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <16 x i8> @llvm.ctpop.v16i8(<16 x i8> %op)
  ret <16 x i8> %res
}

define void @ctpop_v32i8(ptr %a) {
; CHECK-LABEL: ctpop_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    cnt z0.b, p0/m, z0.b
; CHECK-NEXT:    cnt z1.b, p0/m, z1.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call <32 x i8> @llvm.ctpop.v32i8(<32 x i8> %op)
  store <32 x i8> %res, ptr %a
  ret void
}

define <2 x i16> @ctpop_v2i16(<2 x i16> %op) {
; CHECK-LABEL: ctpop_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    and z0.s, z0.s, #0xffff
; CHECK-NEXT:    cnt z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i16> @llvm.ctpop.v2i16(<2 x i16> %op)
  ret <2 x i16> %res
}

define <4 x i16> @ctpop_v4i16(<4 x i16> %op) {
; CHECK-LABEL: ctpop_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    cnt z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i16> @llvm.ctpop.v4i16(<4 x i16> %op)
  ret <4 x i16> %res
}

define <8 x i16> @ctpop_v8i16(<8 x i16> %op) {
; CHECK-LABEL: ctpop_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    cnt z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i16> @llvm.ctpop.v8i16(<8 x i16> %op)
  ret <8 x i16> %res
}

define void @ctpop_v16i16(ptr %a) {
; CHECK-LABEL: ctpop_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    cnt z0.h, p0/m, z0.h
; CHECK-NEXT:    cnt z1.h, p0/m, z1.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call <16 x i16> @llvm.ctpop.v16i16(<16 x i16> %op)
  store <16 x i16> %res, ptr %a
  ret void
}

define <2 x i32> @ctpop_v2i32(<2 x i32> %op) {
; CHECK-LABEL: ctpop_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    cnt z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %op)
  ret <2 x i32> %res
}

define <4 x i32> @ctpop_v4i32(<4 x i32> %op) {
; CHECK-LABEL: ctpop_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    cnt z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i32> @llvm.ctpop.v4i32(<4 x i32> %op)
  ret <4 x i32> %res
}

define void @ctpop_v8i32(ptr %a) {
; CHECK-LABEL: ctpop_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    cnt z0.s, p0/m, z0.s
; CHECK-NEXT:    cnt z1.s, p0/m, z1.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call <8 x i32> @llvm.ctpop.v8i32(<8 x i32> %op)
  store <8 x i32> %res, ptr %a
  ret void
}

define <1 x i64> @ctpop_v1i64(<1 x i64> %op) {
; CHECK-LABEL: ctpop_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    cnt z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <1 x i64> @llvm.ctpop.v1i64(<1 x i64> %op)
  ret <1 x i64> %res
}

define <2 x i64> @ctpop_v2i64(<2 x i64> %op) {
; CHECK-LABEL: ctpop_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    cnt z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i64> @llvm.ctpop.v2i64(<2 x i64> %op)
  ret <2 x i64> %res
}

define void @ctpop_v4i64(ptr %a) {
; CHECK-LABEL: ctpop_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    cnt z0.d, p0/m, z0.d
; CHECK-NEXT:    cnt z1.d, p0/m, z1.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call <4 x i64> @llvm.ctpop.v4i64(<4 x i64> %op)
  store <4 x i64> %res, ptr %a
  ret void
}

;
; Count trailing zeros
;

define <4 x i8> @cttz_v4i8(<4 x i8> %op) {
; CHECK-LABEL: cttz_v4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    orr z0.h, z0.h, #0x100
; CHECK-NEXT:    rbit z0.h, p0/m, z0.h
; CHECK-NEXT:    clz z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i8> @llvm.cttz.v4i8(<4 x i8> %op)
  ret <4 x i8> %res
}

define <8 x i8> @cttz_v8i8(<8 x i8> %op) {
; CHECK-LABEL: cttz_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl8
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    rbit z0.b, p0/m, z0.b
; CHECK-NEXT:    clz z0.b, p0/m, z0.b
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i8> @llvm.cttz.v8i8(<8 x i8> %op)
  ret <8 x i8> %res
}

define <16 x i8> @cttz_v16i8(<16 x i8> %op) {
; CHECK-LABEL: cttz_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    rbit z0.b, p0/m, z0.b
; CHECK-NEXT:    clz z0.b, p0/m, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <16 x i8> @llvm.cttz.v16i8(<16 x i8> %op)
  ret <16 x i8> %res
}

define void @cttz_v32i8(ptr %a) {
; CHECK-LABEL: cttz_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl16
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    rbit z0.b, p0/m, z0.b
; CHECK-NEXT:    rbit z1.b, p0/m, z1.b
; CHECK-NEXT:    clz z0.b, p0/m, z0.b
; CHECK-NEXT:    clz z1.b, p0/m, z1.b
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <32 x i8>, ptr %a
  %res = call <32 x i8> @llvm.cttz.v32i8(<32 x i8> %op)
  store <32 x i8> %res, ptr %a
  ret void
}

define <2 x i16> @cttz_v2i16(<2 x i16> %op) {
; CHECK-LABEL: cttz_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    orr z0.s, z0.s, #0x10000
; CHECK-NEXT:    rbit z0.s, p0/m, z0.s
; CHECK-NEXT:    clz z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i16> @llvm.cttz.v2i16(<2 x i16> %op)
  ret <2 x i16> %res
}

define <4 x i16> @cttz_v4i16(<4 x i16> %op) {
; CHECK-LABEL: cttz_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl4
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    rbit z0.h, p0/m, z0.h
; CHECK-NEXT:    clz z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i16> @llvm.cttz.v4i16(<4 x i16> %op)
  ret <4 x i16> %res
}

define <8 x i16> @cttz_v8i16(<8 x i16> %op) {
; CHECK-LABEL: cttz_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    rbit z0.h, p0/m, z0.h
; CHECK-NEXT:    clz z0.h, p0/m, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <8 x i16> @llvm.cttz.v8i16(<8 x i16> %op)
  ret <8 x i16> %res
}

define void @cttz_v16i16(ptr %a) {
; CHECK-LABEL: cttz_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl8
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    rbit z0.h, p0/m, z0.h
; CHECK-NEXT:    rbit z1.h, p0/m, z1.h
; CHECK-NEXT:    clz z0.h, p0/m, z0.h
; CHECK-NEXT:    clz z1.h, p0/m, z1.h
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <16 x i16>, ptr %a
  %res = call <16 x i16> @llvm.cttz.v16i16(<16 x i16> %op)
  store <16 x i16> %res, ptr %a
  ret void
}

define <2 x i32> @cttz_v2i32(<2 x i32> %op) {
; CHECK-LABEL: cttz_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl2
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    rbit z0.s, p0/m, z0.s
; CHECK-NEXT:    clz z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i32> @llvm.cttz.v2i32(<2 x i32> %op)
  ret <2 x i32> %res
}

define <4 x i32> @cttz_v4i32(<4 x i32> %op) {
; CHECK-LABEL: cttz_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    rbit z0.s, p0/m, z0.s
; CHECK-NEXT:    clz z0.s, p0/m, z0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <4 x i32> @llvm.cttz.v4i32(<4 x i32> %op)
  ret <4 x i32> %res
}

define void @cttz_v8i32(ptr %a) {
; CHECK-LABEL: cttz_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    rbit z0.s, p0/m, z0.s
; CHECK-NEXT:    rbit z1.s, p0/m, z1.s
; CHECK-NEXT:    clz z0.s, p0/m, z0.s
; CHECK-NEXT:    clz z1.s, p0/m, z1.s
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <8 x i32>, ptr %a
  %res = call <8 x i32> @llvm.cttz.v8i32(<8 x i32> %op)
  store <8 x i32> %res, ptr %a
  ret void
}

define <1 x i64> @cttz_v1i64(<1 x i64> %op) {
; CHECK-LABEL: cttz_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    rbit z0.d, p0/m, z0.d
; CHECK-NEXT:    clz z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %res = call <1 x i64> @llvm.cttz.v1i64(<1 x i64> %op)
  ret <1 x i64> %res
}

define <2 x i64> @cttz_v2i64(<2 x i64> %op) {
; CHECK-LABEL: cttz_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    // kill: def $q0 killed $q0 def $z0
; CHECK-NEXT:    rbit z0.d, p0/m, z0.d
; CHECK-NEXT:    clz z0.d, p0/m, z0.d
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %res = call <2 x i64> @llvm.cttz.v2i64(<2 x i64> %op)
  ret <2 x i64> %res
}

define void @cttz_v4i64(ptr %a) {
; CHECK-LABEL: cttz_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    ldp q0, q1, [x0]
; CHECK-NEXT:    rbit z0.d, p0/m, z0.d
; CHECK-NEXT:    rbit z1.d, p0/m, z1.d
; CHECK-NEXT:    clz z0.d, p0/m, z0.d
; CHECK-NEXT:    clz z1.d, p0/m, z1.d
; CHECK-NEXT:    stp q0, q1, [x0]
; CHECK-NEXT:    ret
  %op = load <4 x i64>, ptr %a
  %res = call <4 x i64> @llvm.cttz.v4i64(<4 x i64> %op)
  store <4 x i64> %res, ptr %a
  ret void
}


declare <4 x i8> @llvm.ctlz.v4i8(<4 x i8>)
declare <8 x i8> @llvm.ctlz.v8i8(<8 x i8>)
declare <16 x i8> @llvm.ctlz.v16i8(<16 x i8>)
declare <32 x i8> @llvm.ctlz.v32i8(<32 x i8>)
declare <2 x i16> @llvm.ctlz.v2i16(<2 x i16>)
declare <4 x i16> @llvm.ctlz.v4i16(<4 x i16>)
declare <8 x i16> @llvm.ctlz.v8i16(<8 x i16>)
declare <16 x i16> @llvm.ctlz.v16i16(<16 x i16>)
declare <2 x i32> @llvm.ctlz.v2i32(<2 x i32>)
declare <4 x i32> @llvm.ctlz.v4i32(<4 x i32>)
declare <8 x i32> @llvm.ctlz.v8i32(<8 x i32>)
declare <1 x i64> @llvm.ctlz.v1i64(<1 x i64>)
declare <2 x i64> @llvm.ctlz.v2i64(<2 x i64>)
declare <4 x i64> @llvm.ctlz.v4i64(<4 x i64>)

declare <4 x i8> @llvm.ctpop.v4i8(<4 x i8>)
declare <8 x i8> @llvm.ctpop.v8i8(<8 x i8>)
declare <16 x i8> @llvm.ctpop.v16i8(<16 x i8>)
declare <32 x i8> @llvm.ctpop.v32i8(<32 x i8>)
declare <2 x i16> @llvm.ctpop.v2i16(<2 x i16>)
declare <4 x i16> @llvm.ctpop.v4i16(<4 x i16>)
declare <8 x i16> @llvm.ctpop.v8i16(<8 x i16>)
declare <16 x i16> @llvm.ctpop.v16i16(<16 x i16>)
declare <2 x i32> @llvm.ctpop.v2i32(<2 x i32>)
declare <4 x i32> @llvm.ctpop.v4i32(<4 x i32>)
declare <8 x i32> @llvm.ctpop.v8i32(<8 x i32>)
declare <1 x i64> @llvm.ctpop.v1i64(<1 x i64>)
declare <2 x i64> @llvm.ctpop.v2i64(<2 x i64>)
declare <4 x i64> @llvm.ctpop.v4i64(<4 x i64>)

declare <4 x i8> @llvm.cttz.v4i8(<4 x i8>)
declare <8 x i8> @llvm.cttz.v8i8(<8 x i8>)
declare <16 x i8> @llvm.cttz.v16i8(<16 x i8>)
declare <32 x i8> @llvm.cttz.v32i8(<32 x i8>)
declare <2 x i16> @llvm.cttz.v2i16(<2 x i16>)
declare <4 x i16> @llvm.cttz.v4i16(<4 x i16>)
declare <8 x i16> @llvm.cttz.v8i16(<8 x i16>)
declare <16 x i16> @llvm.cttz.v16i16(<16 x i16>)
declare <2 x i32> @llvm.cttz.v2i32(<2 x i32>)
declare <4 x i32> @llvm.cttz.v4i32(<4 x i32>)
declare <8 x i32> @llvm.cttz.v8i32(<8 x i32>)
declare <1 x i64> @llvm.cttz.v1i64(<1 x i64>)
declare <2 x i64> @llvm.cttz.v2i64(<2 x i64>)
declare <4 x i64> @llvm.cttz.v4i64(<4 x i64>)