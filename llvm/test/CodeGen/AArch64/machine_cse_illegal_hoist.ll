; RUN: llc -O3 < %s | FileCheck %s
;
;  Check ADRP instr is not hoisted to entry basic block
;  which may throw exception.
;
; CHECK: adrp
; CHECK: adrp
; CHECK: adrp

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64"

@var = hidden local_unnamed_addr global i32 0, align 4
@_ZTIi = external dso_local constant ptr
declare dso_local void @_Z2fnv() local_unnamed_addr #1
declare dso_local i32 @__gxx_personality_v0(...)
declare i32 @llvm.eh.typeid.for(ptr) #2
declare dso_local ptr @__cxa_begin_catch(ptr) local_unnamed_addr
declare dso_local void @__cxa_end_catch() local_unnamed_addr

define hidden i32 @_Z7examplev() personality ptr @__gxx_personality_v0 {
entry:
  invoke void @_Z2fnv() to label %try.cont unwind label %lpad

lpad:                                             ; preds = %entry
  %0 = landingpad { ptr, i32 }
          catch ptr @_ZTIi
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  %2 = extractvalue { ptr, i32 } %0, 1
  %3 = tail call i32 @llvm.eh.typeid.for(ptr @_ZTIi)
  %matches = icmp eq i32 %2, %3
  %4 = tail call ptr @__cxa_begin_catch(ptr %1)
  %5 = load i32, ptr @var, align 4
  br i1 %matches, label %catch1, label %catch

catch1:                                           ; preds = %lpad
  %or3 = or i32 %5, 4
  store i32 %or3, ptr @var, align 4
  tail call void @__cxa_end_catch()
  br label %try.cont

try.cont:                                         ; preds = %entry, %catch1, %catch
  %6 = load i32, ptr @var, align 4
  ret i32 %6

catch:                                            ; preds = %lpad
  %or = or i32 %5, 8
  store i32 %or, ptr @var, align 4
  tail call void @__cxa_end_catch()
  br label %try.cont
}
