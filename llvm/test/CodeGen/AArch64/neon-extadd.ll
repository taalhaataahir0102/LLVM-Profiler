; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple aarch64 -o - | FileCheck %s

define <8 x i16> @extadds_v8i8_i16(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: extadds_v8i8_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
entry:
  %s0s = sext <8 x i8> %s0 to <8 x i16>
  %s1s = sext <8 x i8> %s1 to <8 x i16>
  %m = add <8 x i16> %s0s, %s1s
  ret <8 x i16> %m
}

define <8 x i16> @extaddu_v8i8_i16(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: extaddu_v8i8_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
entry:
  %s0s = zext <8 x i8> %s0 to <8 x i16>
  %s1s = zext <8 x i8> %s1 to <8 x i16>
  %m = add <8 x i16> %s0s, %s1s
  ret <8 x i16> %m
}

define <16 x i16> @extadds_v16i8_i16(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: extadds_v16i8_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl2 v2.8h, v0.16b, v1.16b
; CHECK-NEXT:    saddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %s0s = sext <16 x i8> %s0 to <16 x i16>
  %s1s = sext <16 x i8> %s1 to <16 x i16>
  %m = add <16 x i16> %s0s, %s1s
  ret <16 x i16> %m
}

define <16 x i16> @extaddu_v16i8_i16(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: extaddu_v16i8_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl2 v2.8h, v0.16b, v1.16b
; CHECK-NEXT:    uaddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %s0s = zext <16 x i8> %s0 to <16 x i16>
  %s1s = zext <16 x i8> %s1 to <16 x i16>
  %m = add <16 x i16> %s0s, %s1s
  ret <16 x i16> %m
}

define <32 x i16> @extadds_v32i8_i16(<32 x i8> %s0, <32 x i8> %s1) {
; CHECK-LABEL: extadds_v32i8_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl2 v4.8h, v1.16b, v3.16b
; CHECK-NEXT:    saddl v5.8h, v0.8b, v2.8b
; CHECK-NEXT:    saddl2 v6.8h, v0.16b, v2.16b
; CHECK-NEXT:    saddl v2.8h, v1.8b, v3.8b
; CHECK-NEXT:    mov v0.16b, v5.16b
; CHECK-NEXT:    mov v1.16b, v6.16b
; CHECK-NEXT:    mov v3.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %s0s = sext <32 x i8> %s0 to <32 x i16>
  %s1s = sext <32 x i8> %s1 to <32 x i16>
  %m = add <32 x i16> %s0s, %s1s
  ret <32 x i16> %m
}

define <32 x i16> @extaddu_v32i8_i16(<32 x i8> %s0, <32 x i8> %s1) {
; CHECK-LABEL: extaddu_v32i8_i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl2 v4.8h, v1.16b, v3.16b
; CHECK-NEXT:    uaddl v5.8h, v0.8b, v2.8b
; CHECK-NEXT:    uaddl2 v6.8h, v0.16b, v2.16b
; CHECK-NEXT:    uaddl v2.8h, v1.8b, v3.8b
; CHECK-NEXT:    mov v0.16b, v5.16b
; CHECK-NEXT:    mov v1.16b, v6.16b
; CHECK-NEXT:    mov v3.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %s0s = zext <32 x i8> %s0 to <32 x i16>
  %s1s = zext <32 x i8> %s1 to <32 x i16>
  %m = add <32 x i16> %s0s, %s1s
  ret <32 x i16> %m
}

define <8 x i32> @extadds_v8i8_i32(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: extadds_v8i8_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    sshll2 v1.4s, v0.8h, #0
; CHECK-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-NEXT:    ret
entry:
  %s0s = sext <8 x i8> %s0 to <8 x i32>
  %s1s = sext <8 x i8> %s1 to <8 x i32>
  %m = add <8 x i32> %s0s, %s1s
  ret <8 x i32> %m
}

define <8 x i32> @extaddu_v8i8_i32(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: extaddu_v8i8_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ushll2 v1.4s, v0.8h, #0
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    ret
entry:
  %s0s = zext <8 x i8> %s0 to <8 x i32>
  %s1s = zext <8 x i8> %s1 to <8 x i32>
  %m = add <8 x i32> %s0s, %s1s
  ret <8 x i32> %m
}

define <16 x i32> @extadds_v16i8_i32(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: extadds_v16i8_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl v2.8h, v0.8b, v1.8b
; CHECK-NEXT:    saddl2 v4.8h, v0.16b, v1.16b
; CHECK-NEXT:    sshll v0.4s, v2.4h, #0
; CHECK-NEXT:    sshll2 v3.4s, v4.8h, #0
; CHECK-NEXT:    sshll2 v1.4s, v2.8h, #0
; CHECK-NEXT:    sshll v2.4s, v4.4h, #0
; CHECK-NEXT:    ret
entry:
  %s0s = sext <16 x i8> %s0 to <16 x i32>
  %s1s = sext <16 x i8> %s1 to <16 x i32>
  %m = add <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}

define <16 x i32> @extaddu_v16i8_i32(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: extaddu_v16i8_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl v2.8h, v0.8b, v1.8b
; CHECK-NEXT:    uaddl2 v4.8h, v0.16b, v1.16b
; CHECK-NEXT:    ushll v0.4s, v2.4h, #0
; CHECK-NEXT:    ushll2 v3.4s, v4.8h, #0
; CHECK-NEXT:    ushll2 v1.4s, v2.8h, #0
; CHECK-NEXT:    ushll v2.4s, v4.4h, #0
; CHECK-NEXT:    ret
entry:
  %s0s = zext <16 x i8> %s0 to <16 x i32>
  %s1s = zext <16 x i8> %s1 to <16 x i32>
  %m = add <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}

define <8 x i64> @extadds_v8i8_i64(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: extadds_v8i8_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    sshll v1.4s, v0.4h, #0
; CHECK-NEXT:    sshll2 v2.4s, v0.8h, #0
; CHECK-NEXT:    sshll v0.2d, v1.2s, #0
; CHECK-NEXT:    sshll2 v3.2d, v2.4s, #0
; CHECK-NEXT:    sshll2 v1.2d, v1.4s, #0
; CHECK-NEXT:    sshll v2.2d, v2.2s, #0
; CHECK-NEXT:    ret
entry:
  %s0s = sext <8 x i8> %s0 to <8 x i64>
  %s1s = sext <8 x i8> %s1 to <8 x i64>
  %m = add <8 x i64> %s0s, %s1s
  ret <8 x i64> %m
}

define <8 x i64> @extaddu_v8i8_i64(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: extaddu_v8i8_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ushll v1.4s, v0.4h, #0
; CHECK-NEXT:    ushll2 v2.4s, v0.8h, #0
; CHECK-NEXT:    ushll v0.2d, v1.2s, #0
; CHECK-NEXT:    ushll2 v3.2d, v2.4s, #0
; CHECK-NEXT:    ushll2 v1.2d, v1.4s, #0
; CHECK-NEXT:    ushll v2.2d, v2.2s, #0
; CHECK-NEXT:    ret
entry:
  %s0s = zext <8 x i8> %s0 to <8 x i64>
  %s1s = zext <8 x i8> %s1 to <8 x i64>
  %m = add <8 x i64> %s0s, %s1s
  ret <8 x i64> %m
}

define <4 x i32> @extadds_v4i16_i32(<4 x i16> %s0, <4 x i16> %s1) {
; CHECK-LABEL: extadds_v4i16_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %s0s = sext <4 x i16> %s0 to <4 x i32>
  %s1s = sext <4 x i16> %s1 to <4 x i32>
  %m = add <4 x i32> %s0s, %s1s
  ret <4 x i32> %m
}

define <4 x i32> @extaddu_v4i16_i32(<4 x i16> %s0, <4 x i16> %s1) {
; CHECK-LABEL: extaddu_v4i16_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %s0s = zext <4 x i16> %s0 to <4 x i32>
  %s1s = zext <4 x i16> %s1 to <4 x i32>
  %m = add <4 x i32> %s0s, %s1s
  ret <4 x i32> %m
}

define <8 x i32> @extadds_v8i16_i32(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: extadds_v8i16_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl2 v2.4s, v0.8h, v1.8h
; CHECK-NEXT:    saddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %s0s = sext <8 x i16> %s0 to <8 x i32>
  %s1s = sext <8 x i16> %s1 to <8 x i32>
  %m = add <8 x i32> %s0s, %s1s
  ret <8 x i32> %m
}

define <8 x i32> @extaddu_v8i16_i32(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: extaddu_v8i16_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl2 v2.4s, v0.8h, v1.8h
; CHECK-NEXT:    uaddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %s0s = zext <8 x i16> %s0 to <8 x i32>
  %s1s = zext <8 x i16> %s1 to <8 x i32>
  %m = add <8 x i32> %s0s, %s1s
  ret <8 x i32> %m
}

define <16 x i32> @extadds_v16i16_i32(<16 x i16> %s0, <16 x i16> %s1) {
; CHECK-LABEL: extadds_v16i16_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl2 v4.4s, v1.8h, v3.8h
; CHECK-NEXT:    saddl v5.4s, v0.4h, v2.4h
; CHECK-NEXT:    saddl2 v6.4s, v0.8h, v2.8h
; CHECK-NEXT:    saddl v2.4s, v1.4h, v3.4h
; CHECK-NEXT:    mov v0.16b, v5.16b
; CHECK-NEXT:    mov v1.16b, v6.16b
; CHECK-NEXT:    mov v3.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %s0s = sext <16 x i16> %s0 to <16 x i32>
  %s1s = sext <16 x i16> %s1 to <16 x i32>
  %m = add <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}

define <16 x i32> @extaddu_v16i16_i32(<16 x i16> %s0, <16 x i16> %s1) {
; CHECK-LABEL: extaddu_v16i16_i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl2 v4.4s, v1.8h, v3.8h
; CHECK-NEXT:    uaddl v5.4s, v0.4h, v2.4h
; CHECK-NEXT:    uaddl2 v6.4s, v0.8h, v2.8h
; CHECK-NEXT:    uaddl v2.4s, v1.4h, v3.4h
; CHECK-NEXT:    mov v0.16b, v5.16b
; CHECK-NEXT:    mov v1.16b, v6.16b
; CHECK-NEXT:    mov v3.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %s0s = zext <16 x i16> %s0 to <16 x i32>
  %s1s = zext <16 x i16> %s1 to <16 x i32>
  %m = add <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}

define <4 x i64> @extadds_v4i16_i64(<4 x i16> %s0, <4 x i16> %s1) {
; CHECK-LABEL: extadds_v4i16_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    sshll2 v1.2d, v0.4s, #0
; CHECK-NEXT:    sshll v0.2d, v0.2s, #0
; CHECK-NEXT:    ret
entry:
  %s0s = sext <4 x i16> %s0 to <4 x i64>
  %s1s = sext <4 x i16> %s1 to <4 x i64>
  %m = add <4 x i64> %s0s, %s1s
  ret <4 x i64> %m
}

define <4 x i64> @extaddu_v4i16_i64(<4 x i16> %s0, <4 x i16> %s1) {
; CHECK-LABEL: extaddu_v4i16_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ushll2 v1.2d, v0.4s, #0
; CHECK-NEXT:    ushll v0.2d, v0.2s, #0
; CHECK-NEXT:    ret
entry:
  %s0s = zext <4 x i16> %s0 to <4 x i64>
  %s1s = zext <4 x i16> %s1 to <4 x i64>
  %m = add <4 x i64> %s0s, %s1s
  ret <4 x i64> %m
}

define <8 x i64> @extadds_v8i16_i64(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: extadds_v8i16_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl v2.4s, v0.4h, v1.4h
; CHECK-NEXT:    saddl2 v4.4s, v0.8h, v1.8h
; CHECK-NEXT:    sshll v0.2d, v2.2s, #0
; CHECK-NEXT:    sshll2 v3.2d, v4.4s, #0
; CHECK-NEXT:    sshll2 v1.2d, v2.4s, #0
; CHECK-NEXT:    sshll v2.2d, v4.2s, #0
; CHECK-NEXT:    ret
entry:
  %s0s = sext <8 x i16> %s0 to <8 x i64>
  %s1s = sext <8 x i16> %s1 to <8 x i64>
  %m = add <8 x i64> %s0s, %s1s
  ret <8 x i64> %m
}

define <8 x i64> @extaddu_v8i16_i64(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: extaddu_v8i16_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl v2.4s, v0.4h, v1.4h
; CHECK-NEXT:    uaddl2 v4.4s, v0.8h, v1.8h
; CHECK-NEXT:    ushll v0.2d, v2.2s, #0
; CHECK-NEXT:    ushll2 v3.2d, v4.4s, #0
; CHECK-NEXT:    ushll2 v1.2d, v2.4s, #0
; CHECK-NEXT:    ushll v2.2d, v4.2s, #0
; CHECK-NEXT:    ret
entry:
  %s0s = zext <8 x i16> %s0 to <8 x i64>
  %s1s = zext <8 x i16> %s1 to <8 x i64>
  %m = add <8 x i64> %s0s, %s1s
  ret <8 x i64> %m
}

define <2 x i64> @extadds_v2i32_i64(<2 x i32> %s0, <2 x i32> %s1) {
; CHECK-LABEL: extadds_v2i32_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %s0s = sext <2 x i32> %s0 to <2 x i64>
  %s1s = sext <2 x i32> %s1 to <2 x i64>
  %m = add <2 x i64> %s0s, %s1s
  ret <2 x i64> %m
}

define <2 x i64> @extaddu_v2i32_i64(<2 x i32> %s0, <2 x i32> %s1) {
; CHECK-LABEL: extaddu_v2i32_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %s0s = zext <2 x i32> %s0 to <2 x i64>
  %s1s = zext <2 x i32> %s1 to <2 x i64>
  %m = add <2 x i64> %s0s, %s1s
  ret <2 x i64> %m
}

define <4 x i64> @extadds_v4i32_i64(<4 x i32> %s0, <4 x i32> %s1) {
; CHECK-LABEL: extadds_v4i32_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl2 v2.2d, v0.4s, v1.4s
; CHECK-NEXT:    saddl v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %s0s = sext <4 x i32> %s0 to <4 x i64>
  %s1s = sext <4 x i32> %s1 to <4 x i64>
  %m = add <4 x i64> %s0s, %s1s
  ret <4 x i64> %m
}

define <4 x i64> @extaddu_v4i32_i64(<4 x i32> %s0, <4 x i32> %s1) {
; CHECK-LABEL: extaddu_v4i32_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl2 v2.2d, v0.4s, v1.4s
; CHECK-NEXT:    uaddl v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %s0s = zext <4 x i32> %s0 to <4 x i64>
  %s1s = zext <4 x i32> %s1 to <4 x i64>
  %m = add <4 x i64> %s0s, %s1s
  ret <4 x i64> %m
}

define <8 x i64> @extadds_v8i32_i64(<8 x i32> %s0, <8 x i32> %s1) {
; CHECK-LABEL: extadds_v8i32_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    saddl2 v4.2d, v1.4s, v3.4s
; CHECK-NEXT:    saddl v5.2d, v0.2s, v2.2s
; CHECK-NEXT:    saddl2 v6.2d, v0.4s, v2.4s
; CHECK-NEXT:    saddl v2.2d, v1.2s, v3.2s
; CHECK-NEXT:    mov v0.16b, v5.16b
; CHECK-NEXT:    mov v1.16b, v6.16b
; CHECK-NEXT:    mov v3.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %s0s = sext <8 x i32> %s0 to <8 x i64>
  %s1s = sext <8 x i32> %s1 to <8 x i64>
  %m = add <8 x i64> %s0s, %s1s
  ret <8 x i64> %m
}

define <8 x i64> @extaddu_v8i32_i64(<8 x i32> %s0, <8 x i32> %s1) {
; CHECK-LABEL: extaddu_v8i32_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uaddl2 v4.2d, v1.4s, v3.4s
; CHECK-NEXT:    uaddl v5.2d, v0.2s, v2.2s
; CHECK-NEXT:    uaddl2 v6.2d, v0.4s, v2.4s
; CHECK-NEXT:    uaddl v2.2d, v1.2s, v3.2s
; CHECK-NEXT:    mov v0.16b, v5.16b
; CHECK-NEXT:    mov v1.16b, v6.16b
; CHECK-NEXT:    mov v3.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %s0s = zext <8 x i32> %s0 to <8 x i64>
  %s1s = zext <8 x i32> %s1 to <8 x i64>
  %m = add <8 x i64> %s0s, %s1s
  ret <8 x i64> %m
}

define <16 x i32> @add_zs(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: add_zs:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ushll v2.8h, v0.8b, #0
; CHECK-NEXT:    ushll2 v0.8h, v0.16b, #0
; CHECK-NEXT:    saddw v2.8h, v2.8h, v1.8b
; CHECK-NEXT:    saddw2 v4.8h, v0.8h, v1.16b
; CHECK-NEXT:    sshll v0.4s, v2.4h, #0
; CHECK-NEXT:    sshll2 v3.4s, v4.8h, #0
; CHECK-NEXT:    sshll2 v1.4s, v2.8h, #0
; CHECK-NEXT:    sshll v2.4s, v4.4h, #0
; CHECK-NEXT:    ret
entry:
  %s0s = zext <16 x i8> %s0 to <16 x i32>
  %s1s = sext <16 x i8> %s1 to <16 x i32>
  %m = add <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}

define <20 x i32> @v20(<20 x i8> %s0, <20 x i8> %s1) {
; CHECK-LABEL: v20:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov s0, w0
; CHECK-NEXT:    ldr b2, [sp, #160]
; CHECK-NEXT:    add x10, sp, #168
; CHECK-NEXT:    ldr b3, [sp]
; CHECK-NEXT:    add x11, sp, #8
; CHECK-NEXT:    ldr b1, [sp, #96]
; CHECK-NEXT:    ld1 { v2.b }[1], [x10]
; CHECK-NEXT:    add x9, sp, #104
; CHECK-NEXT:    add x10, sp, #176
; CHECK-NEXT:    mov v0.b[1], w1
; CHECK-NEXT:    ld1 { v3.b }[1], [x11]
; CHECK-NEXT:    ld1 { v1.b }[1], [x9]
; CHECK-NEXT:    add x12, sp, #16
; CHECK-NEXT:    add x9, sp, #112
; CHECK-NEXT:    add x13, sp, #184
; CHECK-NEXT:    ld1 { v2.b }[2], [x10]
; CHECK-NEXT:    add x11, sp, #120
; CHECK-NEXT:    add x14, sp, #32
; CHECK-NEXT:    ld1 { v3.b }[2], [x12]
; CHECK-NEXT:    ld1 { v1.b }[2], [x9]
; CHECK-NEXT:    ldr b5, [sp, #64]
; CHECK-NEXT:    mov v0.b[2], w2
; CHECK-NEXT:    ldr b4, [sp, #224]
; CHECK-NEXT:    add x10, sp, #128
; CHECK-NEXT:    ld1 { v2.b }[3], [x13]
; CHECK-NEXT:    add x13, sp, #24
; CHECK-NEXT:    add x12, sp, #136
; CHECK-NEXT:    ld1 { v3.b }[3], [x13]
; CHECK-NEXT:    ld1 { v1.b }[3], [x11]
; CHECK-NEXT:    add x11, sp, #192
; CHECK-NEXT:    add x13, sp, #200
; CHECK-NEXT:    add x15, sp, #80
; CHECK-NEXT:    add x9, sp, #144
; CHECK-NEXT:    mov v0.b[3], w3
; CHECK-NEXT:    ld1 { v2.b }[4], [x11]
; CHECK-NEXT:    add x11, sp, #232
; CHECK-NEXT:    ld1 { v3.b }[4], [x14]
; CHECK-NEXT:    add x14, sp, #72
; CHECK-NEXT:    ld1 { v4.b }[1], [x11]
; CHECK-NEXT:    ld1 { v5.b }[1], [x14]
; CHECK-NEXT:    add x14, sp, #40
; CHECK-NEXT:    ld1 { v1.b }[4], [x10]
; CHECK-NEXT:    ld1 { v2.b }[5], [x13]
; CHECK-NEXT:    add x11, sp, #208
; CHECK-NEXT:    add x13, sp, #48
; CHECK-NEXT:    mov v0.b[4], w4
; CHECK-NEXT:    ld1 { v3.b }[5], [x14]
; CHECK-NEXT:    add x14, sp, #240
; CHECK-NEXT:    ld1 { v4.b }[2], [x14]
; CHECK-NEXT:    ld1 { v5.b }[2], [x15]
; CHECK-NEXT:    ld1 { v1.b }[5], [x12]
; CHECK-NEXT:    ld1 { v2.b }[6], [x11]
; CHECK-NEXT:    add x10, sp, #216
; CHECK-NEXT:    add x11, sp, #56
; CHECK-NEXT:    ld1 { v3.b }[6], [x13]
; CHECK-NEXT:    add x12, sp, #248
; CHECK-NEXT:    add x13, sp, #88
; CHECK-NEXT:    mov v0.b[5], w5
; CHECK-NEXT:    ld1 { v4.b }[3], [x12]
; CHECK-NEXT:    ld1 { v5.b }[3], [x13]
; CHECK-NEXT:    ld1 { v1.b }[6], [x9]
; CHECK-NEXT:    ld1 { v2.b }[7], [x10]
; CHECK-NEXT:    add x9, sp, #152
; CHECK-NEXT:    ld1 { v3.b }[7], [x11]
; CHECK-NEXT:    uaddl v4.8h, v5.8b, v4.8b
; CHECK-NEXT:    mov v0.b[6], w6
; CHECK-NEXT:    ld1 { v1.b }[7], [x9]
; CHECK-NEXT:    uaddl v2.8h, v3.8b, v2.8b
; CHECK-NEXT:    mov v0.b[7], w7
; CHECK-NEXT:    ushll2 v3.4s, v2.8h, #0
; CHECK-NEXT:    ushll v2.4s, v2.4h, #0
; CHECK-NEXT:    uaddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ushll v1.4s, v4.4h, #0
; CHECK-NEXT:    stp q3, q1, [x8, #48]
; CHECK-NEXT:    ushll2 v1.4s, v0.8h, #0
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    stp q1, q2, [x8, #16]
; CHECK-NEXT:    str q0, [x8]
; CHECK-NEXT:    ret
entry:
  %s0s = zext <20 x i8> %s0 to <20 x i32>
  %s1s = zext <20 x i8> %s1 to <20 x i32>
  %m = add <20 x i32> %s0s, %s1s
  ret <20 x i32> %m
}

define <16 x i32> @i12(<16 x i12> %s0, <16 x i12> %s1) {
; CHECK-LABEL: i12:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x23, [sp, #-48]! // 8-byte Folded Spill
; CHECK-NEXT:    stp x22, x21, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp x20, x19, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w20, -16
; CHECK-NEXT:    .cfi_offset w21, -24
; CHECK-NEXT:    .cfi_offset w22, -32
; CHECK-NEXT:    .cfi_offset w23, -48
; CHECK-NEXT:    ldr w12, [sp, #112]
; CHECK-NEXT:    ldr w14, [sp, #144]
; CHECK-NEXT:    fmov s2, w4
; CHECK-NEXT:    ldr w16, [sp, #176]
; CHECK-NEXT:    ldr w19, [sp, #208]
; CHECK-NEXT:    fmov s3, w0
; CHECK-NEXT:    ldr w20, [sp, #80]
; CHECK-NEXT:    ldr w21, [sp, #48]
; CHECK-NEXT:    fmov s5, w12
; CHECK-NEXT:    fmov s4, w19
; CHECK-NEXT:    fmov s6, w16
; CHECK-NEXT:    fmov s7, w14
; CHECK-NEXT:    fmov s0, w20
; CHECK-NEXT:    fmov s1, w21
; CHECK-NEXT:    ldr w10, [sp, #120]
; CHECK-NEXT:    ldr w11, [sp, #152]
; CHECK-NEXT:    ldr w13, [sp, #184]
; CHECK-NEXT:    ldr w15, [sp, #216]
; CHECK-NEXT:    ldr w22, [sp, #88]
; CHECK-NEXT:    ldr w23, [sp, #56]
; CHECK-NEXT:    mov v2.h[1], w5
; CHECK-NEXT:    mov v3.h[1], w1
; CHECK-NEXT:    mov v5.h[1], w10
; CHECK-NEXT:    mov v4.h[1], w15
; CHECK-NEXT:    mov v0.h[1], w22
; CHECK-NEXT:    mov v1.h[1], w23
; CHECK-NEXT:    mov v6.h[1], w13
; CHECK-NEXT:    mov v7.h[1], w11
; CHECK-NEXT:    ldr w8, [sp, #128]
; CHECK-NEXT:    ldr w9, [sp, #160]
; CHECK-NEXT:    ldr w17, [sp, #64]
; CHECK-NEXT:    ldr w18, [sp, #96]
; CHECK-NEXT:    ldr w10, [sp, #192]
; CHECK-NEXT:    ldr w11, [sp, #224]
; CHECK-NEXT:    mov v2.h[2], w6
; CHECK-NEXT:    mov v3.h[2], w2
; CHECK-NEXT:    mov v0.h[2], w18
; CHECK-NEXT:    mov v1.h[2], w17
; CHECK-NEXT:    mov v5.h[2], w8
; CHECK-NEXT:    mov v4.h[2], w11
; CHECK-NEXT:    mov v6.h[2], w10
; CHECK-NEXT:    mov v7.h[2], w9
; CHECK-NEXT:    ldr w12, [sp, #72]
; CHECK-NEXT:    ldr w13, [sp, #104]
; CHECK-NEXT:    ldr w8, [sp, #136]
; CHECK-NEXT:    ldr w9, [sp, #168]
; CHECK-NEXT:    ldr w10, [sp, #200]
; CHECK-NEXT:    ldr w11, [sp, #232]
; CHECK-NEXT:    mov v0.h[3], w13
; CHECK-NEXT:    mov v1.h[3], w12
; CHECK-NEXT:    mov v2.h[3], w7
; CHECK-NEXT:    mov v3.h[3], w3
; CHECK-NEXT:    mov v5.h[3], w8
; CHECK-NEXT:    mov v4.h[3], w11
; CHECK-NEXT:    mov v6.h[3], w10
; CHECK-NEXT:    mov v7.h[3], w9
; CHECK-NEXT:    movi v16.4s, #15, msl #8
; CHECK-NEXT:    ldp x20, x19, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    ushll v1.4s, v1.4h, #0
; CHECK-NEXT:    ushll v2.4s, v2.4h, #0
; CHECK-NEXT:    ushll v3.4s, v3.4h, #0
; CHECK-NEXT:    ushll v5.4s, v5.4h, #0
; CHECK-NEXT:    ushll v4.4s, v4.4h, #0
; CHECK-NEXT:    ushll v6.4s, v6.4h, #0
; CHECK-NEXT:    ushll v7.4s, v7.4h, #0
; CHECK-NEXT:    and v17.16b, v0.16b, v16.16b
; CHECK-NEXT:    and v18.16b, v1.16b, v16.16b
; CHECK-NEXT:    and v1.16b, v2.16b, v16.16b
; CHECK-NEXT:    and v0.16b, v3.16b, v16.16b
; CHECK-NEXT:    and v2.16b, v5.16b, v16.16b
; CHECK-NEXT:    and v3.16b, v4.16b, v16.16b
; CHECK-NEXT:    and v4.16b, v6.16b, v16.16b
; CHECK-NEXT:    and v5.16b, v7.16b, v16.16b
; CHECK-NEXT:    ldp x22, x21, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    add v3.4s, v17.4s, v3.4s
; CHECK-NEXT:    add v1.4s, v1.4s, v5.4s
; CHECK-NEXT:    add v2.4s, v18.4s, v4.4s
; CHECK-NEXT:    ldr x23, [sp], #48 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %s0s = zext <16 x i12> %s0 to <16 x i32>
  %s1s = zext <16 x i12> %s1 to <16 x i32>
  %m = add <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}

define <16 x i32> @sub_zz(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: sub_zz:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    usubl v2.8h, v0.8b, v1.8b
; CHECK-NEXT:    usubl2 v4.8h, v0.16b, v1.16b
; CHECK-NEXT:    sshll v0.4s, v2.4h, #0
; CHECK-NEXT:    sshll2 v3.4s, v4.8h, #0
; CHECK-NEXT:    sshll2 v1.4s, v2.8h, #0
; CHECK-NEXT:    sshll v2.4s, v4.4h, #0
; CHECK-NEXT:    ret
entry:
  %s0s = zext <16 x i8> %s0 to <16 x i32>
  %s1s = zext <16 x i8> %s1 to <16 x i32>
  %m = sub <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}

define <16 x i32> @sub_ss(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: sub_ss:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ssubl v2.8h, v0.8b, v1.8b
; CHECK-NEXT:    ssubl2 v4.8h, v0.16b, v1.16b
; CHECK-NEXT:    sshll v0.4s, v2.4h, #0
; CHECK-NEXT:    sshll2 v3.4s, v4.8h, #0
; CHECK-NEXT:    sshll2 v1.4s, v2.8h, #0
; CHECK-NEXT:    sshll v2.4s, v4.4h, #0
; CHECK-NEXT:    ret
entry:
  %s0s = sext <16 x i8> %s0 to <16 x i32>
  %s1s = sext <16 x i8> %s1 to <16 x i32>
  %m = sub <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}

define <16 x i32> @sub_zs(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: sub_zs:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ushll v2.8h, v0.8b, #0
; CHECK-NEXT:    ushll2 v0.8h, v0.16b, #0
; CHECK-NEXT:    ssubw v2.8h, v2.8h, v1.8b
; CHECK-NEXT:    ssubw2 v4.8h, v0.8h, v1.16b
; CHECK-NEXT:    sshll v0.4s, v2.4h, #0
; CHECK-NEXT:    sshll2 v3.4s, v4.8h, #0
; CHECK-NEXT:    sshll2 v1.4s, v2.8h, #0
; CHECK-NEXT:    sshll v2.4s, v4.4h, #0
; CHECK-NEXT:    ret
entry:
  %s0s = zext <16 x i8> %s0 to <16 x i32>
  %s1s = sext <16 x i8> %s1 to <16 x i32>
  %m = sub <16 x i32> %s0s, %s1s
  ret <16 x i32> %m
}
