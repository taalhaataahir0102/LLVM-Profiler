; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve -force-streaming-compatible-sve  < %s | FileCheck %s --check-prefixes=CHECK,SVE
; RUN: llc -mattr=+sve2 -force-streaming-compatible-sve  < %s | FileCheck %s --check-prefixes=CHECK,SVE2

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"

target triple = "aarch64-unknown-linux-gnu"

;============ f16

define void @test_copysign_v4f16_v4f16(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v4f16_v4f16:
; SVE:       // %bb.0:
; SVE-NEXT:    ldr d0, [x0]
; SVE-NEXT:    ldr d1, [x1]
; SVE-NEXT:    and z1.h, z1.h, #0x8000
; SVE-NEXT:    and z0.h, z0.h, #0x7fff
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    str d0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v4f16_v4f16:
; SVE2:       // %bb.0:
; SVE2-NEXT:    mov z0.h, #32767 // =0x7fff
; SVE2-NEXT:    ldr d1, [x0]
; SVE2-NEXT:    ldr d2, [x1]
; SVE2-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; SVE2-NEXT:    str d1, [x0]
; SVE2-NEXT:    ret
  %a = load <4 x half>, ptr %ap
  %b = load <4 x half>, ptr %bp
  %r = call <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %b)
  store <4 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v8f16_v8f16(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v8f16_v8f16:
; SVE:       // %bb.0:
; SVE-NEXT:    ldr q0, [x0]
; SVE-NEXT:    ldr q1, [x1]
; SVE-NEXT:    and z1.h, z1.h, #0x8000
; SVE-NEXT:    and z0.h, z0.h, #0x7fff
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    str q0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v8f16_v8f16:
; SVE2:       // %bb.0:
; SVE2-NEXT:    mov z0.h, #32767 // =0x7fff
; SVE2-NEXT:    ldr q1, [x0]
; SVE2-NEXT:    ldr q2, [x1]
; SVE2-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; SVE2-NEXT:    str q1, [x0]
; SVE2-NEXT:    ret
  %a = load <8 x half>, ptr %ap
  %b = load <8 x half>, ptr %bp
  %r = call <8 x half> @llvm.copysign.v8f16(<8 x half> %a, <8 x half> %b)
  store <8 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v16f16_v16f16(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v16f16_v16f16:
; SVE:       // %bb.0:
; SVE-NEXT:    ldp q0, q3, [x1]
; SVE-NEXT:    ldp q1, q2, [x0]
; SVE-NEXT:    and z0.h, z0.h, #0x8000
; SVE-NEXT:    and z3.h, z3.h, #0x8000
; SVE-NEXT:    and z1.h, z1.h, #0x7fff
; SVE-NEXT:    and z2.h, z2.h, #0x7fff
; SVE-NEXT:    orr z0.d, z1.d, z0.d
; SVE-NEXT:    orr z1.d, z2.d, z3.d
; SVE-NEXT:    stp q0, q1, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v16f16_v16f16:
; SVE2:       // %bb.0:
; SVE2-NEXT:    mov z0.h, #32767 // =0x7fff
; SVE2-NEXT:    ldp q1, q4, [x1]
; SVE2-NEXT:    ldp q2, q3, [x0]
; SVE2-NEXT:    bsl z2.d, z2.d, z1.d, z0.d
; SVE2-NEXT:    bsl z3.d, z3.d, z4.d, z0.d
; SVE2-NEXT:    stp q2, q3, [x0]
; SVE2-NEXT:    ret
  %a = load <16 x half>, ptr %ap
  %b = load <16 x half>, ptr %bp
  %r = call <16 x half> @llvm.copysign.v16f16(<16 x half> %a, <16 x half> %b)
  store <16 x half> %r, ptr %ap
  ret void
}

;============ f32

define void @test_copysign_v2f32_v2f32(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v2f32_v2f32:
; SVE:       // %bb.0:
; SVE-NEXT:    ldr d0, [x0]
; SVE-NEXT:    ldr d1, [x1]
; SVE-NEXT:    and z1.s, z1.s, #0x80000000
; SVE-NEXT:    and z0.s, z0.s, #0x7fffffff
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    str d0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v2f32_v2f32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    mov z0.s, #0x7fffffff
; SVE2-NEXT:    ldr d1, [x0]
; SVE2-NEXT:    ldr d2, [x1]
; SVE2-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; SVE2-NEXT:    str d1, [x0]
; SVE2-NEXT:    ret
  %a = load <2 x float>, ptr %ap
  %b = load <2 x float>, ptr %bp
  %r = call <2 x float> @llvm.copysign.v2f32(<2 x float> %a, <2 x float> %b)
  store <2 x float> %r, ptr %ap
  ret void
}

define void @test_copysign_v4f32_v4f32(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v4f32_v4f32:
; SVE:       // %bb.0:
; SVE-NEXT:    ldr q0, [x0]
; SVE-NEXT:    ldr q1, [x1]
; SVE-NEXT:    and z1.s, z1.s, #0x80000000
; SVE-NEXT:    and z0.s, z0.s, #0x7fffffff
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    str q0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v4f32_v4f32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    mov z0.s, #0x7fffffff
; SVE2-NEXT:    ldr q1, [x0]
; SVE2-NEXT:    ldr q2, [x1]
; SVE2-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; SVE2-NEXT:    str q1, [x0]
; SVE2-NEXT:    ret
  %a = load <4 x float>, ptr %ap
  %b = load <4 x float>, ptr %bp
  %r = call <4 x float> @llvm.copysign.v4f32(<4 x float> %a, <4 x float> %b)
  store <4 x float> %r, ptr %ap
  ret void
}

define void @test_copysign_v8f32_v8f32(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v8f32_v8f32:
; SVE:       // %bb.0:
; SVE-NEXT:    ldp q0, q3, [x1]
; SVE-NEXT:    ldp q1, q2, [x0]
; SVE-NEXT:    and z0.s, z0.s, #0x80000000
; SVE-NEXT:    and z3.s, z3.s, #0x80000000
; SVE-NEXT:    and z1.s, z1.s, #0x7fffffff
; SVE-NEXT:    and z2.s, z2.s, #0x7fffffff
; SVE-NEXT:    orr z0.d, z1.d, z0.d
; SVE-NEXT:    orr z1.d, z2.d, z3.d
; SVE-NEXT:    stp q0, q1, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v8f32_v8f32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    mov z0.s, #0x7fffffff
; SVE2-NEXT:    ldp q1, q4, [x1]
; SVE2-NEXT:    ldp q2, q3, [x0]
; SVE2-NEXT:    bsl z2.d, z2.d, z1.d, z0.d
; SVE2-NEXT:    bsl z3.d, z3.d, z4.d, z0.d
; SVE2-NEXT:    stp q2, q3, [x0]
; SVE2-NEXT:    ret
  %a = load <8 x float>, ptr %ap
  %b = load <8 x float>, ptr %bp
  %r = call <8 x float> @llvm.copysign.v8f32(<8 x float> %a, <8 x float> %b)
  store <8 x float> %r, ptr %ap
  ret void
}

;============ f64

define void @test_copysign_v2f64_v2f64(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v2f64_v2f64:
; SVE:       // %bb.0:
; SVE-NEXT:    ldr q0, [x0]
; SVE-NEXT:    ldr q1, [x1]
; SVE-NEXT:    and z1.d, z1.d, #0x8000000000000000
; SVE-NEXT:    and z0.d, z0.d, #0x7fffffffffffffff
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    str q0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v2f64_v2f64:
; SVE2:       // %bb.0:
; SVE2-NEXT:    mov z0.d, #0x7fffffffffffffff
; SVE2-NEXT:    ldr q1, [x0]
; SVE2-NEXT:    ldr q2, [x1]
; SVE2-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; SVE2-NEXT:    str q1, [x0]
; SVE2-NEXT:    ret
  %a = load <2 x double>, ptr %ap
  %b = load <2 x double>, ptr %bp
  %r = call <2 x double> @llvm.copysign.v2f64(<2 x double> %a, <2 x double> %b)
  store <2 x double> %r, ptr %ap
  ret void
}

define void @test_copysign_v4f64_v4f64(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v4f64_v4f64:
; SVE:       // %bb.0:
; SVE-NEXT:    ldp q0, q3, [x1]
; SVE-NEXT:    ldp q1, q2, [x0]
; SVE-NEXT:    and z0.d, z0.d, #0x8000000000000000
; SVE-NEXT:    and z3.d, z3.d, #0x8000000000000000
; SVE-NEXT:    and z1.d, z1.d, #0x7fffffffffffffff
; SVE-NEXT:    and z2.d, z2.d, #0x7fffffffffffffff
; SVE-NEXT:    orr z0.d, z1.d, z0.d
; SVE-NEXT:    orr z1.d, z2.d, z3.d
; SVE-NEXT:    stp q0, q1, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v4f64_v4f64:
; SVE2:       // %bb.0:
; SVE2-NEXT:    mov z0.d, #0x7fffffffffffffff
; SVE2-NEXT:    ldp q1, q4, [x1]
; SVE2-NEXT:    ldp q2, q3, [x0]
; SVE2-NEXT:    bsl z2.d, z2.d, z1.d, z0.d
; SVE2-NEXT:    bsl z3.d, z3.d, z4.d, z0.d
; SVE2-NEXT:    stp q2, q3, [x0]
; SVE2-NEXT:    ret
  %a = load <4 x double>, ptr %ap
  %b = load <4 x double>, ptr %bp
  %r = call <4 x double> @llvm.copysign.v4f64(<4 x double> %a, <4 x double> %b)
  store <4 x double> %r, ptr %ap
  ret void
}

;============ v2f32

define void @test_copysign_v2f32_v2f64(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v2f32_v2f64:
; SVE:       // %bb.0:
; SVE-NEXT:    ptrue p0.d
; SVE-NEXT:    ldr q0, [x1]
; SVE-NEXT:    ldr d1, [x0]
; SVE-NEXT:    and z1.s, z1.s, #0x7fffffff
; SVE-NEXT:    fcvt z0.s, p0/m, z0.d
; SVE-NEXT:    uzp1 z0.s, z0.s, z0.s
; SVE-NEXT:    and z0.s, z0.s, #0x80000000
; SVE-NEXT:    orr z0.d, z1.d, z0.d
; SVE-NEXT:    str d0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v2f32_v2f64:
; SVE2:       // %bb.0:
; SVE2-NEXT:    ptrue p0.d
; SVE2-NEXT:    ldr q0, [x1]
; SVE2-NEXT:    mov z1.s, #0x7fffffff
; SVE2-NEXT:    ldr d2, [x0]
; SVE2-NEXT:    fcvt z0.s, p0/m, z0.d
; SVE2-NEXT:    uzp1 z0.s, z0.s, z0.s
; SVE2-NEXT:    bsl z2.d, z2.d, z0.d, z1.d
; SVE2-NEXT:    str d2, [x0]
; SVE2-NEXT:    ret
  %a = load <2 x float>, ptr %ap
  %b = load <2 x double>, ptr %bp
  %tmp0 = fptrunc <2 x double> %b to <2 x float>
  %r = call <2 x float> @llvm.copysign.v2f32(<2 x float> %a, <2 x float> %tmp0)
  store <2 x float> %r, ptr %ap
  ret void
}

;============ v4f32

; SplitVecOp #1
define void @test_copysign_v4f32_v4f64(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v4f32_v4f64:
; SVE:       // %bb.0:
; SVE-NEXT:    ptrue p0.d
; SVE-NEXT:    ldp q0, q1, [x1]
; SVE-NEXT:    fcvt z1.s, p0/m, z1.d
; SVE-NEXT:    fcvt z0.s, p0/m, z0.d
; SVE-NEXT:    ptrue p0.s, vl2
; SVE-NEXT:    uzp1 z1.s, z1.s, z1.s
; SVE-NEXT:    uzp1 z0.s, z0.s, z0.s
; SVE-NEXT:    splice z0.s, p0, z0.s, z1.s
; SVE-NEXT:    ldr q1, [x0]
; SVE-NEXT:    and z1.s, z1.s, #0x7fffffff
; SVE-NEXT:    and z0.s, z0.s, #0x80000000
; SVE-NEXT:    orr z0.d, z1.d, z0.d
; SVE-NEXT:    str q0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v4f32_v4f64:
; SVE2:       // %bb.0:
; SVE2-NEXT:    ptrue p0.d
; SVE2-NEXT:    ldp q0, q1, [x1]
; SVE2-NEXT:    ldr q2, [x0]
; SVE2-NEXT:    fcvt z1.s, p0/m, z1.d
; SVE2-NEXT:    fcvt z0.s, p0/m, z0.d
; SVE2-NEXT:    ptrue p0.s, vl2
; SVE2-NEXT:    uzp1 z1.s, z1.s, z1.s
; SVE2-NEXT:    uzp1 z0.s, z0.s, z0.s
; SVE2-NEXT:    splice z0.s, p0, z0.s, z1.s
; SVE2-NEXT:    mov z1.s, #0x7fffffff
; SVE2-NEXT:    bsl z2.d, z2.d, z0.d, z1.d
; SVE2-NEXT:    str q2, [x0]
; SVE2-NEXT:    ret
  %a = load <4 x float>, ptr %ap
  %b = load <4 x double>, ptr %bp
  %tmp0 = fptrunc <4 x double> %b to <4 x float>
  %r = call <4 x float> @llvm.copysign.v4f32(<4 x float> %a, <4 x float> %tmp0)
  store <4 x float> %r, ptr %ap
  ret void
}

;============ v2f64

define void @test_copysign_v2f64_v2f32(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v2f64_v2f32:
; SVE:       // %bb.0:
; SVE-NEXT:    ptrue p0.d, vl2
; SVE-NEXT:    ldr q0, [x0]
; SVE-NEXT:    and z0.d, z0.d, #0x7fffffffffffffff
; SVE-NEXT:    ld1w { z1.d }, p0/z, [x1]
; SVE-NEXT:    fcvt z1.d, p0/m, z1.s
; SVE-NEXT:    and z1.d, z1.d, #0x8000000000000000
; SVE-NEXT:    orr z0.d, z0.d, z1.d
; SVE-NEXT:    str q0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v2f64_v2f32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    ptrue p0.d, vl2
; SVE2-NEXT:    ldr q0, [x0]
; SVE2-NEXT:    mov z2.d, #0x7fffffffffffffff
; SVE2-NEXT:    ld1w { z1.d }, p0/z, [x1]
; SVE2-NEXT:    fcvt z1.d, p0/m, z1.s
; SVE2-NEXT:    bsl z0.d, z0.d, z1.d, z2.d
; SVE2-NEXT:    str q0, [x0]
; SVE2-NEXT:    ret
  %a = load <2 x double>, ptr %ap
  %b = load < 2 x float>, ptr %bp
  %tmp0 = fpext <2 x float> %b to <2 x double>
  %r = call <2 x double> @llvm.copysign.v2f64(<2 x double> %a, <2 x double> %tmp0)
  store <2 x double> %r, ptr %ap
  ret void
}

;============ v4f64

; SplitVecRes mismatched
define void @test_copysign_v4f64_v4f32(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v4f64_v4f32:
; SVE:       // %bb.0:
; SVE-NEXT:    ptrue p0.d, vl2
; SVE-NEXT:    mov x8, #2 // =0x2
; SVE-NEXT:    ldp q0, q1, [x0]
; SVE-NEXT:    and z0.d, z0.d, #0x7fffffffffffffff
; SVE-NEXT:    and z1.d, z1.d, #0x7fffffffffffffff
; SVE-NEXT:    ld1w { z2.d }, p0/z, [x1, x8, lsl #2]
; SVE-NEXT:    ld1w { z3.d }, p0/z, [x1]
; SVE-NEXT:    fcvt z3.d, p0/m, z3.s
; SVE-NEXT:    fcvt z2.d, p0/m, z2.s
; SVE-NEXT:    and z3.d, z3.d, #0x8000000000000000
; SVE-NEXT:    and z2.d, z2.d, #0x8000000000000000
; SVE-NEXT:    orr z0.d, z0.d, z3.d
; SVE-NEXT:    orr z1.d, z1.d, z2.d
; SVE-NEXT:    stp q0, q1, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v4f64_v4f32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    ptrue p0.d, vl2
; SVE2-NEXT:    mov x8, #2 // =0x2
; SVE2-NEXT:    mov z4.d, #0x7fffffffffffffff
; SVE2-NEXT:    ldp q0, q1, [x0]
; SVE2-NEXT:    ld1w { z2.d }, p0/z, [x1, x8, lsl #2]
; SVE2-NEXT:    ld1w { z3.d }, p0/z, [x1]
; SVE2-NEXT:    fcvt z3.d, p0/m, z3.s
; SVE2-NEXT:    fcvt z2.d, p0/m, z2.s
; SVE2-NEXT:    bsl z0.d, z0.d, z3.d, z4.d
; SVE2-NEXT:    bsl z1.d, z1.d, z2.d, z4.d
; SVE2-NEXT:    stp q0, q1, [x0]
; SVE2-NEXT:    ret
  %a = load <4 x double>, ptr %ap
  %b = load <4 x float>, ptr %bp
  %tmp0 = fpext <4 x float> %b to <4 x double>
  %r = call <4 x double> @llvm.copysign.v4f64(<4 x double> %a, <4 x double> %tmp0)
  store <4 x double> %r, ptr %ap
  ret void
}

;============ v4f16

define void @test_copysign_v4f16_v4f32(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v4f16_v4f32:
; SVE:       // %bb.0:
; SVE-NEXT:    ptrue p0.s
; SVE-NEXT:    ldr q0, [x1]
; SVE-NEXT:    ldr d1, [x0]
; SVE-NEXT:    and z1.h, z1.h, #0x7fff
; SVE-NEXT:    fcvt z0.h, p0/m, z0.s
; SVE-NEXT:    uzp1 z0.h, z0.h, z0.h
; SVE-NEXT:    and z0.h, z0.h, #0x8000
; SVE-NEXT:    orr z0.d, z1.d, z0.d
; SVE-NEXT:    str d0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v4f16_v4f32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    ptrue p0.s
; SVE2-NEXT:    ldr q0, [x1]
; SVE2-NEXT:    mov z1.h, #32767 // =0x7fff
; SVE2-NEXT:    ldr d2, [x0]
; SVE2-NEXT:    fcvt z0.h, p0/m, z0.s
; SVE2-NEXT:    uzp1 z0.h, z0.h, z0.h
; SVE2-NEXT:    bsl z2.d, z2.d, z0.d, z1.d
; SVE2-NEXT:    str d2, [x0]
; SVE2-NEXT:    ret
  %a = load <4 x half>, ptr %ap
  %b = load <4 x float>, ptr %bp
  %tmp0 = fptrunc <4 x float> %b to <4 x half>
  %r = call <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %tmp0)
  store <4 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v4f16_v4f64(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v4f16_v4f64:
; SVE:       // %bb.0:
; SVE-NEXT:    sub sp, sp, #16
; SVE-NEXT:    .cfi_def_cfa_offset 16
; SVE-NEXT:    ldp q1, q0, [x1]
; SVE-NEXT:    ldr d4, [x0]
; SVE-NEXT:    and z4.h, z4.h, #0x7fff
; SVE-NEXT:    mov z2.d, z0.d[1]
; SVE-NEXT:    mov z3.d, z1.d[1]
; SVE-NEXT:    fcvt h0, d0
; SVE-NEXT:    fcvt h1, d1
; SVE-NEXT:    fcvt h2, d2
; SVE-NEXT:    fcvt h3, d3
; SVE-NEXT:    str h0, [sp, #12]
; SVE-NEXT:    str h1, [sp, #8]
; SVE-NEXT:    str h2, [sp, #14]
; SVE-NEXT:    str h3, [sp, #10]
; SVE-NEXT:    ldr d0, [sp, #8]
; SVE-NEXT:    and z0.h, z0.h, #0x8000
; SVE-NEXT:    orr z0.d, z4.d, z0.d
; SVE-NEXT:    str d0, [x0]
; SVE-NEXT:    add sp, sp, #16
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v4f16_v4f64:
; SVE2:       // %bb.0:
; SVE2-NEXT:    sub sp, sp, #16
; SVE2-NEXT:    .cfi_def_cfa_offset 16
; SVE2-NEXT:    ldp q2, q1, [x1]
; SVE2-NEXT:    mov z0.h, #32767 // =0x7fff
; SVE2-NEXT:    ldr d5, [x0]
; SVE2-NEXT:    mov z3.d, z1.d[1]
; SVE2-NEXT:    mov z4.d, z2.d[1]
; SVE2-NEXT:    fcvt h1, d1
; SVE2-NEXT:    fcvt h2, d2
; SVE2-NEXT:    fcvt h3, d3
; SVE2-NEXT:    fcvt h4, d4
; SVE2-NEXT:    str h1, [sp, #12]
; SVE2-NEXT:    str h2, [sp, #8]
; SVE2-NEXT:    str h3, [sp, #14]
; SVE2-NEXT:    str h4, [sp, #10]
; SVE2-NEXT:    ldr d1, [sp, #8]
; SVE2-NEXT:    bsl z5.d, z5.d, z1.d, z0.d
; SVE2-NEXT:    str d5, [x0]
; SVE2-NEXT:    add sp, sp, #16
; SVE2-NEXT:    ret
  %a = load <4 x half>, ptr %ap
  %b = load <4 x double>, ptr %bp
  %tmp0 = fptrunc <4 x double> %b to <4 x half>
  %r = call <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %tmp0)
  store <4 x half> %r, ptr %ap
  ret void
}

;============ v8f16

define void @test_copysign_v8f16_v8f32(ptr %ap, ptr %bp) {
; SVE-LABEL: test_copysign_v8f16_v8f32:
; SVE:       // %bb.0:
; SVE-NEXT:    ptrue p0.s
; SVE-NEXT:    ldp q0, q1, [x1]
; SVE-NEXT:    fcvt z1.h, p0/m, z1.s
; SVE-NEXT:    fcvt z0.h, p0/m, z0.s
; SVE-NEXT:    ptrue p0.h, vl4
; SVE-NEXT:    uzp1 z1.h, z1.h, z1.h
; SVE-NEXT:    uzp1 z0.h, z0.h, z0.h
; SVE-NEXT:    splice z0.h, p0, z0.h, z1.h
; SVE-NEXT:    ldr q1, [x0]
; SVE-NEXT:    and z1.h, z1.h, #0x7fff
; SVE-NEXT:    and z0.h, z0.h, #0x8000
; SVE-NEXT:    orr z0.d, z1.d, z0.d
; SVE-NEXT:    str q0, [x0]
; SVE-NEXT:    ret
;
; SVE2-LABEL: test_copysign_v8f16_v8f32:
; SVE2:       // %bb.0:
; SVE2-NEXT:    ptrue p0.s
; SVE2-NEXT:    ldp q0, q1, [x1]
; SVE2-NEXT:    ldr q2, [x0]
; SVE2-NEXT:    fcvt z1.h, p0/m, z1.s
; SVE2-NEXT:    fcvt z0.h, p0/m, z0.s
; SVE2-NEXT:    ptrue p0.h, vl4
; SVE2-NEXT:    uzp1 z1.h, z1.h, z1.h
; SVE2-NEXT:    uzp1 z0.h, z0.h, z0.h
; SVE2-NEXT:    splice z0.h, p0, z0.h, z1.h
; SVE2-NEXT:    mov z1.h, #32767 // =0x7fff
; SVE2-NEXT:    bsl z2.d, z2.d, z0.d, z1.d
; SVE2-NEXT:    str q2, [x0]
; SVE2-NEXT:    ret
  %a = load <8 x half>, ptr %ap
  %b = load <8 x float>, ptr %bp
  %tmp0 = fptrunc <8 x float> %b to <8 x half>
  %r = call <8 x half> @llvm.copysign.v8f16(<8 x half> %a, <8 x half> %tmp0)
  store <8 x half> %r, ptr %ap
  ret void
}

declare <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %b) #0
declare <8 x half> @llvm.copysign.v8f16(<8 x half> %a, <8 x half> %b) #0
declare <16 x half> @llvm.copysign.v16f16(<16 x half> %a, <16 x half> %b) #0

declare <2 x float> @llvm.copysign.v2f32(<2 x float> %a, <2 x float> %b) #0
declare <4 x float> @llvm.copysign.v4f32(<4 x float> %a, <4 x float> %b) #0
declare <8 x float> @llvm.copysign.v8f32(<8 x float> %a, <8 x float> %b) #0

declare <2 x double> @llvm.copysign.v2f64(<2 x double> %a, <2 x double> %b) #0
declare <4 x double> @llvm.copysign.v4f64(<4 x double> %a, <4 x double> %b) #0
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK: {{.*}}
