; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+v -stop-after=finalize-isel | FileCheck %s

; Make sure we don't create a COPY instruction for IMPLICIT_DEF.

define <vscale x 8 x i64> @vpload_nxv8i64(<vscale x 8 x i64>* %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) #1 {
  ; CHECK-LABEL: name: vpload_nxv8i64
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $x10, $v0, $x11
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:gprnox0 = COPY $x11
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vr = COPY $v0
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:gpr = COPY $x10
  ; CHECK-NEXT:   $v0 = COPY [[COPY1]]
  ; CHECK-NEXT:   [[PseudoVLE64_V_M8_MASK:%[0-9]+]]:vrm8nov0 = PseudoVLE64_V_M8_MASK $noreg, [[COPY2]], $v0, [[COPY]], 6 /* e64 */, 1 /* ta, mu */ :: (load unknown-size from %ir.ptr, align 64)
  ; CHECK-NEXT:   $v8m8 = COPY [[PseudoVLE64_V_M8_MASK]]
  ; CHECK-NEXT:   PseudoRET implicit $v8m8
  %load = call <vscale x 8 x i64> @llvm.vp.load.nxv8i64.p0(<vscale x 8 x i64>* %ptr, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i64> %load
}

declare <vscale x 8 x i64> @llvm.vp.load.nxv8i64.p0(<vscale x 8 x i64>*, <vscale x 8 x i1>, i32)
