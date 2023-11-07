; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; This test is a copy of mma-acc-spill.ll except that it uses mcpu=future.
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -disable-auto-paired-vec-st=false \
; RUN:   -mcpu=future -ppc-asm-full-reg-names \
; RUN:   -ppc-vsr-nums-as-vr < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -disable-auto-paired-vec-st=false \
; RUN:   -mcpu=future -ppc-asm-full-reg-names \
; RUN:   -ppc-vsr-nums-as-vr < %s | FileCheck %s --check-prefix=CHECK-BE

declare <512 x i1> @llvm.ppc.mma.xvf16ger2pp(<512 x i1>, <16 x i8>, <16 x i8>)
declare <512 x i1> @llvm.ppc.mma.assemble.acc(<16 x i8>, <16 x i8>, <16 x i8>, <16 x i8>)
declare void @foo()
define void @intrinsics1(<16 x i8> %vc1, <16 x i8> %vc2, <16 x i8> %vc3, <16 x i8> %vc4, ptr %ptr) {
; CHECK-LABEL: intrinsics1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    stdu r1, -176(r1)
; CHECK-NEXT:    .cfi_def_cfa_offset 176
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    .cfi_offset r30, -16
; CHECK-NEXT:    .cfi_offset v28, -80
; CHECK-NEXT:    .cfi_offset v29, -64
; CHECK-NEXT:    .cfi_offset v30, -48
; CHECK-NEXT:    .cfi_offset v31, -32
; CHECK-NEXT:    stxv v28, 96(r1) # 16-byte Folded Spill
; CHECK-NEXT:    stxv v29, 112(r1) # 16-byte Folded Spill
; CHECK-NEXT:    stxv v30, 128(r1) # 16-byte Folded Spill
; CHECK-NEXT:    stxv v31, 144(r1) # 16-byte Folded Spill
; CHECK-NEXT:    vmr v31, v5
; CHECK-NEXT:    vmr v29, v3
; CHECK-NEXT:    vmr v30, v4
; CHECK-NEXT:    vmr v28, v2
; CHECK-NEXT:    std r30, 160(r1) # 8-byte Folded Spill
; CHECK-NEXT:    ld r30, 272(r1)
; CHECK-NEXT:    dmxxinstfdmr512 wacc0, vsp60, vsp62, 0
; CHECK-NEXT:    xvf16ger2pp wacc0, v2, v4
; CHECK-NEXT:    dmxxextfdmr512 wacc0, vsp36, vsp34, 0
; CHECK-NEXT:    stxvp vsp36, 64(r1)
; CHECK-NEXT:    stxvp vsp34, 32(r1)
; CHECK-NEXT:    bl foo@notoc
; CHECK-NEXT:    lxvp vsp34, 64(r1)
; CHECK-NEXT:    lxvp vsp36, 32(r1)
; CHECK-NEXT:    dmxxinstfdmr512 wacc0, vsp34, vsp36, 0
; CHECK-NEXT:    xvf16ger2pp wacc0, v28, v30
; CHECK-NEXT:    dmxxextfdmr512 wacc0, vsp34, vsp36, 0
; CHECK-NEXT:    stxv v4, 48(r30)
; CHECK-NEXT:    stxv v5, 32(r30)
; CHECK-NEXT:    stxv v2, 16(r30)
; CHECK-NEXT:    stxv v3, 0(r30)
; CHECK-NEXT:    lxv v31, 144(r1) # 16-byte Folded Reload
; CHECK-NEXT:    lxv v30, 128(r1) # 16-byte Folded Reload
; CHECK-NEXT:    lxv v29, 112(r1) # 16-byte Folded Reload
; CHECK-NEXT:    lxv v28, 96(r1) # 16-byte Folded Reload
; CHECK-NEXT:    ld r30, 160(r1) # 8-byte Folded Reload
; CHECK-NEXT:    addi r1, r1, 176
; CHECK-NEXT:    ld r0, 16(r1)
; CHECK-NEXT:    mtlr r0
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: intrinsics1:
; CHECK-BE:       # %bb.0:
; CHECK-BE-NEXT:    mflr r0
; CHECK-BE-NEXT:    std r0, 16(r1)
; CHECK-BE-NEXT:    stdu r1, -256(r1)
; CHECK-BE-NEXT:    .cfi_def_cfa_offset 256
; CHECK-BE-NEXT:    .cfi_offset lr, 16
; CHECK-BE-NEXT:    .cfi_offset r30, -16
; CHECK-BE-NEXT:    .cfi_offset v28, -80
; CHECK-BE-NEXT:    .cfi_offset v29, -64
; CHECK-BE-NEXT:    .cfi_offset v30, -48
; CHECK-BE-NEXT:    .cfi_offset v31, -32
; CHECK-BE-NEXT:    stxv v28, 176(r1) # 16-byte Folded Spill
; CHECK-BE-NEXT:    stxv v29, 192(r1) # 16-byte Folded Spill
; CHECK-BE-NEXT:    stxv v30, 208(r1) # 16-byte Folded Spill
; CHECK-BE-NEXT:    stxv v31, 224(r1) # 16-byte Folded Spill
; CHECK-BE-NEXT:    vmr v31, v5
; CHECK-BE-NEXT:    vmr v29, v3
; CHECK-BE-NEXT:    vmr v30, v4
; CHECK-BE-NEXT:    vmr v28, v2
; CHECK-BE-NEXT:    std r30, 240(r1) # 8-byte Folded Spill
; CHECK-BE-NEXT:    ld r30, 368(r1)
; CHECK-BE-NEXT:    dmxxinstfdmr512 wacc0, vsp60, vsp62, 0
; CHECK-BE-NEXT:    xvf16ger2pp wacc0, v2, v4
; CHECK-BE-NEXT:    dmxxextfdmr512 wacc0, vsp36, vsp34, 0
; CHECK-BE-NEXT:    stxvp vsp36, 112(r1)
; CHECK-BE-NEXT:    stxvp vsp34, 144(r1)
; CHECK-BE-NEXT:    bl foo
; CHECK-BE-NEXT:    nop
; CHECK-BE-NEXT:    lxvp vsp34, 112(r1)
; CHECK-BE-NEXT:    lxvp vsp36, 144(r1)
; CHECK-BE-NEXT:    dmxxinstfdmr512 wacc0, vsp34, vsp36, 0
; CHECK-BE-NEXT:    xvf16ger2pp wacc0, v28, v30
; CHECK-BE-NEXT:    dmxxextfdmr512 wacc0, vsp34, vsp36, 0
; CHECK-BE-NEXT:    stxv v5, 48(r30)
; CHECK-BE-NEXT:    stxv v4, 32(r30)
; CHECK-BE-NEXT:    stxv v3, 16(r30)
; CHECK-BE-NEXT:    stxv v2, 0(r30)
; CHECK-BE-NEXT:    lxv v31, 224(r1) # 16-byte Folded Reload
; CHECK-BE-NEXT:    lxv v30, 208(r1) # 16-byte Folded Reload
; CHECK-BE-NEXT:    lxv v29, 192(r1) # 16-byte Folded Reload
; CHECK-BE-NEXT:    lxv v28, 176(r1) # 16-byte Folded Reload
; CHECK-BE-NEXT:    ld r30, 240(r1) # 8-byte Folded Reload
; CHECK-BE-NEXT:    addi r1, r1, 256
; CHECK-BE-NEXT:    ld r0, 16(r1)
; CHECK-BE-NEXT:    mtlr r0
; CHECK-BE-NEXT:    blr
  %1 = tail call <512 x i1> @llvm.ppc.mma.assemble.acc(<16 x i8> %vc1, <16 x i8> %vc2, <16 x i8> %vc3, <16 x i8> %vc4)
  %2 = tail call <512 x i1> @llvm.ppc.mma.xvf16ger2pp(<512 x i1> %1, <16 x i8> %vc1, <16 x i8> %vc3)
  tail call void @foo()
  %3 = tail call <512 x i1> @llvm.ppc.mma.xvf16ger2pp(<512 x i1> %2, <16 x i8> %vc1, <16 x i8> %vc3)
  store <512 x i1> %3, ptr %ptr, align 64
  ret void
}
