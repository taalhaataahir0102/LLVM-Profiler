; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <4 x float> @llvm.loongarch.lsx.vfcvth.s.h(<8 x i16>)

define <4 x float> @lsx_vfcvth_s_h(<8 x i16> %va) nounwind {
; CHECK-LABEL: lsx_vfcvth_s_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vfcvth.s.h $vr0, $vr0
; CHECK-NEXT:    ret
entry:
  %res = call <4 x float> @llvm.loongarch.lsx.vfcvth.s.h(<8 x i16> %va)
  ret <4 x float> %res
}

declare <2 x double> @llvm.loongarch.lsx.vfcvth.d.s(<4 x float>)

define <2 x double> @lsx_vfcvth_d_s(<4 x float> %va) nounwind {
; CHECK-LABEL: lsx_vfcvth_d_s:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vfcvth.d.s $vr0, $vr0
; CHECK-NEXT:    ret
entry:
  %res = call <2 x double> @llvm.loongarch.lsx.vfcvth.d.s(<4 x float> %va)
  ret <2 x double> %res
}
