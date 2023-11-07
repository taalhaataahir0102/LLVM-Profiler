; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256,CHECK_NO_EXTEND_ROUND
; RUN: llc -aarch64-sve-vector-bits-min=512  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512,CHECK_NO_EXTEND_ROUND
; RUN: llc -aarch64-sve-vector-bits-min=2048 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512,CHECK_NO_EXTEND_ROUND
; RUN: llc -aarch64-sve-vector-bits-min=256  --combiner-vector-fcopysign-extend-round < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256,CHECK_EXTEND_ROUND
; RUN: llc -aarch64-sve-vector-bits-min=512  --combiner-vector-fcopysign-extend-round < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512,CHECK_EXTEND_ROUND
; RUN: llc -aarch64-sve-vector-bits-min=2048 --combiner-vector-fcopysign-extend-round < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512,CHECK_EXTEND_ROUND


target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"

target triple = "aarch64-unknown-linux-gnu"

;============ f16

define void @test_copysign_v4f16_v4f16(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v4f16_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4h, #128, lsl #8
; CHECK-NEXT:    ldr d1, [x0]
; CHECK-NEXT:    ldr d2, [x1]
; CHECK-NEXT:    bsl v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %a = load <4 x half>, ptr %ap
  %b = load <4 x half>, ptr %bp
  %r = call <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %b)
  store <4 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v8f16_v8f16(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v8f16_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.8h, #128, lsl #8
; CHECK-NEXT:    ldr q1, [x0]
; CHECK-NEXT:    ldr q2, [x1]
; CHECK-NEXT:    bsl v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %a = load <8 x half>, ptr %ap
  %b = load <8 x half>, ptr %bp
  %r = call <8 x half> @llvm.copysign.v8f16(<8 x half> %a, <8 x half> %b)
  store <8 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v16f16_v16f16(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v16f16_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    mov z0.h, #32767 // =0x7fff
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z2.h }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1h { z1.h }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <16 x half>, ptr %ap
  %b = load <16 x half>, ptr %bp
  %r = call <16 x half> @llvm.copysign.v16f16(<16 x half> %a, <16 x half> %b)
  store <16 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v32f16_v32f16(ptr %ap, ptr %bp) #0 {
; VBITS_GE_256-LABEL: test_copysign_v32f16_v32f16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.h, vl16
; VBITS_GE_256-NEXT:    mov x8, #16 // =0x10
; VBITS_GE_256-NEXT:    mov z0.h, #32767 // =0x7fff
; VBITS_GE_256-NEXT:    ld1h { z1.h }, p0/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z2.h }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1h { z3.h }, p0/z, [x1, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z4.h }, p0/z, [x1]
; VBITS_GE_256-NEXT:    bsl z1.d, z1.d, z3.d, z0.d
; VBITS_GE_256-NEXT:    bsl z2.d, z2.d, z4.d, z0.d
; VBITS_GE_256-NEXT:    st1h { z1.h }, p0, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z2.h }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: test_copysign_v32f16_v32f16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.h, vl32
; VBITS_GE_512-NEXT:    mov z0.h, #32767 // =0x7fff
; VBITS_GE_512-NEXT:    ld1h { z1.h }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1h { z2.h }, p0/z, [x1]
; VBITS_GE_512-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; VBITS_GE_512-NEXT:    st1h { z1.h }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %a = load <32 x half>, ptr %ap
  %b = load <32 x half>, ptr %bp
  %r = call <32 x half> @llvm.copysign.v32f16(<32 x half> %a, <32 x half> %b)
  store <32 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v64f16_v64f16(ptr %ap, ptr %bp) vscale_range(8,0) #0 {
; CHECK-LABEL: test_copysign_v64f16_v64f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl64
; CHECK-NEXT:    mov z0.h, #32767 // =0x7fff
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z2.h }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1h { z1.h }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <64 x half>, ptr %ap
  %b = load <64 x half>, ptr %bp
  %r = call <64 x half> @llvm.copysign.v64f16(<64 x half> %a, <64 x half> %b)
  store <64 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v128f16_v128f16(ptr %ap, ptr %bp) vscale_range(16,0) #0 {
; CHECK-LABEL: test_copysign_v128f16_v128f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl128
; CHECK-NEXT:    mov z0.h, #32767 // =0x7fff
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z2.h }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1h { z1.h }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <128 x half>, ptr %ap
  %b = load <128 x half>, ptr %bp
  %r = call <128 x half> @llvm.copysign.v128f16(<128 x half> %a, <128 x half> %b)
  store <128 x half> %r, ptr %ap
  ret void
}

;============ f32

define void @test_copysign_v2f32_v2f32(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v2f32_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #128, lsl #24
; CHECK-NEXT:    ldr d1, [x0]
; CHECK-NEXT:    ldr d2, [x1]
; CHECK-NEXT:    bsl v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %ap
  %b = load <2 x float>, ptr %bp
  %r = call <2 x float> @llvm.copysign.v2f32(<2 x float> %a, <2 x float> %b)
  store <2 x float> %r, ptr %ap
  ret void
}

define void @test_copysign_v4f32_v4f32(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v4f32_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.4s, #128, lsl #24
; CHECK-NEXT:    ldr q1, [x0]
; CHECK-NEXT:    ldr q2, [x1]
; CHECK-NEXT:    bsl v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %a = load <4 x float>, ptr %ap
  %b = load <4 x float>, ptr %bp
  %r = call <4 x float> @llvm.copysign.v4f32(<4 x float> %a, <4 x float> %b)
  store <4 x float> %r, ptr %ap
  ret void
}

define void @test_copysign_v8f32_v8f32(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v8f32_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    mov z0.s, #0x7fffffff
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1w { z1.s }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %ap
  %b = load <8 x float>, ptr %bp
  %r = call <8 x float> @llvm.copysign.v8f32(<8 x float> %a, <8 x float> %b)
  store <8 x float> %r, ptr %ap
  ret void
}

define void @test_copysign_v16f32_v16f32(ptr %ap, ptr %bp) #0 {
; VBITS_GE_256-LABEL: test_copysign_v16f32_v16f32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    mov x8, #8 // =0x8
; VBITS_GE_256-NEXT:    mov z0.s, #0x7fffffff
; VBITS_GE_256-NEXT:    ld1w { z1.s }, p0/z, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z2.s }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1w { z3.s }, p0/z, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z4.s }, p0/z, [x1]
; VBITS_GE_256-NEXT:    bsl z1.d, z1.d, z3.d, z0.d
; VBITS_GE_256-NEXT:    bsl z2.d, z2.d, z4.d, z0.d
; VBITS_GE_256-NEXT:    st1w { z1.s }, p0, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z2.s }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: test_copysign_v16f32_v16f32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    mov z0.s, #0x7fffffff
; VBITS_GE_512-NEXT:    ld1w { z1.s }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1w { z2.s }, p0/z, [x1]
; VBITS_GE_512-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; VBITS_GE_512-NEXT:    st1w { z1.s }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %a = load <16 x float>, ptr %ap
  %b = load <16 x float>, ptr %bp
  %r = call <16 x float> @llvm.copysign.v16f32(<16 x float> %a, <16 x float> %b)
  store <16 x float> %r, ptr %ap
  ret void
}

define void @test_copysign_v32f32_v32f32(ptr %ap, ptr %bp) vscale_range(8,0) #0 {
; CHECK-LABEL: test_copysign_v32f32_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    mov z0.s, #0x7fffffff
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1w { z1.s }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <32 x float>, ptr %ap
  %b = load <32 x float>, ptr %bp
  %r = call <32 x float> @llvm.copysign.v32f32(<32 x float> %a, <32 x float> %b)
  store <32 x float> %r, ptr %ap
  ret void
}

define void @test_copysign_v64f32_v64f32(ptr %ap, ptr %bp) vscale_range(16,0) #0 {
; CHECK-LABEL: test_copysign_v64f32_v64f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    mov z0.s, #0x7fffffff
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1w { z1.s }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <64 x float>, ptr %ap
  %b = load <64 x float>, ptr %bp
  %r = call <64 x float> @llvm.copysign.v64f32(<64 x float> %a, <64 x float> %b)
  store <64 x float> %r, ptr %ap
  ret void
}

;============ f64

define void @test_copysign_v2f64_v2f64(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v2f64_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xffffffffffffffff
; CHECK-NEXT:    ldr q1, [x0]
; CHECK-NEXT:    ldr q2, [x1]
; CHECK-NEXT:    fneg v0.2d, v0.2d
; CHECK-NEXT:    bsl v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %ap
  %b = load <2 x double>, ptr %bp
  %r = call <2 x double> @llvm.copysign.v2f64(<2 x double> %a, <2 x double> %b)
  store <2 x double> %r, ptr %ap
  ret void
}

define void @test_copysign_v4f64_v4f64(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v4f64_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    mov z0.d, #0x7fffffffffffffff
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1d { z1.d }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <4 x double>, ptr %ap
  %b = load <4 x double>, ptr %bp
  %r = call <4 x double> @llvm.copysign.v4f64(<4 x double> %a, <4 x double> %b)
  store <4 x double> %r, ptr %ap
  ret void
}

define void @test_copysign_v8f64_v8f64(ptr %ap, ptr %bp) #0 {
; VBITS_GE_256-LABEL: test_copysign_v8f64_v8f64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    mov x8, #4 // =0x4
; VBITS_GE_256-NEXT:    mov z0.d, #0x7fffffffffffffff
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z2.d }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1d { z3.d }, p0/z, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z4.d }, p0/z, [x1]
; VBITS_GE_256-NEXT:    bsl z1.d, z1.d, z3.d, z0.d
; VBITS_GE_256-NEXT:    bsl z2.d, z2.d, z4.d, z0.d
; VBITS_GE_256-NEXT:    st1d { z1.d }, p0, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z2.d }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: test_copysign_v8f64_v8f64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    mov z0.d, #0x7fffffffffffffff
; VBITS_GE_512-NEXT:    ld1d { z1.d }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1d { z2.d }, p0/z, [x1]
; VBITS_GE_512-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; VBITS_GE_512-NEXT:    st1d { z1.d }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %a = load <8 x double>, ptr %ap
  %b = load <8 x double>, ptr %bp
  %r = call <8 x double> @llvm.copysign.v8f64(<8 x double> %a, <8 x double> %b)
  store <8 x double> %r, ptr %ap
  ret void
}

define void @test_copysign_v16f64_v16f64(ptr %ap, ptr %bp) vscale_range(8,0) #0 {
; CHECK-LABEL: test_copysign_v16f64_v16f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    mov z0.d, #0x7fffffffffffffff
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1d { z1.d }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <16 x double>, ptr %ap
  %b = load <16 x double>, ptr %bp
  %r = call <16 x double> @llvm.copysign.v16f64(<16 x double> %a, <16 x double> %b)
  store <16 x double> %r, ptr %ap
  ret void
}

define void @test_copysign_v32f64_v32f64(ptr %ap, ptr %bp) vscale_range(16,0) #0 {
; CHECK-LABEL: test_copysign_v32f64_v32f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    mov z0.d, #0x7fffffffffffffff
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [x1]
; CHECK-NEXT:    bsl z1.d, z1.d, z2.d, z0.d
; CHECK-NEXT:    st1d { z1.d }, p0, [x0]
; CHECK-NEXT:    ret
  %a = load <32 x double>, ptr %ap
  %b = load <32 x double>, ptr %bp
  %r = call <32 x double> @llvm.copysign.v32f64(<32 x double> %a, <32 x double> %b)
  store <32 x double> %r, ptr %ap
  ret void
}

;============ v2f32

define void @test_copysign_v2f32_v2f64(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v2f32_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    mvni v1.2s, #128, lsl #24
; CHECK-NEXT:    ldr d2, [x0]
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    bit v0.8b, v2.8b, v1.8b
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %ap
  %b = load <2 x double>, ptr %bp
  %tmp0 = fptrunc <2 x double> %b to <2 x float>
  %r = call <2 x float> @llvm.copysign.v2f32(<2 x float> %a, <2 x float> %tmp0)
  store <2 x float> %r, ptr %ap
  ret void
}

;============ v4f32

; SplitVecOp #1
define void @test_copysign_v4f32_v4f64(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v4f32_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    mvni v2.4s, #128, lsl #24
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x1]
; CHECK-NEXT:    fcvt z1.s, p1/m, z1.d
; CHECK-NEXT:    uzp1 z1.s, z1.s, z1.s
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %a = load <4 x float>, ptr %ap
  %b = load <4 x double>, ptr %bp
  %tmp0 = fptrunc <4 x double> %b to <4 x float>
  %r = call <4 x float> @llvm.copysign.v4f32(<4 x float> %a, <4 x float> %tmp0)
  store <4 x float> %r, ptr %ap
  ret void
}

;============ v2f64

define void @test_copysign_v2f64_v2f32(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v2f64_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xffffffffffffffff
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    fcvtl v1.2d, v1.2s
; CHECK-NEXT:    fneg v0.2d, v0.2d
; CHECK-NEXT:    bsl v0.16b, v2.16b, v1.16b
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %ap
  %b = load < 2 x float>, ptr %bp
  %tmp0 = fpext <2 x float> %b to <2 x double>
  %r = call <2 x double> @llvm.copysign.v2f64(<2 x double> %a, <2 x double> %tmp0)
  store <2 x double> %r, ptr %ap
  ret void
}

;============ v4f64

; SplitVecRes mismatched
define void @test_copysign_v4f64_v4f32(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK_NO_EXTEND_ROUND-LABEL: test_copysign_v4f64_v4f32:
; CHECK_NO_EXTEND_ROUND:       // %bb.0:
; CHECK_NO_EXTEND_ROUND-NEXT:    ptrue p0.d, vl4
; CHECK_NO_EXTEND_ROUND-NEXT:    mov z2.d, #0x7fffffffffffffff
; CHECK_NO_EXTEND_ROUND-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK_NO_EXTEND_ROUND-NEXT:    ld1w { z1.d }, p0/z, [x1]
; CHECK_NO_EXTEND_ROUND-NEXT:    fcvt z1.d, p0/m, z1.s
; CHECK_NO_EXTEND_ROUND-NEXT:    bsl z0.d, z0.d, z1.d, z2.d
; CHECK_NO_EXTEND_ROUND-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK_NO_EXTEND_ROUND-NEXT:    ret
;
; CHECK_EXTEND_ROUND-LABEL: test_copysign_v4f64_v4f32:
; CHECK_EXTEND_ROUND:       // %bb.0:
; CHECK_EXTEND_ROUND-NEXT:    ptrue p0.d, vl4
; CHECK_EXTEND_ROUND-NEXT:    mov z2.d, #0x7fffffffffffffff
; CHECK_EXTEND_ROUND-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK_EXTEND_ROUND-NEXT:    ldr q1, [x1]
; CHECK_EXTEND_ROUND-NEXT:    uunpklo z1.d, z1.s
; CHECK_EXTEND_ROUND-NEXT:    fcvt z1.d, p0/m, z1.s
; CHECK_EXTEND_ROUND-NEXT:    bsl z0.d, z0.d, z1.d, z2.d
; CHECK_EXTEND_ROUND-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK_EXTEND_ROUND-NEXT:    ret
  %a = load <4 x double>, ptr %ap
  %b = load <4 x float>, ptr %bp
  %tmp0 = fpext <4 x float> %b to <4 x double>
  %r = call <4 x double> @llvm.copysign.v4f64(<4 x double> %a, <4 x double> %tmp0)
  store <4 x double> %r, ptr %ap
  ret void
}

;============ v4f16

define void @test_copysign_v4f16_v4f32(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v4f16_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    mvni v1.4h, #128, lsl #8
; CHECK-NEXT:    ldr d2, [x0]
; CHECK-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NEXT:    bit v0.8b, v2.8b, v1.8b
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %a = load <4 x half>, ptr %ap
  %b = load <4 x float>, ptr %bp
  %tmp0 = fptrunc <4 x float> %b to <4 x half>
  %r = call <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %tmp0)
  store <4 x half> %r, ptr %ap
  ret void
}

define void @test_copysign_v4f16_v4f64(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v4f16_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    mvni v2.4h, #128, lsl #8
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x1]
; CHECK-NEXT:    fcvt z1.h, p1/m, z1.d
; CHECK-NEXT:    uzp1 z1.s, z1.s, z1.s
; CHECK-NEXT:    uzp1 z1.h, z1.h, z1.h
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %a = load <4 x half>, ptr %ap
  %b = load <4 x double>, ptr %bp
  %tmp0 = fptrunc <4 x double> %b to <4 x half>
  %r = call <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %tmp0)
  store <4 x half> %r, ptr %ap
  ret void
}

declare <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %b) #0

;============ v8f16


define void @test_copysign_v8f16_v8f32(ptr %ap, ptr %bp) vscale_range(2,0) #0 {
; CHECK-LABEL: test_copysign_v8f16_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    mvni v2.8h, #128, lsl #8
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    fcvt z1.h, p1/m, z1.s
; CHECK-NEXT:    uzp1 z1.h, z1.h, z1.h
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret
  %a = load <8 x half>, ptr %ap
  %b = load <8 x float>, ptr %bp
  %tmp0 = fptrunc <8 x float> %b to <8 x half>
  %r = call <8 x half> @llvm.copysign.v8f16(<8 x half> %a, <8 x half> %tmp0)
  store <8 x half> %r, ptr %ap
  ret void
}

declare <8 x half> @llvm.copysign.v8f16(<8 x half> %a, <8 x half> %b) #0
declare <16 x half> @llvm.copysign.v16f16(<16 x half> %a, <16 x half> %b) #0
declare <32 x half> @llvm.copysign.v32f16(<32 x half> %a, <32 x half> %b) #0
declare <64 x half> @llvm.copysign.v64f16(<64 x half> %a, <64 x half> %b) #0
declare <128 x half> @llvm.copysign.v128f16(<128 x half> %a, <128 x half> %b) #0

declare <2 x float> @llvm.copysign.v2f32(<2 x float> %a, <2 x float> %b) #0
declare <4 x float> @llvm.copysign.v4f32(<4 x float> %a, <4 x float> %b) #0
declare <8 x float> @llvm.copysign.v8f32(<8 x float> %a, <8 x float> %b) #0
declare <16 x float> @llvm.copysign.v16f32(<16 x float> %a, <16 x float> %b) #0
declare <32 x float> @llvm.copysign.v32f32(<32 x float> %a, <32 x float> %b) #0
declare <64 x float> @llvm.copysign.v64f32(<64 x float> %a, <64 x float> %b) #0

declare <2 x double> @llvm.copysign.v2f64(<2 x double> %a, <2 x double> %b) #0
declare <4 x double> @llvm.copysign.v4f64(<4 x double> %a, <4 x double> %b) #0
declare <8 x double> @llvm.copysign.v8f64(<8 x double> %a, <8 x double> %b) #0
declare <16 x double> @llvm.copysign.v16f64(<16 x double> %a, <16 x double> %b) #0
declare <32 x double> @llvm.copysign.v32f64(<32 x double> %a, <32 x double> %b) #0

attributes #0 = { "target-features"="+sve2" }
