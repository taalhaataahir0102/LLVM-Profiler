; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -verify-machineinstrs -mtriple powerpc-ibm-aix-xcoff -mcpu=pwr8 \
; RUN:   -ppc-asm-full-reg-names < %s | FileCheck %s --check-prefixes=AIX32
; RUN: llc -verify-machineinstrs -mtriple powerpc64-ibm-aix-xcoff -mcpu=pwr8 \
; RUN:   -ppc-asm-full-reg-names < %s | FileCheck %s --check-prefixes=AIX64
; RUN: llc -verify-machineinstrs -mtriple powerpc64-unknown-linux -mcpu=pwr8 \
; RUN:   -ppc-asm-full-reg-names < %s | FileCheck %s --check-prefixes=LINUX64BE
; RUN: llc -verify-machineinstrs -mtriple powerpc64le-unknown-linux -mcpu=pwr8 \
; RUN:   -ppc-asm-full-reg-names < %s | FileCheck %s --check-prefixes=LINUX64LE

define dso_local i64 @rotatemask32(i64 noundef %word) local_unnamed_addr #0 {
; AIX32-LABEL: rotatemask32:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    cntlzw r5, r4
; AIX32-NEXT:    cmplwi r3, 0
; AIX32-NEXT:    cntlzw r3, r3
; AIX32-NEXT:    addi r5, r5, 32
; AIX32-NEXT:    iseleq r3, r5, r3
; AIX32-NEXT:    rlwnm r4, r4, r3, 1, 31
; AIX32-NEXT:    li r3, 0
; AIX32-NEXT:    blr
;
; AIX64-LABEL: rotatemask32:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    cntlzd r4, r3
; AIX64-NEXT:    rlwnm r3, r3, r4, 1, 31
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: rotatemask32:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    cntlzd r4, r3
; LINUX64BE-NEXT:    rlwnm r3, r3, r4, 1, 31
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: rotatemask32:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    cntlzd r4, r3
; LINUX64LE-NEXT:    rlwnm r3, r3, r4, 1, 31
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.ctlz.i64(i64 %word, i1 false)
  %cast = trunc i64 %0 to i32
  %conv1 = trunc i64 %word to i32
  %1 = tail call i32 @llvm.fshl.i32(i32 %conv1, i32 %conv1, i32 %cast)
  %2 = and i32 %1, 2147483647
  %and = zext i32 %2 to i64
  ret i64 %and
}

declare i64 @llvm.ctlz.i64(i64, i1 immarg) #0
declare i32 @llvm.fshl.i32(i32, i32, i32) #0

define dso_local i64 @rotatemask64(i64 noundef %word) local_unnamed_addr #0 {
; AIX32-LABEL: rotatemask64:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    cntlzw r5, r4
; AIX32-NEXT:    cntlzw r6, r3
; AIX32-NEXT:    cmplwi r3, 0
; AIX32-NEXT:    addi r5, r5, 32
; AIX32-NEXT:    iseleq r5, r5, r6
; AIX32-NEXT:    andi. r6, r5, 32
; AIX32-NEXT:    clrlwi r5, r5, 27
; AIX32-NEXT:    iseleq r6, r3, r4
; AIX32-NEXT:    subfic r7, r5, 32
; AIX32-NEXT:    iseleq r3, r4, r3
; AIX32-NEXT:    slw r8, r6, r5
; AIX32-NEXT:    srw r6, r6, r7
; AIX32-NEXT:    srw r4, r3, r7
; AIX32-NEXT:    slw r3, r3, r5
; AIX32-NEXT:    or r5, r8, r4
; AIX32-NEXT:    or r4, r3, r6
; AIX32-NEXT:    clrlwi r3, r5, 1
; AIX32-NEXT:    blr
;
; AIX64-LABEL: rotatemask64:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    cntlzd r4, r3
; AIX64-NEXT:    rotld r3, r3, r4
; AIX64-NEXT:    clrldi r3, r3, 1
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: rotatemask64:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    cntlzd r4, r3
; LINUX64BE-NEXT:    rotld r3, r3, r4
; LINUX64BE-NEXT:    clrldi r3, r3, 1
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: rotatemask64:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    cntlzd r4, r3
; LINUX64LE-NEXT:    rotld r3, r3, r4
; LINUX64LE-NEXT:    clrldi r3, r3, 1
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.ctlz.i64(i64 %word, i1 false)
  %1 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 %0)
  %and = and i64 %1, 9223372036854775807
  ret i64 %and
}

declare i64 @llvm.fshl.i64(i64, i64, i64) #1

define dso_local i64 @rotatemask64_2(i64 noundef %word) local_unnamed_addr #0 {
; AIX32-LABEL: rotatemask64_2:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    cntlzw r5, r4
; AIX32-NEXT:    cntlzw r6, r3
; AIX32-NEXT:    cmplwi r3, 0
; AIX32-NEXT:    addi r5, r5, 32
; AIX32-NEXT:    iseleq r5, r5, r6
; AIX32-NEXT:    andi. r6, r5, 32
; AIX32-NEXT:    clrlwi r5, r5, 27
; AIX32-NEXT:    iseleq r6, r3, r4
; AIX32-NEXT:    subfic r7, r5, 32
; AIX32-NEXT:    iseleq r3, r4, r3
; AIX32-NEXT:    slw r8, r6, r5
; AIX32-NEXT:    srw r6, r6, r7
; AIX32-NEXT:    srw r4, r3, r7
; AIX32-NEXT:    slw r3, r3, r5
; AIX32-NEXT:    or r5, r8, r4
; AIX32-NEXT:    or r4, r3, r6
; AIX32-NEXT:    clrlwi r3, r5, 1
; AIX32-NEXT:    blr
;
; AIX64-LABEL: rotatemask64_2:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    cntlzd r4, r3
; AIX64-NEXT:    rotld r3, r3, r4
; AIX64-NEXT:    clrldi r3, r3, 1
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: rotatemask64_2:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    cntlzd r4, r3
; LINUX64BE-NEXT:    rotld r3, r3, r4
; LINUX64BE-NEXT:    clrldi r3, r3, 1
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: rotatemask64_2:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    cntlzd r4, r3
; LINUX64LE-NEXT:    rotld r3, r3, r4
; LINUX64LE-NEXT:    clrldi r3, r3, 1
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.ctlz.i64(i64 %word, i1 false)
  %1 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 %0)
  %and = and i64 %1, 9223372036854775807
  ret i64 %and
}

define dso_local i64 @rotatemask64_3(i64 noundef %word) local_unnamed_addr #0 {
; AIX32-LABEL: rotatemask64_3:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    cntlzw r5, r4
; AIX32-NEXT:    cntlzw r6, r3
; AIX32-NEXT:    cmplwi r3, 0
; AIX32-NEXT:    addi r5, r5, 32
; AIX32-NEXT:    iseleq r5, r5, r6
; AIX32-NEXT:    andi. r6, r5, 32
; AIX32-NEXT:    clrlwi r5, r5, 27
; AIX32-NEXT:    iseleq r6, r3, r4
; AIX32-NEXT:    subfic r7, r5, 32
; AIX32-NEXT:    iseleq r3, r4, r3
; AIX32-NEXT:    srw r4, r6, r7
; AIX32-NEXT:    slw r8, r3, r5
; AIX32-NEXT:    srw r3, r3, r7
; AIX32-NEXT:    slw r5, r6, r5
; AIX32-NEXT:    or r4, r8, r4
; AIX32-NEXT:    or r3, r5, r3
; AIX32-NEXT:    clrlwi r3, r3, 1
; AIX32-NEXT:    rlwinm r4, r4, 0, 0, 23
; AIX32-NEXT:    blr
;
; AIX64-LABEL: rotatemask64_3:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    cntlzd r4, r3
; AIX64-NEXT:    rotld r3, r3, r4
; AIX64-NEXT:    rldicl r3, r3, 56, 8
; AIX64-NEXT:    rldicl r3, r3, 8, 1
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: rotatemask64_3:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    cntlzd r4, r3
; LINUX64BE-NEXT:    rotld r3, r3, r4
; LINUX64BE-NEXT:    rldicl r3, r3, 56, 8
; LINUX64BE-NEXT:    rldicl r3, r3, 8, 1
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: rotatemask64_3:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    cntlzd r4, r3
; LINUX64LE-NEXT:    rotld r3, r3, r4
; LINUX64LE-NEXT:    rldicl r3, r3, 56, 8
; LINUX64LE-NEXT:    rldicl r3, r3, 8, 1
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.ctlz.i64(i64 %word, i1 false)
  %1 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 %0)
  %and = and i64 %1, 9223372036854775552
  ret i64 %and
}

define dso_local i64 @rotatemask64_nocount(i64 noundef %word, i64 noundef %clz) local_unnamed_addr #0 {
; AIX32-LABEL: rotatemask64_nocount:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    andi. r5, r6, 32
; AIX32-NEXT:    clrlwi r5, r6, 27
; AIX32-NEXT:    iseleq r6, r3, r4
; AIX32-NEXT:    subfic r7, r5, 32
; AIX32-NEXT:    iseleq r3, r4, r3
; AIX32-NEXT:    slw r8, r6, r5
; AIX32-NEXT:    srw r4, r3, r7
; AIX32-NEXT:    srw r6, r6, r7
; AIX32-NEXT:    slw r3, r3, r5
; AIX32-NEXT:    or r5, r8, r4
; AIX32-NEXT:    or r4, r3, r6
; AIX32-NEXT:    clrlwi r3, r5, 8
; AIX32-NEXT:    blr
;
; AIX64-LABEL: rotatemask64_nocount:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    rotld r3, r3, r4
; AIX64-NEXT:    clrldi r3, r3, 8
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: rotatemask64_nocount:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    rotld r3, r3, r4
; LINUX64BE-NEXT:    clrldi r3, r3, 8
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: rotatemask64_nocount:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    rotld r3, r3, r4
; LINUX64LE-NEXT:    clrldi r3, r3, 8
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 %clz)
  %and = and i64 %0, 72057594037927935
  ret i64 %and
}

define dso_local i64 @builtincheck(i64 noundef %word, i64 noundef %shift) local_unnamed_addr #0 {
; AIX32-LABEL: builtincheck:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    andi. r5, r6, 32
; AIX32-NEXT:    clrlwi r5, r6, 27
; AIX32-NEXT:    iseleq r6, r3, r4
; AIX32-NEXT:    subfic r7, r5, 32
; AIX32-NEXT:    iseleq r3, r4, r3
; AIX32-NEXT:    slw r8, r6, r5
; AIX32-NEXT:    srw r4, r3, r7
; AIX32-NEXT:    srw r6, r6, r7
; AIX32-NEXT:    slw r3, r3, r5
; AIX32-NEXT:    or r5, r8, r4
; AIX32-NEXT:    or r4, r3, r6
; AIX32-NEXT:    clrlwi r3, r5, 1
; AIX32-NEXT:    blr
;
; AIX64-LABEL: builtincheck:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    rotld r3, r3, r4
; AIX64-NEXT:    clrldi r3, r3, 1
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: builtincheck:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    rotld r3, r3, r4
; LINUX64BE-NEXT:    clrldi r3, r3, 1
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: builtincheck:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    rotld r3, r3, r4
; LINUX64LE-NEXT:    clrldi r3, r3, 1
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 %shift)
  %1 = and i64 %0, 9223372036854775807
  ret i64 %1
}

define dso_local i64 @immshift(i64 noundef %word) local_unnamed_addr #0 {
; AIX32-LABEL: immshift:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    rotlwi r5, r3, 15
; AIX32-NEXT:    srwi r6, r4, 17
; AIX32-NEXT:    rlwimi r5, r4, 15, 0, 16
; AIX32-NEXT:    rlwimi r6, r3, 15, 12, 16
; AIX32-NEXT:    mr r3, r6
; AIX32-NEXT:    mr r4, r5
; AIX32-NEXT:    blr
;
; AIX64-LABEL: immshift:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    rldicl r3, r3, 15, 12
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: immshift:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    rldicl r3, r3, 15, 12
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: immshift:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    rldicl r3, r3, 15, 12
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 15)
  %and = and i64 %0, 4503599627370495
  ret i64 %and
}

define dso_local i64 @twomasks(i64 noundef %word) local_unnamed_addr #0 {
; AIX32-LABEL: twomasks:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    mflr r0
; AIX32-NEXT:    stwu r1, -64(r1)
; AIX32-NEXT:    cntlzw r5, r4
; AIX32-NEXT:    cntlzw r6, r3
; AIX32-NEXT:    stw r0, 72(r1)
; AIX32-NEXT:    cmplwi r3, 0
; AIX32-NEXT:    addi r5, r5, 32
; AIX32-NEXT:    iseleq r5, r5, r6
; AIX32-NEXT:    andi. r6, r5, 32
; AIX32-NEXT:    clrlwi r5, r5, 27
; AIX32-NEXT:    iseleq r6, r3, r4
; AIX32-NEXT:    subfic r7, r5, 32
; AIX32-NEXT:    iseleq r3, r4, r3
; AIX32-NEXT:    slw r8, r6, r5
; AIX32-NEXT:    srw r6, r6, r7
; AIX32-NEXT:    srw r4, r3, r7
; AIX32-NEXT:    slw r3, r3, r5
; AIX32-NEXT:    or r5, r8, r4
; AIX32-NEXT:    or r4, r3, r6
; AIX32-NEXT:    clrlwi r3, r5, 1
; AIX32-NEXT:    clrlwi r5, r5, 16
; AIX32-NEXT:    mr r6, r4
; AIX32-NEXT:    bl .callee[PR]
; AIX32-NEXT:    nop
; AIX32-NEXT:    addi r1, r1, 64
; AIX32-NEXT:    lwz r0, 8(r1)
; AIX32-NEXT:    mtlr r0
; AIX32-NEXT:    blr
;
; AIX64-LABEL: twomasks:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    mflr r0
; AIX64-NEXT:    stdu r1, -112(r1)
; AIX64-NEXT:    cntlzd r4, r3
; AIX64-NEXT:    std r0, 128(r1)
; AIX64-NEXT:    rotld r4, r3, r4
; AIX64-NEXT:    clrldi r3, r4, 1
; AIX64-NEXT:    clrldi r4, r4, 16
; AIX64-NEXT:    bl .callee[PR]
; AIX64-NEXT:    nop
; AIX64-NEXT:    addi r1, r1, 112
; AIX64-NEXT:    ld r0, 16(r1)
; AIX64-NEXT:    mtlr r0
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: twomasks:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    mflr r0
; LINUX64BE-NEXT:    stdu r1, -112(r1)
; LINUX64BE-NEXT:    cntlzd r4, r3
; LINUX64BE-NEXT:    std r0, 128(r1)
; LINUX64BE-NEXT:    rotld r4, r3, r4
; LINUX64BE-NEXT:    clrldi r3, r4, 1
; LINUX64BE-NEXT:    clrldi r4, r4, 16
; LINUX64BE-NEXT:    bl callee
; LINUX64BE-NEXT:    nop
; LINUX64BE-NEXT:    addi r1, r1, 112
; LINUX64BE-NEXT:    ld r0, 16(r1)
; LINUX64BE-NEXT:    mtlr r0
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: twomasks:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    mflr r0
; LINUX64LE-NEXT:    stdu r1, -32(r1)
; LINUX64LE-NEXT:    cntlzd r4, r3
; LINUX64LE-NEXT:    std r0, 48(r1)
; LINUX64LE-NEXT:    rotld r4, r3, r4
; LINUX64LE-NEXT:    clrldi r3, r4, 1
; LINUX64LE-NEXT:    clrldi r4, r4, 16
; LINUX64LE-NEXT:    bl callee
; LINUX64LE-NEXT:    nop
; LINUX64LE-NEXT:    addi r1, r1, 32
; LINUX64LE-NEXT:    ld r0, 16(r1)
; LINUX64LE-NEXT:    mtlr r0
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.ctlz.i64(i64 %word, i1 false)
  %1 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 %0)
  %and = and i64 %1, 9223372036854775807
  %and1 = and i64 %1, 281474976710655
  %call = tail call i64 @callee(i64 noundef %and, i64 noundef %and1) #0
  ret i64 %call
}

declare i64 @callee(i64 noundef, i64 noundef) local_unnamed_addr #0

define dso_local i64 @tworotates(i64 noundef %word) local_unnamed_addr #0 {
; AIX32-LABEL: tworotates:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    mflr r0
; AIX32-NEXT:    stwu r1, -64(r1)
; AIX32-NEXT:    cntlzw r5, r4
; AIX32-NEXT:    cntlzw r6, r3
; AIX32-NEXT:    stw r0, 72(r1)
; AIX32-NEXT:    cmplwi r3, 0
; AIX32-NEXT:    addi r5, r5, 32
; AIX32-NEXT:    iseleq r5, r5, r6
; AIX32-NEXT:    andi. r6, r5, 32
; AIX32-NEXT:    clrlwi r5, r5, 27
; AIX32-NEXT:    iseleq r7, r3, r4
; AIX32-NEXT:    subfic r8, r5, 32
; AIX32-NEXT:    rotlwi r6, r3, 23
; AIX32-NEXT:    iseleq r9, r4, r3
; AIX32-NEXT:    slw r11, r7, r5
; AIX32-NEXT:    srw r7, r7, r8
; AIX32-NEXT:    srw r10, r9, r8
; AIX32-NEXT:    slw r8, r9, r5
; AIX32-NEXT:    srwi r5, r4, 9
; AIX32-NEXT:    or r9, r11, r10
; AIX32-NEXT:    rlwimi r6, r4, 23, 0, 8
; AIX32-NEXT:    or r4, r8, r7
; AIX32-NEXT:    clrlwi r7, r9, 1
; AIX32-NEXT:    rlwimi r5, r3, 23, 1, 8
; AIX32-NEXT:    mr r3, r7
; AIX32-NEXT:    bl .callee[PR]
; AIX32-NEXT:    nop
; AIX32-NEXT:    addi r1, r1, 64
; AIX32-NEXT:    lwz r0, 8(r1)
; AIX32-NEXT:    mtlr r0
; AIX32-NEXT:    blr
;
; AIX64-LABEL: tworotates:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    mflr r0
; AIX64-NEXT:    stdu r1, -112(r1)
; AIX64-NEXT:    cntlzd r4, r3
; AIX64-NEXT:    std r0, 128(r1)
; AIX64-NEXT:    rotld r4, r3, r4
; AIX64-NEXT:    clrldi r5, r4, 1
; AIX64-NEXT:    rldicl r4, r3, 23, 1
; AIX64-NEXT:    mr r3, r5
; AIX64-NEXT:    bl .callee[PR]
; AIX64-NEXT:    nop
; AIX64-NEXT:    addi r1, r1, 112
; AIX64-NEXT:    ld r0, 16(r1)
; AIX64-NEXT:    mtlr r0
; AIX64-NEXT:    blr
;
; LINUX64BE-LABEL: tworotates:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    mflr r0
; LINUX64BE-NEXT:    stdu r1, -112(r1)
; LINUX64BE-NEXT:    cntlzd r4, r3
; LINUX64BE-NEXT:    std r0, 128(r1)
; LINUX64BE-NEXT:    rotld r4, r3, r4
; LINUX64BE-NEXT:    clrldi r5, r4, 1
; LINUX64BE-NEXT:    rldicl r4, r3, 23, 1
; LINUX64BE-NEXT:    mr r3, r5
; LINUX64BE-NEXT:    bl callee
; LINUX64BE-NEXT:    nop
; LINUX64BE-NEXT:    addi r1, r1, 112
; LINUX64BE-NEXT:    ld r0, 16(r1)
; LINUX64BE-NEXT:    mtlr r0
; LINUX64BE-NEXT:    blr
;
; LINUX64LE-LABEL: tworotates:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    mflr r0
; LINUX64LE-NEXT:    stdu r1, -32(r1)
; LINUX64LE-NEXT:    cntlzd r4, r3
; LINUX64LE-NEXT:    std r0, 48(r1)
; LINUX64LE-NEXT:    rotld r4, r3, r4
; LINUX64LE-NEXT:    clrldi r5, r4, 1
; LINUX64LE-NEXT:    rldicl r4, r3, 23, 1
; LINUX64LE-NEXT:    mr r3, r5
; LINUX64LE-NEXT:    bl callee
; LINUX64LE-NEXT:    nop
; LINUX64LE-NEXT:    addi r1, r1, 32
; LINUX64LE-NEXT:    ld r0, 16(r1)
; LINUX64LE-NEXT:    mtlr r0
; LINUX64LE-NEXT:    blr
entry:
  %0 = tail call i64 @llvm.ctlz.i64(i64 %word, i1 false)
  %1 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 %0)
  %2 = tail call i64 @llvm.fshl.i64(i64 %word, i64 %word, i64 23)
  %and = and i64 %1, 9223372036854775807
  %and1 = and i64 %2, 9223372036854775807
  %call = tail call i64 @callee(i64 noundef %and, i64 noundef %and1) #0
  ret i64 %call
}

attributes #0 = { nounwind }
