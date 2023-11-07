; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define <vscale x 16 x i8> @sext_i1_i8(<vscale x 16 x i1> %a) {
; CHECK-LABEL: sext_i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    ret
  %r = sext <vscale x 16 x i1> %a to <vscale x 16 x i8>
  ret <vscale x 16 x i8> %r
}

define <vscale x 8 x i16> @sext_i1_i16(<vscale x 8 x i1> %a) {
; CHECK-LABEL: sext_i1_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    ret
  %r = sext <vscale x 8 x i1> %a to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %r
}

define <vscale x 4 x i32> @sext_i1_i32(<vscale x 4 x i1> %a) {
; CHECK-LABEL: sext_i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    ret
  %r = sext <vscale x 4 x i1> %a to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %r
}

define <vscale x 2 x i64> @sext_i1_i64(<vscale x 2 x i1> %a) {
; CHECK-LABEL: sext_i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i1> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 16 x i8> @zext_i1_i8(<vscale x 16 x i1> %a) {
; CHECK-LABEL: zext_i1_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, p0/z, #1 // =0x1
; CHECK-NEXT:    ret
  %r = zext <vscale x 16 x i1> %a to <vscale x 16 x i8>
  ret <vscale x 16 x i8> %r
}

define <vscale x 8 x i16> @zext_i1_i16(<vscale x 8 x i1> %a) {
; CHECK-LABEL: zext_i1_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, p0/z, #1 // =0x1
; CHECK-NEXT:    ret
  %r = zext <vscale x 8 x i1> %a to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %r
}

define <vscale x 4 x i32> @zext_i1_i32(<vscale x 4 x i1> %a) {
; CHECK-LABEL: zext_i1_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, p0/z, #1 // =0x1
; CHECK-NEXT:    ret
  %r = zext <vscale x 4 x i1> %a to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %r
}

define <vscale x 2 x i64> @zext_i1_i64(<vscale x 2 x i1> %a) {
; CHECK-LABEL: zext_i1_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, p0/z, #1 // =0x1
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i1> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 8 x i16> @sext_i8_i16(<vscale x 8 x i8> %a) {
; CHECK-LABEL: sext_i8_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    sxtb z0.h, p0/m, z0.h
; CHECK-NEXT:    ret
  %r = sext <vscale x 8 x i8> %a to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %r
}

define <vscale x 4 x i32> @sext_i8_i32(<vscale x 4 x i8> %a) {
; CHECK-LABEL: sext_i8_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    sxtb z0.s, p0/m, z0.s
; CHECK-NEXT:    ret
  %r = sext <vscale x 4 x i8> %a to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %r
}

define <vscale x 2 x i64> @sext_i8_i64(<vscale x 2 x i8> %a) {
; CHECK-LABEL: sext_i8_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    sxtb z0.d, p0/m, z0.d
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i8> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 8 x i16> @zext_i8_i16(<vscale x 8 x i8> %a) {
; CHECK-LABEL: zext_i8_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.h, z0.h, #0xff
; CHECK-NEXT:    ret
  %r = zext <vscale x 8 x i8> %a to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %r
}

define <vscale x 4 x i32> @zext_i8_i32(<vscale x 4 x i8> %a) {
; CHECK-LABEL: zext_i8_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.s, z0.s, #0xff
; CHECK-NEXT:    ret
  %r = zext <vscale x 4 x i8> %a to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %r
}

define <vscale x 2 x i64> @zext_i8_i64(<vscale x 2 x i8> %a) {
; CHECK-LABEL: zext_i8_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.d, z0.d, #0xff
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i8> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 4 x i32> @sext_i16_i32(<vscale x 4 x i16> %a) {
; CHECK-LABEL: sext_i16_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    sxth z0.s, p0/m, z0.s
; CHECK-NEXT:    ret
  %r = sext <vscale x 4 x i16> %a to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %r
}

define <vscale x 2 x i64> @sext_i16_i64(<vscale x 2 x i16> %a) {
; CHECK-LABEL: sext_i16_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    sxth z0.d, p0/m, z0.d
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i16> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 4 x i32> @zext_i16_i32(<vscale x 4 x i16> %a) {
; CHECK-LABEL: zext_i16_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.s, z0.s, #0xffff
; CHECK-NEXT:    ret
  %r = zext <vscale x 4 x i16> %a to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %r
}

define <vscale x 2 x i64> @zext_i16_i64(<vscale x 2 x i16> %a) {
; CHECK-LABEL: zext_i16_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.d, z0.d, #0xffff
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i16> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @sext_i32_i64(<vscale x 2 x i32> %a) {
; CHECK-LABEL: sext_i32_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    sxtw z0.d, p0/m, z0.d
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i32> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @zext_i32_i64(<vscale x 2 x i32> %a) {
; CHECK-LABEL: zext_i32_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.d, z0.d, #0xffffffff
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i32> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

; Extending to illegal types

define <vscale x 16 x i16> @sext_b_to_h(<vscale x 16 x i8> %a) {
; CHECK-LABEL: sext_b_to_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sunpklo z2.h, z0.b
; CHECK-NEXT:    sunpkhi z1.h, z0.b
; CHECK-NEXT:    mov z0.d, z2.d
; CHECK-NEXT:    ret
  %ext = sext <vscale x 16 x i8> %a to <vscale x 16 x i16>
  ret <vscale x 16 x i16> %ext
}

define <vscale x 8 x i32> @sext_h_to_s(<vscale x 8 x i16> %a) {
; CHECK-LABEL: sext_h_to_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sunpklo z2.s, z0.h
; CHECK-NEXT:    sunpkhi z1.s, z0.h
; CHECK-NEXT:    mov z0.d, z2.d
; CHECK-NEXT:    ret
  %ext = sext <vscale x 8 x i16> %a to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %ext
}

define <vscale x 4 x i64> @sext_s_to_d(<vscale x 4 x i32> %a) {
; CHECK-LABEL: sext_s_to_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sunpklo z2.d, z0.s
; CHECK-NEXT:    sunpkhi z1.d, z0.s
; CHECK-NEXT:    mov z0.d, z2.d
; CHECK-NEXT:    ret
  %ext = sext <vscale x 4 x i32> %a to <vscale x 4 x i64>
  ret <vscale x 4 x i64> %ext
}

define <vscale x 16 x i32> @sext_b_to_s(<vscale x 16 x i8> %a) {
; CHECK-LABEL: sext_b_to_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sunpklo z1.h, z0.b
; CHECK-NEXT:    sunpkhi z3.h, z0.b
; CHECK-NEXT:    sunpklo z0.s, z1.h
; CHECK-NEXT:    sunpkhi z1.s, z1.h
; CHECK-NEXT:    sunpklo z2.s, z3.h
; CHECK-NEXT:    sunpkhi z3.s, z3.h
; CHECK-NEXT:    ret
  %ext = sext <vscale x 16 x i8> %a to <vscale x 16 x i32>
  ret <vscale x 16 x i32> %ext
}

define <vscale x 16 x i64> @sext_b_to_d(<vscale x 16 x i8> %a) {
; CHECK-LABEL: sext_b_to_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sunpklo z1.h, z0.b
; CHECK-NEXT:    sunpkhi z0.h, z0.b
; CHECK-NEXT:    sunpklo z2.s, z1.h
; CHECK-NEXT:    sunpkhi z3.s, z1.h
; CHECK-NEXT:    sunpklo z5.s, z0.h
; CHECK-NEXT:    sunpkhi z7.s, z0.h
; CHECK-NEXT:    sunpklo z0.d, z2.s
; CHECK-NEXT:    sunpkhi z1.d, z2.s
; CHECK-NEXT:    sunpklo z2.d, z3.s
; CHECK-NEXT:    sunpkhi z3.d, z3.s
; CHECK-NEXT:    sunpklo z4.d, z5.s
; CHECK-NEXT:    sunpkhi z5.d, z5.s
; CHECK-NEXT:    sunpklo z6.d, z7.s
; CHECK-NEXT:    sunpkhi z7.d, z7.s
; CHECK-NEXT:    ret
  %ext = sext <vscale x 16 x i8> %a to <vscale x 16 x i64>
  ret <vscale x 16 x i64> %ext
}

define <vscale x 16 x i16> @zext_b_to_h(<vscale x 16 x i8> %a) {
; CHECK-LABEL: zext_b_to_h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uunpklo z2.h, z0.b
; CHECK-NEXT:    uunpkhi z1.h, z0.b
; CHECK-NEXT:    mov z0.d, z2.d
; CHECK-NEXT:    ret
  %ext = zext <vscale x 16 x i8> %a to <vscale x 16 x i16>
  ret <vscale x 16 x i16> %ext
}

define <vscale x 8 x i32> @zext_h_to_s(<vscale x 8 x i16> %a) {
; CHECK-LABEL: zext_h_to_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uunpklo z2.s, z0.h
; CHECK-NEXT:    uunpkhi z1.s, z0.h
; CHECK-NEXT:    mov z0.d, z2.d
; CHECK-NEXT:    ret
  %ext = zext <vscale x 8 x i16> %a to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %ext
}

define <vscale x 4 x i64> @zext_s_to_d(<vscale x 4 x i32> %a) {
; CHECK-LABEL: zext_s_to_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uunpklo z2.d, z0.s
; CHECK-NEXT:    uunpkhi z1.d, z0.s
; CHECK-NEXT:    mov z0.d, z2.d
; CHECK-NEXT:    ret
  %ext = zext <vscale x 4 x i32> %a to <vscale x 4 x i64>
  ret <vscale x 4 x i64> %ext
}

define <vscale x 16 x i32> @zext_b_to_s(<vscale x 16 x i8> %a) {
; CHECK-LABEL: zext_b_to_s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uunpklo z1.h, z0.b
; CHECK-NEXT:    uunpkhi z3.h, z0.b
; CHECK-NEXT:    uunpklo z0.s, z1.h
; CHECK-NEXT:    uunpkhi z1.s, z1.h
; CHECK-NEXT:    uunpklo z2.s, z3.h
; CHECK-NEXT:    uunpkhi z3.s, z3.h
; CHECK-NEXT:    ret
  %ext = zext <vscale x 16 x i8> %a to <vscale x 16 x i32>
  ret <vscale x 16 x i32> %ext
}

define <vscale x 16 x i64> @zext_b_to_d(<vscale x 16 x i8> %a) {
; CHECK-LABEL: zext_b_to_d:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uunpklo z1.h, z0.b
; CHECK-NEXT:    uunpkhi z0.h, z0.b
; CHECK-NEXT:    uunpklo z2.s, z1.h
; CHECK-NEXT:    uunpkhi z3.s, z1.h
; CHECK-NEXT:    uunpklo z5.s, z0.h
; CHECK-NEXT:    uunpkhi z7.s, z0.h
; CHECK-NEXT:    uunpklo z0.d, z2.s
; CHECK-NEXT:    uunpkhi z1.d, z2.s
; CHECK-NEXT:    uunpklo z2.d, z3.s
; CHECK-NEXT:    uunpkhi z3.d, z3.s
; CHECK-NEXT:    uunpklo z4.d, z5.s
; CHECK-NEXT:    uunpkhi z5.d, z5.s
; CHECK-NEXT:    uunpklo z6.d, z7.s
; CHECK-NEXT:    uunpkhi z7.d, z7.s
; CHECK-NEXT:    ret
  %ext = zext <vscale x 16 x i8> %a to <vscale x 16 x i64>
  ret <vscale x 16 x i64> %ext
}

; Extending non power-of-two types

define <vscale x 2 x i64> @sext_i18_i64(<vscale x 2 x i18> %a) {
; CHECK-LABEL: sext_i18_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl z0.d, z0.d, #46
; CHECK-NEXT:    asr z0.d, z0.d, #46
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i18> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @zext_i18_i64(<vscale x 2 x i18> %a) {
; CHECK-LABEL: zext_i18_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z0.d, z0.d, #0x3ffff
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i18> %a to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}
