; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vrotr.b(<16 x i8>, <16 x i8>)

define <16 x i8> @lsx_vrotr_b(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vrotr_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrotr.b $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vrotr.b(<16 x i8> %va, <16 x i8> %vb)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vrotr.h(<8 x i16>, <8 x i16>)

define <8 x i16> @lsx_vrotr_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vrotr_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrotr.h $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vrotr.h(<8 x i16> %va, <8 x i16> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vrotr.w(<4 x i32>, <4 x i32>)

define <4 x i32> @lsx_vrotr_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vrotr_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrotr.w $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vrotr.w(<4 x i32> %va, <4 x i32> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vrotr.d(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vrotr_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vrotr_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrotr.d $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vrotr.d(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <16 x i8> @llvm.loongarch.lsx.vrotri.b(<16 x i8>, i32)

define <16 x i8> @lsx_vrotri_b(<16 x i8> %va) nounwind {
; CHECK-LABEL: lsx_vrotri_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrotri.b $vr0, $vr0, 7
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vrotri.b(<16 x i8> %va, i32 7)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vrotri.h(<8 x i16>, i32)

define <8 x i16> @lsx_vrotri_h(<8 x i16> %va) nounwind {
; CHECK-LABEL: lsx_vrotri_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrotri.h $vr0, $vr0, 15
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vrotri.h(<8 x i16> %va, i32 15)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vrotri.w(<4 x i32>, i32)

define <4 x i32> @lsx_vrotri_w(<4 x i32> %va) nounwind {
; CHECK-LABEL: lsx_vrotri_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrotri.w $vr0, $vr0, 31
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vrotri.w(<4 x i32> %va, i32 31)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vrotri.d(<2 x i64>, i32)

define <2 x i64> @lsx_vrotri_d(<2 x i64> %va) nounwind {
; CHECK-LABEL: lsx_vrotri_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vrotri.d $vr0, $vr0, 63
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vrotri.d(<2 x i64> %va, i32 63)
  ret <2 x i64> %res
}
