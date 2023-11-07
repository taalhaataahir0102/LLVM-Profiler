; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine %s | FileCheck %s

@a = common global i8 0, align 1
@b = external global i32

define void @tinkywinky() {
; CHECK-LABEL: @tinkywinky(
; CHECK-NEXT:    [[PATATINO:%.*]] = load i8, ptr @a, align 1
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i8 [[PATATINO]], 0
; CHECK-NEXT:    [[LNOT_EXT:%.*]] = zext i1 [[TOBOOL_NOT]] to i32
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[LNOT_EXT]], xor (i32 zext (i1 icmp ne (ptr @a, ptr @b) to i32), i32 2)
; CHECK-NEXT:    store i32 [[OR]], ptr @b, align 4
; CHECK-NEXT:    ret void
;
  %patatino = load i8, ptr @a
  %tobool = icmp ne i8 %patatino, 0
  %lnot = xor i1 %tobool, true
  %lnot.ext = zext i1 %lnot to i32
  %or = or i32 xor (i32 zext (i1 icmp ne (ptr @a, ptr @b) to i32), i32 2), %lnot.ext
  store i32 %or, ptr @b, align 4
  ret void
}
