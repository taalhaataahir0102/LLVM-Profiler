; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:   FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:   FileCheck %s --check-prefix=CHECK-BE

%96 = type <{ i32 }>
%97 = type <{ i32 }>
%98 = type <{ i32 }>
%100 = type <{ i8, i8, i8, i8, i32, i64, i64, [1 x i64], [1 x i64], [1 x i64] }>
%101 = type <{ i8, i8, i8, i8, i32, i64, i64, [1 x i64], [1 x i64], [1 x i64], [24 x i8] }>
%102 = type <{ i8, i8, i8, i8, i32, i64, i64, [1 x i64], [1 x i64], [1 x i64] }>
%103 = type <{ ptr, i8, i8, i8, i8, [4 x i8], i32, [12 x i8], i32, [4 x i8] }>
%104 = type <{ i32 }>
%105 = type <{ i32 }>
%106 = type <{ i32 }>

; Function Attrs: nobuiltin norecurse
define dso_local signext i32 @test_FI_elim(ptr noalias nocapture dereferenceable(40) %arg, ptr noalias nocapture nonnull readonly %arg2, ptr noalias nocapture nonnull readonly %arg3, ptr noalias nocapture nonnull readonly %arg4, ptr noalias nocapture dereferenceable(48) %arg6, ptr noalias nocapture dereferenceable(72) %arg7) local_unnamed_addr #2 {
; CHECK-LABEL: test_FI_elim:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    stdu r1, -80(r1)
; CHECK-NEXT:    .cfi_def_cfa_offset 80
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    lxv v2, 0(r3)
; CHECK-NEXT:    mr r9, r6
; CHECK-NEXT:    mr r6, r5
; CHECK-NEXT:    li r12, -127
; CHECK-NEXT:    li r0, 4
; CHECK-NEXT:    stb r12, 0(r3)
; CHECK-NEXT:    li r2, 1
; CHECK-NEXT:    std r0, 0(r3)
; CHECK-NEXT:    stw r2, 0(r3)
; CHECK-NEXT:    li r11, 3
; CHECK-NEXT:    stb r11, 0(0)
; CHECK-NEXT:    mfvsrd r5, v2
; CHECK-NEXT:    vaddudm v3, v2, v2
; CHECK-NEXT:    pstxv v2, 64(r1), 0
; CHECK-NEXT:    neg r5, r5
; CHECK-NEXT:    mfvsrd r10, v3
; CHECK-NEXT:    std r5, 0(r3)
; CHECK-NEXT:    lbz r5, 2(r7)
; CHECK-NEXT:    mr r7, r9
; CHECK-NEXT:    stb r11, 0(r3)
; CHECK-NEXT:    stb r12, 0(r3)
; CHECK-NEXT:    std r2, 0(r3)
; CHECK-NEXT:    neg r10, r10
; CHECK-NEXT:    rlwinm r5, r5, 0, 27, 27
; CHECK-NEXT:    stb r5, 0(0)
; CHECK-NEXT:    lbz r5, 2(r8)
; CHECK-NEXT:    rlwinm r5, r5, 0, 27, 27
; CHECK-NEXT:    stb r5, 0(r3)
; CHECK-NEXT:    li r5, 2
; CHECK-NEXT:    std r0, 0(r3)
; CHECK-NEXT:    stw r5, 0(r3)
; CHECK-NEXT:    mr r5, r4
; CHECK-NEXT:    std r10, 0(r3)
; CHECK-NEXT:    bl foo@notoc
; CHECK-NEXT:    extsw r3, r3
; CHECK-NEXT:    addi r1, r1, 80
; CHECK-NEXT:    ld r0, 16(r1)
; CHECK-NEXT:    mtlr r0
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: test_FI_elim:
; CHECK-BE:       # %bb.0: # %bb
; CHECK-BE-NEXT:    mflr r0
; CHECK-BE-NEXT:    std r0, 16(r1)
; CHECK-BE-NEXT:    stdu r1, -176(r1)
; CHECK-BE-NEXT:    .cfi_def_cfa_offset 176
; CHECK-BE-NEXT:    .cfi_offset lr, 16
; CHECK-BE-NEXT:    .cfi_offset r30, -16
; CHECK-BE-NEXT:    lxv v2, 0(r3)
; CHECK-BE-NEXT:    mr r9, r6
; CHECK-BE-NEXT:    mr r6, r5
; CHECK-BE-NEXT:    std r30, 160(r1) # 8-byte Folded Spill
; CHECK-BE-NEXT:    li r12, -127
; CHECK-BE-NEXT:    li r0, 4
; CHECK-BE-NEXT:    stb r12, 0(r3)
; CHECK-BE-NEXT:    li r30, 1
; CHECK-BE-NEXT:    std r0, 0(r3)
; CHECK-BE-NEXT:    stw r30, 0(r3)
; CHECK-BE-NEXT:    li r11, 3
; CHECK-BE-NEXT:    stb r11, 0(0)
; CHECK-BE-NEXT:    mfvsrld r5, v2
; CHECK-BE-NEXT:    vaddudm v3, v2, v2
; CHECK-BE-NEXT:    pstxv v2, 144(r1), 0
; CHECK-BE-NEXT:    mfvsrld r10, v3
; CHECK-BE-NEXT:    neg r5, r5
; CHECK-BE-NEXT:    std r5, 0(r3)
; CHECK-BE-NEXT:    lbz r5, 2(r7)
; CHECK-BE-NEXT:    mr r7, r9
; CHECK-BE-NEXT:    stb r11, 0(r3)
; CHECK-BE-NEXT:    stb r12, 0(r3)
; CHECK-BE-NEXT:    std r30, 0(r3)
; CHECK-BE-NEXT:    neg r10, r10
; CHECK-BE-NEXT:    rlwinm r5, r5, 0, 27, 27
; CHECK-BE-NEXT:    stb r5, 0(0)
; CHECK-BE-NEXT:    lbz r5, 2(r8)
; CHECK-BE-NEXT:    rlwinm r5, r5, 0, 27, 27
; CHECK-BE-NEXT:    stb r5, 0(r3)
; CHECK-BE-NEXT:    li r5, 2
; CHECK-BE-NEXT:    std r0, 0(r3)
; CHECK-BE-NEXT:    stw r5, 0(r3)
; CHECK-BE-NEXT:    mr r5, r4
; CHECK-BE-NEXT:    std r10, 0(r3)
; CHECK-BE-NEXT:    bl foo
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    ld r30, 160(r1) # 8-byte Folded Reload
; CHECK-BE-NEXT:    extsw r3, r3
; CHECK-BE-NEXT:    addi r1, r1, 176
; CHECK-BE-NEXT:    ld r0, 16(r1)
; CHECK-BE-NEXT:    mtlr r0
; CHECK-BE-NEXT:    blr
bb:
  %i = alloca %102, align 8
  %i8 = load <2 x i64>, ptr undef, align 8
  %i9 = extractelement <2 x i64> %i8, i32 1
  %i10 = sub i64 0, %i9
  %i11 = load <2 x i64>, ptr undef, align 8
  %i12 = load <2 x i64>, ptr undef, align 8
  %i13 = add nsw <2 x i64> %i11, %i12
  %i14 = extractelement <2 x i64> %i13, i32 1
  %i15 = sub i64 0, %i14
  store i8 3, ptr null, align 8
  store i8 -127, ptr undef, align 1
  store i64 4, ptr undef, align 8
  store i32 1, ptr undef, align 4
  %i16 = getelementptr inbounds %102, ptr %i, i64 0, i32 8, i64 0
  store <2 x i64> %i8, ptr %i16, align 8
  store i64 %i10, ptr undef, align 8
  store i8 3, ptr undef, align 8
  %i18 = getelementptr inbounds %100, ptr %arg6, i64 0, i32 2
  %i19 = load i8, ptr %i18, align 1
  %i20 = and i8 %i19, 16
  store i8 %i20, ptr null, align 2
  store i8 -127, ptr undef, align 1
  store i64 1, ptr undef, align 8
  %i21 = getelementptr inbounds %101, ptr %arg7, i64 0, i32 2
  %i22 = load i8, ptr %i21, align 1
  %i23 = and i8 %i22, 16
  store i8 %i23, ptr undef, align 2
  store i64 4, ptr undef, align 8
  store i32 2, ptr undef, align 4
  store i64 %i15, ptr undef, align 8
  %i28 = call i32 @foo(ptr nonnull %arg, ptr nonnull undef, ptr %arg2, ptr %arg3, ptr %arg4)
  ret i32 %i28
}

declare dso_local i32 @foo(ptr, ptr, ptr, ptr, ptr) local_unnamed_addr #1
