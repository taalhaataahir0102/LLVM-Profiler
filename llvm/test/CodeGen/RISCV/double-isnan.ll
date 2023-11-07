; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -target-abi ilp32d -verify-machineinstrs \
; RUN:   < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d -target-abi lp64d -verify-machineinstrs \
; RUN:   < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+zdinx -target-abi ilp32 -verify-machineinstrs \
; RUN:   < %s | FileCheck --check-prefix=CHECKRV32ZDINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zdinx -target-abi lp64 -verify-machineinstrs \
; RUN:   < %s | FileCheck --check-prefix=CHECKRV64ZDINX %s

define zeroext i1 @double_is_nan(double %a) nounwind {
; CHECK-LABEL: double_is_nan:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.d a0, fa0, fa0
; CHECK-NEXT:    xori a0, a0, 1
; CHECK-NEXT:    ret
;
; CHECKRV32ZDINX-LABEL: double_is_nan:
; CHECKRV32ZDINX:       # %bb.0:
; CHECKRV32ZDINX-NEXT:    addi sp, sp, -16
; CHECKRV32ZDINX-NEXT:    sw a0, 8(sp)
; CHECKRV32ZDINX-NEXT:    sw a1, 12(sp)
; CHECKRV32ZDINX-NEXT:    lw a0, 8(sp)
; CHECKRV32ZDINX-NEXT:    lw a1, 12(sp)
; CHECKRV32ZDINX-NEXT:    feq.d a0, a0, a0
; CHECKRV32ZDINX-NEXT:    xori a0, a0, 1
; CHECKRV32ZDINX-NEXT:    addi sp, sp, 16
; CHECKRV32ZDINX-NEXT:    ret
;
; CHECKRV64ZDINX-LABEL: double_is_nan:
; CHECKRV64ZDINX:       # %bb.0:
; CHECKRV64ZDINX-NEXT:    feq.d a0, a0, a0
; CHECKRV64ZDINX-NEXT:    xori a0, a0, 1
; CHECKRV64ZDINX-NEXT:    ret
  %1 = fcmp uno double %a, 0.000000e+00
  ret i1 %1
}

define zeroext i1 @double_not_nan(double %a) nounwind {
; CHECK-LABEL: double_not_nan:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.d a0, fa0, fa0
; CHECK-NEXT:    ret
;
; CHECKRV32ZDINX-LABEL: double_not_nan:
; CHECKRV32ZDINX:       # %bb.0:
; CHECKRV32ZDINX-NEXT:    addi sp, sp, -16
; CHECKRV32ZDINX-NEXT:    sw a0, 8(sp)
; CHECKRV32ZDINX-NEXT:    sw a1, 12(sp)
; CHECKRV32ZDINX-NEXT:    lw a0, 8(sp)
; CHECKRV32ZDINX-NEXT:    lw a1, 12(sp)
; CHECKRV32ZDINX-NEXT:    feq.d a0, a0, a0
; CHECKRV32ZDINX-NEXT:    addi sp, sp, 16
; CHECKRV32ZDINX-NEXT:    ret
;
; CHECKRV64ZDINX-LABEL: double_not_nan:
; CHECKRV64ZDINX:       # %bb.0:
; CHECKRV64ZDINX-NEXT:    feq.d a0, a0, a0
; CHECKRV64ZDINX-NEXT:    ret
  %1 = fcmp ord double %a, 0.000000e+00
  ret i1 %1
}
