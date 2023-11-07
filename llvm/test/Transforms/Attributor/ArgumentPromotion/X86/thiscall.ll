; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; In PR41658, argpromotion put an inalloca in a position that per the
; calling convention is passed in a register. This test verifies that
; we don't do that anymore. It also verifies that the combination of
; globalopt and argpromotion is able to optimize the call safely.
;
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

target datalayout = "e-m:x-p:32:32-i64:64-f80:32-n8:16:32-a:0:32-S32"
target triple = "i386-pc-windows-msvc19.11.0"

%struct.a = type { i8 }

define internal x86_thiscallcc void @internalfun(ptr %this, ptr inalloca(<{ %struct.a }>)) {
; CHECK-LABEL: define {{[^@]+}}@internalfun
; CHECK-SAME: (ptr noalias nocapture nofree readnone [[THIS:%.*]], ptr noundef nonnull inalloca(<{ [[STRUCT_A:%.*]] }>) align 4 dereferenceable(1) [[TMP0:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARGMEM:%.*]] = alloca inalloca <{ [[STRUCT_A]] }>, align 4
; CHECK-NEXT:    [[CALL:%.*]] = call x86_thiscallcc ptr @copy_ctor(ptr noundef nonnull align 4 dereferenceable(1) [[ARGMEM]], ptr noundef nonnull align 4 dereferenceable(1) [[TMP0]])
; CHECK-NEXT:    call void @ext(ptr noundef nonnull inalloca(<{ [[STRUCT_A]] }>) align 4 dereferenceable(1) [[ARGMEM]])
; CHECK-NEXT:    ret void
;
entry:
  %argmem = alloca inalloca <{ %struct.a }>, align 4
  %call = call x86_thiscallcc ptr @copy_ctor(ptr %argmem, ptr dereferenceable(1) %0)
  call void @ext(ptr inalloca(<{ %struct.a }>) %argmem)
  ret void
}

; This is here to ensure @internalfun is live.
define void @exportedfun(ptr %a) {
; TUNIT-LABEL: define {{[^@]+}}@exportedfun
; TUNIT-SAME: (ptr nocapture nofree readnone [[A:%.*]]) {
; TUNIT-NEXT:    [[INALLOCA_SAVE:%.*]] = tail call ptr @llvm.stacksave.p0() #[[ATTR1:[0-9]+]]
; TUNIT-NEXT:    [[ARGMEM:%.*]] = alloca inalloca <{ [[STRUCT_A:%.*]] }>, align 4
; TUNIT-NEXT:    call x86_thiscallcc void @internalfun(ptr noalias nocapture nofree readnone undef, ptr noundef nonnull inalloca(<{ [[STRUCT_A]] }>) align 4 dereferenceable(1) [[ARGMEM]])
; TUNIT-NEXT:    call void @llvm.stackrestore.p0(ptr nofree [[INALLOCA_SAVE]])
; TUNIT-NEXT:    ret void
;
; CGSCC-LABEL: define {{[^@]+}}@exportedfun
; CGSCC-SAME: (ptr nocapture nofree readnone [[A:%.*]]) {
; CGSCC-NEXT:    [[INALLOCA_SAVE:%.*]] = tail call ptr @llvm.stacksave.p0() #[[ATTR1:[0-9]+]]
; CGSCC-NEXT:    [[ARGMEM:%.*]] = alloca inalloca <{ [[STRUCT_A:%.*]] }>, align 4
; CGSCC-NEXT:    call x86_thiscallcc void @internalfun(ptr noalias nocapture nofree readnone [[A]], ptr noundef nonnull inalloca(<{ [[STRUCT_A]] }>) align 4 dereferenceable(1) [[ARGMEM]])
; CGSCC-NEXT:    call void @llvm.stackrestore.p0(ptr nofree [[INALLOCA_SAVE]])
; CGSCC-NEXT:    ret void
;
  %inalloca.save = tail call ptr @llvm.stacksave()
  %argmem = alloca inalloca <{ %struct.a }>, align 4
  call x86_thiscallcc void @internalfun(ptr %a, ptr inalloca(<{ %struct.a }>) %argmem)
  call void @llvm.stackrestore(ptr %inalloca.save)
  ret void
}

declare x86_thiscallcc ptr @copy_ctor(ptr returned, ptr dereferenceable(1))
declare void @ext(ptr inalloca(<{ %struct.a }>))
declare ptr @llvm.stacksave()
declare void @llvm.stackrestore(ptr)
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nocallback nofree nosync nounwind willreturn }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nofree willreturn }
;.
