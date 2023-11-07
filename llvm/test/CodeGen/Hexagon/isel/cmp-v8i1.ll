; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -march=hexagon < %s | FileCheck %s

define void @f0(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f0:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = xor(p0,p1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = not(p0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp eq <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f1(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f1:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = xor(p0,p1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp ne <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f2(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f2:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = and(p0,!p1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp slt <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f3(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f3:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = or(p0,!p1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp sle <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f4(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f4:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = and(p1,!p0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp sgt <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f5(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f5:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = or(p1,!p0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp sge <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f6(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f6:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = and(p1,!p0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp ult <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f7(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f7:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = or(p1,!p0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp ule <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f8(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f8:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = and(p0,!p1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp ugt <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}

define void @f9(ptr %a0, ptr %a1, ptr %a2) {
; CHECK-LABEL: f9:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  // %bb.0: // %b0
; CHECK-NEXT:    {
; CHECK-NEXT:     r1 = memub(r1+#0)
; CHECK-NEXT:     r0 = memub(r0+#0)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = r0
; CHECK-NEXT:     p1 = r1
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     p0 = or(p0,!p1)
; CHECK-NEXT:    }
; CHECK-NEXT:    {
; CHECK-NEXT:     r3 = p0
; CHECK-NEXT:     jumpr r31
; CHECK-NEXT:     memb(r2+#0) = r3.new
; CHECK-NEXT:    }
b0:
  %v0 = load <8 x i1>, ptr %a0
  %v1 = load <8 x i1>, ptr %a1
  %v2 = icmp uge <8 x i1> %v0, %v1
  store <8 x i1> %v2, ptr %a2
  ret void
}
