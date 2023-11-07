; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

define <vscale x 4 x i32> @replace_sel_intrinsic(<vscale x 4 x i1> %p, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b) #0 {
; CHECK-LABEL: @replace_sel_intrinsic(
; CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 4 x i1> [[P:%.*]], <vscale x 4 x i32> [[A:%.*]], <vscale x 4 x i32> [[B:%.*]]
; CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
;
  %1 = tail call <vscale x 4 x i32> @llvm.aarch64.sve.sel.nxv4i32(<vscale x 4 x i1> %p, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %1
}

declare <vscale x 4 x i32> @llvm.aarch64.sve.sel.nxv4i32(<vscale x 4 x i1>, <vscale x 4 x i32>, <vscale x 4 x i32>)

attributes #0 = { "target-features"="+sve" }
