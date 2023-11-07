; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=i686 -mattr=cmov | FileCheck %s --check-prefix=X86

declare  i4  @llvm.sdiv.fix.i4   (i4,  i4,  i32)
declare  i15 @llvm.sdiv.fix.i15  (i15, i15, i32)
declare  i16 @llvm.sdiv.fix.i16  (i16, i16, i32)
declare  i18 @llvm.sdiv.fix.i18  (i18, i18, i32)
declare  i64 @llvm.sdiv.fix.i64  (i64, i64, i32)
declare  <4 x i32> @llvm.sdiv.fix.v4i32(<4 x i32>, <4 x i32>, i32)

define i16 @func(i16 %x, i16 %y) nounwind {
; X64-LABEL: func:
; X64:       # %bb.0:
; X64-NEXT:    movswl %si, %esi
; X64-NEXT:    movswl %di, %ecx
; X64-NEXT:    shll $7, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    cltd
; X64-NEXT:    idivl %esi
; X64-NEXT:    # kill: def $eax killed $eax def $rax
; X64-NEXT:    leal -1(%rax), %edi
; X64-NEXT:    testl %esi, %esi
; X64-NEXT:    sets %sil
; X64-NEXT:    testl %ecx, %ecx
; X64-NEXT:    sets %cl
; X64-NEXT:    xorb %sil, %cl
; X64-NEXT:    testl %edx, %edx
; X64-NEXT:    setne %dl
; X64-NEXT:    testb %cl, %dl
; X64-NEXT:    cmovnel %edi, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $rax
; X64-NEXT:    retq
;
; X86-LABEL: func:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shll $7, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    cltd
; X86-NEXT:    idivl %esi
; X86-NEXT:    leal -1(%eax), %edi
; X86-NEXT:    testl %esi, %esi
; X86-NEXT:    sets %bl
; X86-NEXT:    testl %ecx, %ecx
; X86-NEXT:    sets %cl
; X86-NEXT:    xorb %bl, %cl
; X86-NEXT:    testl %edx, %edx
; X86-NEXT:    setne %dl
; X86-NEXT:    testb %cl, %dl
; X86-NEXT:    cmovnel %edi, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %tmp = call i16 @llvm.sdiv.fix.i16(i16 %x, i16 %y, i32 7)
  ret i16 %tmp
}

define i16 @func2(i8 %x, i8 %y) nounwind {
; X64-LABEL: func2:
; X64:       # %bb.0:
; X64-NEXT:    movsbl %sil, %esi
; X64-NEXT:    movsbl %dil, %ecx
; X64-NEXT:    shll $14, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    cltd
; X64-NEXT:    idivl %esi
; X64-NEXT:    # kill: def $eax killed $eax def $rax
; X64-NEXT:    leal -1(%rax), %edi
; X64-NEXT:    testl %esi, %esi
; X64-NEXT:    sets %sil
; X64-NEXT:    testl %ecx, %ecx
; X64-NEXT:    sets %cl
; X64-NEXT:    xorb %sil, %cl
; X64-NEXT:    testl %edx, %edx
; X64-NEXT:    setne %dl
; X64-NEXT:    testb %cl, %dl
; X64-NEXT:    cmovel %eax, %edi
; X64-NEXT:    addl %edi, %edi
; X64-NEXT:    movswl %di, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: func2:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shll $14, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    cltd
; X86-NEXT:    idivl %edi
; X86-NEXT:    leal -1(%eax), %esi
; X86-NEXT:    testl %edi, %edi
; X86-NEXT:    sets %bl
; X86-NEXT:    testl %ecx, %ecx
; X86-NEXT:    sets %cl
; X86-NEXT:    xorb %bl, %cl
; X86-NEXT:    testl %edx, %edx
; X86-NEXT:    setne %dl
; X86-NEXT:    testb %cl, %dl
; X86-NEXT:    cmovel %eax, %esi
; X86-NEXT:    addl %esi, %esi
; X86-NEXT:    movswl %si, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %x2 = sext i8 %x to i15
  %y2 = sext i8 %y to i15
  %tmp = call i15 @llvm.sdiv.fix.i15(i15 %x2, i15 %y2, i32 14)
  %tmp2 = sext i15 %tmp to i16
  ret i16 %tmp2
}

define i16 @func3(i15 %x, i8 %y) nounwind {
; X64-LABEL: func3:
; X64:       # %bb.0:
; X64-NEXT:    shll $8, %esi
; X64-NEXT:    movswl %si, %ecx
; X64-NEXT:    addl %edi, %edi
; X64-NEXT:    shrl $4, %ecx
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    cwtd
; X64-NEXT:    idivw %cx
; X64-NEXT:    # kill: def $ax killed $ax def $rax
; X64-NEXT:    leal -1(%rax), %esi
; X64-NEXT:    testw %di, %di
; X64-NEXT:    sets %dil
; X64-NEXT:    testw %cx, %cx
; X64-NEXT:    sets %cl
; X64-NEXT:    xorb %dil, %cl
; X64-NEXT:    testw %dx, %dx
; X64-NEXT:    setne %dl
; X64-NEXT:    testb %cl, %dl
; X64-NEXT:    cmovel %eax, %esi
; X64-NEXT:    addl %esi, %esi
; X64-NEXT:    movswl %si, %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: func3:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    shll $8, %eax
; X86-NEXT:    movswl %ax, %esi
; X86-NEXT:    addl %ecx, %ecx
; X86-NEXT:    shrl $4, %esi
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    cwtd
; X86-NEXT:    idivw %si
; X86-NEXT:    # kill: def $ax killed $ax def $eax
; X86-NEXT:    leal -1(%eax), %edi
; X86-NEXT:    testw %cx, %cx
; X86-NEXT:    sets %cl
; X86-NEXT:    testw %si, %si
; X86-NEXT:    sets %ch
; X86-NEXT:    xorb %cl, %ch
; X86-NEXT:    testw %dx, %dx
; X86-NEXT:    setne %cl
; X86-NEXT:    testb %ch, %cl
; X86-NEXT:    cmovel %eax, %edi
; X86-NEXT:    addl %edi, %edi
; X86-NEXT:    movswl %di, %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl
  %y2 = sext i8 %y to i15
  %y3 = shl i15 %y2, 7
  %tmp = call i15 @llvm.sdiv.fix.i15(i15 %x, i15 %y3, i32 4)
  %tmp2 = sext i15 %tmp to i16
  ret i16 %tmp2
}

define i4 @func4(i4 %x, i4 %y) nounwind {
; X64-LABEL: func4:
; X64:       # %bb.0:
; X64-NEXT:    shlb $4, %sil
; X64-NEXT:    sarb $4, %sil
; X64-NEXT:    shlb $4, %dil
; X64-NEXT:    sarb $4, %dil
; X64-NEXT:    shlb $2, %dil
; X64-NEXT:    movsbl %dil, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    idivb %sil
; X64-NEXT:    movsbl %ah, %edx
; X64-NEXT:    movzbl %al, %edi
; X64-NEXT:    leal -1(%rdi), %eax
; X64-NEXT:    movzbl %al, %eax
; X64-NEXT:    testb %sil, %sil
; X64-NEXT:    sets %sil
; X64-NEXT:    testb %cl, %cl
; X64-NEXT:    sets %cl
; X64-NEXT:    xorb %sil, %cl
; X64-NEXT:    testb %dl, %dl
; X64-NEXT:    setne %dl
; X64-NEXT:    testb %cl, %dl
; X64-NEXT:    cmovel %edi, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: func4:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %esi
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shlb $4, %cl
; X86-NEXT:    sarb $4, %cl
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    shlb $4, %dl
; X86-NEXT:    sarb $4, %dl
; X86-NEXT:    shlb $2, %dl
; X86-NEXT:    movsbl %dl, %eax
; X86-NEXT:    idivb %cl
; X86-NEXT:    movsbl %ah, %ebx
; X86-NEXT:    movzbl %al, %esi
; X86-NEXT:    decb %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    testb %cl, %cl
; X86-NEXT:    sets %cl
; X86-NEXT:    testb %dl, %dl
; X86-NEXT:    sets %dl
; X86-NEXT:    xorb %cl, %dl
; X86-NEXT:    testb %bl, %bl
; X86-NEXT:    setne %cl
; X86-NEXT:    testb %dl, %cl
; X86-NEXT:    cmovel %esi, %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %tmp = call i4 @llvm.sdiv.fix.i4(i4 %x, i4 %y, i32 2)
  ret i4 %tmp
}

define i64 @func5(i64 %x, i64 %y) nounwind {
; X64-LABEL: func5:
; X64:       # %bb.0:
; X64-NEXT:    pushq %rbp
; X64-NEXT:    pushq %r15
; X64-NEXT:    pushq %r14
; X64-NEXT:    pushq %r13
; X64-NEXT:    pushq %r12
; X64-NEXT:    pushq %rbx
; X64-NEXT:    pushq %rax
; X64-NEXT:    movq %rsi, %rbx
; X64-NEXT:    movq %rdi, %r14
; X64-NEXT:    movq %rdi, %r15
; X64-NEXT:    sarq $63, %r15
; X64-NEXT:    shldq $31, %rdi, %r15
; X64-NEXT:    shlq $31, %r14
; X64-NEXT:    movq %rsi, %r12
; X64-NEXT:    sarq $63, %r12
; X64-NEXT:    movq %r14, %rdi
; X64-NEXT:    movq %r15, %rsi
; X64-NEXT:    movq %rbx, %rdx
; X64-NEXT:    movq %r12, %rcx
; X64-NEXT:    callq __divti3@PLT
; X64-NEXT:    movq %rax, (%rsp) # 8-byte Spill
; X64-NEXT:    leaq -1(%rax), %rbp
; X64-NEXT:    testq %r15, %r15
; X64-NEXT:    sets %al
; X64-NEXT:    testq %r12, %r12
; X64-NEXT:    sets %r13b
; X64-NEXT:    xorb %al, %r13b
; X64-NEXT:    movq %r14, %rdi
; X64-NEXT:    movq %r15, %rsi
; X64-NEXT:    movq %rbx, %rdx
; X64-NEXT:    movq %r12, %rcx
; X64-NEXT:    callq __modti3@PLT
; X64-NEXT:    orq %rax, %rdx
; X64-NEXT:    setne %al
; X64-NEXT:    testb %r13b, %al
; X64-NEXT:    cmoveq (%rsp), %rbp # 8-byte Folded Reload
; X64-NEXT:    movq %rbp, %rax
; X64-NEXT:    addq $8, %rsp
; X64-NEXT:    popq %rbx
; X64-NEXT:    popq %r12
; X64-NEXT:    popq %r13
; X64-NEXT:    popq %r14
; X64-NEXT:    popq %r15
; X64-NEXT:    popq %rbp
; X64-NEXT:    retq
;
; X86-LABEL: func5:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $72, %esp
; X86-NEXT:    movl 8(%ebp), %ecx
; X86-NEXT:    movl 12(%ebp), %eax
; X86-NEXT:    movl 20(%ebp), %edx
; X86-NEXT:    movl %edx, %esi
; X86-NEXT:    sarl $31, %esi
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    sarl $31, %edi
; X86-NEXT:    movl %edi, %ebx
; X86-NEXT:    shldl $31, %eax, %ebx
; X86-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    shldl $31, %ecx, %eax
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    shll $31, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %edx
; X86-NEXT:    pushl 16(%ebp)
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %eax
; X86-NEXT:    pushl %ecx
; X86-NEXT:    leal {{[0-9]+}}(%esp), %eax
; X86-NEXT:    pushl %eax
; X86-NEXT:    calll __divti3
; X86-NEXT:    addl $32, %esp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    subl $1, %eax
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    sbbl $0, %ebx
; X86-NEXT:    testl %esi, %esi
; X86-NEXT:    sets %al
; X86-NEXT:    testl %edi, %edi
; X86-NEXT:    sets %cl
; X86-NEXT:    xorb %al, %cl
; X86-NEXT:    movb %cl, {{[-0-9]+}}(%e{{[sb]}}p) # 1-byte Spill
; X86-NEXT:    leal {{[0-9]+}}(%esp), %eax
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl 20(%ebp)
; X86-NEXT:    pushl 16(%ebp)
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; X86-NEXT:    pushl {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; X86-NEXT:    pushl {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; X86-NEXT:    pushl %eax
; X86-NEXT:    calll __modti3
; X86-NEXT:    addl $32, %esp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    orl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    orl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    orl %eax, %ecx
; X86-NEXT:    setne %al
; X86-NEXT:    testb %al, {{[-0-9]+}}(%e{{[sb]}}p) # 1-byte Folded Reload
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X86-NEXT:    cmovel {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Folded Reload
; X86-NEXT:    cmovel {{[-0-9]+}}(%e{{[sb]}}p), %ebx # 4-byte Folded Reload
; X86-NEXT:    movl %ebx, %edx
; X86-NEXT:    leal -12(%ebp), %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
  %tmp = call i64 @llvm.sdiv.fix.i64(i64 %x, i64 %y, i32 31)
  ret i64 %tmp
}

define i18 @func6(i16 %x, i16 %y) nounwind {
; X64-LABEL: func6:
; X64:       # %bb.0:
; X64-NEXT:    movswl %di, %ecx
; X64-NEXT:    movswl %si, %esi
; X64-NEXT:    shll $7, %ecx
; X64-NEXT:    movl %ecx, %eax
; X64-NEXT:    cltd
; X64-NEXT:    idivl %esi
; X64-NEXT:    # kill: def $eax killed $eax def $rax
; X64-NEXT:    leal -1(%rax), %edi
; X64-NEXT:    testl %esi, %esi
; X64-NEXT:    sets %sil
; X64-NEXT:    testl %ecx, %ecx
; X64-NEXT:    sets %cl
; X64-NEXT:    xorb %sil, %cl
; X64-NEXT:    testl %edx, %edx
; X64-NEXT:    setne %dl
; X64-NEXT:    testb %cl, %dl
; X64-NEXT:    cmovnel %edi, %eax
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    retq
;
; X86-LABEL: func6:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    shll $7, %ecx
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    cltd
; X86-NEXT:    idivl %esi
; X86-NEXT:    leal -1(%eax), %edi
; X86-NEXT:    testl %esi, %esi
; X86-NEXT:    sets %bl
; X86-NEXT:    testl %ecx, %ecx
; X86-NEXT:    sets %cl
; X86-NEXT:    xorb %bl, %cl
; X86-NEXT:    testl %edx, %edx
; X86-NEXT:    setne %dl
; X86-NEXT:    testb %cl, %dl
; X86-NEXT:    cmovnel %edi, %eax
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %x2 = sext i16 %x to i18
  %y2 = sext i16 %y to i18
  %tmp = call i18 @llvm.sdiv.fix.i18(i18 %x2, i18 %y2, i32 7)
  ret i18 %tmp
}

define <4 x i32> @vec(<4 x i32> %x, <4 x i32> %y) nounwind {
; X64-LABEL: vec:
; X64:       # %bb.0:
; X64-NEXT:    pxor %xmm2, %xmm2
; X64-NEXT:    pcmpgtd %xmm1, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm4 = xmm1[2,3,2,3]
; X64-NEXT:    movdqa %xmm1, %xmm3
; X64-NEXT:    punpckldq {{.*#+}} xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
; X64-NEXT:    movq %xmm3, %rcx
; X64-NEXT:    pxor %xmm5, %xmm5
; X64-NEXT:    pcmpgtd %xmm0, %xmm5
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; X64-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm5[0],xmm0[1],xmm5[1]
; X64-NEXT:    psllq $31, %xmm0
; X64-NEXT:    movq %xmm0, %rax
; X64-NEXT:    cqto
; X64-NEXT:    idivq %rcx
; X64-NEXT:    movq %rax, %rcx
; X64-NEXT:    movq %rdx, %rsi
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[2,3,2,3]
; X64-NEXT:    movq %xmm3, %rdi
; X64-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[2,3,2,3]
; X64-NEXT:    movq %xmm3, %rax
; X64-NEXT:    cqto
; X64-NEXT:    idivq %rdi
; X64-NEXT:    movq %rax, %rdi
; X64-NEXT:    movq %rdx, %r8
; X64-NEXT:    pxor %xmm3, %xmm3
; X64-NEXT:    pcmpgtd %xmm4, %xmm3
; X64-NEXT:    punpckldq {{.*#+}} xmm4 = xmm4[0],xmm3[0],xmm4[1],xmm3[1]
; X64-NEXT:    movq %xmm4, %r9
; X64-NEXT:    pxor %xmm5, %xmm5
; X64-NEXT:    pcmpgtd %xmm1, %xmm5
; X64-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm5[0],xmm1[1],xmm5[1]
; X64-NEXT:    psllq $31, %xmm1
; X64-NEXT:    movq %xmm1, %rax
; X64-NEXT:    cqto
; X64-NEXT:    idivq %r9
; X64-NEXT:    movq %rax, %r9
; X64-NEXT:    movq %rdx, %r10
; X64-NEXT:    pshufd {{.*#+}} xmm4 = xmm4[2,3,2,3]
; X64-NEXT:    movq %xmm4, %r11
; X64-NEXT:    pshufd {{.*#+}} xmm4 = xmm1[2,3,2,3]
; X64-NEXT:    movq %xmm4, %rax
; X64-NEXT:    cqto
; X64-NEXT:    idivq %r11
; X64-NEXT:    movq %rsi, %xmm4
; X64-NEXT:    movq %r8, %xmm5
; X64-NEXT:    pxor %xmm6, %xmm6
; X64-NEXT:    punpcklqdq {{.*#+}} xmm4 = xmm4[0],xmm5[0]
; X64-NEXT:    pcmpeqd %xmm6, %xmm4
; X64-NEXT:    pshufd {{.*#+}} xmm5 = xmm4[1,0,3,2]
; X64-NEXT:    pand %xmm4, %xmm5
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[0,0,1,1]
; X64-NEXT:    pxor %xmm4, %xmm4
; X64-NEXT:    pcmpgtd %xmm2, %xmm4
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; X64-NEXT:    pxor %xmm2, %xmm2
; X64-NEXT:    pcmpgtd %xmm0, %xmm2
; X64-NEXT:    movq %rcx, %xmm0
; X64-NEXT:    pxor %xmm4, %xmm2
; X64-NEXT:    movq %rdi, %xmm4
; X64-NEXT:    pandn %xmm2, %xmm5
; X64-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm4[0]
; X64-NEXT:    movdqa %xmm5, %xmm2
; X64-NEXT:    pandn %xmm0, %xmm2
; X64-NEXT:    pcmpeqd %xmm4, %xmm4
; X64-NEXT:    paddq %xmm4, %xmm0
; X64-NEXT:    pand %xmm5, %xmm0
; X64-NEXT:    por %xmm2, %xmm0
; X64-NEXT:    movq %r10, %xmm2
; X64-NEXT:    movq %rdx, %xmm5
; X64-NEXT:    punpcklqdq {{.*#+}} xmm2 = xmm2[0],xmm5[0]
; X64-NEXT:    pcmpeqd %xmm6, %xmm2
; X64-NEXT:    pshufd {{.*#+}} xmm5 = xmm2[1,0,3,2]
; X64-NEXT:    pand %xmm2, %xmm5
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm3[0,0,1,1]
; X64-NEXT:    pxor %xmm3, %xmm3
; X64-NEXT:    pcmpgtd %xmm2, %xmm3
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; X64-NEXT:    pcmpgtd %xmm1, %xmm6
; X64-NEXT:    pxor %xmm3, %xmm6
; X64-NEXT:    pandn %xmm6, %xmm5
; X64-NEXT:    movq %r9, %xmm1
; X64-NEXT:    movq %rax, %xmm2
; X64-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; X64-NEXT:    movdqa %xmm5, %xmm2
; X64-NEXT:    pandn %xmm1, %xmm2
; X64-NEXT:    paddq %xmm4, %xmm1
; X64-NEXT:    pand %xmm5, %xmm1
; X64-NEXT:    por %xmm2, %xmm1
; X64-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,2],xmm1[0,2]
; X64-NEXT:    retq
;
; X86-LABEL: vec:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    subl $60, %esp
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl %esi, %ebp
; X86-NEXT:    sarl $31, %ebp
; X86-NEXT:    movl %ebp, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl %ecx, %edx
; X86-NEXT:    shll $31, %edx
; X86-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl %ecx, %eax
; X86-NEXT:    shrl $31, %eax
; X86-NEXT:    shldl $31, %ecx, %eax
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %eax
; X86-NEXT:    pushl %edx
; X86-NEXT:    calll __divdi3
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl %edi, %eax
; X86-NEXT:    sarl $31, %eax
; X86-NEXT:    movl %ebx, %ebp
; X86-NEXT:    shll $31, %ebp
; X86-NEXT:    movl %ebx, %ecx
; X86-NEXT:    shrl $31, %ecx
; X86-NEXT:    shldl $31, %ebx, %ecx
; X86-NEXT:    pushl %eax
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %ecx
; X86-NEXT:    movl %ecx, %ebx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    pushl %ebp
; X86-NEXT:    calll __moddi3
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %ebp
; X86-NEXT:    calll __divdi3
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    sarl $31, %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %ebx
; X86-NEXT:    shll $31, %ebx
; X86-NEXT:    movl %edx, %edi
; X86-NEXT:    shrl $31, %edi
; X86-NEXT:    shldl $31, %edx, %edi
; X86-NEXT:    pushl %ecx
; X86-NEXT:    movl %ecx, %ebp
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    pushl %eax
; X86-NEXT:    movl %eax, %esi
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %ebx
; X86-NEXT:    calll __moddi3
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %esi
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %ebx
; X86-NEXT:    calll __divdi3
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %eax, %ebx
; X86-NEXT:    sarl $31, %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    shll $31, %esi
; X86-NEXT:    movl %ecx, %ebp
; X86-NEXT:    shrl $31, %ebp
; X86-NEXT:    shldl $31, %ecx, %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %eax
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %esi
; X86-NEXT:    calll __moddi3
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    movl %eax, (%esp) # 4-byte Spill
; X86-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl {{[0-9]+}}(%esp)
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %esi
; X86-NEXT:    calll __divdi3
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    testl %ebp, %ebp
; X86-NEXT:    sets %cl
; X86-NEXT:    testl %ebx, %ebx
; X86-NEXT:    sets %dl
; X86-NEXT:    xorb %cl, %dl
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    orl (%esp), %ecx # 4-byte Folded Reload
; X86-NEXT:    setne %cl
; X86-NEXT:    testb %dl, %cl
; X86-NEXT:    leal -1(%eax), %ecx
; X86-NEXT:    cmovel %eax, %ecx
; X86-NEXT:    movl %ecx, (%esp) # 4-byte Spill
; X86-NEXT:    testl %edi, %edi
; X86-NEXT:    sets %al
; X86-NEXT:    cmpl $0, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; X86-NEXT:    sets %cl
; X86-NEXT:    xorb %al, %cl
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X86-NEXT:    orl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Folded Reload
; X86-NEXT:    setne %al
; X86-NEXT:    testb %cl, %al
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X86-NEXT:    leal -1(%eax), %ecx
; X86-NEXT:    cmovel %eax, %ecx
; X86-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-NEXT:    cmpl $0, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; X86-NEXT:    sets %al
; X86-NEXT:    cmpl $0, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; X86-NEXT:    sets %cl
; X86-NEXT:    xorb %al, %cl
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X86-NEXT:    orl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Folded Reload
; X86-NEXT:    setne %al
; X86-NEXT:    testb %cl, %al
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X86-NEXT:    leal -1(%eax), %ebp
; X86-NEXT:    cmovel %eax, %ebp
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X86-NEXT:    testl %edx, %edx
; X86-NEXT:    sets %al
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    testl %ecx, %ecx
; X86-NEXT:    sets %bl
; X86-NEXT:    xorb %al, %bl
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edi # 4-byte Reload
; X86-NEXT:    leal -1(%edi), %esi
; X86-NEXT:    pushl %ecx
; X86-NEXT:    pushl {{[0-9]+}}(%esp)
; X86-NEXT:    pushl %edx
; X86-NEXT:    pushl {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; X86-NEXT:    calll __moddi3
; X86-NEXT:    addl $16, %esp
; X86-NEXT:    orl %eax, %edx
; X86-NEXT:    setne %al
; X86-NEXT:    testb %bl, %al
; X86-NEXT:    cmovel %edi, %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl %esi, 12(%eax)
; X86-NEXT:    movl %ebp, 8(%eax)
; X86-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X86-NEXT:    movl %ecx, 4(%eax)
; X86-NEXT:    movl (%esp), %ecx # 4-byte Reload
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    addl $60, %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl $4
  %tmp = call <4 x i32> @llvm.sdiv.fix.v4i32(<4 x i32> %x, <4 x i32> %y, i32 31)
  ret <4 x i32> %tmp
}
