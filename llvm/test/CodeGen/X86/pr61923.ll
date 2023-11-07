; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=x86_64-unknown-linux-gnu  -mattr=+avx < %s -o - | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Regressed test from https://github.com/llvm/llvm-project/issues/61923
define void @test_loop(ptr align 1 %src, ptr align 1 %dest, i32 %len) {
; CHECK-LABEL: test_loop:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $32, %edx
; CHECK-NEXT:    jb .LBB0_4
; CHECK-NEXT:  # %bb.1: # %memcmp.loop.preheader
; CHECK-NEXT:    movl %edx, %eax
; CHECK-NEXT:    andl $-32, %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_2: # %memcmp.loop
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vmovups (%rsi,%rcx), %ymm0
; CHECK-NEXT:    vxorps (%rdi,%rcx), %ymm0, %ymm0
; CHECK-NEXT:    vptest %ymm0, %ymm0
; CHECK-NEXT:    jne .LBB0_4
; CHECK-NEXT:  # %bb.3: # %memcmp.loop.latch
; CHECK-NEXT:    # in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    addq $32, %rcx
; CHECK-NEXT:    cmpq %rax, %rcx
; CHECK-NEXT:    jb .LBB0_2
; CHECK-NEXT:  .LBB0_4: # %done
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  %len.wide = zext i32 %len to i64
  %elements.len = lshr i64 %len.wide, 0
  %loop.entry.cond = icmp uge i64 %elements.len, 32
  br i1 %loop.entry.cond, label %memcmp.loop.preheader, label %done

memcmp.loop.preheader:                            ; preds = %entry
  %memcmp.loop.iters = lshr i64 %elements.len, 5
  %memcmp.loop.elements = shl i64 %memcmp.loop.iters, 5
  br label %memcmp.loop

memcmp.loop:                                      ; preds = %memcmp.loop.latch, %memcmp.loop.preheader
  %vector.index = phi i64 [ 0, %memcmp.loop.preheader ], [ %vector.index.next, %memcmp.loop.latch ]
  %left.vector_start_ptr = getelementptr inbounds i8, ptr %dest, i64 %vector.index
  %right.vector_start_ptr = getelementptr inbounds i8, ptr %src, i64 %vector.index
  %left.vector = load <32 x i8>, ptr %left.vector_start_ptr, align 1
  %right.vector = load <32 x i8>, ptr %right.vector_start_ptr, align 1
  %vec.cmp = icmp eq <32 x i8> %left.vector, %right.vector
  %vec.cmp.reduced = call i1 @llvm.vector.reduce.and.v32i1(<32 x i1> %vec.cmp)
  br i1 %vec.cmp.reduced, label %memcmp.loop.latch, label %done

memcmp.loop.latch:                                ; preds = %memcmp.loop
  %vector.index.next = add i64 %vector.index, 32
  %loop.continue = icmp ult i64 %vector.index.next, %memcmp.loop.elements
  br i1 %loop.continue, label %memcmp.loop, label %done

done:
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.vector.reduce.and.v32i1(<32 x i1>) #2
