; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare i32 @llvm.loongarch.lsx.vpickve2gr.b(<16 x i8>, i32)

define i32 @lsx_vpickve2gr_b(<16 x i8> %va) nounwind {
; CHECK-LABEL: lsx_vpickve2gr_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpickve2gr.b $a0, $vr0, 15
; CHECK-NEXT:    ret
entry:
  %res = call i32 @llvm.loongarch.lsx.vpickve2gr.b(<16 x i8> %va, i32 15)
  ret i32 %res
}

declare i32 @llvm.loongarch.lsx.vpickve2gr.h(<8 x i16>, i32)

define i32 @lsx_vpickve2gr_h(<8 x i16> %va) nounwind {
; CHECK-LABEL: lsx_vpickve2gr_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpickve2gr.h $a0, $vr0, 7
; CHECK-NEXT:    ret
entry:
  %res = call i32 @llvm.loongarch.lsx.vpickve2gr.h(<8 x i16> %va, i32 7)
  ret i32 %res
}

declare i32 @llvm.loongarch.lsx.vpickve2gr.w(<4 x i32>, i32)

define i32 @lsx_vpickve2gr_w(<4 x i32> %va) nounwind {
; CHECK-LABEL: lsx_vpickve2gr_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpickve2gr.w $a0, $vr0, 3
; CHECK-NEXT:    ret
entry:
  %res = call i32 @llvm.loongarch.lsx.vpickve2gr.w(<4 x i32> %va, i32 3)
  ret i32 %res
}

declare i64 @llvm.loongarch.lsx.vpickve2gr.d(<2 x i64>, i32)

define i64 @lsx_vpickve2gr_d(<2 x i64> %va) nounwind {
; CHECK-LABEL: lsx_vpickve2gr_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpickve2gr.d $a0, $vr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call i64 @llvm.loongarch.lsx.vpickve2gr.d(<2 x i64> %va, i32 1)
  ret i64 %res
}

declare i32 @llvm.loongarch.lsx.vpickve2gr.bu(<16 x i8>, i32)

define i32 @lsx_vpickve2gr_bu(<16 x i8> %va) nounwind {
; CHECK-LABEL: lsx_vpickve2gr_bu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpickve2gr.bu $a0, $vr0, 15
; CHECK-NEXT:    ret
entry:
  %res = call i32 @llvm.loongarch.lsx.vpickve2gr.bu(<16 x i8> %va, i32 15)
  ret i32 %res
}

declare i32 @llvm.loongarch.lsx.vpickve2gr.hu(<8 x i16>, i32)

define i32 @lsx_vpickve2gr_hu(<8 x i16> %va) nounwind {
; CHECK-LABEL: lsx_vpickve2gr_hu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpickve2gr.hu $a0, $vr0, 7
; CHECK-NEXT:    ret
entry:
  %res = call i32 @llvm.loongarch.lsx.vpickve2gr.hu(<8 x i16> %va, i32 7)
  ret i32 %res
}

declare i32 @llvm.loongarch.lsx.vpickve2gr.wu(<4 x i32>, i32)

define i32 @lsx_vpickve2gr_wu(<4 x i32> %va) nounwind {
; CHECK-LABEL: lsx_vpickve2gr_wu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpickve2gr.wu $a0, $vr0, 3
; CHECK-NEXT:    ret
entry:
  %res = call i32 @llvm.loongarch.lsx.vpickve2gr.wu(<4 x i32> %va, i32 3)
  ret i32 %res
}

declare i64 @llvm.loongarch.lsx.vpickve2gr.du(<2 x i64>, i32)

define i64 @lsx_vpickve2gr_du(<2 x i64> %va) nounwind {
; CHECK-LABEL: lsx_vpickve2gr_du:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpickve2gr.du $a0, $vr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call i64 @llvm.loongarch.lsx.vpickve2gr.du(<2 x i64> %va, i32 1)
  ret i64 %res
}
