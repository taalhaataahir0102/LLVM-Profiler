; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-- < %s -pre-RA-sched=list-ilp    | FileCheck %s --check-prefix=ILP
; RUN: llc -mtriple=x86_64-- < %s -pre-RA-sched=list-hybrid | FileCheck %s --check-prefix=HYBRID
; RUN: llc -mtriple=x86_64-- < %s -pre-RA-sched=list-burr   | FileCheck %s --check-prefix=BURR
; RUN: llc -mtriple=x86_64-- < %s -pre-RA-sched=source      | FileCheck %s --check-prefix=SRC
; FIXME: Fix machine verifier issues and remove -verify-machineinstrs=0. PR39452.
; RUN: llc -mtriple=x86_64-- < %s -pre-RA-sched=linearize -verify-machineinstrs=0 | FileCheck %s --check-prefix=LIN

; PR22304 https://llvm.org/bugs/show_bug.cgi?id=22304
; Tests checking backtracking in source scheduler. llc used to crash on them.

define i256 @test1(i256 %a) nounwind {
; ILP-LABEL: test1:
; ILP:       # %bb.0:
; ILP-NEXT:    movq %rdi, %rax
; ILP-NEXT:    leal (%rsi,%rsi), %ecx
; ILP-NEXT:    addb $3, %cl
; ILP-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; ILP-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; ILP-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; ILP-NEXT:    movq $1, -{{[0-9]+}}(%rsp)
; ILP-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; ILP-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; ILP-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; ILP-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; ILP-NEXT:    movl %ecx, %edx
; ILP-NEXT:    shrb $3, %dl
; ILP-NEXT:    andb $7, %cl
; ILP-NEXT:    negb %dl
; ILP-NEXT:    movsbq %dl, %rdx
; ILP-NEXT:    movq -16(%rsp,%rdx), %rsi
; ILP-NEXT:    movq -8(%rsp,%rdx), %rdi
; ILP-NEXT:    shldq %cl, %rsi, %rdi
; ILP-NEXT:    movq -32(%rsp,%rdx), %r8
; ILP-NEXT:    movq -24(%rsp,%rdx), %rdx
; ILP-NEXT:    movq %r8, %r9
; ILP-NEXT:    shlq %cl, %r9
; ILP-NEXT:    movq %rdx, %r10
; ILP-NEXT:    shldq %cl, %r8, %r10
; ILP-NEXT:    movq %rdi, 24(%rax)
; ILP-NEXT:    movq %r10, 8(%rax)
; ILP-NEXT:    movq %r9, (%rax)
; ILP-NEXT:    shlq %cl, %rsi
; ILP-NEXT:    notb %cl
; ILP-NEXT:    shrq %rdx
; ILP-NEXT:    # kill: def $cl killed $cl killed $ecx
; ILP-NEXT:    shrq %cl, %rdx
; ILP-NEXT:    orq %rsi, %rdx
; ILP-NEXT:    movq %rdx, 16(%rax)
; ILP-NEXT:    retq
;
; HYBRID-LABEL: test1:
; HYBRID:       # %bb.0:
; HYBRID-NEXT:    movq %rdi, %rax
; HYBRID-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; HYBRID-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; HYBRID-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; HYBRID-NEXT:    movq $1, -{{[0-9]+}}(%rsp)
; HYBRID-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; HYBRID-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; HYBRID-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; HYBRID-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; HYBRID-NEXT:    addl %esi, %esi
; HYBRID-NEXT:    addb $3, %sil
; HYBRID-NEXT:    movl %esi, %ecx
; HYBRID-NEXT:    andb $7, %cl
; HYBRID-NEXT:    shrb $3, %sil
; HYBRID-NEXT:    negb %sil
; HYBRID-NEXT:    movsbq %sil, %rdx
; HYBRID-NEXT:    movq -16(%rsp,%rdx), %rsi
; HYBRID-NEXT:    movq -8(%rsp,%rdx), %rdi
; HYBRID-NEXT:    shldq %cl, %rsi, %rdi
; HYBRID-NEXT:    movq %rdi, 24(%rax)
; HYBRID-NEXT:    movq -32(%rsp,%rdx), %rdi
; HYBRID-NEXT:    movq -24(%rsp,%rdx), %rdx
; HYBRID-NEXT:    movq %rdx, %r8
; HYBRID-NEXT:    shldq %cl, %rdi, %r8
; HYBRID-NEXT:    movq %r8, 8(%rax)
; HYBRID-NEXT:    shlq %cl, %rdi
; HYBRID-NEXT:    movq %rdi, (%rax)
; HYBRID-NEXT:    shlq %cl, %rsi
; HYBRID-NEXT:    notb %cl
; HYBRID-NEXT:    shrq %rdx
; HYBRID-NEXT:    shrq %cl, %rdx
; HYBRID-NEXT:    orq %rsi, %rdx
; HYBRID-NEXT:    movq %rdx, 16(%rax)
; HYBRID-NEXT:    retq
;
; BURR-LABEL: test1:
; BURR:       # %bb.0:
; BURR-NEXT:    movq %rdi, %rax
; BURR-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; BURR-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; BURR-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; BURR-NEXT:    movq $1, -{{[0-9]+}}(%rsp)
; BURR-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; BURR-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; BURR-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; BURR-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; BURR-NEXT:    addl %esi, %esi
; BURR-NEXT:    addb $3, %sil
; BURR-NEXT:    movl %esi, %ecx
; BURR-NEXT:    andb $7, %cl
; BURR-NEXT:    shrb $3, %sil
; BURR-NEXT:    negb %sil
; BURR-NEXT:    movsbq %sil, %rdx
; BURR-NEXT:    movq -16(%rsp,%rdx), %rsi
; BURR-NEXT:    movq -8(%rsp,%rdx), %rdi
; BURR-NEXT:    shldq %cl, %rsi, %rdi
; BURR-NEXT:    movq %rdi, 24(%rax)
; BURR-NEXT:    movq -32(%rsp,%rdx), %rdi
; BURR-NEXT:    movq -24(%rsp,%rdx), %rdx
; BURR-NEXT:    movq %rdx, %r8
; BURR-NEXT:    shldq %cl, %rdi, %r8
; BURR-NEXT:    movq %r8, 8(%rax)
; BURR-NEXT:    shlq %cl, %rdi
; BURR-NEXT:    movq %rdi, (%rax)
; BURR-NEXT:    shlq %cl, %rsi
; BURR-NEXT:    notb %cl
; BURR-NEXT:    shrq %rdx
; BURR-NEXT:    shrq %cl, %rdx
; BURR-NEXT:    orq %rsi, %rdx
; BURR-NEXT:    movq %rdx, 16(%rax)
; BURR-NEXT:    retq
;
; SRC-LABEL: test1:
; SRC:       # %bb.0:
; SRC-NEXT:    movq %rdi, %rax
; SRC-NEXT:    addl %esi, %esi
; SRC-NEXT:    addb $3, %sil
; SRC-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; SRC-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; SRC-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; SRC-NEXT:    movq $1, -{{[0-9]+}}(%rsp)
; SRC-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; SRC-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; SRC-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; SRC-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; SRC-NEXT:    movl %esi, %edx
; SRC-NEXT:    andb $7, %dl
; SRC-NEXT:    shrb $3, %sil
; SRC-NEXT:    negb %sil
; SRC-NEXT:    movsbq %sil, %rsi
; SRC-NEXT:    movq -16(%rsp,%rsi), %rdi
; SRC-NEXT:    movq %rdi, %r8
; SRC-NEXT:    movl %edx, %ecx
; SRC-NEXT:    shlq %cl, %r8
; SRC-NEXT:    notb %cl
; SRC-NEXT:    movq -32(%rsp,%rsi), %r9
; SRC-NEXT:    movq -24(%rsp,%rsi), %r10
; SRC-NEXT:    movq %r10, %r11
; SRC-NEXT:    shrq %r11
; SRC-NEXT:    shrq %cl, %r11
; SRC-NEXT:    orq %r8, %r11
; SRC-NEXT:    movq -8(%rsp,%rsi), %rsi
; SRC-NEXT:    movl %edx, %ecx
; SRC-NEXT:    shldq %cl, %rdi, %rsi
; SRC-NEXT:    movq %r9, %rdi
; SRC-NEXT:    shlq %cl, %rdi
; SRC-NEXT:    shldq %cl, %r9, %r10
; SRC-NEXT:    movq %rsi, 24(%rax)
; SRC-NEXT:    movq %r10, 8(%rax)
; SRC-NEXT:    movq %rdi, (%rax)
; SRC-NEXT:    movq %r11, 16(%rax)
; SRC-NEXT:    retq
;
; LIN-LABEL: test1:
; LIN:       # %bb.0:
; LIN-NEXT:    movq %rdi, %rax
; LIN-NEXT:    leal (%rsi,%rsi), %edx
; LIN-NEXT:    addb $3, %dl
; LIN-NEXT:    movl %edx, %ecx
; LIN-NEXT:    shrb $3, %cl
; LIN-NEXT:    negb %cl
; LIN-NEXT:    movsbq %cl, %rsi
; LIN-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; LIN-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; LIN-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; LIN-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; LIN-NEXT:    movq $1, -{{[0-9]+}}(%rsp)
; LIN-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; LIN-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; LIN-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; LIN-NEXT:    movq -32(%rsp,%rsi), %rdi
; LIN-NEXT:    andb $7, %dl
; LIN-NEXT:    movq %rdi, %r8
; LIN-NEXT:    movl %edx, %ecx
; LIN-NEXT:    shlq %cl, %r8
; LIN-NEXT:    movq %r8, (%rax)
; LIN-NEXT:    movq -24(%rsp,%rsi), %r8
; LIN-NEXT:    movq %r8, %r9
; LIN-NEXT:    shldq %cl, %rdi, %r9
; LIN-NEXT:    movq %r9, 8(%rax)
; LIN-NEXT:    movq -16(%rsp,%rsi), %rdi
; LIN-NEXT:    movq %rdi, %r9
; LIN-NEXT:    shlq %cl, %r9
; LIN-NEXT:    shrq %r8
; LIN-NEXT:    notb %cl
; LIN-NEXT:    shrq %cl, %r8
; LIN-NEXT:    orq %r9, %r8
; LIN-NEXT:    movq %r8, 16(%rax)
; LIN-NEXT:    movq -8(%rsp,%rsi), %rsi
; LIN-NEXT:    movl %edx, %ecx
; LIN-NEXT:    shldq %cl, %rdi, %rsi
; LIN-NEXT:    movq %rsi, 24(%rax)
; LIN-NEXT:    retq
  %b = add i256 %a, 1
  %m = shl i256 %b, 1
  %p = add i256 %m, 1
  %v = lshr i256 %b, %p
  %t = trunc i256 %v to i1
  %c = shl i256 1, %p
  %f = select i1 %t, i256 undef, i256 %c
  ret i256 %f
}

define i256 @test2(i256 %a) nounwind {
; ILP-LABEL: test2:
; ILP:       # %bb.0:
; ILP-NEXT:    movq %rdi, %rax
; ILP-NEXT:    xorl %edi, %edi
; ILP-NEXT:    movq %rsi, %r11
; ILP-NEXT:    negq %r11
; ILP-NEXT:    movl $0, %r10d
; ILP-NEXT:    sbbq %rdx, %r10
; ILP-NEXT:    movl $0, %r9d
; ILP-NEXT:    sbbq %rcx, %r9
; ILP-NEXT:    sbbq %r8, %rdi
; ILP-NEXT:    andq %r8, %rdi
; ILP-NEXT:    bsrq %rdi, %r8
; ILP-NEXT:    andq %rdx, %r10
; ILP-NEXT:    bsrq %r10, %rdx
; ILP-NEXT:    xorq $63, %r8
; ILP-NEXT:    andq %rcx, %r9
; ILP-NEXT:    bsrq %r9, %rcx
; ILP-NEXT:    xorq $63, %rcx
; ILP-NEXT:    addq $64, %rcx
; ILP-NEXT:    testq %rdi, %rdi
; ILP-NEXT:    cmovneq %r8, %rcx
; ILP-NEXT:    xorq $63, %rdx
; ILP-NEXT:    andq %rsi, %r11
; ILP-NEXT:    movl $127, %esi
; ILP-NEXT:    bsrq %r11, %r8
; ILP-NEXT:    cmoveq %rsi, %r8
; ILP-NEXT:    xorq $63, %r8
; ILP-NEXT:    addq $64, %r8
; ILP-NEXT:    testq %r10, %r10
; ILP-NEXT:    cmovneq %rdx, %r8
; ILP-NEXT:    subq $-128, %r8
; ILP-NEXT:    orq %rdi, %r9
; ILP-NEXT:    cmovneq %rcx, %r8
; ILP-NEXT:    movq %r8, (%rax)
; ILP-NEXT:    movq $0, 24(%rax)
; ILP-NEXT:    movq $0, 16(%rax)
; ILP-NEXT:    movq $0, 8(%rax)
; ILP-NEXT:    retq
;
; HYBRID-LABEL: test2:
; HYBRID:       # %bb.0:
; HYBRID-NEXT:    movq %rdi, %rax
; HYBRID-NEXT:    xorl %edi, %edi
; HYBRID-NEXT:    movq %rsi, %r11
; HYBRID-NEXT:    negq %r11
; HYBRID-NEXT:    movl $0, %r10d
; HYBRID-NEXT:    sbbq %rdx, %r10
; HYBRID-NEXT:    movl $0, %r9d
; HYBRID-NEXT:    sbbq %rcx, %r9
; HYBRID-NEXT:    sbbq %r8, %rdi
; HYBRID-NEXT:    andq %r8, %rdi
; HYBRID-NEXT:    bsrq %rdi, %r8
; HYBRID-NEXT:    xorq $63, %r8
; HYBRID-NEXT:    andq %rcx, %r9
; HYBRID-NEXT:    bsrq %r9, %rcx
; HYBRID-NEXT:    xorq $63, %rcx
; HYBRID-NEXT:    addq $64, %rcx
; HYBRID-NEXT:    testq %rdi, %rdi
; HYBRID-NEXT:    cmovneq %r8, %rcx
; HYBRID-NEXT:    andq %rdx, %r10
; HYBRID-NEXT:    bsrq %r10, %rdx
; HYBRID-NEXT:    xorq $63, %rdx
; HYBRID-NEXT:    andq %rsi, %r11
; HYBRID-NEXT:    movl $127, %esi
; HYBRID-NEXT:    bsrq %r11, %r8
; HYBRID-NEXT:    cmoveq %rsi, %r8
; HYBRID-NEXT:    xorq $63, %r8
; HYBRID-NEXT:    addq $64, %r8
; HYBRID-NEXT:    testq %r10, %r10
; HYBRID-NEXT:    cmovneq %rdx, %r8
; HYBRID-NEXT:    subq $-128, %r8
; HYBRID-NEXT:    orq %rdi, %r9
; HYBRID-NEXT:    cmovneq %rcx, %r8
; HYBRID-NEXT:    movq %r8, (%rax)
; HYBRID-NEXT:    movq $0, 24(%rax)
; HYBRID-NEXT:    movq $0, 16(%rax)
; HYBRID-NEXT:    movq $0, 8(%rax)
; HYBRID-NEXT:    retq
;
; BURR-LABEL: test2:
; BURR:       # %bb.0:
; BURR-NEXT:    movq %rdi, %rax
; BURR-NEXT:    xorl %edi, %edi
; BURR-NEXT:    movq %rsi, %r11
; BURR-NEXT:    negq %r11
; BURR-NEXT:    movl $0, %r10d
; BURR-NEXT:    sbbq %rdx, %r10
; BURR-NEXT:    movl $0, %r9d
; BURR-NEXT:    sbbq %rcx, %r9
; BURR-NEXT:    sbbq %r8, %rdi
; BURR-NEXT:    andq %r8, %rdi
; BURR-NEXT:    bsrq %rdi, %r8
; BURR-NEXT:    xorq $63, %r8
; BURR-NEXT:    andq %rcx, %r9
; BURR-NEXT:    bsrq %r9, %rcx
; BURR-NEXT:    xorq $63, %rcx
; BURR-NEXT:    addq $64, %rcx
; BURR-NEXT:    testq %rdi, %rdi
; BURR-NEXT:    cmovneq %r8, %rcx
; BURR-NEXT:    andq %rdx, %r10
; BURR-NEXT:    bsrq %r10, %rdx
; BURR-NEXT:    xorq $63, %rdx
; BURR-NEXT:    andq %rsi, %r11
; BURR-NEXT:    movl $127, %esi
; BURR-NEXT:    bsrq %r11, %r8
; BURR-NEXT:    cmoveq %rsi, %r8
; BURR-NEXT:    xorq $63, %r8
; BURR-NEXT:    addq $64, %r8
; BURR-NEXT:    testq %r10, %r10
; BURR-NEXT:    cmovneq %rdx, %r8
; BURR-NEXT:    subq $-128, %r8
; BURR-NEXT:    orq %rdi, %r9
; BURR-NEXT:    cmovneq %rcx, %r8
; BURR-NEXT:    movq %r8, (%rax)
; BURR-NEXT:    movq $0, 24(%rax)
; BURR-NEXT:    movq $0, 16(%rax)
; BURR-NEXT:    movq $0, 8(%rax)
; BURR-NEXT:    retq
;
; SRC-LABEL: test2:
; SRC:       # %bb.0:
; SRC-NEXT:    movq %rdi, %rax
; SRC-NEXT:    xorl %edi, %edi
; SRC-NEXT:    movq %rsi, %r11
; SRC-NEXT:    negq %r11
; SRC-NEXT:    movl $0, %r10d
; SRC-NEXT:    sbbq %rdx, %r10
; SRC-NEXT:    movl $0, %r9d
; SRC-NEXT:    sbbq %rcx, %r9
; SRC-NEXT:    sbbq %r8, %rdi
; SRC-NEXT:    andq %rdx, %r10
; SRC-NEXT:    andq %rcx, %r9
; SRC-NEXT:    andq %r8, %rdi
; SRC-NEXT:    andq %rsi, %r11
; SRC-NEXT:    bsrq %rdi, %rcx
; SRC-NEXT:    xorq $63, %rcx
; SRC-NEXT:    bsrq %r9, %rdx
; SRC-NEXT:    xorq $63, %rdx
; SRC-NEXT:    addq $64, %rdx
; SRC-NEXT:    testq %rdi, %rdi
; SRC-NEXT:    cmovneq %rcx, %rdx
; SRC-NEXT:    bsrq %r10, %rcx
; SRC-NEXT:    xorq $63, %rcx
; SRC-NEXT:    bsrq %r11, %rsi
; SRC-NEXT:    movl $127, %r8d
; SRC-NEXT:    cmovneq %rsi, %r8
; SRC-NEXT:    xorq $63, %r8
; SRC-NEXT:    addq $64, %r8
; SRC-NEXT:    testq %r10, %r10
; SRC-NEXT:    cmovneq %rcx, %r8
; SRC-NEXT:    subq $-128, %r8
; SRC-NEXT:    orq %r9, %rdi
; SRC-NEXT:    cmovneq %rdx, %r8
; SRC-NEXT:    movq %r8, (%rax)
; SRC-NEXT:    movq $0, 24(%rax)
; SRC-NEXT:    movq $0, 16(%rax)
; SRC-NEXT:    movq $0, 8(%rax)
; SRC-NEXT:    retq
;
; LIN-LABEL: test2:
; LIN:       # %bb.0:
; LIN-NEXT:    movq %rdi, %rax
; LIN-NEXT:    movq %rsi, %rdi
; LIN-NEXT:    negq %rdi
; LIN-NEXT:    andq %rsi, %rdi
; LIN-NEXT:    bsrq %rdi, %rsi
; LIN-NEXT:    movl $127, %edi
; LIN-NEXT:    cmovneq %rsi, %rdi
; LIN-NEXT:    xorq $63, %rdi
; LIN-NEXT:    addq $64, %rdi
; LIN-NEXT:    xorl %esi, %esi
; LIN-NEXT:    movl $0, %r9d
; LIN-NEXT:    sbbq %rdx, %r9
; LIN-NEXT:    andq %rdx, %r9
; LIN-NEXT:    bsrq %r9, %rdx
; LIN-NEXT:    xorq $63, %rdx
; LIN-NEXT:    testq %r9, %r9
; LIN-NEXT:    cmoveq %rdi, %rdx
; LIN-NEXT:    subq $-128, %rdx
; LIN-NEXT:    movl $0, %edi
; LIN-NEXT:    sbbq %rcx, %rdi
; LIN-NEXT:    andq %rcx, %rdi
; LIN-NEXT:    bsrq %rdi, %rcx
; LIN-NEXT:    xorq $63, %rcx
; LIN-NEXT:    addq $64, %rcx
; LIN-NEXT:    sbbq %r8, %rsi
; LIN-NEXT:    andq %r8, %rsi
; LIN-NEXT:    bsrq %rsi, %r8
; LIN-NEXT:    xorq $63, %r8
; LIN-NEXT:    testq %rsi, %rsi
; LIN-NEXT:    cmoveq %rcx, %r8
; LIN-NEXT:    orq %rdi, %rsi
; LIN-NEXT:    cmoveq %rdx, %r8
; LIN-NEXT:    movq %r8, (%rax)
; LIN-NEXT:    movq $0, 8(%rax)
; LIN-NEXT:    movq $0, 16(%rax)
; LIN-NEXT:    movq $0, 24(%rax)
; LIN-NEXT:    retq
  %b = sub i256 0, %a
  %c = and i256 %b, %a
  %d = call i256 @llvm.ctlz.i256(i256 %c, i1 false)
  ret i256 %d
}

define i256 @test3(i256 %n) nounwind {
; ILP-LABEL: test3:
; ILP:       # %bb.0:
; ILP-NEXT:    pushq %rbx
; ILP-NEXT:    movq %rdi, %rax
; ILP-NEXT:    xorl %r9d, %r9d
; ILP-NEXT:    movq %rsi, %rdi
; ILP-NEXT:    negq %rdi
; ILP-NEXT:    movl $0, %r10d
; ILP-NEXT:    sbbq %rdx, %r10
; ILP-NEXT:    movl $0, %r11d
; ILP-NEXT:    sbbq %rcx, %r11
; ILP-NEXT:    sbbq %r8, %r9
; ILP-NEXT:    notq %r8
; ILP-NEXT:    andq %r9, %r8
; ILP-NEXT:    bsrq %r8, %rbx
; ILP-NEXT:    notq %rdx
; ILP-NEXT:    andq %r10, %rdx
; ILP-NEXT:    bsrq %rdx, %r9
; ILP-NEXT:    notq %rsi
; ILP-NEXT:    xorq $63, %rbx
; ILP-NEXT:    notq %rcx
; ILP-NEXT:    andq %r11, %rcx
; ILP-NEXT:    bsrq %rcx, %r10
; ILP-NEXT:    xorq $63, %r10
; ILP-NEXT:    addq $64, %r10
; ILP-NEXT:    testq %r8, %r8
; ILP-NEXT:    cmovneq %rbx, %r10
; ILP-NEXT:    xorq $63, %r9
; ILP-NEXT:    andq %rdi, %rsi
; ILP-NEXT:    movl $127, %edi
; ILP-NEXT:    bsrq %rsi, %rsi
; ILP-NEXT:    cmoveq %rdi, %rsi
; ILP-NEXT:    xorq $63, %rsi
; ILP-NEXT:    addq $64, %rsi
; ILP-NEXT:    testq %rdx, %rdx
; ILP-NEXT:    cmovneq %r9, %rsi
; ILP-NEXT:    subq $-128, %rsi
; ILP-NEXT:    orq %r8, %rcx
; ILP-NEXT:    cmovneq %r10, %rsi
; ILP-NEXT:    movq %rsi, (%rax)
; ILP-NEXT:    movq $0, 24(%rax)
; ILP-NEXT:    movq $0, 16(%rax)
; ILP-NEXT:    movq $0, 8(%rax)
; ILP-NEXT:    popq %rbx
; ILP-NEXT:    retq
;
; HYBRID-LABEL: test3:
; HYBRID:       # %bb.0:
; HYBRID-NEXT:    pushq %rbx
; HYBRID-NEXT:    movq %rdi, %rax
; HYBRID-NEXT:    xorl %r9d, %r9d
; HYBRID-NEXT:    movq %rsi, %rdi
; HYBRID-NEXT:    negq %rdi
; HYBRID-NEXT:    movl $0, %r10d
; HYBRID-NEXT:    sbbq %rdx, %r10
; HYBRID-NEXT:    movl $0, %r11d
; HYBRID-NEXT:    sbbq %rcx, %r11
; HYBRID-NEXT:    sbbq %r8, %r9
; HYBRID-NEXT:    notq %r8
; HYBRID-NEXT:    andq %r9, %r8
; HYBRID-NEXT:    bsrq %r8, %rbx
; HYBRID-NEXT:    xorq $63, %rbx
; HYBRID-NEXT:    notq %rcx
; HYBRID-NEXT:    andq %r11, %rcx
; HYBRID-NEXT:    bsrq %rcx, %r9
; HYBRID-NEXT:    xorq $63, %r9
; HYBRID-NEXT:    addq $64, %r9
; HYBRID-NEXT:    testq %r8, %r8
; HYBRID-NEXT:    cmovneq %rbx, %r9
; HYBRID-NEXT:    notq %rdx
; HYBRID-NEXT:    andq %r10, %rdx
; HYBRID-NEXT:    bsrq %rdx, %r10
; HYBRID-NEXT:    xorq $63, %r10
; HYBRID-NEXT:    notq %rsi
; HYBRID-NEXT:    andq %rdi, %rsi
; HYBRID-NEXT:    movl $127, %edi
; HYBRID-NEXT:    bsrq %rsi, %rsi
; HYBRID-NEXT:    cmoveq %rdi, %rsi
; HYBRID-NEXT:    xorq $63, %rsi
; HYBRID-NEXT:    addq $64, %rsi
; HYBRID-NEXT:    testq %rdx, %rdx
; HYBRID-NEXT:    cmovneq %r10, %rsi
; HYBRID-NEXT:    subq $-128, %rsi
; HYBRID-NEXT:    orq %r8, %rcx
; HYBRID-NEXT:    cmovneq %r9, %rsi
; HYBRID-NEXT:    movq %rsi, (%rax)
; HYBRID-NEXT:    movq $0, 24(%rax)
; HYBRID-NEXT:    movq $0, 16(%rax)
; HYBRID-NEXT:    movq $0, 8(%rax)
; HYBRID-NEXT:    popq %rbx
; HYBRID-NEXT:    retq
;
; BURR-LABEL: test3:
; BURR:       # %bb.0:
; BURR-NEXT:    pushq %rbx
; BURR-NEXT:    movq %rdi, %rax
; BURR-NEXT:    xorl %r9d, %r9d
; BURR-NEXT:    movq %rsi, %rdi
; BURR-NEXT:    negq %rdi
; BURR-NEXT:    movl $0, %r10d
; BURR-NEXT:    sbbq %rdx, %r10
; BURR-NEXT:    movl $0, %r11d
; BURR-NEXT:    sbbq %rcx, %r11
; BURR-NEXT:    sbbq %r8, %r9
; BURR-NEXT:    notq %r8
; BURR-NEXT:    andq %r9, %r8
; BURR-NEXT:    bsrq %r8, %rbx
; BURR-NEXT:    xorq $63, %rbx
; BURR-NEXT:    notq %rcx
; BURR-NEXT:    andq %r11, %rcx
; BURR-NEXT:    bsrq %rcx, %r9
; BURR-NEXT:    xorq $63, %r9
; BURR-NEXT:    addq $64, %r9
; BURR-NEXT:    testq %r8, %r8
; BURR-NEXT:    cmovneq %rbx, %r9
; BURR-NEXT:    notq %rdx
; BURR-NEXT:    andq %r10, %rdx
; BURR-NEXT:    bsrq %rdx, %r10
; BURR-NEXT:    xorq $63, %r10
; BURR-NEXT:    notq %rsi
; BURR-NEXT:    andq %rdi, %rsi
; BURR-NEXT:    movl $127, %edi
; BURR-NEXT:    bsrq %rsi, %rsi
; BURR-NEXT:    cmoveq %rdi, %rsi
; BURR-NEXT:    xorq $63, %rsi
; BURR-NEXT:    addq $64, %rsi
; BURR-NEXT:    testq %rdx, %rdx
; BURR-NEXT:    cmovneq %r10, %rsi
; BURR-NEXT:    subq $-128, %rsi
; BURR-NEXT:    orq %r8, %rcx
; BURR-NEXT:    cmovneq %r9, %rsi
; BURR-NEXT:    movq %rsi, (%rax)
; BURR-NEXT:    movq $0, 24(%rax)
; BURR-NEXT:    movq $0, 16(%rax)
; BURR-NEXT:    movq $0, 8(%rax)
; BURR-NEXT:    popq %rbx
; BURR-NEXT:    retq
;
; SRC-LABEL: test3:
; SRC:       # %bb.0:
; SRC-NEXT:    movq %rdi, %rax
; SRC-NEXT:    movq %rsi, %rdi
; SRC-NEXT:    notq %rdi
; SRC-NEXT:    xorl %r9d, %r9d
; SRC-NEXT:    negq %rsi
; SRC-NEXT:    movl $0, %r10d
; SRC-NEXT:    sbbq %rdx, %r10
; SRC-NEXT:    notq %rdx
; SRC-NEXT:    movl $0, %r11d
; SRC-NEXT:    sbbq %rcx, %r11
; SRC-NEXT:    notq %rcx
; SRC-NEXT:    sbbq %r8, %r9
; SRC-NEXT:    notq %r8
; SRC-NEXT:    andq %r10, %rdx
; SRC-NEXT:    andq %r11, %rcx
; SRC-NEXT:    andq %r9, %r8
; SRC-NEXT:    andq %rdi, %rsi
; SRC-NEXT:    bsrq %r8, %rdi
; SRC-NEXT:    xorq $63, %rdi
; SRC-NEXT:    bsrq %rcx, %r9
; SRC-NEXT:    xorq $63, %r9
; SRC-NEXT:    addq $64, %r9
; SRC-NEXT:    testq %r8, %r8
; SRC-NEXT:    cmovneq %rdi, %r9
; SRC-NEXT:    bsrq %rdx, %rdi
; SRC-NEXT:    xorq $63, %rdi
; SRC-NEXT:    bsrq %rsi, %rsi
; SRC-NEXT:    movl $127, %r10d
; SRC-NEXT:    cmovneq %rsi, %r10
; SRC-NEXT:    xorq $63, %r10
; SRC-NEXT:    addq $64, %r10
; SRC-NEXT:    testq %rdx, %rdx
; SRC-NEXT:    cmovneq %rdi, %r10
; SRC-NEXT:    subq $-128, %r10
; SRC-NEXT:    orq %rcx, %r8
; SRC-NEXT:    cmovneq %r9, %r10
; SRC-NEXT:    movq %r10, (%rax)
; SRC-NEXT:    movq $0, 24(%rax)
; SRC-NEXT:    movq $0, 16(%rax)
; SRC-NEXT:    movq $0, 8(%rax)
; SRC-NEXT:    retq
;
; LIN-LABEL: test3:
; LIN:       # %bb.0:
; LIN-NEXT:    movq %rdi, %rax
; LIN-NEXT:    movq %rsi, %rdi
; LIN-NEXT:    negq %rdi
; LIN-NEXT:    notq %rsi
; LIN-NEXT:    andq %rdi, %rsi
; LIN-NEXT:    bsrq %rsi, %rsi
; LIN-NEXT:    movl $127, %r9d
; LIN-NEXT:    cmovneq %rsi, %r9
; LIN-NEXT:    xorq $63, %r9
; LIN-NEXT:    addq $64, %r9
; LIN-NEXT:    xorl %edi, %edi
; LIN-NEXT:    movl $0, %esi
; LIN-NEXT:    sbbq %rdx, %rsi
; LIN-NEXT:    notq %rdx
; LIN-NEXT:    andq %rsi, %rdx
; LIN-NEXT:    bsrq %rdx, %rsi
; LIN-NEXT:    xorq $63, %rsi
; LIN-NEXT:    testq %rdx, %rdx
; LIN-NEXT:    cmoveq %r9, %rsi
; LIN-NEXT:    subq $-128, %rsi
; LIN-NEXT:    movl $0, %edx
; LIN-NEXT:    sbbq %rcx, %rdx
; LIN-NEXT:    notq %rcx
; LIN-NEXT:    andq %rdx, %rcx
; LIN-NEXT:    bsrq %rcx, %rdx
; LIN-NEXT:    xorq $63, %rdx
; LIN-NEXT:    addq $64, %rdx
; LIN-NEXT:    sbbq %r8, %rdi
; LIN-NEXT:    notq %r8
; LIN-NEXT:    andq %rdi, %r8
; LIN-NEXT:    bsrq %r8, %rdi
; LIN-NEXT:    xorq $63, %rdi
; LIN-NEXT:    testq %r8, %r8
; LIN-NEXT:    cmoveq %rdx, %rdi
; LIN-NEXT:    orq %rcx, %r8
; LIN-NEXT:    cmoveq %rsi, %rdi
; LIN-NEXT:    movq %rdi, (%rax)
; LIN-NEXT:    movq $0, 8(%rax)
; LIN-NEXT:    movq $0, 16(%rax)
; LIN-NEXT:    movq $0, 24(%rax)
; LIN-NEXT:    retq
  %m = sub i256 -1, %n
  %x = sub i256 0, %n
  %y = and i256 %x, %m
  %z = call i256 @llvm.ctlz.i256(i256 %y, i1 false)
  ret i256 %z
}

declare i256 @llvm.ctlz.i256(i256, i1) nounwind readnone

define i64 @test4(i64 %a, i64 %b) nounwind {
; ILP-LABEL: test4:
; ILP:       # %bb.0:
; ILP-NEXT:    xorl %eax, %eax
; ILP-NEXT:    xorl %ecx, %ecx
; ILP-NEXT:    incq %rsi
; ILP-NEXT:    sete %cl
; ILP-NEXT:    cmpq %rdi, %rsi
; ILP-NEXT:    sbbq $0, %rcx
; ILP-NEXT:    movl $0, %ecx
; ILP-NEXT:    sbbq %rcx, %rcx
; ILP-NEXT:    movl $0, %ecx
; ILP-NEXT:    sbbq %rcx, %rcx
; ILP-NEXT:    adcq $1, %rax
; ILP-NEXT:    retq
;
; HYBRID-LABEL: test4:
; HYBRID:       # %bb.0:
; HYBRID-NEXT:    xorl %eax, %eax
; HYBRID-NEXT:    xorl %ecx, %ecx
; HYBRID-NEXT:    incq %rsi
; HYBRID-NEXT:    sete %cl
; HYBRID-NEXT:    cmpq %rdi, %rsi
; HYBRID-NEXT:    sbbq $0, %rcx
; HYBRID-NEXT:    movl $0, %ecx
; HYBRID-NEXT:    sbbq %rcx, %rcx
; HYBRID-NEXT:    movl $0, %ecx
; HYBRID-NEXT:    sbbq %rcx, %rcx
; HYBRID-NEXT:    adcq $1, %rax
; HYBRID-NEXT:    retq
;
; BURR-LABEL: test4:
; BURR:       # %bb.0:
; BURR-NEXT:    xorl %eax, %eax
; BURR-NEXT:    xorl %ecx, %ecx
; BURR-NEXT:    incq %rsi
; BURR-NEXT:    sete %cl
; BURR-NEXT:    cmpq %rdi, %rsi
; BURR-NEXT:    sbbq $0, %rcx
; BURR-NEXT:    movl $0, %ecx
; BURR-NEXT:    sbbq %rcx, %rcx
; BURR-NEXT:    movl $0, %ecx
; BURR-NEXT:    sbbq %rcx, %rcx
; BURR-NEXT:    adcq $1, %rax
; BURR-NEXT:    retq
;
; SRC-LABEL: test4:
; SRC:       # %bb.0:
; SRC-NEXT:    xorl %ecx, %ecx
; SRC-NEXT:    incq %rsi
; SRC-NEXT:    sete %cl
; SRC-NEXT:    xorl %eax, %eax
; SRC-NEXT:    cmpq %rdi, %rsi
; SRC-NEXT:    sbbq $0, %rcx
; SRC-NEXT:    movl $0, %ecx
; SRC-NEXT:    sbbq %rcx, %rcx
; SRC-NEXT:    movl $0, %ecx
; SRC-NEXT:    sbbq %rcx, %rcx
; SRC-NEXT:    adcq $1, %rax
; SRC-NEXT:    retq
;
; LIN-LABEL: test4:
; LIN:       # %bb.0:
; LIN-NEXT:    xorl %eax, %eax
; LIN-NEXT:    xorl %ecx, %ecx
; LIN-NEXT:    incq %rsi
; LIN-NEXT:    sete %cl
; LIN-NEXT:    cmpq %rdi, %rsi
; LIN-NEXT:    sbbq $0, %rcx
; LIN-NEXT:    movl $0, %ecx
; LIN-NEXT:    sbbq %rcx, %rcx
; LIN-NEXT:    movl $0, %ecx
; LIN-NEXT:    sbbq %rcx, %rcx
; LIN-NEXT:    adcq $1, %rax
; LIN-NEXT:    retq
  %r = zext i64 %b to i256
  %u = add i256 %r, 1
  %w = and i256 %u, 1461501637330902918203684832716283019655932542975
  %x = zext i64 %a to i256
  %c = icmp uge i256 %w, %x
  %y = select i1 %c, i64 0, i64 1
  %z = add i64 %y, 1
  ret i64 %z
}

define i256 @PR25498(i256 %a) nounwind {
; ILP-LABEL: PR25498:
; ILP:       # %bb.0:
; ILP-NEXT:    pushq %rbx
; ILP-NEXT:    movq %rdi, %rax
; ILP-NEXT:    xorl %edi, %edi
; ILP-NEXT:    movq %rsi, %rbx
; ILP-NEXT:    negq %rbx
; ILP-NEXT:    movl $0, %r11d
; ILP-NEXT:    sbbq %rdx, %r11
; ILP-NEXT:    movl $0, %r9d
; ILP-NEXT:    sbbq %rcx, %r9
; ILP-NEXT:    movl $0, %r10d
; ILP-NEXT:    sbbq %r8, %r10
; ILP-NEXT:    orq %r8, %rdx
; ILP-NEXT:    orq %rcx, %rsi
; ILP-NEXT:    orq %rdx, %rsi
; ILP-NEXT:    je .LBB4_1
; ILP-NEXT:  # %bb.2: # %cond.false
; ILP-NEXT:    bsrq %r11, %rdx
; ILP-NEXT:    bsrq %r10, %rcx
; ILP-NEXT:    xorq $63, %rcx
; ILP-NEXT:    bsrq %r9, %rsi
; ILP-NEXT:    xorq $63, %rsi
; ILP-NEXT:    addq $64, %rsi
; ILP-NEXT:    testq %r10, %r10
; ILP-NEXT:    cmovneq %rcx, %rsi
; ILP-NEXT:    xorq $63, %rdx
; ILP-NEXT:    bsrq %rbx, %rcx
; ILP-NEXT:    xorq $63, %rcx
; ILP-NEXT:    addq $64, %rcx
; ILP-NEXT:    testq %r11, %r11
; ILP-NEXT:    cmovneq %rdx, %rcx
; ILP-NEXT:    subq $-128, %rcx
; ILP-NEXT:    xorl %edi, %edi
; ILP-NEXT:    orq %r10, %r9
; ILP-NEXT:    cmovneq %rsi, %rcx
; ILP-NEXT:    jmp .LBB4_3
; ILP-NEXT:  .LBB4_1:
; ILP-NEXT:    movl $256, %ecx # imm = 0x100
; ILP-NEXT:  .LBB4_3: # %cond.end
; ILP-NEXT:    movq %rcx, (%rax)
; ILP-NEXT:    movq %rdi, 8(%rax)
; ILP-NEXT:    movq %rdi, 16(%rax)
; ILP-NEXT:    movq %rdi, 24(%rax)
; ILP-NEXT:    popq %rbx
; ILP-NEXT:    retq
;
; HYBRID-LABEL: PR25498:
; HYBRID:       # %bb.0:
; HYBRID-NEXT:    pushq %rbx
; HYBRID-NEXT:    movq %rdi, %rax
; HYBRID-NEXT:    xorl %edi, %edi
; HYBRID-NEXT:    movq %rsi, %rbx
; HYBRID-NEXT:    negq %rbx
; HYBRID-NEXT:    movl $0, %r11d
; HYBRID-NEXT:    sbbq %rdx, %r11
; HYBRID-NEXT:    movl $0, %r9d
; HYBRID-NEXT:    sbbq %rcx, %r9
; HYBRID-NEXT:    movl $0, %r10d
; HYBRID-NEXT:    sbbq %r8, %r10
; HYBRID-NEXT:    orq %r8, %rdx
; HYBRID-NEXT:    orq %rcx, %rsi
; HYBRID-NEXT:    orq %rdx, %rsi
; HYBRID-NEXT:    je .LBB4_1
; HYBRID-NEXT:  # %bb.2: # %cond.false
; HYBRID-NEXT:    bsrq %r10, %rcx
; HYBRID-NEXT:    xorq $63, %rcx
; HYBRID-NEXT:    bsrq %r9, %rdx
; HYBRID-NEXT:    xorq $63, %rdx
; HYBRID-NEXT:    addq $64, %rdx
; HYBRID-NEXT:    testq %r10, %r10
; HYBRID-NEXT:    cmovneq %rcx, %rdx
; HYBRID-NEXT:    bsrq %r11, %rsi
; HYBRID-NEXT:    xorq $63, %rsi
; HYBRID-NEXT:    bsrq %rbx, %rcx
; HYBRID-NEXT:    xorq $63, %rcx
; HYBRID-NEXT:    addq $64, %rcx
; HYBRID-NEXT:    testq %r11, %r11
; HYBRID-NEXT:    cmovneq %rsi, %rcx
; HYBRID-NEXT:    subq $-128, %rcx
; HYBRID-NEXT:    orq %r10, %r9
; HYBRID-NEXT:    cmovneq %rdx, %rcx
; HYBRID-NEXT:    xorl %edi, %edi
; HYBRID-NEXT:    jmp .LBB4_3
; HYBRID-NEXT:  .LBB4_1:
; HYBRID-NEXT:    movl $256, %ecx # imm = 0x100
; HYBRID-NEXT:  .LBB4_3: # %cond.end
; HYBRID-NEXT:    movq %rcx, (%rax)
; HYBRID-NEXT:    movq %rdi, 8(%rax)
; HYBRID-NEXT:    movq %rdi, 16(%rax)
; HYBRID-NEXT:    movq %rdi, 24(%rax)
; HYBRID-NEXT:    popq %rbx
; HYBRID-NEXT:    retq
;
; BURR-LABEL: PR25498:
; BURR:       # %bb.0:
; BURR-NEXT:    pushq %rbx
; BURR-NEXT:    movq %rdi, %rax
; BURR-NEXT:    xorl %edi, %edi
; BURR-NEXT:    movq %rsi, %rbx
; BURR-NEXT:    negq %rbx
; BURR-NEXT:    movl $0, %r11d
; BURR-NEXT:    sbbq %rdx, %r11
; BURR-NEXT:    movl $0, %r9d
; BURR-NEXT:    sbbq %rcx, %r9
; BURR-NEXT:    movl $0, %r10d
; BURR-NEXT:    sbbq %r8, %r10
; BURR-NEXT:    orq %r8, %rdx
; BURR-NEXT:    orq %rcx, %rsi
; BURR-NEXT:    orq %rdx, %rsi
; BURR-NEXT:    je .LBB4_1
; BURR-NEXT:  # %bb.2: # %cond.false
; BURR-NEXT:    bsrq %r10, %rcx
; BURR-NEXT:    xorq $63, %rcx
; BURR-NEXT:    bsrq %r9, %rdx
; BURR-NEXT:    xorq $63, %rdx
; BURR-NEXT:    addq $64, %rdx
; BURR-NEXT:    testq %r10, %r10
; BURR-NEXT:    cmovneq %rcx, %rdx
; BURR-NEXT:    bsrq %r11, %rsi
; BURR-NEXT:    xorq $63, %rsi
; BURR-NEXT:    bsrq %rbx, %rcx
; BURR-NEXT:    xorq $63, %rcx
; BURR-NEXT:    addq $64, %rcx
; BURR-NEXT:    testq %r11, %r11
; BURR-NEXT:    cmovneq %rsi, %rcx
; BURR-NEXT:    subq $-128, %rcx
; BURR-NEXT:    orq %r10, %r9
; BURR-NEXT:    cmovneq %rdx, %rcx
; BURR-NEXT:    xorl %edi, %edi
; BURR-NEXT:    jmp .LBB4_3
; BURR-NEXT:  .LBB4_1:
; BURR-NEXT:    movl $256, %ecx # imm = 0x100
; BURR-NEXT:  .LBB4_3: # %cond.end
; BURR-NEXT:    movq %rcx, (%rax)
; BURR-NEXT:    movq %rdi, 8(%rax)
; BURR-NEXT:    movq %rdi, 16(%rax)
; BURR-NEXT:    movq %rdi, 24(%rax)
; BURR-NEXT:    popq %rbx
; BURR-NEXT:    retq
;
; SRC-LABEL: PR25498:
; SRC:       # %bb.0:
; SRC-NEXT:    pushq %rbx
; SRC-NEXT:    movq %rdi, %rax
; SRC-NEXT:    xorl %edi, %edi
; SRC-NEXT:    movq %rsi, %rbx
; SRC-NEXT:    negq %rbx
; SRC-NEXT:    movl $0, %r11d
; SRC-NEXT:    sbbq %rdx, %r11
; SRC-NEXT:    movl $0, %r9d
; SRC-NEXT:    sbbq %rcx, %r9
; SRC-NEXT:    movl $0, %r10d
; SRC-NEXT:    sbbq %r8, %r10
; SRC-NEXT:    orq %r8, %rdx
; SRC-NEXT:    orq %rcx, %rsi
; SRC-NEXT:    orq %rdx, %rsi
; SRC-NEXT:    je .LBB4_1
; SRC-NEXT:  # %bb.2: # %cond.false
; SRC-NEXT:    bsrq %r10, %rcx
; SRC-NEXT:    xorq $63, %rcx
; SRC-NEXT:    bsrq %r9, %rdx
; SRC-NEXT:    xorq $63, %rdx
; SRC-NEXT:    addq $64, %rdx
; SRC-NEXT:    testq %r10, %r10
; SRC-NEXT:    cmovneq %rcx, %rdx
; SRC-NEXT:    bsrq %r11, %rsi
; SRC-NEXT:    xorq $63, %rsi
; SRC-NEXT:    bsrq %rbx, %rcx
; SRC-NEXT:    xorq $63, %rcx
; SRC-NEXT:    addq $64, %rcx
; SRC-NEXT:    testq %r11, %r11
; SRC-NEXT:    cmovneq %rsi, %rcx
; SRC-NEXT:    subq $-128, %rcx
; SRC-NEXT:    orq %r10, %r9
; SRC-NEXT:    cmovneq %rdx, %rcx
; SRC-NEXT:    xorl %edi, %edi
; SRC-NEXT:    jmp .LBB4_3
; SRC-NEXT:  .LBB4_1:
; SRC-NEXT:    movl $256, %ecx # imm = 0x100
; SRC-NEXT:  .LBB4_3: # %cond.end
; SRC-NEXT:    movq %rcx, (%rax)
; SRC-NEXT:    movq %rdi, 8(%rax)
; SRC-NEXT:    movq %rdi, 16(%rax)
; SRC-NEXT:    movq %rdi, 24(%rax)
; SRC-NEXT:    popq %rbx
; SRC-NEXT:    retq
;
; LIN-LABEL: PR25498:
; LIN:       # %bb.0:
; LIN-NEXT:    pushq %rbx
; LIN-NEXT:    movq %rdi, %rax
; LIN-NEXT:    movq %rsi, %rbx
; LIN-NEXT:    negq %rbx
; LIN-NEXT:    xorl %edi, %edi
; LIN-NEXT:    movl $0, %r11d
; LIN-NEXT:    sbbq %rdx, %r11
; LIN-NEXT:    movl $0, %r9d
; LIN-NEXT:    sbbq %rcx, %r9
; LIN-NEXT:    movl $0, %r10d
; LIN-NEXT:    sbbq %r8, %r10
; LIN-NEXT:    orq %rcx, %rsi
; LIN-NEXT:    orq %r8, %rdx
; LIN-NEXT:    orq %rsi, %rdx
; LIN-NEXT:    je .LBB4_1
; LIN-NEXT:  # %bb.2: # %cond.false
; LIN-NEXT:    bsrq %rbx, %rcx
; LIN-NEXT:    xorq $63, %rcx
; LIN-NEXT:    addq $64, %rcx
; LIN-NEXT:    bsrq %r11, %rdx
; LIN-NEXT:    xorq $63, %rdx
; LIN-NEXT:    testq %r11, %r11
; LIN-NEXT:    cmoveq %rcx, %rdx
; LIN-NEXT:    subq $-128, %rdx
; LIN-NEXT:    bsrq %r9, %rsi
; LIN-NEXT:    xorq $63, %rsi
; LIN-NEXT:    addq $64, %rsi
; LIN-NEXT:    bsrq %r10, %rcx
; LIN-NEXT:    xorq $63, %rcx
; LIN-NEXT:    testq %r10, %r10
; LIN-NEXT:    cmoveq %rsi, %rcx
; LIN-NEXT:    orq %r10, %r9
; LIN-NEXT:    cmoveq %rdx, %rcx
; LIN-NEXT:    xorl %edi, %edi
; LIN-NEXT:    jmp .LBB4_3
; LIN-NEXT:  .LBB4_1:
; LIN-NEXT:    movl $256, %ecx # imm = 0x100
; LIN-NEXT:  .LBB4_3: # %cond.end
; LIN-NEXT:    movq %rcx, (%rax)
; LIN-NEXT:    movq %rdi, 8(%rax)
; LIN-NEXT:    movq %rdi, 16(%rax)
; LIN-NEXT:    movq %rdi, 24(%rax)
; LIN-NEXT:    popq %rbx
; LIN-NEXT:    retq
  %b = sub i256 0, %a
  %cmpz = icmp eq i256 %b, 0
  br i1 %cmpz, label %cond.end, label %cond.false

cond.false:
  %d = call i256 @llvm.ctlz.i256(i256 %b, i1 true)
  br label %cond.end

cond.end:
  %ctz = phi i256 [ 256, %0 ], [ %d, %cond.false ]
  ret i256 %ctz
}

