; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=thumbv7k-linux-gnu | FileCheck %s

declare {<2 x i64>, <2 x i1>} @llvm.uadd.with.overflow.v2i64(<2 x i64>, <2 x i64>)
declare {<2 x i64>, <2 x i1>} @llvm.usub.with.overflow.v2i64(<2 x i64>, <2 x i64>)
declare {<2 x i64>, <2 x i1>} @llvm.sadd.with.overflow.v2i64(<2 x i64>, <2 x i64>)
declare {<2 x i64>, <2 x i1>} @llvm.ssub.with.overflow.v2i64(<2 x i64>, <2 x i64>)

define <2 x i1> @uaddo(ptr %ptr, ptr %ptr2) {
; CHECK-LABEL: uaddo:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r4, r5, r6, r7, lr}
; CHECK-NEXT:    vld1.64 {d18, d19}, [r0]
; CHECK-NEXT:    vld1.64 {d16, d17}, [r1]
; CHECK-NEXT:    vmov r3, r2, d18
; CHECK-NEXT:    vadd.i64 q8, q9, q8
; CHECK-NEXT:    movs r1, #0
; CHECK-NEXT:    vmov r6, r7, d19
; CHECK-NEXT:    vmov lr, r12, d16
; CHECK-NEXT:    vmov r4, r5, d17
; CHECK-NEXT:    subs.w r3, lr, r3
; CHECK-NEXT:    sbcs.w r2, r12, r2
; CHECK-NEXT:    mov.w r2, #0
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    it ne
; CHECK-NEXT:    movne.w r2, #-1
; CHECK-NEXT:    subs r3, r4, r6
; CHECK-NEXT:    sbcs.w r3, r5, r7
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    it ne
; CHECK-NEXT:    movne.w r1, #-1
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    pop {r4, r5, r6, r7, pc}
  %x = load <2 x i64>, ptr %ptr, align 8
  %y = load <2 x i64>, ptr %ptr2, align 8
  %s = call {<2 x i64>, <2 x i1>} @llvm.uadd.with.overflow.v2i64(<2 x i64> %x, <2 x i64> %y)
  %m = extractvalue {<2 x i64>, <2 x i1>} %s, 0
  %o = extractvalue {<2 x i64>, <2 x i1>} %s, 1
  store <2 x i64> %m, ptr %ptr
  ret <2 x i1> %o
}

define <2 x i1> @usubo(ptr %ptr, ptr %ptr2) {
; CHECK-LABEL: usubo:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    push {r4, r5, r6, r7, lr}
; CHECK-NEXT:    vld1.64 {d16, d17}, [r1]
; CHECK-NEXT:    movs r1, #0
; CHECK-NEXT:    vld1.64 {d18, d19}, [r0]
; CHECK-NEXT:    vsub.i64 q8, q9, q8
; CHECK-NEXT:    vmov lr, r12, d18
; CHECK-NEXT:    vmov r4, r5, d19
; CHECK-NEXT:    vmov r3, r2, d16
; CHECK-NEXT:    vmov r6, r7, d17
; CHECK-NEXT:    subs.w r3, lr, r3
; CHECK-NEXT:    sbcs.w r2, r12, r2
; CHECK-NEXT:    mov.w r2, #0
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r2, #1
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    it ne
; CHECK-NEXT:    movne.w r2, #-1
; CHECK-NEXT:    subs r3, r4, r6
; CHECK-NEXT:    sbcs.w r3, r5, r7
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r1, #1
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    it ne
; CHECK-NEXT:    movne.w r1, #-1
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    pop {r4, r5, r6, r7, pc}
  %x = load <2 x i64>, ptr %ptr, align 8
  %y = load <2 x i64>, ptr %ptr2, align 8
  %s = call {<2 x i64>, <2 x i1>} @llvm.usub.with.overflow.v2i64(<2 x i64> %x, <2 x i64> %y)
  %m = extractvalue {<2 x i64>, <2 x i1>} %s, 0
  %o = extractvalue {<2 x i64>, <2 x i1>} %s, 1
  store <2 x i64> %m, ptr %ptr
  ret <2 x i1> %o
}

define <2 x i1> @saddo(ptr %ptr, ptr %ptr2) {
; CHECK-LABEL: saddo:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.64 {d16, d17}, [r1]
; CHECK-NEXT:    vld1.64 {d18, d19}, [r0]
; CHECK-NEXT:    vqadd.s64 q10, q9, q8
; CHECK-NEXT:    vadd.i64 q8, q9, q8
; CHECK-NEXT:    vceq.i32 q9, q8, q10
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    vrev64.32 q10, q9
; CHECK-NEXT:    vand q9, q9, q10
; CHECK-NEXT:    vmvn q9, q9
; CHECK-NEXT:    vmovn.i64 d18, q9
; CHECK-NEXT:    vmov r2, r1, d18
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    bx lr
  %x = load <2 x i64>, ptr %ptr, align 8
  %y = load <2 x i64>, ptr %ptr2, align 8
  %s = call {<2 x i64>, <2 x i1>} @llvm.sadd.with.overflow.v2i64(<2 x i64> %x, <2 x i64> %y)
  %m = extractvalue {<2 x i64>, <2 x i1>} %s, 0
  %o = extractvalue {<2 x i64>, <2 x i1>} %s, 1
  store <2 x i64> %m, ptr %ptr
  ret <2 x i1> %o
}

define <2 x i1> @ssubo(ptr %ptr, ptr %ptr2) {
; CHECK-LABEL: ssubo:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vld1.64 {d16, d17}, [r1]
; CHECK-NEXT:    vld1.64 {d18, d19}, [r0]
; CHECK-NEXT:    vqsub.s64 q10, q9, q8
; CHECK-NEXT:    vsub.i64 q8, q9, q8
; CHECK-NEXT:    vceq.i32 q9, q8, q10
; CHECK-NEXT:    vst1.64 {d16, d17}, [r0]
; CHECK-NEXT:    vrev64.32 q10, q9
; CHECK-NEXT:    vand q9, q9, q10
; CHECK-NEXT:    vmvn q9, q9
; CHECK-NEXT:    vmovn.i64 d18, q9
; CHECK-NEXT:    vmov r2, r1, d18
; CHECK-NEXT:    mov r0, r2
; CHECK-NEXT:    bx lr
  %x = load <2 x i64>, ptr %ptr, align 8
  %y = load <2 x i64>, ptr %ptr2, align 8
  %s = call {<2 x i64>, <2 x i1>} @llvm.ssub.with.overflow.v2i64(<2 x i64> %x, <2 x i64> %y)
  %m = extractvalue {<2 x i64>, <2 x i1>} %s, 0
  %o = extractvalue {<2 x i64>, <2 x i1>} %s, 1
  store <2 x i64> %m, ptr %ptr
  ret <2 x i1> %o
}
