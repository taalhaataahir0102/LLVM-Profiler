; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=mips -mattr=+single-float < %s | FileCheck %s

define void @f0() nounwind {
; CHECK-LABEL: f0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addiu $sp, $sp, -8
; CHECK-NEXT:    addiu $1, $zero, 1
; CHECK-NEXT:    sw $1, 4($sp)
; CHECK-NEXT:    lw $1, 4($sp)
; CHECK-NEXT:    srl $2, $1, 1
; CHECK-NEXT:    andi $3, $1, 1
; CHECK-NEXT:    or $2, $3, $2
; CHECK-NEXT:    mtc1 $2, $f0
; CHECK-NEXT:    cvt.s.w $f0, $f0
; CHECK-NEXT:    add.s $f0, $f0, $f0
; CHECK-NEXT:    mtc1 $1, $f1
; CHECK-NEXT:    cvt.s.w $f1, $f1
; CHECK-NEXT:    slti $1, $1, 0
; CHECK-NEXT:    movn.s $f1, $f0, $1
; CHECK-NEXT:    swc1 $f1, 0($sp)
; CHECK-NEXT:    jr $ra
; CHECK-NEXT:    addiu $sp, $sp, 8
entry:
  %b = alloca i32, align 4
  %a = alloca float, align 4
  store volatile i32 1, ptr %b, align 4
  %0 = load volatile i32, ptr %b, align 4
  %conv = uitofp i32 %0 to float
  store float %conv, ptr %a, align 4
  ret void
}
