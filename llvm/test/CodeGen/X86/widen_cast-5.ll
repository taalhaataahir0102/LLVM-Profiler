; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-apple-darwin -mattr=+sse4.2 | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+sse4.2 | FileCheck %s --check-prefix=X64

; bitcast a i64 to v2i32

define void @convert(ptr %dst.addr, i64 %src) nounwind {
; X86-LABEL: convert:
; X86:       ## %bb.0: ## %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    xorps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0
; X86-NEXT:    movlps %xmm0, (%eax)
; X86-NEXT:    retl
;
; X64-LABEL: convert:
; X64:       ## %bb.0: ## %entry
; X64-NEXT:    movabsq $140733193388287, %rax ## imm = 0x7FFF000000FF
; X64-NEXT:    xorq %rsi, %rax
; X64-NEXT:    movq %rax, (%rdi)
; X64-NEXT:    retq
entry:
	%conv = bitcast i64 %src to <2 x i32>
	%xor = xor <2 x i32> %conv, < i32 255, i32 32767 >
	store <2 x i32> %xor, ptr %dst.addr
	ret void
}
