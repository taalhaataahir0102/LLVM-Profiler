; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -verify-machineinstrs -stop-after=irtranslator -o - %s | FileCheck %s

@var = global i32 undef

define i32 @test() {
  ; CHECK-LABEL: name: test
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 -1
  ; CHECK-NEXT:   [[INTTOPTR:%[0-9]+]]:_(p0) = G_INTTOPTR [[C]](s32)
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @var
  ; CHECK-NEXT:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[INTTOPTR]](p0), [[GV]]
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s32) = G_ZEXT [[ICMP]](s1)
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY [[ZEXT]](s32)
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY [[COPY]](s32)
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY [[COPY1]](s32)
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:_(s32) = COPY [[COPY2]](s32)
  ; CHECK-NEXT:   $vgpr0 = COPY [[COPY3]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0
  ret i32 bitcast (<1 x i32> <i32 extractelement (<1 x i32> bitcast (i32 zext (i1 icmp eq (ptr @var, ptr inttoptr (i32 -1 to ptr)) to i32) to <1 x i32>), i64 0)> to i32)
}

@a = external global [2 x i32], align 4

define i32 @test_fcmp_constexpr() {
  ; CHECK-LABEL: name: test_fcmp_constexpr
  ; CHECK: bb.1.entry:
  ; CHECK-NEXT:   [[GV:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @a
  ; CHECK-NEXT:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; CHECK-NEXT:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[GV]], [[C]](s64)
  ; CHECK-NEXT:   [[GV1:%[0-9]+]]:_(p0) = G_GLOBAL_VALUE @var
  ; CHECK-NEXT:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[PTR_ADD]](p0), [[GV1]]
  ; CHECK-NEXT:   [[UITOFP:%[0-9]+]]:_(s32) = G_UITOFP [[ICMP]](s1)
  ; CHECK-NEXT:   [[C1:%[0-9]+]]:_(s32) = G_FCONSTANT float 0.000000e+00
  ; CHECK-NEXT:   [[FCMP:%[0-9]+]]:_(s1) = G_FCMP floatpred(oeq), [[UITOFP]](s32), [[C1]]
  ; CHECK-NEXT:   [[ZEXT:%[0-9]+]]:_(s32) = G_ZEXT [[FCMP]](s1)
  ; CHECK-NEXT:   $vgpr0 = COPY [[ZEXT]](s32)
  ; CHECK-NEXT:   SI_RETURN implicit $vgpr0
entry:
  ret i32 zext (i1 fcmp oeq (float uitofp (i1 icmp eq (ptr getelementptr inbounds ([2 x i32], ptr @a, i64 0, i64 1), ptr @var) to float), float 0.000000e+00) to i32)
}
