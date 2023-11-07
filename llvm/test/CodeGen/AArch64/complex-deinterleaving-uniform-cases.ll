; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s --mattr=+complxnum,+neon,+fullfp16 -o - | FileCheck %s

target triple = "aarch64"

; Expected to transform
define <4 x float> @simple_mul(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: simple_mul:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v2.2d, #0000000000000000
; CHECK-NEXT:    fcmla v2.4s, v0.4s, v1.4s, #0
; CHECK-NEXT:    fcmla v2.4s, v0.4s, v1.4s, #90
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec17 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec19 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec20 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x float> %strided.vec20, %strided.vec
  %1 = fmul fast <2 x float> %strided.vec19, %strided.vec17
  %2 = fadd fast <2 x float> %1, %0
  %3 = fmul fast <2 x float> %strided.vec19, %strided.vec
  %4 = fmul fast <2 x float> %strided.vec17, %strided.vec20
  %5 = fsub fast <2 x float> %3, %4
  %interleaved.vec = shufflevector <2 x float> %5, <2 x float> %2, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to not transform
define <4 x float> @simple_mul_no_contract(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: simple_mul_no_contract:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ext v2.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ext v3.16b, v1.16b, v1.16b, #8
; CHECK-NEXT:    zip1 v4.2s, v0.2s, v2.2s
; CHECK-NEXT:    zip2 v0.2s, v0.2s, v2.2s
; CHECK-NEXT:    zip1 v2.2s, v1.2s, v3.2s
; CHECK-NEXT:    zip2 v1.2s, v1.2s, v3.2s
; CHECK-NEXT:    fmul v3.2s, v1.2s, v4.2s
; CHECK-NEXT:    fmul v4.2s, v2.2s, v4.2s
; CHECK-NEXT:    fmul v1.2s, v0.2s, v1.2s
; CHECK-NEXT:    fmla v3.2s, v0.2s, v2.2s
; CHECK-NEXT:    fsub v0.2s, v4.2s, v1.2s
; CHECK-NEXT:    zip1 v0.4s, v0.4s, v3.4s
; CHECK-NEXT:    ret
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec17 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec19 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec20 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x float> %strided.vec20, %strided.vec
  %1 = fmul fast <2 x float> %strided.vec19, %strided.vec17
  %2 = fadd fast <2 x float> %1, %0
  %3 = fmul fast <2 x float> %strided.vec19, %strided.vec
  %4 = fmul fast <2 x float> %strided.vec17, %strided.vec20
  %5 = fsub <2 x float> %3, %4
  %interleaved.vec = shufflevector <2 x float> %5, <2 x float> %2, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to transform
define <4 x float> @three_way_mul(<4 x float> %a, <4 x float> %b, <4 x float> %c) {
; CHECK-LABEL: three_way_mul:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v4.2d, #0000000000000000
; CHECK-NEXT:    movi v3.2d, #0000000000000000
; CHECK-NEXT:    fcmla v4.4s, v1.4s, v0.4s, #0
; CHECK-NEXT:    fcmla v4.4s, v1.4s, v0.4s, #90
; CHECK-NEXT:    fcmla v3.4s, v2.4s, v4.4s, #0
; CHECK-NEXT:    fcmla v3.4s, v2.4s, v4.4s, #90
; CHECK-NEXT:    mov v0.16b, v3.16b
; CHECK-NEXT:    ret
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec39 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec41 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec42 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec44 = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec45 = shufflevector <4 x float> %c, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fmul fast <2 x float> %strided.vec41, %strided.vec
  %1 = fmul fast <2 x float> %strided.vec42, %strided.vec39
  %2 = fsub fast <2 x float> %0, %1
  %3 = fmul fast <2 x float> %2, %strided.vec45
  %4 = fmul fast <2 x float> %strided.vec42, %strided.vec
  %5 = fmul fast <2 x float> %strided.vec39, %strided.vec41
  %6 = fadd fast <2 x float> %4, %5
  %7 = fmul fast <2 x float> %6, %strided.vec44
  %8 = fadd fast <2 x float> %3, %7
  %9 = fmul fast <2 x float> %2, %strided.vec44
  %10 = fmul fast <2 x float> %6, %strided.vec45
  %11 = fsub fast <2 x float> %9, %10
  %interleaved.vec = shufflevector <2 x float> %11, <2 x float> %8, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to transform
define <4 x float> @simple_add_90(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: simple_add_90:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcadd v0.4s, v1.4s, v0.4s, #90
; CHECK-NEXT:    ret
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec17 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec19 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec20 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fsub fast <2 x float> %strided.vec19, %strided.vec17
  %1 = fadd fast <2 x float> %strided.vec20, %strided.vec
  %interleaved.vec = shufflevector <2 x float> %0, <2 x float> %1, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to not transform, fadd commutativity is not yet implemented
define <4 x float> @simple_add_270_false(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: simple_add_270_false:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcadd v0.4s, v0.4s, v1.4s, #270
; CHECK-NEXT:    ret
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec17 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec19 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec20 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fadd fast <2 x float> %strided.vec20, %strided.vec
  %1 = fsub fast <2 x float> %strided.vec17, %strided.vec19
  %interleaved.vec = shufflevector <2 x float> %0, <2 x float> %1, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to transform
define <4 x float> @simple_add_270_true(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: simple_add_270_true:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcadd v0.4s, v0.4s, v1.4s, #270
; CHECK-NEXT:    ret
entry:
  %strided.vec = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec17 = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %strided.vec19 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec20 = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fadd fast <2 x float> %strided.vec, %strided.vec20
  %1 = fsub fast <2 x float> %strided.vec17, %strided.vec19
  %interleaved.vec = shufflevector <2 x float> %0, <2 x float> %1, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to not transform
define <4 x float> @add_external_use(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: add_external_use:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ext v2.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ext v3.16b, v1.16b, v1.16b, #8
; CHECK-NEXT:    zip1 v4.2s, v0.2s, v2.2s
; CHECK-NEXT:    zip2 v0.2s, v0.2s, v2.2s
; CHECK-NEXT:    zip1 v2.2s, v1.2s, v3.2s
; CHECK-NEXT:    zip2 v1.2s, v1.2s, v3.2s
; CHECK-NEXT:    fadd v0.2s, v0.2s, v2.2s
; CHECK-NEXT:    fsub v1.2s, v4.2s, v1.2s
; CHECK-NEXT:    zip1 v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ret
entry:
  %a.real = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %a.imag = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %b.real = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %b.imag = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fsub fast <2 x float> %a.real, %b.imag
  %1 = fadd fast <2 x float> %a.imag, %b.real
  %interleaved.vec = shufflevector <2 x float> %0, <2 x float> %1, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  %dup = shufflevector <2 x float> %0, <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %interleaved.vec2 = shufflevector <4 x float> %interleaved.vec, <4 x float> %dup, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x float> %interleaved.vec2
}

; Expected to transform
define <4 x float> @mul_mul_with_fneg(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: mul_mul_with_fneg:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v2.2d, #0000000000000000
; CHECK-NEXT:    fcmla v2.4s, v1.4s, v0.4s, #270
; CHECK-NEXT:    fcmla v2.4s, v1.4s, v0.4s, #180
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %a.real = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %a.imag = shufflevector <4 x float> %a, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %b.real = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 0, i32 2>
  %b.imag = shufflevector <4 x float> %b, <4 x float> poison, <2 x i32> <i32 1, i32 3>
  %0 = fneg fast <2 x float> %a.imag
  %1 = fmul fast <2 x float> %b.real, %0
  %2 = fmul fast <2 x float> %a.real, %b.imag
  %3 = fsub fast <2 x float> %1, %2
  %4 = fmul fast <2 x float> %b.imag, %a.imag
  %5 = fmul fast <2 x float> %a.real, %b.real
  %6 = fsub fast <2 x float> %4, %5
  %interleaved.vec = shufflevector <2 x float> %6, <2 x float> %3, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  ret <4 x float> %interleaved.vec
}

; Expected to not transform
define <12 x float> @abp90c12(<12 x float> %a, <12 x float> %b, <12 x float> %c) {
; CHECK-LABEL: abp90c12:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $s1 killed $s1 def $q1
; CHECK-NEXT:    // kill: def $s3 killed $s3 def $q3
; CHECK-NEXT:    ldr s16, [sp, #40]
; CHECK-NEXT:    add x10, sp, #56
; CHECK-NEXT:    add x9, sp, #48
; CHECK-NEXT:    mov v1.s[1], v3.s[0]
; CHECK-NEXT:    ldr s3, [sp, #32]
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    // kill: def $s5 killed $s5 def $q5
; CHECK-NEXT:    // kill: def $s2 killed $s2 def $q2
; CHECK-NEXT:    ldr s18, [sp, #8]
; CHECK-NEXT:    ld1 { v16.s }[1], [x10]
; CHECK-NEXT:    mov v0.s[1], v2.s[0]
; CHECK-NEXT:    add x10, sp, #72
; CHECK-NEXT:    ld1 { v3.s }[1], [x9]
; CHECK-NEXT:    add x9, sp, #64
; CHECK-NEXT:    ldr s17, [sp, #96]
; CHECK-NEXT:    // kill: def $s7 killed $s7 def $q7
; CHECK-NEXT:    // kill: def $s4 killed $s4 def $q4
; CHECK-NEXT:    // kill: def $s6 killed $s6 def $q6
; CHECK-NEXT:    ldr s2, [sp, #136]
; CHECK-NEXT:    ldr s20, [sp, #192]
; CHECK-NEXT:    mov v1.s[2], v5.s[0]
; CHECK-NEXT:    ld1 { v16.s }[2], [x10]
; CHECK-NEXT:    ldr s5, [sp, #104]
; CHECK-NEXT:    ld1 { v3.s }[2], [x9]
; CHECK-NEXT:    add x9, sp, #24
; CHECK-NEXT:    add x10, sp, #112
; CHECK-NEXT:    ld1 { v18.s }[1], [x9]
; CHECK-NEXT:    add x9, sp, #88
; CHECK-NEXT:    mov v0.s[2], v4.s[0]
; CHECK-NEXT:    ld1 { v17.s }[1], [x10]
; CHECK-NEXT:    add x10, sp, #80
; CHECK-NEXT:    ld1 { v16.s }[3], [x9]
; CHECK-NEXT:    mov v1.s[3], v7.s[0]
; CHECK-NEXT:    add x9, sp, #120
; CHECK-NEXT:    ldr s4, [sp, #128]
; CHECK-NEXT:    ld1 { v3.s }[3], [x10]
; CHECK-NEXT:    ld1 { v5.s }[1], [x9]
; CHECK-NEXT:    add x9, sp, #144
; CHECK-NEXT:    ldr s7, [sp]
; CHECK-NEXT:    ld1 { v4.s }[1], [x9]
; CHECK-NEXT:    mov v0.s[3], v6.s[0]
; CHECK-NEXT:    add x10, sp, #16
; CHECK-NEXT:    add x9, sp, #160
; CHECK-NEXT:    fmul v6.4s, v16.4s, v1.4s
; CHECK-NEXT:    fmul v19.4s, v5.4s, v18.4s
; CHECK-NEXT:    fmul v18.4s, v17.4s, v18.4s
; CHECK-NEXT:    fmul v1.4s, v3.4s, v1.4s
; CHECK-NEXT:    ld1 { v7.s }[1], [x10]
; CHECK-NEXT:    ld1 { v4.s }[2], [x9]
; CHECK-NEXT:    add x9, sp, #152
; CHECK-NEXT:    add x10, sp, #208
; CHECK-NEXT:    ld1 { v2.s }[1], [x9]
; CHECK-NEXT:    add x9, sp, #176
; CHECK-NEXT:    ld1 { v20.s }[1], [x10]
; CHECK-NEXT:    fneg v6.4s, v6.4s
; CHECK-NEXT:    fneg v19.4s, v19.4s
; CHECK-NEXT:    fmla v18.4s, v7.4s, v5.4s
; CHECK-NEXT:    fmla v1.4s, v0.4s, v16.4s
; CHECK-NEXT:    ld1 { v4.s }[3], [x9]
; CHECK-NEXT:    add x9, sp, #168
; CHECK-NEXT:    ld1 { v2.s }[2], [x9]
; CHECK-NEXT:    ldr s5, [sp, #200]
; CHECK-NEXT:    add x9, sp, #216
; CHECK-NEXT:    add x10, sp, #184
; CHECK-NEXT:    fmla v6.4s, v0.4s, v3.4s
; CHECK-NEXT:    fmla v19.4s, v7.4s, v17.4s
; CHECK-NEXT:    ld1 { v5.s }[1], [x9]
; CHECK-NEXT:    fsub v0.4s, v4.4s, v1.4s
; CHECK-NEXT:    fsub v1.4s, v20.4s, v18.4s
; CHECK-NEXT:    ld1 { v2.s }[3], [x10]
; CHECK-NEXT:    fadd v3.4s, v5.4s, v19.4s
; CHECK-NEXT:    fadd v2.4s, v2.4s, v6.4s
; CHECK-NEXT:    ext v4.16b, v0.16b, v1.16b, #12
; CHECK-NEXT:    ext v5.16b, v2.16b, v3.16b, #12
; CHECK-NEXT:    trn2 v1.4s, v1.4s, v3.4s
; CHECK-NEXT:    ext v4.16b, v0.16b, v4.16b, #12
; CHECK-NEXT:    ext v5.16b, v2.16b, v5.16b, #8
; CHECK-NEXT:    rev64 v4.4s, v4.4s
; CHECK-NEXT:    trn2 v3.4s, v4.4s, v5.4s
; CHECK-NEXT:    zip2 v4.4s, v0.4s, v2.4s
; CHECK-NEXT:    zip1 v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    ext v1.16b, v3.16b, v1.16b, #8
; CHECK-NEXT:    mov v4.d[1], v3.d[0]
; CHECK-NEXT:    str q0, [x8]
; CHECK-NEXT:    stp q4, q1, [x8, #16]
; CHECK-NEXT:    ret
entry:
  %ar = shufflevector <12 x float> %a, <12 x float> poison, <6 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10>
  %ai = shufflevector <12 x float> %a, <12 x float> poison, <6 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11>
  %br = shufflevector <12 x float> %b, <12 x float> poison, <6 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10>
  %bi = shufflevector <12 x float> %b, <12 x float> poison, <6 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11>
  %cr = shufflevector <12 x float> %c, <12 x float> poison, <6 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10>
  %ci = shufflevector <12 x float> %c, <12 x float> poison, <6 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11>

  %i6 = fmul fast <6 x float> %br, %ar
  %i7 = fmul fast <6 x float> %bi, %ai
  %xr = fsub fast <6 x float> %i6, %i7
  %i9 = fmul fast <6 x float> %bi, %ar
  %i10 = fmul fast <6 x float> %br, %ai
  %xi = fadd fast <6 x float> %i9, %i10

  %zr = fsub fast <6 x float> %cr, %xi
  %zi = fadd fast <6 x float> %ci, %xr
  %interleaved.vec = shufflevector <6 x float> %zr, <6 x float> %zi, <12 x i32> <i32 0, i32 6, i32 1, i32 7, i32 2, i32 8, i32 3, i32 9, i32 4, i32 10, i32 5, i32 11>
  ret <12 x float> %interleaved.vec
}
