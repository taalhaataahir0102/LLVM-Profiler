; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=riscv32 | FileCheck %s

define i1 @f(i64 %LGV1) {
; CHECK-LABEL: f:
; CHECK:       # %bb.0:
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    xori a0, a0, 1
; CHECK-NEXT:    ret
  %B1 = xor i64 %LGV1, %LGV1
  %B2 = srem i64 1, %B1
  %B5 = lshr i64 1, %B2
  %C4 = icmp ule i64 %LGV1, %B5
  ret i1 %C4
}

define i64 @g(ptr %A, i64 %0) {
; CHECK-LABEL: g:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slt a0, a0, a2
; CHECK-NEXT:    xori a0, a0, 1
; CHECK-NEXT:    sb a0, 0(zero)
; CHECK-NEXT:    ret
  store i64 poison, ptr %A, align 4
  %LGV1 = load i64, ptr %A, align 4
  %B1 = ashr i64 1, %LGV1
  %C = icmp sle i64 %0, %B1
  store i1 %C, ptr null, align 1
  ret i64 %LGV1
}
