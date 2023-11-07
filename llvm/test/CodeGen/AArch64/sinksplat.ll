; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -o - %s | FileCheck %s

define <4 x i32> @smull(<4 x i16> %x, ptr %y) {
; CHECK-LABEL: smull:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov d1, d0
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:  .LBB0_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr d2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    smlal v0.4s, v2.4h, v1.h[3]
; CHECK-NEXT:    b.eq .LBB0_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i16> %x, <4 x i16> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x i32> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x i16>, ptr %y
  %b = tail call <4 x i32> @llvm.aarch64.neon.smull.v4i32(<4 x i16> %l, <4 x i16> %a)
  %c = add nsw <4 x i32> %q, %b
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x i32> %c
}

define <4 x i32> @umull(<4 x i16> %x, ptr %y) {
; CHECK-LABEL: umull:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov d1, d0
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:  .LBB1_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr d2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    umlal v0.4s, v2.4h, v1.h[3]
; CHECK-NEXT:    b.eq .LBB1_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i16> %x, <4 x i16> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x i32> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x i16>, ptr %y
  %b = tail call <4 x i32> @llvm.aarch64.neon.umull.v4i32(<4 x i16> %l, <4 x i16> %a)
  %c = add nsw <4 x i32> %q, %b
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x i32> %c
}

define <4 x i32> @sqadd(<4 x i32> %x, ptr %y) {
; CHECK-LABEL: sqadd:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov v1.16b, v0.16b
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:  .LBB2_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    sqrdmulh v2.4s, v2.4s, v1.s[3]
; CHECK-NEXT:    sqadd v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    b.eq .LBB2_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i32> %x, <4 x i32> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x i32> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x i32>, ptr %y
  %b = tail call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %l, <4 x i32> %a)
  %c = tail call <4 x i32> @llvm.aarch64.neon.sqadd.v4i32(<4 x i32> %q, <4 x i32> %b)
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x i32> %c
}

define <4 x i32> @sqsub(<4 x i32> %x, ptr %y) {
; CHECK-LABEL: sqsub:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov v1.16b, v0.16b
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:  .LBB3_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    sqrdmulh v2.4s, v2.4s, v1.s[3]
; CHECK-NEXT:    sqsub v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    b.eq .LBB3_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i32> %x, <4 x i32> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x i32> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x i32>, ptr %y
  %b = tail call <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32> %l, <4 x i32> %a)
  %c = tail call <4 x i32> @llvm.aarch64.neon.sqsub.v4i32(<4 x i32> %q, <4 x i32> %b)
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x i32> %c
}

define <4 x i32> @sqdmulh(<4 x i32> %x, ptr %y) {
; CHECK-LABEL: sqdmulh:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov v1.16b, v0.16b
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:  .LBB4_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    sqdmulh v2.4s, v2.4s, v1.s[3]
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    b.eq .LBB4_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i32> %x, <4 x i32> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x i32> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x i32>, ptr %y
  %b = tail call <4 x i32> @llvm.aarch64.neon.sqdmulh.v4i32(<4 x i32> %l, <4 x i32> %a)
  %c = add nsw <4 x i32> %q, %b
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x i32> %c
}

define <4 x i32> @sqdmull(<4 x i16> %x, ptr %y) {
; CHECK-LABEL: sqdmull:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov d1, d0
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:  .LBB5_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr d2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    sqdmull v2.4s, v2.4h, v1.h[3]
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    b.eq .LBB5_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i16> %x, <4 x i16> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x i32> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x i16>, ptr %y
  %b = tail call <4 x i32> @llvm.aarch64.neon.sqdmull.v4i32(<4 x i16> %l, <4 x i16> %a)
  %c = add nsw <4 x i32> %q, %b
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x i32> %c
}

define <4 x i32> @mlal(<4 x i32> %x, ptr %y) {
; CHECK-LABEL: mlal:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov v1.16b, v0.16b
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    dup v1.4s, v1.s[3]
; CHECK-NEXT:  .LBB6_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    mla v0.4s, v2.4s, v1.4s
; CHECK-NEXT:    b.eq .LBB6_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i32> %x, <4 x i32> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x i32> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x i32>, ptr %y
  %b = mul <4 x i32> %l, %a
  %c = add <4 x i32> %q, %b
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x i32> %c
}

define <4 x float> @fmul(<4 x float> %x, ptr %y) {
; CHECK-LABEL: fmul:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov v1.16b, v0.16b
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:  .LBB7_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    fmul v2.4s, v2.4s, v1.s[3]
; CHECK-NEXT:    fadd v0.4s, v2.4s, v0.4s
; CHECK-NEXT:    b.eq .LBB7_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x float> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x float>, ptr %y
  %b = fmul <4 x float> %l, %a
  %c = fadd <4 x float> %b, %q
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x float> %c
}

define <4 x float> @fmuladd(<4 x float> %x, ptr %y) {
; CHECK-LABEL: fmuladd:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov v1.16b, v0.16b
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    dup v1.4s, v1.s[3]
; CHECK-NEXT:  .LBB8_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    fmla v0.4s, v1.4s, v2.4s
; CHECK-NEXT:    b.eq .LBB8_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x float> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x float>, ptr %y
  %b = fmul fast <4 x float> %l, %a
  %c = fadd fast <4 x float> %b, %q
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x float> %c
}

define <4 x float> @fma(<4 x float> %x, ptr %y) {
; CHECK-LABEL: fma:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov v1.16b, v0.16b
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    dup v1.4s, v1.s[3]
; CHECK-NEXT:  .LBB9_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    mov v3.16b, v0.16b
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    fmla v0.4s, v3.4s, v2.4s
; CHECK-NEXT:    b.eq .LBB9_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x float> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x float>, ptr %y
  %c = tail call <4 x float> @llvm.fma.v4f32(<4 x float> %l, <4 x float> %q, <4 x float> %a)
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x float> %c
}

define <4 x i32> @smull_nonsplat(<4 x i16> %x, ptr %y) {
; CHECK-LABEL: smull_nonsplat:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov d1, d0
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    trn2 v2.4h, v1.4h, v1.4h
; CHECK-NEXT:    zip2 v1.4h, v2.4h, v1.4h
; CHECK-NEXT:  .LBB10_1: // %l1
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr d2, [x0]
; CHECK-NEXT:    subs w8, w8, #1
; CHECK-NEXT:    smlal v0.4s, v2.4h, v1.4h
; CHECK-NEXT:    b.eq .LBB10_1
; CHECK-NEXT:  // %bb.2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i16> %x, <4 x i16> undef, <4 x i32> <i32 3, i32 2, i32 3, i32 3>
  br label %l1

l1:
  %p = phi i32 [ 0, %entry ], [ %pa, %l1 ]
  %q = phi <4 x i32> [ zeroinitializer, %entry ], [ %c, %l1 ]
  %l = load <4 x i16>, ptr %y
  %b = tail call <4 x i32> @llvm.aarch64.neon.smull.v4i32(<4 x i16> %l, <4 x i16> %a)
  %c = add nsw <4 x i32> %q, %b
  %pa = add i32 %p, 1
  %c1 = icmp eq i32 %p, 0
  br i1 %c1, label %l1, label %l2

l2:
  ret <4 x i32> %c
}

define <4 x i32> @smull_splat_and_extract(<4 x i16> %x, <8 x i16> %l, ptr %y, i1 %co) {
; CHECK-LABEL: smull_splat_and_extract:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov d2, d0
; CHECK-NEXT:    smull v0.4s, v1.4h, v2.h[3]
; CHECK-NEXT:    tbz w1, #0, .LBB11_2
; CHECK-NEXT:  // %bb.1: // %l1
; CHECK-NEXT:    smlal2 v0.4s, v1.8h, v2.h[3]
; CHECK-NEXT:  .LBB11_2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i16> %x, <4 x i16> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %e1 = shufflevector <8 x i16> %l, <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %e2 = shufflevector <8 x i16> %l, <8 x i16> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %b = tail call <4 x i32> @llvm.aarch64.neon.smull.v4i32(<4 x i16> %e1, <4 x i16> %a)
  br i1 %co, label %l1, label %l2

l1:
  %b2 = tail call <4 x i32> @llvm.aarch64.neon.smull.v4i32(<4 x i16> %e2, <4 x i16> %a)
  %c2 = add nsw <4 x i32> %b, %b2
  br label %l2

l2:
  %r = phi <4 x i32> [ %b, %entry ], [ %c2, %l1 ]
  ret <4 x i32> %r
}

define <4 x i32> @umull_splat_and_extract(<4 x i16> %x, <8 x i16> %l, ptr %y, i1 %co) {
; CHECK-LABEL: umull_splat_and_extract:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmov d2, d0
; CHECK-NEXT:    umull v0.4s, v1.4h, v2.h[3]
; CHECK-NEXT:    tbz w1, #0, .LBB12_2
; CHECK-NEXT:  // %bb.1: // %l1
; CHECK-NEXT:    umlal2 v0.4s, v1.8h, v2.h[3]
; CHECK-NEXT:  .LBB12_2: // %l2
; CHECK-NEXT:    ret
entry:
  %a = shufflevector <4 x i16> %x, <4 x i16> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %e1 = shufflevector <8 x i16> %l, <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %e2 = shufflevector <8 x i16> %l, <8 x i16> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %b = tail call <4 x i32> @llvm.aarch64.neon.umull.v4i32(<4 x i16> %e1, <4 x i16> %a)
  br i1 %co, label %l1, label %l2

l1:
  %b2 = tail call <4 x i32> @llvm.aarch64.neon.umull.v4i32(<4 x i16> %e2, <4 x i16> %a)
  %c2 = add nsw <4 x i32> %b, %b2
  br label %l2

l2:
  %r = phi <4 x i32> [ %b, %entry ], [ %c2, %l1 ]
  ret <4 x i32> %r
}


declare <4 x i32> @llvm.aarch64.neon.smull.v4i32(<4 x i16>, <4 x i16>)
declare <4 x i32> @llvm.aarch64.neon.umull.v4i32(<4 x i16>, <4 x i16>)
declare <4 x i32> @llvm.aarch64.neon.sqadd.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.aarch64.neon.sqsub.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.aarch64.neon.sqrdmulh.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.aarch64.neon.sqdmull.v4i32(<4 x i16>, <4 x i16>)
declare <4 x i32> @llvm.aarch64.neon.sqdmulh.v4i32(<4 x i32>, <4 x i32>)
declare <4 x float> @llvm.fma.v4f32(<4 x float> %l, <4 x float> %a, <4 x float> %q)
