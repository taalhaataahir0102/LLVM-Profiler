; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64 < %s | FileCheck --check-prefixes CHECK-V8A %s
; RUN: llc -mtriple=aarch64 -mattr=v8.3a < %s | FileCheck --check-prefixes CHECK-V83A %s
; RUN: llc -mtriple=aarch64 -filetype=obj -o - <%s | llvm-dwarfdump -v - | FileCheck --check-prefix=CHECK-DUMP %s

@.str = private unnamed_addr constant [15 x i8] c"some exception\00", align 1
@_ZTIPKc = external dso_local constant ptr

define dso_local i32 @_Z3fooi(i32 %x) #0 {
; CHECK-V8A-LABEL: _Z3fooi:
; CHECK-V8A:       // %bb.0: // %entry
; CHECK-V8A-NEXT:    hint #25
; CHECK-V8A-NEXT:    .cfi_negate_ra_state
; CHECK-V8A-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-V8A-NEXT:    .cfi_def_cfa_offset 16
; CHECK-V8A-NEXT:    .cfi_offset w30, -16
; CHECK-V8A-NEXT:    str w0, [sp, #8]
; CHECK-V8A-NEXT:    mov w0, #8 // =0x8
; CHECK-V8A-NEXT:    bl __cxa_allocate_exception
; CHECK-V8A-NEXT:    adrp x8, .L.str
; CHECK-V8A-NEXT:    add x8, x8, :lo12:.L.str
; CHECK-V8A-NEXT:    adrp x1, _ZTIPKc
; CHECK-V8A-NEXT:    add x1, x1, :lo12:_ZTIPKc
; CHECK-V8A-NEXT:    mov x2, xzr
; CHECK-V8A-NEXT:    str x8, [x0]
; CHECK-V8A-NEXT:    bl __cxa_throw
;
; CHECK-V83A-LABEL: _Z3fooi:
; CHECK-V83A:       // %bb.0: // %entry
; CHECK-V83A-NEXT:    paciasp
; CHECK-V83A-NEXT:    .cfi_negate_ra_state
; CHECK-V83A-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-V83A-NEXT:    .cfi_def_cfa_offset 16
; CHECK-V83A-NEXT:    .cfi_offset w30, -16
; CHECK-V83A-NEXT:    str w0, [sp, #8]
; CHECK-V83A-NEXT:    mov w0, #8 // =0x8
; CHECK-V83A-NEXT:    bl __cxa_allocate_exception
; CHECK-V83A-NEXT:    adrp x8, .L.str
; CHECK-V83A-NEXT:    add x8, x8, :lo12:.L.str
; CHECK-V83A-NEXT:    adrp x1, _ZTIPKc
; CHECK-V83A-NEXT:    add x1, x1, :lo12:_ZTIPKc
; CHECK-V83A-NEXT:    mov x2, xzr
; CHECK-V83A-NEXT:    str x8, [x0]
; CHECK-V83A-NEXT:    bl __cxa_throw
entry:
  %retval = alloca i32, align 4
  %x.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  %exception = call ptr @__cxa_allocate_exception(i64 8) #1
  store ptr @.str, ptr %exception, align 16
  call void @__cxa_throw(ptr %exception, ptr @_ZTIPKc, ptr null) #2
  unreachable

return:                                           ; No predecessors!
  %0 = load i32, ptr %retval, align 4
  ret i32 %0
}

; For asynchronous unwind tables, we need to flip the value of RA_SIGN_STATE
; before and after the tail call.
define hidden noundef i32 @baz_async(i32 noundef %a) #0 uwtable(async) {
; CHECK-V8A-LABEL: baz_async:
; CHECK-V8A:       // %bb.0: // %entry
; CHECK-V8A-NEXT:    hint #25
; CHECK-V8A-NEXT:    .cfi_negate_ra_state
; CHECK-V8A-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-V8A-NEXT:    .cfi_def_cfa_offset 16
; CHECK-V8A-NEXT:    .cfi_offset w30, -16
; CHECK-V8A-NEXT:    .cfi_remember_state
; CHECK-V8A-NEXT:    cbz w0, .LBB1_2
; CHECK-V8A-NEXT:  // %bb.1: // %if.then
; CHECK-V8A-NEXT:    mov w0, wzr
; CHECK-V8A-NEXT:    bl _Z3bari
; CHECK-V8A-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-V8A-NEXT:    .cfi_def_cfa_offset 0
; CHECK-V8A-NEXT:    hint #29
; CHECK-V8A-NEXT:    .cfi_negate_ra_state
; CHECK-V8A-NEXT:    .cfi_restore w30
; CHECK-V8A-NEXT:    b _Z3bari
; CHECK-V8A-NEXT:  .LBB1_2: // %if.else
; CHECK-V8A-NEXT:    .cfi_restore_state
; CHECK-V8A-NEXT:    bl _Z4quuxi
; CHECK-V8A-NEXT:    add w0, w0, #1
; CHECK-V8A-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-V8A-NEXT:    .cfi_def_cfa_offset 0
; CHECK-V8A-NEXT:    hint #29
; CHECK-V8A-NEXT:    .cfi_negate_ra_state
; CHECK-V8A-NEXT:    .cfi_restore w30
; CHECK-V8A-NEXT:    ret
;
; CHECK-V83A-LABEL: baz_async:
; CHECK-V83A:       // %bb.0: // %entry
; CHECK-V83A-NEXT:    paciasp
; CHECK-V83A-NEXT:    .cfi_negate_ra_state
; CHECK-V83A-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-V83A-NEXT:    .cfi_def_cfa_offset 16
; CHECK-V83A-NEXT:    .cfi_offset w30, -16
; CHECK-V83A-NEXT:    .cfi_remember_state
; CHECK-V83A-NEXT:    cbz w0, .LBB1_2
; CHECK-V83A-NEXT:  // %bb.1: // %if.then
; CHECK-V83A-NEXT:    mov w0, wzr
; CHECK-V83A-NEXT:    bl _Z3bari
; CHECK-V83A-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-V83A-NEXT:    .cfi_def_cfa_offset 0
; CHECK-V83A-NEXT:    autiasp
; CHECK-V83A-NEXT:    .cfi_negate_ra_state
; CHECK-V83A-NEXT:    .cfi_restore w30
; CHECK-V83A-NEXT:    b _Z3bari
; CHECK-V83A-NEXT:  .LBB1_2: // %if.else
; CHECK-V83A-NEXT:    .cfi_restore_state
; CHECK-V83A-NEXT:    bl _Z4quuxi
; CHECK-V83A-NEXT:    add w0, w0, #1
; CHECK-V83A-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-V83A-NEXT:    .cfi_def_cfa_offset 0
; CHECK-V83A-NEXT:    .cfi_restore w30
; CHECK-V83A-NEXT:    retaa
entry:
  %tobool.not = icmp eq i32 %a, 0
  br i1 %tobool.not, label %if.else, label %if.then

if.then:                                          ; preds = %entry
  %call = tail call noundef i32 @_Z3bari(i32 noundef 0)
  %call1 = tail call noundef i32 @_Z3bari(i32 noundef %call)
  br label %return

if.else:                                          ; preds = %entry
  %call2 = tail call noundef i32 @_Z4quuxi(i32 noundef 0)
  %add = add nsw i32 %call2, 1
  br label %return

return:                                           ; preds = %if.else, %if.then
  %retval.0 = phi i32 [ %call1, %if.then ], [ %add, %if.else ]
  ret i32 %retval.0
}

; For synchronous unwind tables, we don't need to update the unwind tables
; around the tail call. The tail-called function might throw an exception, but
; at this point we are set up to return into baz's caller, so the unwinder will
; never see baz's unwind table for that exception.
define hidden noundef i32 @baz_sync(i32 noundef %a) #0 uwtable(sync) {
; CHECK-V8A-LABEL: baz_sync:
; CHECK-V8A:       // %bb.0: // %entry
; CHECK-V8A-NEXT:    hint #25
; CHECK-V8A-NEXT:    .cfi_negate_ra_state
; CHECK-V8A-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-V8A-NEXT:    .cfi_def_cfa_offset 16
; CHECK-V8A-NEXT:    .cfi_offset w30, -16
; CHECK-V8A-NEXT:    cbz w0, .LBB2_2
; CHECK-V8A-NEXT:  // %bb.1: // %if.then
; CHECK-V8A-NEXT:    mov w0, wzr
; CHECK-V8A-NEXT:    bl _Z3bari
; CHECK-V8A-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-V8A-NEXT:    hint #29
; CHECK-V8A-NEXT:    b _Z3bari
; CHECK-V8A-NEXT:  .LBB2_2: // %if.else
; CHECK-V8A-NEXT:    bl _Z4quuxi
; CHECK-V8A-NEXT:    add w0, w0, #1
; CHECK-V8A-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-V8A-NEXT:    hint #29
; CHECK-V8A-NEXT:    ret
;
; CHECK-V83A-LABEL: baz_sync:
; CHECK-V83A:       // %bb.0: // %entry
; CHECK-V83A-NEXT:    paciasp
; CHECK-V83A-NEXT:    .cfi_negate_ra_state
; CHECK-V83A-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-V83A-NEXT:    .cfi_def_cfa_offset 16
; CHECK-V83A-NEXT:    .cfi_offset w30, -16
; CHECK-V83A-NEXT:    cbz w0, .LBB2_2
; CHECK-V83A-NEXT:  // %bb.1: // %if.then
; CHECK-V83A-NEXT:    mov w0, wzr
; CHECK-V83A-NEXT:    bl _Z3bari
; CHECK-V83A-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-V83A-NEXT:    autiasp
; CHECK-V83A-NEXT:    b _Z3bari
; CHECK-V83A-NEXT:  .LBB2_2: // %if.else
; CHECK-V83A-NEXT:    bl _Z4quuxi
; CHECK-V83A-NEXT:    add w0, w0, #1
; CHECK-V83A-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-V83A-NEXT:    retaa
entry:
  %tobool.not = icmp eq i32 %a, 0
  br i1 %tobool.not, label %if.else, label %if.then

if.then:                                          ; preds = %entry
  %call = tail call noundef i32 @_Z3bari(i32 noundef 0)
  %call1 = tail call noundef i32 @_Z3bari(i32 noundef %call)
  br label %return

if.else:                                          ; preds = %entry
  %call2 = tail call noundef i32 @_Z4quuxi(i32 noundef 0)
  %add = add nsw i32 %call2, 1
  br label %return

return:                                           ; preds = %if.else, %if.then
  %retval.0 = phi i32 [ %call1, %if.then ], [ %add, %if.else ]
  ret i32 %retval.0
}

declare dso_local ptr @__cxa_allocate_exception(i64)

declare dso_local void @__cxa_throw(ptr, ptr, ptr)

declare dso_local noundef i32 @_Z3bari(i32 noundef) local_unnamed_addr
declare dso_local noundef i32 @_Z4quuxi(i32 noundef) local_unnamed_addr

attributes #0 = { "sign-return-address"="all" }

; foo
; CHECK-DUMP-LABEL: FDE
; CHECK-DUMP:   DW_CFA_AARCH64_negate_ra_state:
; CHECK-DUMP-NOT: DW_CFA_AARCH64_negate_ra_state
; CHECK-DUMP-NOT: DW_CFA_remember_state
; CHECK-DUMP-NOT: DW_CFA_restore_state

; baz_async
; CHECK-DUMP-LABEL: FDE
; CHECK-DUMP: Format:       DWARF32
; CHECK-DUMP:   DW_CFA_AARCH64_negate_ra_state:
; CHECK-DUMP:   DW_CFA_remember_state:
; CHECK-DUMP:   DW_CFA_AARCH64_negate_ra_state:
; CHECK-DUMP:   DW_CFA_restore_state:
; CHECK-DUMP:   DW_CFA_AARCH64_negate_ra_state:

; baz_sync
; CHECK-DUMP-LABEL: FDE
; CHECK-DUMP:   DW_CFA_AARCH64_negate_ra_state:
; CHECK-DUMP-NOT: DW_CFA_AARCH64_negate_ra_state
; CHECK-DUMP-NOT: DW_CFA_remember_state
; CHECK-DUMP-NOT: DW_CFA_restore_state
