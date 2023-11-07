; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -O2 -o - %s | FileCheck %s
target datalayout = "e-m:e-i64:64-n32:64"
target triple = "powerpc64le-grtev4-linux-gnu"

; Intended layout:
; The code for tail-duplication during layout will produce the layout:
; test1
; test2
; body1 (with copy of test2)
; body2
; exit

define void @tail_dup_break_cfg(i32 %tag) {
; CHECK-LABEL: tail_dup_break_cfg:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    .cfi_offset r30, -16
; CHECK-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; CHECK-NEXT:    stdu 1, -48(1)
; CHECK-NEXT:    mr 30, 3
; CHECK-NEXT:    std 0, 64(1)
; CHECK-NEXT:    andi. 3, 30, 1
; CHECK-NEXT:    bc 12, 1, .LBB0_3
; CHECK-NEXT:  # %bb.1: # %test2
; CHECK-NEXT:    andi. 3, 30, 2
; CHECK-NEXT:    bne 0, .LBB0_4
; CHECK-NEXT:  .LBB0_2: # %exit
; CHECK-NEXT:    addi 1, 1, 48
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
; CHECK-NEXT:  .LBB0_3: # %body1
; CHECK-NEXT:    bl a
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl a
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl a
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl a
; CHECK-NEXT:    nop
; CHECK-NEXT:    andi. 3, 30, 2
; CHECK-NEXT:    beq 0, .LBB0_2
; CHECK-NEXT:  .LBB0_4: # %body2
; CHECK-NEXT:    bl b
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl b
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl b
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl b
; CHECK-NEXT:    nop
; CHECK-NEXT:    b .LBB0_2
entry:
  br label %test1
test1:
  %tagbit1 = and i32 %tag, 1
  %tagbit1eq0 = icmp eq i32 %tagbit1, 0
  br i1 %tagbit1eq0, label %test2, label %body1, !prof !1 ; %test2 more likely
body1:
  call void @a()
  call void @a()
  call void @a()
  call void @a()
  br label %test2
test2:
  %tagbit2 = and i32 %tag, 2
  %tagbit2eq0 = icmp eq i32 %tagbit2, 0
  br i1 %tagbit2eq0, label %exit, label %body2, !prof !1 ; %exit more likely
body2:
  call void @b()
  call void @b()
  call void @b()
  call void @b()
  br label %exit
exit:
  ret void
}

; The branch weights here hint that we shouldn't tail duplicate in this case.
define void @tail_dup_dont_break_cfg(i32 %tag) {
; CHECK-LABEL: tail_dup_dont_break_cfg:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    .cfi_offset r30, -16
; CHECK-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; CHECK-NEXT:    stdu 1, -48(1)
; CHECK-NEXT:    mr 30, 3
; CHECK-NEXT:    std 0, 64(1)
; CHECK-NEXT:    andi. 3, 30, 1
; CHECK-NEXT:    bc 4, 1, .LBB1_2
; CHECK-NEXT:  # %bb.1: # %body1
; CHECK-NEXT:    bl a
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl a
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl a
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl a
; CHECK-NEXT:    nop
; CHECK-NEXT:  .LBB1_2: # %test2
; CHECK-NEXT:    andi. 3, 30, 2
; CHECK-NEXT:    beq 0, .LBB1_4
; CHECK-NEXT:  # %bb.3: # %body2
; CHECK-NEXT:    bl b
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl b
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl b
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl b
; CHECK-NEXT:    nop
; CHECK-NEXT:  .LBB1_4: # %exit
; CHECK-NEXT:    addi 1, 1, 48
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
entry:
  br label %test1
test1:
  %tagbit1 = and i32 %tag, 1
  %tagbit1eq0 = icmp eq i32 %tagbit1, 0
  br i1 %tagbit1eq0, label %test2, label %body1, !prof !1 ; %test2 more likely
body1:
  call void @a()
  call void @a()
  call void @a()
  call void @a()
  br label %test2
test2:
  %tagbit2 = and i32 %tag, 2
  %tagbit2eq0 = icmp ne i32 %tagbit2, 0
  br i1 %tagbit2eq0, label %body2, label %exit, !prof !3 ; %body2 more likely
body2:
  call void @b()
  call void @b()
  call void @b()
  call void @b()
  br label %exit
exit:
  ret void
}

declare void @a()
declare void @b()
declare void @c()
declare void @d()

; This function arranges for the successors of %succ to have already been laid
; out. When we consider whether to lay out succ after bb and to tail-duplicate
; it, v and ret have already been placed, so we tail-duplicate as it removes a
; branch and strictly increases fallthrough
define void @tail_dup_no_succ(i32 %tag) {
; CHECK-LABEL: tail_dup_no_succ:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    .cfi_offset r30, -16
; CHECK-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; CHECK-NEXT:    stdu 1, -48(1)
; CHECK-NEXT:    mr 30, 3
; CHECK-NEXT:    andi. 3, 3, 1
; CHECK-NEXT:    std 0, 64(1)
; CHECK-NEXT:    bc 12, 1, .LBB2_3
; CHECK-NEXT:  .LBB2_1: # %v
; CHECK-NEXT:    bl d
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl d
; CHECK-NEXT:    nop
; CHECK-NEXT:  .LBB2_2: # %ret
; CHECK-NEXT:    addi 1, 1, 48
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
; CHECK-NEXT:  .LBB2_3: # %bb
; CHECK-NEXT:    andi. 3, 30, 2
; CHECK-NEXT:    bne 0, .LBB2_5
; CHECK-NEXT:  # %bb.4: # %succ
; CHECK-NEXT:    andi. 3, 30, 4
; CHECK-NEXT:    beq 0, .LBB2_2
; CHECK-NEXT:    b .LBB2_1
; CHECK-NEXT:  .LBB2_5: # %c
; CHECK-NEXT:    bl c
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl c
; CHECK-NEXT:    nop
; CHECK-NEXT:    andi. 3, 30, 4
; CHECK-NEXT:    beq 0, .LBB2_2
; CHECK-NEXT:    b .LBB2_1
entry:
  %tagbit1 = and i32 %tag, 1
  %tagbit1eq0 = icmp eq i32 %tagbit1, 0
  br i1 %tagbit1eq0, label %v, label %bb, !prof !2 ; %v very much more likely
bb:
  %tagbit2 = and i32 %tag, 2
  %tagbit2eq0 = icmp eq i32 %tagbit2, 0
  br i1 %tagbit2eq0, label %succ, label %c, !prof !3 ; %succ more likely
c:
  call void @c()
  call void @c()
  br label %succ
succ:
  %tagbit3 = and i32 %tag, 4
  %tagbit3eq0 = icmp eq i32 %tagbit3, 0
  br i1 %tagbit3eq0, label %ret, label %v, !prof !1 ; %u more likely
v:
  call void @d()
  call void @d()
  br label %ret
ret:
  ret void
}

!1 = !{!"branch_weights", i32 5, i32 3}
!2 = !{!"branch_weights", i32 95, i32 5}
!3 = !{!"branch_weights", i32 8, i32 3}
