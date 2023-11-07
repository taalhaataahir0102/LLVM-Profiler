; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+movdir64b | FileCheck %s --check-prefix=X64

define void @test_movdir64b() {
; X64-LABEL: test_movdir64b:
; X64:       # %bb.0: # %entry
; X64-NEXT:    subq $3880, %rsp # imm = 0xF28
; X64-NEXT:    .cfi_def_cfa_offset 3888
; X64-NEXT:    #APP
; X64-EMPTY:
; X64-NEXT:    movdir64b -{{[0-9]+}}(%rsp), %rax
; X64-EMPTY:
; X64-NEXT:    #NO_APP
; X64-NEXT:    addq $3880, %rsp # imm = 0xF28
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
entry:
  %arr = alloca [1000 x i32], align 16
  call void asm sideeffect inteldialect "movdir64b rax, zmmword ptr $0", "*m,~{dirflag},~{fpsr},~{flags}"(ptr elementtype([1000 x i32]) %arr)
  ret void
}
