; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm64-eabi | FileCheck %s

define void @bzero_4_heap(ptr nocapture %c) {
; CHECK-LABEL: bzero_4_heap:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str wzr, [x0]
; CHECK-NEXT:    ret
  call void @llvm.memset.p0.i64(ptr align 4 %c, i8 0, i64 4, i1 false)
  ret void
}

define void @bzero_8_heap(ptr nocapture %c) {
; CHECK-LABEL: bzero_8_heap:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str xzr, [x0]
; CHECK-NEXT:    ret
  call void @llvm.memset.p0.i64(ptr align 8 %c, i8 0, i64 8, i1 false)
  ret void
}

define void @bzero_12_heap(ptr nocapture %c) {
; CHECK-LABEL: bzero_12_heap:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str wzr, [x0, #8]
; CHECK-NEXT:    str xzr, [x0]
; CHECK-NEXT:    ret
  call void @llvm.memset.p0.i64(ptr align 8 %c, i8 0, i64 12, i1 false)
  ret void
}

define void @bzero_16_heap(ptr nocapture %c) {
; CHECK-LABEL: bzero_16_heap:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp xzr, xzr, [x0]
; CHECK-NEXT:    ret
  call void @llvm.memset.p0.i64(ptr align 8 %c, i8 0, i64 16, i1 false)
  ret void
}

define void @bzero_32_heap(ptr nocapture %c) {
; CHECK-LABEL: bzero_32_heap:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    stp q0, q0, [x0]
; CHECK-NEXT:    ret
  call void @llvm.memset.p0.i64(ptr align 8 %c, i8 0, i64 32, i1 false)
  ret void
}

define void @bzero_64_heap(ptr nocapture %c) {
; CHECK-LABEL: bzero_64_heap:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    stp q0, q0, [x0]
; CHECK-NEXT:    stp q0, q0, [x0, #32]
; CHECK-NEXT:    ret
  call void @llvm.memset.p0.i64(ptr align 8 %c, i8 0, i64 64, i1 false)
  ret void
}

define void @bzero_4_stack() {
; CHECK-LABEL: bzero_4_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    add x0, sp, #12
; CHECK-NEXT:    str wzr, [sp, #12]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %buf = alloca [4 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 4, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_8_stack() {
; CHECK-LABEL: bzero_8_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x30, xzr, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    add x0, sp, #8
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %buf = alloca [8 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 8, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_12_stack() {
; CHECK-LABEL: bzero_12_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    str x30, [sp, #16] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    str wzr, [sp, #8]
; CHECK-NEXT:    str xzr, [sp]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #16] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  %buf = alloca [12 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 12, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_16_stack() {
; CHECK-LABEL: bzero_16_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    stp xzr, x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    str xzr, [sp]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #16] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  %buf = alloca [16 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 16, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_20_stack() {
; CHECK-LABEL: bzero_20_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    add x0, sp, #8
; CHECK-NEXT:    stp xzr, xzr, [sp, #8]
; CHECK-NEXT:    str wzr, [sp, #24]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %buf = alloca [20 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 20, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_26_stack() {
; CHECK-LABEL: bzero_26_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp xzr, xzr, [sp]
; CHECK-NEXT:    strh wzr, [sp, #24]
; CHECK-NEXT:    str xzr, [sp, #16]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %buf = alloca [26 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 26, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_32_stack() {
; CHECK-LABEL: bzero_32_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %buf = alloca [32 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 32, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_40_stack() {
; CHECK-LABEL: bzero_40_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #64
; CHECK-NEXT:    str x30, [sp, #48] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    str xzr, [sp, #32]
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #48] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #64
; CHECK-NEXT:    ret
  %buf = alloca [40 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 40, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_64_stack() {
; CHECK-LABEL: bzero_64_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #80
; CHECK-NEXT:    str x30, [sp, #64] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 80
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    stp q0, q0, [sp, #32]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #80
; CHECK-NEXT:    ret
  %buf = alloca [64 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 64, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_72_stack() {
; CHECK-LABEL: bzero_72_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #96
; CHECK-NEXT:    str x30, [sp, #80] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 96
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    str xzr, [sp, #64]
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    stp q0, q0, [sp, #32]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #96
; CHECK-NEXT:    ret
  %buf = alloca [72 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 72, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_128_stack() {
; CHECK-LABEL: bzero_128_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #144
; CHECK-NEXT:    str x30, [sp, #128] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 144
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    stp q0, q0, [sp, #32]
; CHECK-NEXT:    stp q0, q0, [sp, #64]
; CHECK-NEXT:    stp q0, q0, [sp, #96]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #128] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #144
; CHECK-NEXT:    ret
  %buf = alloca [128 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 128, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @bzero_256_stack() {
; CHECK-LABEL: bzero_256_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #272
; CHECK-NEXT:    stp x29, x30, [sp, #256] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 272
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    movi v0.2d, #0000000000000000
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    stp q0, q0, [sp, #32]
; CHECK-NEXT:    stp q0, q0, [sp, #64]
; CHECK-NEXT:    stp q0, q0, [sp, #96]
; CHECK-NEXT:    stp q0, q0, [sp, #128]
; CHECK-NEXT:    stp q0, q0, [sp, #160]
; CHECK-NEXT:    stp q0, q0, [sp, #192]
; CHECK-NEXT:    stp q0, q0, [sp, #224]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldp x29, x30, [sp, #256] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #272
; CHECK-NEXT:    ret
  %buf = alloca [256 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 0, i32 256, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_4_stack() {
; CHECK-LABEL: memset_4_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov w8, #-1431655766
; CHECK-NEXT:    add x0, sp, #12
; CHECK-NEXT:    str w8, [sp, #12]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %buf = alloca [4 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 4, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_8_stack() {
; CHECK-LABEL: memset_8_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov x8, #-6148914691236517206
; CHECK-NEXT:    stp x30, x8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    add x0, sp, #8
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %buf = alloca [8 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 8, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_12_stack() {
; CHECK-LABEL: memset_12_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    str x30, [sp, #16] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov x8, #-6148914691236517206
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    str x8, [sp]
; CHECK-NEXT:    str w8, [sp, #8]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #16] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  %buf = alloca [12 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 12, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_16_stack() {
; CHECK-LABEL: memset_16_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov x8, #-6148914691236517206
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp x8, x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    str x8, [sp]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #16] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  %buf = alloca [16 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 16, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_20_stack() {
; CHECK-LABEL: memset_20_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov x8, #-6148914691236517206
; CHECK-NEXT:    add x0, sp, #8
; CHECK-NEXT:    stp x8, x8, [sp, #8]
; CHECK-NEXT:    str w8, [sp, #24]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %buf = alloca [20 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 20, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_26_stack() {
; CHECK-LABEL: memset_26_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    mov x8, #-6148914691236517206
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp x8, x8, [sp, #8]
; CHECK-NEXT:    str x8, [sp]
; CHECK-NEXT:    strh w8, [sp, #24]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %buf = alloca [26 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 26, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_32_stack() {
; CHECK-LABEL: memset_32_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.16b, #170
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %buf = alloca [32 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 32, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_40_stack() {
; CHECK-LABEL: memset_40_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #64
; CHECK-NEXT:    str x30, [sp, #48] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.16b, #170
; CHECK-NEXT:    mov x8, #-6148914691236517206
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    str x8, [sp, #32]
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #48] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #64
; CHECK-NEXT:    ret
  %buf = alloca [40 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 40, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_64_stack() {
; CHECK-LABEL: memset_64_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #80
; CHECK-NEXT:    str x30, [sp, #64] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 80
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.16b, #170
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    stp q0, q0, [sp, #32]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #64] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #80
; CHECK-NEXT:    ret
  %buf = alloca [64 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 64, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_72_stack() {
; CHECK-LABEL: memset_72_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #96
; CHECK-NEXT:    str x30, [sp, #80] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 96
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.16b, #170
; CHECK-NEXT:    mov x8, #-6148914691236517206
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    str x8, [sp, #64]
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    stp q0, q0, [sp, #32]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #96
; CHECK-NEXT:    ret
  %buf = alloca [72 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 72, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_128_stack() {
; CHECK-LABEL: memset_128_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #144
; CHECK-NEXT:    str x30, [sp, #128] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 144
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.16b, #170
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    stp q0, q0, [sp, #32]
; CHECK-NEXT:    stp q0, q0, [sp, #64]
; CHECK-NEXT:    stp q0, q0, [sp, #96]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldr x30, [sp, #128] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #144
; CHECK-NEXT:    ret
  %buf = alloca [128 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 128, i1 false)
  call void @something(ptr %buf)
  ret void
}

define void @memset_256_stack() {
; CHECK-LABEL: memset_256_stack:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #272
; CHECK-NEXT:    stp x29, x30, [sp, #256] // 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 272
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    movi v0.16b, #170
; CHECK-NEXT:    mov x0, sp
; CHECK-NEXT:    stp q0, q0, [sp]
; CHECK-NEXT:    stp q0, q0, [sp, #32]
; CHECK-NEXT:    stp q0, q0, [sp, #64]
; CHECK-NEXT:    stp q0, q0, [sp, #96]
; CHECK-NEXT:    stp q0, q0, [sp, #128]
; CHECK-NEXT:    stp q0, q0, [sp, #160]
; CHECK-NEXT:    stp q0, q0, [sp, #192]
; CHECK-NEXT:    stp q0, q0, [sp, #224]
; CHECK-NEXT:    bl something
; CHECK-NEXT:    ldp x29, x30, [sp, #256] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #272
; CHECK-NEXT:    ret
  %buf = alloca [256 x i8], align 1
  call void @llvm.memset.p0.i32(ptr %buf, i8 -86, i32 256, i1 false)
  call void @something(ptr %buf)
  ret void
}

declare void @something(ptr)
declare void @llvm.memset.p0.i32(ptr nocapture, i8, i32, i1) nounwind
declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind
