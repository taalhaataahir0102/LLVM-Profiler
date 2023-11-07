; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -march=hexagon < %s | FileCheck %s

define void @f0(<2 x i32> %a0, ptr %a1) {
; CHECK-LABEL: f0:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r5:4 = combine(#1,#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r1:0 = and(r1:0,r5:4)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = vcmpw.eq(r1:0,#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r0.new
; CHECK-NEXT:    }
b0:
  %v0 = trunc <2 x i32> %a0 to <2 x i1>
  store <2 x i1> %v0, ptr %a1, align 1
  ret void
}

define void @f1(<4 x i16> %a0, ptr %a1) {
; CHECK-LABEL: f1:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = and(r0,##65537)
; CHECK-NEXT:     r1 = and(r1,##65537)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = vcmph.eq(r1:0,#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r0.new
; CHECK-NEXT:    }
b0:
  %v0 = trunc <4 x i16> %a0 to <4 x i1>
  store <4 x i1> %v0, ptr %a1, align 1
  ret void
}

define void @f2(<8 x i8> %a0, ptr %a1) {
; CHECK-LABEL: f2:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = and(r0,##16843009)
; CHECK-NEXT:     r1 = and(r1,##16843009)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = vcmpb.eq(r1:0,#1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r0 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r0.new
; CHECK-NEXT:    }
b0:
  %v0 = trunc <8 x i8> %a0 to <8 x i1>
  store <8 x i1> %v0, ptr %a1, align 1
  ret void
}
