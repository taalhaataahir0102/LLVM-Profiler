; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s | FileCheck %s

; Verify that the following code can be compiled without +sme, because if the
; call is not entered in streaming-SVE mode at runtime, the codepath leading
; to the smstop/smstart pair will not be executed either.

target triple = "aarch64"

define void @streaming_compatible() #0 {
; CHECK-LABEL: streaming_compatible:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp d15, d14, [sp, #-80]! // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp x30, x19, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    bl __arm_sme_state
; CHECK-NEXT:    and x19, x0, #0x1
; CHECK-NEXT:    tbz x19, #0, .LBB0_2
; CHECK-NEXT:  // %bb.1:
; CHECK-NEXT:    smstop sm
; CHECK-NEXT:  .LBB0_2:
; CHECK-NEXT:    bl non_streaming
; CHECK-NEXT:    tbz x19, #0, .LBB0_4
; CHECK-NEXT:  // %bb.3:
; CHECK-NEXT:    smstart sm
; CHECK-NEXT:  .LBB0_4:
; CHECK-NEXT:    ldp x30, x19, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp], #80 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  call void @non_streaming()
  ret void
}

declare void @non_streaming()

attributes #0 = { nounwind "aarch64_pstate_sm_compatible" }
