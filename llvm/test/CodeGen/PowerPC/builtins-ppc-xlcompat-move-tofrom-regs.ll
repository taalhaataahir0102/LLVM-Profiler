; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr8 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr7 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-aix \
; RUN:   -mcpu=pwr7 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc-unknown-aix \
; RUN:   -mcpu=pwr7 < %s | FileCheck %s --check-prefix=CHECK-32BIT

declare i32 @llvm.ppc.mftbu()
declare i32 @llvm.ppc.mfmsr()
declare void @llvm.ppc.mtmsr(i32)

@ula = external local_unnamed_addr global i64, align 8

define dso_local zeroext i32 @test_mftbu() {
; CHECK-LABEL: test_mftbu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mftbu 3
; CHECK-NEXT:    clrldi 3, 3, 32
; CHECK-NEXT:    blr
;
; CHECK-32BIT-LABEL: test_mftbu:
; CHECK-32BIT:       # %bb.0: # %entry
; CHECK-32BIT-NEXT:    mftbu 3
; CHECK-32BIT-NEXT:    blr
entry:
  %0 = tail call i32 @llvm.ppc.mftbu()
  ret i32 %0
}

define dso_local i64 @test_mfmsr() {
; CHECK-LABEL: test_mfmsr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mfmsr 3
; CHECK-NEXT:    clrldi 3, 3, 32
; CHECK-NEXT:    blr
;
; CHECK-32BIT-LABEL: test_mfmsr:
; CHECK-32BIT:       # %bb.0: # %entry
; CHECK-32BIT-NEXT:    mfmsr 4
; CHECK-32BIT-NEXT:    li 3, 0
; CHECK-32BIT-NEXT:    blr
entry:
  %0 = tail call i32 @llvm.ppc.mfmsr()
  %conv = zext i32 %0 to i64
  ret i64 %conv
}

define dso_local void @test_mtmsr() {
; CHECK-LABEL: test_mtmsr:
; CHECK:    mtmsr 3
; CHECK-NEXT:    blr
;
; CHECK-32BIT-LABEL: test_mtmsr:
; CHECK-32BIT:       # %bb.0: # %entry
; CHECK-32BIT-NEXT:    lwz 3, L..C0(2) # @ula
; CHECK-32BIT-NEXT:    lwz 3, 4(3)
; CHECK-32BIT-NEXT:    mtmsr 3, 0
; CHECK-32BIT-NEXT:    blr
entry:
  %0 = load i64, ptr @ula, align 8
  %conv = trunc i64 %0 to i32
  call void @llvm.ppc.mtmsr(i32 %conv)
  ret void
}
