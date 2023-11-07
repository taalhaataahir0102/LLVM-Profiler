; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 -mattr=+fullfp16,+bf16,+sve | FileCheck %s

define <8 x i8> @loadv8i8(ptr %p) {
; CHECK-LABEL: loadv8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr b0, [x0]
; CHECK-NEXT:    ret
  %l = load i8, ptr %p
  %v = insertelement <8 x i8> zeroinitializer, i8 %l, i32 0
  ret <8 x i8> %v
}

define <16 x i8> @loadv16i8(ptr %p) {
; CHECK-LABEL: loadv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr b0, [x0]
; CHECK-NEXT:    ret
  %l = load i8, ptr %p
  %v = insertelement <16 x i8> zeroinitializer, i8 %l, i32 0
  ret <16 x i8> %v
}

define <4 x i16> @loadv4i16(ptr %p) {
; CHECK-LABEL: loadv4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load i16, ptr %p
  %v = insertelement <4 x i16> zeroinitializer, i16 %l, i32 0
  ret <4 x i16> %v
}

define <8 x i16> @loadv8i16(ptr %p) {
; CHECK-LABEL: loadv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load i16, ptr %p
  %v = insertelement <8 x i16> zeroinitializer, i16 %l, i32 0
  ret <8 x i16> %v
}

define <2 x i32> @loadv2i32(ptr %p) {
; CHECK-LABEL: loadv2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ret
  %l = load i32, ptr %p
  %v = insertelement <2 x i32> zeroinitializer, i32 %l, i32 0
  ret <2 x i32> %v
}

define <4 x i32> @loadv4i32(ptr %p) {
; CHECK-LABEL: loadv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ret
  %l = load i32, ptr %p
  %v = insertelement <4 x i32> zeroinitializer, i32 %l, i32 0
  ret <4 x i32> %v
}

define <2 x i64> @loadv2i64(ptr %p) {
; CHECK-LABEL: loadv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %l = load i64, ptr %p
  %v = insertelement <2 x i64> zeroinitializer, i64 %l, i32 0
  ret <2 x i64> %v
}


define <4 x half> @loadv4f16(ptr %p) {
; CHECK-LABEL: loadv4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load half, ptr %p
  %v = insertelement <4 x half> zeroinitializer, half %l, i32 0
  ret <4 x half> %v
}

define <8 x half> @loadv8f16(ptr %p) {
; CHECK-LABEL: loadv8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load half, ptr %p
  %v = insertelement <8 x half> zeroinitializer, half %l, i32 0
  ret <8 x half> %v
}

define <4 x bfloat> @loadv4bf16(ptr %p) {
; CHECK-LABEL: loadv4bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load bfloat, ptr %p
  %v = insertelement <4 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <4 x bfloat> %v
}

define <8 x bfloat> @loadv8bf16(ptr %p) {
; CHECK-LABEL: loadv8bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load bfloat, ptr %p
  %v = insertelement <8 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <8 x bfloat> %v
}

define <2 x float> @loadv2f32(ptr %p) {
; CHECK-LABEL: loadv2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ret
  %l = load float, ptr %p
  %v = insertelement <2 x float> zeroinitializer, float %l, i32 0
  ret <2 x float> %v
}

define <4 x float> @loadv4f32(ptr %p) {
; CHECK-LABEL: loadv4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ret
  %l = load float, ptr %p
  %v = insertelement <4 x float> zeroinitializer, float %l, i32 0
  ret <4 x float> %v
}

define <2 x double> @loadv2f64(ptr %p) {
; CHECK-LABEL: loadv2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %l = load double, ptr %p
  %v = insertelement <2 x double> zeroinitializer, double %l, i32 0
  ret <2 x double> %v
}


; Unscaled

define <8 x i8> @loadv8i8_offset(ptr %p) {
; CHECK-LABEL: loadv8i8_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr b0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i8, ptr %g
  %v = insertelement <8 x i8> zeroinitializer, i8 %l, i32 0
  ret <8 x i8> %v
}

define <16 x i8> @loadv16i8_offset(ptr %p) {
; CHECK-LABEL: loadv16i8_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr b0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i8, ptr %g
  %v = insertelement <16 x i8> zeroinitializer, i8 %l, i32 0
  ret <16 x i8> %v
}

define <4 x i16> @loadv4i16_offset(ptr %p) {
; CHECK-LABEL: loadv4i16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i16, ptr %g
  %v = insertelement <4 x i16> zeroinitializer, i16 %l, i32 0
  ret <4 x i16> %v
}

define <8 x i16> @loadv8i16_offset(ptr %p) {
; CHECK-LABEL: loadv8i16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i16, ptr %g
  %v = insertelement <8 x i16> zeroinitializer, i16 %l, i32 0
  ret <8 x i16> %v
}

define <2 x i32> @loadv2i32_offset(ptr %p) {
; CHECK-LABEL: loadv2i32_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i32, ptr %g
  %v = insertelement <2 x i32> zeroinitializer, i32 %l, i32 0
  ret <2 x i32> %v
}

define <4 x i32> @loadv4i32_offset(ptr %p) {
; CHECK-LABEL: loadv4i32_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i32, ptr %g
  %v = insertelement <4 x i32> zeroinitializer, i32 %l, i32 0
  ret <4 x i32> %v
}

define <2 x i64> @loadv2i64_offset(ptr %p) {
; CHECK-LABEL: loadv2i64_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur d0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i64, ptr %g
  %v = insertelement <2 x i64> zeroinitializer, i64 %l, i32 0
  ret <2 x i64> %v
}


define <4 x half> @loadv4f16_offset(ptr %p) {
; CHECK-LABEL: loadv4f16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load half, ptr %g
  %v = insertelement <4 x half> zeroinitializer, half %l, i32 0
  ret <4 x half> %v
}

define <8 x half> @loadv8f16_offset(ptr %p) {
; CHECK-LABEL: loadv8f16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load half, ptr %g
  %v = insertelement <8 x half> zeroinitializer, half %l, i32 0
  ret <8 x half> %v
}

define <4 x bfloat> @loadv4bf16_offset(ptr %p) {
; CHECK-LABEL: loadv4bf16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load bfloat, ptr %g
  %v = insertelement <4 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <4 x bfloat> %v
}

define <8 x bfloat> @loadv8bf16_offset(ptr %p) {
; CHECK-LABEL: loadv8bf16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load bfloat, ptr %g
  %v = insertelement <8 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <8 x bfloat> %v
}

define <2 x float> @loadv2f32_offset(ptr %p) {
; CHECK-LABEL: loadv2f32_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load float, ptr %g
  %v = insertelement <2 x float> zeroinitializer, float %l, i32 0
  ret <2 x float> %v
}

define <4 x float> @loadv4f32_offset(ptr %p) {
; CHECK-LABEL: loadv4f32_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load float, ptr %g
  %v = insertelement <4 x float> zeroinitializer, float %l, i32 0
  ret <4 x float> %v
}

define <2 x double> @loadv2f64_offset(ptr %p) {
; CHECK-LABEL: loadv2f64_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur d0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load double, ptr %g
  %v = insertelement <2 x double> zeroinitializer, double %l, i32 0
  ret <2 x double> %v
}


define <8 x i8> @loadv8i8_noffset(ptr %p) {
; CHECK-LABEL: loadv8i8_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur b0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load i8, ptr %g
  %v = insertelement <8 x i8> zeroinitializer, i8 %l, i32 0
  ret <8 x i8> %v
}

define <16 x i8> @loadv16i8_noffset(ptr %p) {
; CHECK-LABEL: loadv16i8_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur b0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load i8, ptr %g
  %v = insertelement <16 x i8> zeroinitializer, i8 %l, i32 0
  ret <16 x i8> %v
}

define <4 x i16> @loadv4i16_noffset(ptr %p) {
; CHECK-LABEL: loadv4i16_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load i16, ptr %g
  %v = insertelement <4 x i16> zeroinitializer, i16 %l, i32 0
  ret <4 x i16> %v
}

define <8 x i16> @loadv8i16_noffset(ptr %p) {
; CHECK-LABEL: loadv8i16_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load i16, ptr %g
  %v = insertelement <8 x i16> zeroinitializer, i16 %l, i32 0
  ret <8 x i16> %v
}

define <2 x i32> @loadv2i32_noffset(ptr %p) {
; CHECK-LABEL: loadv2i32_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load i32, ptr %g
  %v = insertelement <2 x i32> zeroinitializer, i32 %l, i32 0
  ret <2 x i32> %v
}

define <4 x i32> @loadv4i32_noffset(ptr %p) {
; CHECK-LABEL: loadv4i32_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load i32, ptr %g
  %v = insertelement <4 x i32> zeroinitializer, i32 %l, i32 0
  ret <4 x i32> %v
}

define <2 x i64> @loadv2i64_noffset(ptr %p) {
; CHECK-LABEL: loadv2i64_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur d0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load i64, ptr %g
  %v = insertelement <2 x i64> zeroinitializer, i64 %l, i32 0
  ret <2 x i64> %v
}


define <4 x half> @loadv4f16_noffset(ptr %p) {
; CHECK-LABEL: loadv4f16_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load half, ptr %g
  %v = insertelement <4 x half> zeroinitializer, half %l, i32 0
  ret <4 x half> %v
}

define <8 x half> @loadv8f16_noffset(ptr %p) {
; CHECK-LABEL: loadv8f16_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load half, ptr %g
  %v = insertelement <8 x half> zeroinitializer, half %l, i32 0
  ret <8 x half> %v
}

define <4 x bfloat> @loadv4bf16_noffset(ptr %p) {
; CHECK-LABEL: loadv4bf16_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load bfloat, ptr %g
  %v = insertelement <4 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <4 x bfloat> %v
}

define <8 x bfloat> @loadv8bf16_noffset(ptr %p) {
; CHECK-LABEL: loadv8bf16_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load bfloat, ptr %g
  %v = insertelement <8 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <8 x bfloat> %v
}

define <2 x float> @loadv2f32_noffset(ptr %p) {
; CHECK-LABEL: loadv2f32_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load float, ptr %g
  %v = insertelement <2 x float> zeroinitializer, float %l, i32 0
  ret <2 x float> %v
}

define <4 x float> @loadv4f32_noffset(ptr %p) {
; CHECK-LABEL: loadv4f32_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load float, ptr %g
  %v = insertelement <4 x float> zeroinitializer, float %l, i32 0
  ret <4 x float> %v
}

define <2 x double> @loadv2f64_noffset(ptr %p) {
; CHECK-LABEL: loadv2f64_noffset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur d0, [x0, #-1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 -1
  %l = load double, ptr %g
  %v = insertelement <2 x double> zeroinitializer, double %l, i32 0
  ret <2 x double> %v
}


define void @predictor_4x4_neon(ptr nocapture noundef writeonly %0, i64 noundef %1, ptr nocapture noundef readonly %2, ptr nocapture noundef readnone %3) {
; CHECK-LABEL: predictor_4x4_neon:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    ldur w8, [x2, #2]
; CHECK-NEXT:    ldr s1, [x2]
; CHECK-NEXT:    ldur s2, [x2, #1]
; CHECK-NEXT:    ushll v3.8h, v2.8b, #1
; CHECK-NEXT:    mov v0.s[0], w8
; CHECK-NEXT:    lsr w8, w8, #24
; CHECK-NEXT:    uaddl v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    urhadd v1.8b, v1.8b, v2.8b
; CHECK-NEXT:    str s1, [x0]
; CHECK-NEXT:    add v0.8h, v0.8h, v3.8h
; CHECK-NEXT:    dup v3.8b, w8
; CHECK-NEXT:    lsl x8, x1, #1
; CHECK-NEXT:    rshrn v0.8b, v0.8h, #2
; CHECK-NEXT:    zip1 v2.2s, v1.2s, v3.2s
; CHECK-NEXT:    str s0, [x0, x1]
; CHECK-NEXT:    zip1 v3.2s, v0.2s, v3.2s
; CHECK-NEXT:    ext v2.8b, v2.8b, v0.8b, #1
; CHECK-NEXT:    str s2, [x0, x8]
; CHECK-NEXT:    add x8, x8, x1
; CHECK-NEXT:    ext v1.8b, v3.8b, v0.8b, #1
; CHECK-NEXT:    str s1, [x0, x8]
; CHECK-NEXT:    ret
  %5 = load i32, ptr %2, align 4
  %6 = insertelement <2 x i32> <i32 poison, i32 0>, i32 %5, i64 0
  %7 = bitcast <2 x i32> %6 to <8 x i8>
  %8 = getelementptr inbounds i8, ptr %2, i64 1
  %9 = load i32, ptr %8, align 4
  %10 = insertelement <2 x i32> <i32 poison, i32 0>, i32 %9, i64 0
  %11 = bitcast <2 x i32> %10 to <8 x i8>
  %12 = getelementptr inbounds i8, ptr %2, i64 2
  %13 = load i32, ptr %12, align 4
  %14 = insertelement <2 x i32> <i32 poison, i32 0>, i32 %13, i64 0
  %15 = bitcast <2 x i32> %14 to <8 x i8>
  %16 = lshr i32 %13, 24
  %17 = trunc i32 %16 to i8
  %18 = insertelement <8 x i8> undef, i8 %17, i64 0
  %19 = shufflevector <8 x i8> %18, <8 x i8> poison, <8 x i32> zeroinitializer
  %20 = tail call <8 x i8> @llvm.aarch64.neon.urhadd.v8i8(<8 x i8> %7, <8 x i8> %11)
  %21 = zext <8 x i8> %7 to <8 x i16>
  %22 = zext <8 x i8> %11 to <8 x i16>
  %23 = zext <8 x i8> %15 to <8 x i16>
  %24 = shl nuw nsw <8 x i16> %22, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %25 = add nuw nsw <8 x i16> %23, %21
  %26 = add nuw nsw <8 x i16> %25, %24
  %27 = tail call <8 x i8> @llvm.aarch64.neon.rshrn.v8i8(<8 x i16> %26, i32 2)
  %28 = bitcast <8 x i8> %20 to <2 x i32>
  %29 = extractelement <2 x i32> %28, i64 0
  store i32 %29, ptr %0, align 4
  %30 = bitcast <8 x i8> %27 to <2 x i32>
  %31 = getelementptr inbounds i8, ptr %0, i64 %1
  %32 = extractelement <2 x i32> %30, i64 0
  store i32 %32, ptr %31, align 4
  %33 = bitcast <8 x i8> %19 to <2 x i32>
  %34 = shufflevector <2 x i32> %28, <2 x i32> %33, <2 x i32> <i32 0, i32 2>
  %35 = bitcast <2 x i32> %34 to <8 x i8>
  %36 = shufflevector <2 x i32> %30, <2 x i32> %33, <2 x i32> <i32 0, i32 2>
  %37 = bitcast <2 x i32> %36 to <8 x i8>
  %38 = shufflevector <8 x i8> %35, <8 x i8> poison, <8 x i32> <i32 1, i32 2, i32 3, i32 4, i32 undef, i32 undef, i32 undef, i32 undef>
  %39 = bitcast <8 x i8> %38 to <2 x i32>
  %40 = shl nsw i64 %1, 1
  %41 = getelementptr inbounds i8, ptr %0, i64 %40
  %42 = extractelement <2 x i32> %39, i64 0
  store i32 %42, ptr %41, align 4
  %43 = shufflevector <8 x i8> %37, <8 x i8> poison, <8 x i32> <i32 1, i32 2, i32 3, i32 4, i32 undef, i32 undef, i32 undef, i32 undef>
  %44 = bitcast <8 x i8> %43 to <2 x i32>
  %45 = mul nsw i64 %1, 3
  %46 = getelementptr inbounds i8, ptr %0, i64 %45
  %47 = extractelement <2 x i32> %44, i64 0
  store i32 %47, ptr %46, align 4
  ret void
}

define void @predictor_4x4_neon_new(ptr nocapture noundef writeonly %0, i64 noundef %1, ptr nocapture noundef readonly %2, ptr nocapture noundef readnone %3) {
; CHECK-LABEL: predictor_4x4_neon_new:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x2]
; CHECK-NEXT:    ldur s1, [x2, #1]
; CHECK-NEXT:    lsl x8, x1, #1
; CHECK-NEXT:    ldur s2, [x2, #2]
; CHECK-NEXT:    ldur s3, [x2, #3]
; CHECK-NEXT:    uaddl v4.8h, v1.8b, v0.8b
; CHECK-NEXT:    urhadd v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    add x9, x8, x1
; CHECK-NEXT:    uaddl v5.8h, v2.8b, v1.8b
; CHECK-NEXT:    uaddl v3.8h, v3.8b, v2.8b
; CHECK-NEXT:    urhadd v1.8b, v1.8b, v2.8b
; CHECK-NEXT:    str s0, [x0]
; CHECK-NEXT:    add v4.8h, v4.8h, v5.8h
; CHECK-NEXT:    add v3.8h, v3.8h, v5.8h
; CHECK-NEXT:    rshrn v4.8b, v4.8h, #2
; CHECK-NEXT:    rshrn v0.8b, v3.8h, #2
; CHECK-NEXT:    str s4, [x0, x1]
; CHECK-NEXT:    str s1, [x0, x8]
; CHECK-NEXT:    str s0, [x0, x9]
; CHECK-NEXT:    ret
  %5 = load i32, ptr %2, align 4
  %6 = insertelement <2 x i32> <i32 poison, i32 0>, i32 %5, i64 0
  %7 = bitcast <2 x i32> %6 to <8 x i8>
  %8 = getelementptr inbounds i8, ptr %2, i64 1
  %9 = load i32, ptr %8, align 4
  %10 = insertelement <2 x i32> <i32 poison, i32 0>, i32 %9, i64 0
  %11 = bitcast <2 x i32> %10 to <8 x i8>
  %12 = getelementptr inbounds i8, ptr %2, i64 2
  %13 = load i32, ptr %12, align 4
  %14 = insertelement <2 x i32> <i32 poison, i32 0>, i32 %13, i64 0
  %15 = bitcast <2 x i32> %14 to <8 x i8>
  %16 = getelementptr inbounds i8, ptr %2, i64 3
  %17 = load i32, ptr %16, align 4
  %18 = insertelement <2 x i32> <i32 poison, i32 0>, i32 %17, i64 0
  %19 = bitcast <2 x i32> %18 to <8 x i8>
  %20 = tail call <8 x i8> @llvm.aarch64.neon.urhadd.v8i8(<8 x i8> %7, <8 x i8> %11)
  %21 = tail call <8 x i8> @llvm.aarch64.neon.urhadd.v8i8(<8 x i8> %11, <8 x i8> %15)
  %22 = zext <8 x i8> %7 to <8 x i16>
  %23 = zext <8 x i8> %11 to <8 x i16>
  %24 = add nuw nsw <8 x i16> %23, %22
  %25 = zext <8 x i8> %15 to <8 x i16>
  %26 = add nuw nsw <8 x i16> %25, %23
  %27 = add nuw nsw <8 x i16> %24, %26
  %28 = tail call <8 x i8> @llvm.aarch64.neon.rshrn.v8i8(<8 x i16> %27, i32 2)
  %29 = zext <8 x i8> %19 to <8 x i16>
  %30 = add nuw nsw <8 x i16> %29, %25
  %31 = add nuw nsw <8 x i16> %30, %26
  %32 = tail call <8 x i8> @llvm.aarch64.neon.rshrn.v8i8(<8 x i16> %31, i32 2)
  %33 = bitcast <8 x i8> %20 to <2 x i32>
  %34 = extractelement <2 x i32> %33, i64 0
  store i32 %34, ptr %0, align 4
  %35 = bitcast <8 x i8> %28 to <2 x i32>
  %36 = getelementptr inbounds i8, ptr %0, i64 %1
  %37 = extractelement <2 x i32> %35, i64 0
  store i32 %37, ptr %36, align 4
  %38 = bitcast <8 x i8> %21 to <2 x i32>
  %39 = shl nsw i64 %1, 1
  %40 = getelementptr inbounds i8, ptr %0, i64 %39
  %41 = extractelement <2 x i32> %38, i64 0
  store i32 %41, ptr %40, align 4
  %42 = bitcast <8 x i8> %32 to <2 x i32>
  %43 = mul nsw i64 %1, 3
  %44 = getelementptr inbounds i8, ptr %0, i64 %43
  %45 = extractelement <2 x i32> %42, i64 0
  store i32 %45, ptr %44, align 4
  ret void
}


define <vscale x 8 x i8> @loadnxv8i8(ptr %p) {
; CHECK-LABEL: loadnxv8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl1
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ldrb w8, [x0]
; CHECK-NEXT:    mov z0.h, p0/m, w8
; CHECK-NEXT:    ret
  %l = load i8, ptr %p
  %v = insertelement <vscale x 8 x i8> zeroinitializer, i8 %l, i32 0
  ret <vscale x 8 x i8> %v
}

define <vscale x 16 x i8> @loadnxv16i8(ptr %p) {
; CHECK-LABEL: loadnxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr b0, [x0]
; CHECK-NEXT:    ret
  %l = load i8, ptr %p
  %v = insertelement <vscale x 16 x i8> zeroinitializer, i8 %l, i32 0
  ret <vscale x 16 x i8> %v
}

define <vscale x 4 x i16> @loadnxv4i16(ptr %p) {
; CHECK-LABEL: loadnxv4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl1
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    ldrh w8, [x0]
; CHECK-NEXT:    mov z0.s, p0/m, w8
; CHECK-NEXT:    ret
  %l = load i16, ptr %p
  %v = insertelement <vscale x 4 x i16> zeroinitializer, i16 %l, i32 0
  ret <vscale x 4 x i16> %v
}

define <vscale x 8 x i16> @loadnxv8i16(ptr %p) {
; CHECK-LABEL: loadnxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load i16, ptr %p
  %v = insertelement <vscale x 8 x i16> zeroinitializer, i16 %l, i32 0
  ret <vscale x 8 x i16> %v
}

define <vscale x 2 x i32> @loadnxv2i32(ptr %p) {
; CHECK-LABEL: loadnxv2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    mov z0.d, #0 // =0x0
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    mov z0.d, p0/m, x8
; CHECK-NEXT:    ret
  %l = load i32, ptr %p
  %v = insertelement <vscale x 2 x i32> zeroinitializer, i32 %l, i32 0
  ret <vscale x 2 x i32> %v
}

define <vscale x 4 x i32> @loadnxv4i32(ptr %p) {
; CHECK-LABEL: loadnxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ret
  %l = load i32, ptr %p
  %v = insertelement <vscale x 4 x i32> zeroinitializer, i32 %l, i32 0
  ret <vscale x 4 x i32> %v
}

define <vscale x 2 x i64> @loadnxv2i64(ptr %p) {
; CHECK-LABEL: loadnxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %l = load i64, ptr %p
  %v = insertelement <vscale x 2 x i64> zeroinitializer, i64 %l, i32 0
  ret <vscale x 2 x i64> %v
}


define <vscale x 4 x half> @loadnxv4f16(ptr %p) {
; CHECK-LABEL: loadnxv4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov w8, wzr
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ldr h1, [x0]
; CHECK-NEXT:    mov z0.h, p0/m, h1
; CHECK-NEXT:    ret
  %l = load half, ptr %p
  %v = insertelement <vscale x 4 x half> zeroinitializer, half %l, i32 0
  ret <vscale x 4 x half> %v
}

define <vscale x 8 x half> @loadnxv8f16(ptr %p) {
; CHECK-LABEL: loadnxv8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load half, ptr %p
  %v = insertelement <vscale x 8 x half> zeroinitializer, half %l, i32 0
  ret <vscale x 8 x half> %v
}

define <vscale x 4 x bfloat> @loadnxv4bf16(ptr %p) {
; CHECK-LABEL: loadnxv4bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov w8, wzr
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ldr h1, [x0]
; CHECK-NEXT:    mov z0.h, p0/m, h1
; CHECK-NEXT:    ret
  %l = load bfloat, ptr %p
  %v = insertelement <vscale x 4 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <vscale x 4 x bfloat> %v
}

define <vscale x 8 x bfloat> @loadnxv8bf16(ptr %p) {
; CHECK-LABEL: loadnxv8bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr h0, [x0]
; CHECK-NEXT:    ret
  %l = load bfloat, ptr %p
  %v = insertelement <vscale x 8 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <vscale x 8 x bfloat> %v
}

define <vscale x 2 x float> @loadnxv2f32(ptr %p) {
; CHECK-LABEL: loadnxv2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    index z0.d, #0, #1
; CHECK-NEXT:    mov z1.d, x8
; CHECK-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    ldr s1, [x0]
; CHECK-NEXT:    mov z0.s, p0/m, s1
; CHECK-NEXT:    ret
  %l = load float, ptr %p
  %v = insertelement <vscale x 2 x float> zeroinitializer, float %l, i32 0
  ret <vscale x 2 x float> %v
}

define <vscale x 4 x float> @loadnxv4f32(ptr %p) {
; CHECK-LABEL: loadnxv4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr s0, [x0]
; CHECK-NEXT:    ret
  %l = load float, ptr %p
  %v = insertelement <vscale x 4 x float> zeroinitializer, float %l, i32 0
  ret <vscale x 4 x float> %v
}

define <vscale x 2 x double> @loadnxv2f64(ptr %p) {
; CHECK-LABEL: loadnxv2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ret
  %l = load double, ptr %p
  %v = insertelement <vscale x 2 x double> zeroinitializer, double %l, i32 0
  ret <vscale x 2 x double> %v
}


; Unscaled

define <vscale x 8 x i8> @loadnxv8i8_offset(ptr %p) {
; CHECK-LABEL: loadnxv8i8_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl1
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ldrb w8, [x0, #1]
; CHECK-NEXT:    mov z0.h, p0/m, w8
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i8, ptr %g
  %v = insertelement <vscale x 8 x i8> zeroinitializer, i8 %l, i32 0
  ret <vscale x 8 x i8> %v
}

define <vscale x 16 x i8> @loadnxv16i8_offset(ptr %p) {
; CHECK-LABEL: loadnxv16i8_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr b0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i8, ptr %g
  %v = insertelement <vscale x 16 x i8> zeroinitializer, i8 %l, i32 0
  ret <vscale x 16 x i8> %v
}

define <vscale x 4 x i16> @loadnxv4i16_offset(ptr %p) {
; CHECK-LABEL: loadnxv4i16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl1
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    ldurh w8, [x0, #1]
; CHECK-NEXT:    mov z0.s, p0/m, w8
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i16, ptr %g
  %v = insertelement <vscale x 4 x i16> zeroinitializer, i16 %l, i32 0
  ret <vscale x 4 x i16> %v
}

define <vscale x 8 x i16> @loadnxv8i16_offset(ptr %p) {
; CHECK-LABEL: loadnxv8i16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i16, ptr %g
  %v = insertelement <vscale x 8 x i16> zeroinitializer, i16 %l, i32 0
  ret <vscale x 8 x i16> %v
}

define <vscale x 2 x i32> @loadnxv2i32_offset(ptr %p) {
; CHECK-LABEL: loadnxv2i32_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    mov z0.d, #0 // =0x0
; CHECK-NEXT:    ldur w8, [x0, #1]
; CHECK-NEXT:    mov z0.d, p0/m, x8
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i32, ptr %g
  %v = insertelement <vscale x 2 x i32> zeroinitializer, i32 %l, i32 0
  ret <vscale x 2 x i32> %v
}

define <vscale x 4 x i32> @loadnxv4i32_offset(ptr %p) {
; CHECK-LABEL: loadnxv4i32_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i32, ptr %g
  %v = insertelement <vscale x 4 x i32> zeroinitializer, i32 %l, i32 0
  ret <vscale x 4 x i32> %v
}

define <vscale x 2 x i64> @loadnxv2i64_offset(ptr %p) {
; CHECK-LABEL: loadnxv2i64_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur d0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load i64, ptr %g
  %v = insertelement <vscale x 2 x i64> zeroinitializer, i64 %l, i32 0
  ret <vscale x 2 x i64> %v
}


define <vscale x 4 x half> @loadnxv4f16_offset(ptr %p) {
; CHECK-LABEL: loadnxv4f16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov w8, wzr
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ldur h1, [x0, #1]
; CHECK-NEXT:    mov z0.h, p0/m, h1
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load half, ptr %g
  %v = insertelement <vscale x 4 x half> zeroinitializer, half %l, i32 0
  ret <vscale x 4 x half> %v
}

define <vscale x 8 x half> @loadnxv8f16_offset(ptr %p) {
; CHECK-LABEL: loadnxv8f16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load half, ptr %g
  %v = insertelement <vscale x 8 x half> zeroinitializer, half %l, i32 0
  ret <vscale x 8 x half> %v
}

define <vscale x 4 x bfloat> @loadnxv4bf16_offset(ptr %p) {
; CHECK-LABEL: loadnxv4bf16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov w8, wzr
; CHECK-NEXT:    index z0.s, #0, #1
; CHECK-NEXT:    mov z1.s, w8
; CHECK-NEXT:    cmpeq p0.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ldur h1, [x0, #1]
; CHECK-NEXT:    mov z0.h, p0/m, h1
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load bfloat, ptr %g
  %v = insertelement <vscale x 4 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <vscale x 4 x bfloat> %v
}

define <vscale x 8 x bfloat> @loadnxv8bf16_offset(ptr %p) {
; CHECK-LABEL: loadnxv8bf16_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur h0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load bfloat, ptr %g
  %v = insertelement <vscale x 8 x bfloat> zeroinitializer, bfloat %l, i32 0
  ret <vscale x 8 x bfloat> %v
}

define <vscale x 2 x float> @loadnxv2f32_offset(ptr %p) {
; CHECK-LABEL: loadnxv2f32_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:    index z0.d, #0, #1
; CHECK-NEXT:    mov z1.d, x8
; CHECK-NEXT:    cmpeq p0.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    ldur s1, [x0, #1]
; CHECK-NEXT:    mov z0.s, p0/m, s1
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load float, ptr %g
  %v = insertelement <vscale x 2 x float> zeroinitializer, float %l, i32 0
  ret <vscale x 2 x float> %v
}

define <vscale x 4 x float> @loadnxv4f32_offset(ptr %p) {
; CHECK-LABEL: loadnxv4f32_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur s0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load float, ptr %g
  %v = insertelement <vscale x 4 x float> zeroinitializer, float %l, i32 0
  ret <vscale x 4 x float> %v
}

define <vscale x 2 x double> @loadnxv2f64_offset(ptr %p) {
; CHECK-LABEL: loadnxv2f64_offset:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldur d0, [x0, #1]
; CHECK-NEXT:    ret
  %g = getelementptr inbounds i8, ptr %p, i64 1
  %l = load double, ptr %g
  %v = insertelement <vscale x 2 x double> zeroinitializer, double %l, i32 0
  ret <vscale x 2 x double> %v
}


declare <8 x i8> @llvm.aarch64.neon.rshrn.v8i8(<8 x i16>, i32) #1
declare <8 x i8> @llvm.aarch64.neon.urhadd.v8i8(<8 x i8>, <8 x i8>) #1
