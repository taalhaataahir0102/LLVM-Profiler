; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s
; RUN: llc < %s -mtriple=i386-pc-win32 | FileCheck %s -check-prefix=CHECK-WIN

define float @call_ldexpf(float %a, i32 %b) {
; CHECK-LABEL: call_ldexpf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    jmp ldexpf@PLT # TAILCALL
;
; CHECK-WIN-LABEL: call_ldexpf:
; CHECK-WIN:       # %bb.0:
; CHECK-WIN-NEXT:    subl $8, %esp
; CHECK-WIN-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-WIN-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-WIN-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; CHECK-WIN-NEXT:    fstps (%esp)
; CHECK-WIN-NEXT:    calll _ldexpf
; CHECK-WIN-NEXT:    addl $8, %esp
; CHECK-WIN-NEXT:    retl
  %result = call float @ldexpf(float %a, i32 %b)
  ret float %result
}

define double @call_ldexp(double %a, i32 %b) {
; CHECK-LABEL: call_ldexp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    jmp ldexp@PLT # TAILCALL
;
; CHECK-WIN-LABEL: call_ldexp:
; CHECK-WIN:       # %bb.0:
; CHECK-WIN-NEXT:    subl $12, %esp
; CHECK-WIN-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-WIN-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-WIN-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; CHECK-WIN-NEXT:    fstpl (%esp)
; CHECK-WIN-NEXT:    calll _ldexp
; CHECK-WIN-NEXT:    addl $12, %esp
; CHECK-WIN-NEXT:    retl
  %result = call double @ldexp(double %a, i32 %b)
  ret double %result
}

define x86_fp80 @call_ldexpl(x86_fp80 %a, i32 %b) {
; CHECK-LABEL: call_ldexpl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    fldt {{[0-9]+}}(%rsp)
; CHECK-NEXT:    fstpt (%rsp)
; CHECK-NEXT:    callq ldexpl@PLT
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
;
; CHECK-WIN-LABEL: call_ldexpl:
; CHECK-WIN:       # %bb.0:
; CHECK-WIN-NEXT:    pushl %ebp
; CHECK-WIN-NEXT:    movl %esp, %ebp
; CHECK-WIN-NEXT:    andl $-16, %esp
; CHECK-WIN-NEXT:    subl $48, %esp
; CHECK-WIN-NEXT:    fldt 8(%ebp)
; CHECK-WIN-NEXT:    movl 24(%ebp), %eax
; CHECK-WIN-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; CHECK-WIN-NEXT:    fstpt (%esp)
; CHECK-WIN-NEXT:    calll _ldexpl
; CHECK-WIN-NEXT:    movl %ebp, %esp
; CHECK-WIN-NEXT:    popl %ebp
; CHECK-WIN-NEXT:    retl
  %result = call x86_fp80 @ldexpl(x86_fp80 %a, i32 %b)
  ret x86_fp80 %result
}

declare float @ldexpf(float %a, i32 %b) #0
declare double @ldexp(double %a, i32 %b) #0
declare x86_fp80 @ldexpl(x86_fp80 %a, i32 %b) #0

attributes #0 = { nounwind readonly }
