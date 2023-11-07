; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s --mattr=+complxnum,+neon,+fullfp16 -o - | FileCheck %s

target triple = "aarch64"

; Expected to transform
define <2 x double> @complex_mul_v2f64(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: complex_mul_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v2.2d, #0000000000000000
; CHECK-NEXT:    fcmla v2.2d, v0.2d, v1.2d, #0
; CHECK-NEXT:    fcmla v2.2d, v0.2d, v1.2d, #90
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %a.real   = shufflevector <2 x double> %a, <2 x double> poison, <1 x i32> <i32 0>
  %a.imag = shufflevector <2 x double> %a, <2 x double> poison, <1 x i32> <i32 1>
  %b.real = shufflevector <2 x double> %b, <2 x double> poison, <1 x i32> <i32 0>
  %b.imag = shufflevector <2 x double> %b, <2 x double> poison, <1 x i32> <i32 1>
  %0 = fmul fast <1 x double> %b.imag, %a.real
  %1 = fmul fast <1 x double> %b.real, %a.imag
  %2 = fadd fast <1 x double> %1, %0
  %3 = fmul fast <1 x double> %b.real, %a.real
  %4 = fmul fast <1 x double> %a.imag, %b.imag
  %5 = fsub fast <1 x double> %3, %4
  %interleaved.vec = shufflevector <1 x double> %5, <1 x double> %2, <2 x i32> <i32 0, i32 1>
  ret <2 x double> %interleaved.vec
}

; Expected to transform
define <4 x double> @complex_mul_v4f64(<4 x double> %a, <4 x double> %b) {
; CHECK-LABEL: complex_mul_v4f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v4.2d, #0000000000000000
; CHECK-NEXT:    movi v5.2d, #0000000000000000
; CHECK-NEXT:    fcmla v5.2d, v0.2d, v2.2d, #0
; CHECK-NEXT:    fcmla v4.2d, v1.2d, v3.2d, #0
; CHECK-NEXT:    fcmla v5.2d, v0.2d, v2.2d, #90
; CHECK-NEXT:    fcmla v4.2d, v1.2d, v3.2d, #90
; CHECK-NEXT:    mov v0.16b, v5.16b
; CHECK-NEXT:    mov v1.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %a.real   = shufflevector <4 x double> %a, <4 x double> poison, <2 x i32> <i32 0, i32 2>
  %a.imag = shufflevector <4 x double> %a, <4 x double> poison, <2 x i32> <i32 1, i32 3>
  %b.real = shufflevector <4 x double> %b, <4 x double> poison, <2 x i32> <i32 0, i32 2>
  %b.imag = shufflevector <4 x double> %b, <4 x double> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x double> %b.imag, %a.real
  %1 = fmul fast <2 x double> %b.real, %a.imag
  %2 = fadd fast <2 x double> %1, %0
  %3 = fmul fast <2 x double> %b.real, %a.real
  %4 = fmul fast <2 x double> %a.imag, %b.imag
  %5 = fsub fast <2 x double> %3, %4
  %interleaved.vec = shufflevector <2 x double> %5, <2 x double> %2, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x double> %interleaved.vec
}

; Expected to transform
define <8 x double> @complex_mul_v8f64(<8 x double> %a, <8 x double> %b) {
; CHECK-LABEL: complex_mul_v8f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v16.2d, #0000000000000000
; CHECK-NEXT:    movi v17.2d, #0000000000000000
; CHECK-NEXT:    movi v18.2d, #0000000000000000
; CHECK-NEXT:    movi v19.2d, #0000000000000000
; CHECK-NEXT:    fcmla v16.2d, v0.2d, v4.2d, #0
; CHECK-NEXT:    fcmla v18.2d, v1.2d, v5.2d, #0
; CHECK-NEXT:    fcmla v17.2d, v3.2d, v7.2d, #0
; CHECK-NEXT:    fcmla v19.2d, v2.2d, v6.2d, #0
; CHECK-NEXT:    fcmla v16.2d, v0.2d, v4.2d, #90
; CHECK-NEXT:    fcmla v18.2d, v1.2d, v5.2d, #90
; CHECK-NEXT:    fcmla v17.2d, v3.2d, v7.2d, #90
; CHECK-NEXT:    fcmla v19.2d, v2.2d, v6.2d, #90
; CHECK-NEXT:    mov v0.16b, v16.16b
; CHECK-NEXT:    mov v1.16b, v18.16b
; CHECK-NEXT:    mov v3.16b, v17.16b
; CHECK-NEXT:    mov v2.16b, v19.16b
; CHECK-NEXT:    ret
entry:
  %a.real   = shufflevector <8 x double> %a, <8 x double> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %a.imag = shufflevector <8 x double> %a, <8 x double> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %b.real = shufflevector <8 x double> %b, <8 x double> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %b.imag = shufflevector <8 x double> %b, <8 x double> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %0 = fmul fast <4 x double> %b.imag, %a.real
  %1 = fmul fast <4 x double> %b.real, %a.imag
  %2 = fadd fast <4 x double> %1, %0
  %3 = fmul fast <4 x double> %b.real, %a.real
  %4 = fmul fast <4 x double> %a.imag, %b.imag
  %5 = fsub fast <4 x double> %3, %4
  %interleaved.vec = shufflevector <4 x double> %5, <4 x double> %2, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  ret <8 x double> %interleaved.vec
}
