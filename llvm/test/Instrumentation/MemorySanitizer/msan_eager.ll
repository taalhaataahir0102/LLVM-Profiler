; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -msan-check-access-address=0 -msan-track-origins=1 -msan-eager-checks -S -passes='module(msan)' 2>&1 | \
; RUN:   FileCheck -allow-deprecated-dag-overlap --check-prefix=CHECK %s
; RUN: opt < %s -msan-check-access-address=0 -msan-track-origins=1 -S -passes='msan<eager-checks>' 2>&1 | \
; RUN:   FileCheck -allow-deprecated-dag-overlap --check-prefix=CHECK %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define noundef i32 @NormalRet() nounwind uwtable sanitize_memory {
; CHECK-LABEL: @NormalRet(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    ret i32 123
;
  ret i32 123
}

define i32 @PartialRet() nounwind uwtable sanitize_memory {
; CHECK-LABEL: @PartialRet(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    ret i32 123
;
  ret i32 123
}

define noundef i32 @LoadedRet() nounwind uwtable sanitize_memory {
; CHECK-LABEL: @LoadedRet(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 0 to ptr
; CHECK-NEXT:    [[O:%.*]] = load i32, ptr [[P]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[P]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = xor i64 [[TMP1]], 87960930222080
; CHECK-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[TMP2]] to ptr
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP2]], 17592186044416
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr
; CHECK-NEXT:    [[_MSLD:%.*]] = load i32, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i32 [[_MSLD]], 0
; CHECK-NEXT:    br i1 [[_MSCMP]], label [[TMP7:%.*]], label [[TMP8:%.*]], !prof [[PROF0:![0-9]+]]
; CHECK:       7:
; CHECK-NEXT:    call void @__msan_warning_with_origin_noreturn(i32 [[TMP6]]) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    unreachable
; CHECK:       8:
; CHECK-NEXT:    ret i32 [[O]]
;
  %p = inttoptr i64 0 to ptr
  %o = load i32, ptr %p
  ret i32 %o
}


define void @NormalArg(i32 noundef %a) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @NormalArg(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 0 to ptr
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[P]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = xor i64 [[TMP1]], 87960930222080
; CHECK-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[TMP2]] to ptr
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP2]], 17592186044416
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr
; CHECK-NEXT:    store i32 0, ptr [[TMP3]], align 4
; CHECK-NEXT:    store i32 [[A:%.*]], ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
  %p = inttoptr i64 0 to ptr
  store i32 %a, ptr %p
  ret void
}

define void @NormalArgAfterNoUndef(i32 noundef %a, i32 %b) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @NormalArgAfterNoUndef(
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_origin_tls to i64), i64 8) to ptr), align 4
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 0 to ptr
; CHECK-NEXT:    [[TMP3:%.*]] = ptrtoint ptr [[P]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = xor i64 [[TMP3]], 87960930222080
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[TMP4]], 17592186044416
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to ptr
; CHECK-NEXT:    store i32 [[TMP1]], ptr [[TMP5]], align 4
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[_MSCMP]], label [[TMP8:%.*]], label [[TMP9:%.*]], !prof [[PROF0]]
; CHECK:       8:
; CHECK-NEXT:    store i32 [[TMP2]], ptr [[TMP7]], align 4
; CHECK-NEXT:    br label [[TMP9]]
; CHECK:       9:
; CHECK-NEXT:    store i32 [[B:%.*]], ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
  %p = inttoptr i64 0 to ptr
  store i32 %b, ptr %p
  ret void
}

define void @PartialArg(i32 %a) nounwind uwtable sanitize_memory {
; CHECK-LABEL: @PartialArg(
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr @__msan_param_tls, align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr @__msan_param_origin_tls, align 4
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 0 to ptr
; CHECK-NEXT:    [[TMP3:%.*]] = ptrtoint ptr [[P]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = xor i64 [[TMP3]], 87960930222080
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr
; CHECK-NEXT:    [[TMP6:%.*]] = add i64 [[TMP4]], 17592186044416
; CHECK-NEXT:    [[TMP7:%.*]] = inttoptr i64 [[TMP6]] to ptr
; CHECK-NEXT:    store i32 [[TMP1]], ptr [[TMP5]], align 4
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[_MSCMP]], label [[TMP8:%.*]], label [[TMP9:%.*]], !prof [[PROF0]]
; CHECK:       8:
; CHECK-NEXT:    store i32 [[TMP2]], ptr [[TMP7]], align 4
; CHECK-NEXT:    br label [[TMP9]]
; CHECK:       9:
; CHECK-NEXT:    store i32 [[A:%.*]], ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
  %p = inttoptr i64 0 to ptr
  store i32 %a, ptr %p
  ret void
}

define void @CallNormal() nounwind uwtable sanitize_memory {
; CHECK-LABEL: @CallNormal(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[R:%.*]] = call i32 @NormalRet() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    call void @NormalArg(i32 [[R]]) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  %r = call i32 @NormalRet() nounwind uwtable sanitize_memory
  call void @NormalArg(i32 %r) nounwind uwtable sanitize_memory
  ret void
}

define void @CallNormalArgAfterNoUndef() nounwind uwtable sanitize_memory {
; CHECK-LABEL: @CallNormalArgAfterNoUndef(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[R:%.*]] = call i32 @NormalRet() #[[ATTR0]]
; CHECK-NEXT:    store i32 0, ptr inttoptr (i64 add (i64 ptrtoint (ptr @__msan_param_tls to i64), i64 8) to ptr), align 8
; CHECK-NEXT:    call void @NormalArgAfterNoUndef(i32 [[R]], i32 [[R]]) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  %r = call i32 @NormalRet() nounwind uwtable sanitize_memory
  call void @NormalArgAfterNoUndef(i32 %r, i32 %r) nounwind uwtable sanitize_memory
  ret void
}

define void @CallWithLoaded() nounwind uwtable sanitize_memory {
; CHECK-LABEL: @CallWithLoaded(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 0 to ptr
; CHECK-NEXT:    [[O:%.*]] = load i32, ptr [[P]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = ptrtoint ptr [[P]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = xor i64 [[TMP1]], 87960930222080
; CHECK-NEXT:    [[TMP3:%.*]] = inttoptr i64 [[TMP2]] to ptr
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP2]], 17592186044416
; CHECK-NEXT:    [[TMP5:%.*]] = inttoptr i64 [[TMP4]] to ptr
; CHECK-NEXT:    [[_MSLD:%.*]] = load i32, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[_MSCMP:%.*]] = icmp ne i32 [[_MSLD]], 0
; CHECK-NEXT:    br i1 [[_MSCMP]], label [[TMP7:%.*]], label [[TMP8:%.*]], !prof [[PROF0]]
; CHECK:       7:
; CHECK-NEXT:    call void @__msan_warning_with_origin_noreturn(i32 [[TMP6]]) #[[ATTR3]]
; CHECK-NEXT:    unreachable
; CHECK:       8:
; CHECK-NEXT:    call void @NormalArg(i32 [[O]]) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  %p = inttoptr i64 0 to ptr
  %o = load i32, ptr %p
  call void @NormalArg(i32 %o) nounwind uwtable sanitize_memory
  ret void
}

define void @CallPartial() nounwind uwtable sanitize_memory {
; CHECK-LABEL: @CallPartial(
; CHECK-NEXT:    call void @llvm.donothing()
; CHECK-NEXT:    store i32 0, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    [[R:%.*]] = call i32 @PartialRet() #[[ATTR0]]
; CHECK-NEXT:    [[_MSRET:%.*]] = load i32, ptr @__msan_retval_tls, align 8
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr @__msan_retval_origin_tls, align 4
; CHECK-NEXT:    store i32 [[_MSRET]], ptr @__msan_param_tls, align 8
; CHECK-NEXT:    store i32 [[TMP1]], ptr @__msan_param_origin_tls, align 4
; CHECK-NEXT:    call void @PartialArg(i32 [[R]]) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
  %r = call i32 @PartialRet() nounwind uwtable sanitize_memory
  call void @PartialArg(i32 %r) nounwind uwtable sanitize_memory
  ret void
}
