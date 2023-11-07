; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test that the isascii library call simplifier works correctly even for
; targets with 16-bit int.
;
; RUN: opt < %s -mtriple=avr-freebsd -passes=instcombine -S | FileCheck %s
; RUN: opt < %s -mtriple=msp430-linux -passes=instcombine -S | FileCheck %s

declare i16 @isascii(i16)

declare void @sink(i16)


define void @fold_isascii(i16 %c) {
; CHECK-LABEL: @fold_isascii(
; CHECK-NEXT:    call void @sink(i16 1)
; CHECK-NEXT:    call void @sink(i16 1)
; CHECK-NEXT:    call void @sink(i16 1)
; CHECK-NEXT:    call void @sink(i16 0)
; CHECK-NEXT:    call void @sink(i16 0)
; CHECK-NEXT:    call void @sink(i16 0)
; CHECK-NEXT:    call void @sink(i16 0)
; CHECK-NEXT:    call void @sink(i16 0)
; CHECK-NEXT:    [[ISASCII:%.*]] = icmp ult i16 [[C:%.*]], 128
; CHECK-NEXT:    [[IC:%.*]] = zext i1 [[ISASCII]] to i16
; CHECK-NEXT:    call void @sink(i16 [[IC]])
; CHECK-NEXT:    ret void
;
  %i0 = call i16 @isascii(i16 0)
  call void @sink(i16 %i0)

  %i1 = call i16 @isascii(i16 1)
  call void @sink(i16 %i1)

  %i127 = call i16 @isascii(i16 127)
  call void @sink(i16 %i127)

  %i128 = call i16 @isascii(i16 128)
  call void @sink(i16 %i128)

  %i255 = call i16 @isascii(i16 255)
  call void @sink(i16 %i255)

  %i256 = call i16 @isascii(i16 256)
  call void @sink(i16 %i256)

  ; Fold isascii(INT_MAX) to 0.  The call is valid with all int values.
  %imax = call i16 @isascii(i16 32767)
  call void @sink(i16 %imax)

  %uimax = call i16 @isascii(i16 65535)
  call void @sink(i16 %uimax)

  %ic = call i16 @isascii(i16 %c)
  call void @sink(i16 %ic)

  ret void
}
