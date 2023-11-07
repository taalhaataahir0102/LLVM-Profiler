; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s \
; RUN:   | FileCheck %s
; RUN: llc -verify-machineinstrs -target-abi=elfv2 -mtriple=powerpc64-- \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s \
; RUN:   | FileCheck %s

 @_ZL13StaticBoolVar = internal unnamed_addr global i8 0, align 1
@_ZL19StaticSignedCharVar = internal unnamed_addr global i8 0, align 1
@_ZL21StaticUnsignedCharVar = internal unnamed_addr global i8 0, align 1
@_ZL20StaticSignedShortVar = internal unnamed_addr global i16 0, align 2
@_ZL22StaticUnsignedShortVar = internal unnamed_addr global i16 0, align 2
@_ZL18StaticSignedIntVar = internal unnamed_addr global i32 0, align 4
@_ZL20StaticUnsignedIntVar = internal unnamed_addr global i32 0, align 4
@_ZL19StaticSignedLongVar = internal unnamed_addr global i64 0, align 8
@_ZL14StaticFloatVar = internal unnamed_addr global float 0.000000e+00, align 4
@_ZL15StaticDoubleVar = internal unnamed_addr global double 0.000000e+00, align 8
@_ZL19StaticLongDoubleVar = internal unnamed_addr global ppc_fp128 0xM00000000000000000000000000000000, align 16
@_ZL23StaticSigned__Int128Var = internal unnamed_addr global i128 0, align 16
@_ZL19Static__Float128Var = internal unnamed_addr global fp128 0xL00000000000000000000000000000000, align 16
@_ZL25StaticVectorSignedCharVar = internal unnamed_addr global <16 x i8> zeroinitializer, align 16
@_ZL26StaticVectorSignedShortVar = internal unnamed_addr global <8 x i16> zeroinitializer, align 16
@_ZL24StaticVectorSignedIntVar = internal unnamed_addr global <4 x i32> zeroinitializer, align 16
@_ZL29StaticVectorSignedLongLongVar = internal unnamed_addr global <2 x i64> zeroinitializer, align 16
@_ZL29StaticVectorSigned__Int128Var = internal unnamed_addr global <1 x i128> zeroinitializer, align 16
@_ZL20StaticVectorFloatVar = internal unnamed_addr global <4 x float> zeroinitializer, align 16
@_ZL21StaticVectorDoubleVar = internal unnamed_addr global <2 x double> zeroinitializer, align 16

 define zeroext i1 @_Z17ReadStaticBoolVarv() {
; CHECK-LABEL: _Z17ReadStaticBoolVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plbz r3, _ZL13StaticBoolVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i8, ptr @_ZL13StaticBoolVar, align 1, !range !0, !noundef !{}
  %tobool = icmp ne i8 %0, 0
  ret i1 %tobool
}

 define signext i8 @_Z23ReadStaticSignedCharVarv() {
; CHECK-LABEL: _Z23ReadStaticSignedCharVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plbz r3, _ZL19StaticSignedCharVar@PCREL(0), 1
; CHECK-NEXT:    extsb r3, r3
; CHECK-NEXT:    blr
entry:
  %0 = load i8, ptr @_ZL19StaticSignedCharVar, align 1
  ret i8 %0
}

 define zeroext i8 @_Z25ReadStaticUnsignedCharVarv() {
; CHECK-LABEL: _Z25ReadStaticUnsignedCharVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plbz r3, _ZL21StaticUnsignedCharVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i8, ptr @_ZL21StaticUnsignedCharVar, align 1
  ret i8 %0
}

 define signext i16 @_Z24ReadStaticSignedShortVarv() {
; CHECK-LABEL: _Z24ReadStaticSignedShortVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plha r3, _ZL20StaticSignedShortVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i16, ptr @_ZL20StaticSignedShortVar, align 2
  ret i16 %0
}

 define zeroext i16 @_Z26ReadStaticUnsignedShortVarv() {
; CHECK-LABEL: _Z26ReadStaticUnsignedShortVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plhz r3, _ZL22StaticUnsignedShortVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i16, ptr @_ZL22StaticUnsignedShortVar, align 2
  ret i16 %0
}

 define signext i32 @_Z22ReadStaticSignedIntVarv() {
; CHECK-LABEL: _Z22ReadStaticSignedIntVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plwa r3, _ZL18StaticSignedIntVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i32, ptr @_ZL18StaticSignedIntVar, align 4
  ret i32 %0
}

 define zeroext i32 @_Z24ReadStaticUnsignedIntVarv() {
; CHECK-LABEL: _Z24ReadStaticUnsignedIntVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plwz r3, _ZL20StaticUnsignedIntVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i32, ptr @_ZL20StaticUnsignedIntVar, align 4
  ret i32 %0
}

 ; It is the same as unsigned long version
define i64 @_Z23ReadStaticSignedLongVarv() {
; CHECK-LABEL: _Z23ReadStaticSignedLongVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pld r3, _ZL19StaticSignedLongVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i64, ptr @_ZL19StaticSignedLongVar, align 8
  ret i64 %0
}

 define float @_Z18ReadStaticFloatVarv() {
; CHECK-LABEL: _Z18ReadStaticFloatVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plfs f1, _ZL14StaticFloatVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load float, ptr @_ZL14StaticFloatVar, align 4
  ret float %0
}

 define double @_Z19ReadStaticDoubleVarv() {
; CHECK-LABEL: _Z19ReadStaticDoubleVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plfd f1, _ZL15StaticDoubleVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load double, ptr @_ZL15StaticDoubleVar, align 8
  ret double %0
}

 ; FIXME:
define ppc_fp128 @_Z23ReadStaticLongDoubleVarv() {
; CHECK-LABEL: _Z23ReadStaticLongDoubleVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plfd f1, _ZL19StaticLongDoubleVar@PCREL(0), 1
; CHECK-NEXT:    plfd f2, _ZL19StaticLongDoubleVar@PCREL+8(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load ppc_fp128, ptr @_ZL19StaticLongDoubleVar, align 16
  ret ppc_fp128 %0
}

 ; FIXME:
define i128 @_Z27ReadStaticSigned__Int128Varv() {
; CHECK-LABEL: _Z27ReadStaticSigned__Int128Varv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pld r3, _ZL23StaticSigned__Int128Var@PCREL(0), 1
; CHECK-NEXT:    pld r4, _ZL23StaticSigned__Int128Var@PCREL+8(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i128, ptr @_ZL23StaticSigned__Int128Var, align 16
  ret i128 %0
}

 define fp128 @_Z23ReadStatic__Float128Varv() {
; CHECK-LABEL: _Z23ReadStatic__Float128Varv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, _ZL19Static__Float128Var@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load fp128, ptr @_ZL19Static__Float128Var, align 16
  ret fp128 %0
}

 define <16 x i8> @_Z29ReadStaticVectorSignedCharVarv() {
; CHECK-LABEL: _Z29ReadStaticVectorSignedCharVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, _ZL25StaticVectorSignedCharVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load <16 x i8>, ptr @_ZL25StaticVectorSignedCharVar, align 16
  ret <16 x i8> %0
}

 define <8 x i16> @_Z30ReadStaticVectorSignedShortVarv() {
; CHECK-LABEL: _Z30ReadStaticVectorSignedShortVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, _ZL26StaticVectorSignedShortVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load <8 x i16>, ptr @_ZL26StaticVectorSignedShortVar, align 16
  ret <8 x i16> %0
}

 define <4 x i32> @_Z28ReadStaticVectorSignedIntVarv() {
; CHECK-LABEL: _Z28ReadStaticVectorSignedIntVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, _ZL24StaticVectorSignedIntVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load <4 x i32>, ptr @_ZL24StaticVectorSignedIntVar, align 16
  ret <4 x i32> %0
}

 define <2 x i64> @_Z33ReadStaticVectorSignedLongLongVarv() {
; CHECK-LABEL: _Z33ReadStaticVectorSignedLongLongVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, _ZL29StaticVectorSignedLongLongVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load <2 x i64>, ptr @_ZL29StaticVectorSignedLongLongVar, align 16
  ret <2 x i64> %0
}

 define <1 x i128> @_Z33ReadStaticVectorSigned__Int128Varv() {
; CHECK-LABEL: _Z33ReadStaticVectorSigned__Int128Varv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, _ZL29StaticVectorSigned__Int128Var@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load <1 x i128>, ptr @_ZL29StaticVectorSigned__Int128Var, align 16
  ret <1 x i128> %0
}

 define <4 x float> @_Z24ReadStaticVectorFloatVarv() {
; CHECK-LABEL: _Z24ReadStaticVectorFloatVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, _ZL20StaticVectorFloatVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load <4 x float>, ptr @_ZL20StaticVectorFloatVar, align 16
  ret <4 x float> %0
}

 define <2 x double> @_Z25ReadStaticVectorDoubleVarv() {
; CHECK-LABEL: _Z25ReadStaticVectorDoubleVarv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, _ZL21StaticVectorDoubleVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load <2 x double>, ptr @_ZL21StaticVectorDoubleVar, align 16
  ret <2 x double> %0
}

 !0 = !{i8 0, i8 2}

 define void @_Z18WriteStaticBoolVarb(i1 zeroext %val) {
; CHECK-LABEL: _Z18WriteStaticBoolVarb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstb r3, _ZL13StaticBoolVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  %frombool = zext i1 %val to i8
  store i8 %frombool, ptr @_ZL13StaticBoolVar, align 1
  ret void
}

 define void @_Z24WriteStaticSignedCharVara(i8 signext %val) {
; CHECK-LABEL: _Z24WriteStaticSignedCharVara:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstb r3, _ZL19StaticSignedCharVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store i8 %val, ptr @_ZL19StaticSignedCharVar, align 1
  ret void
}

 define void @_Z26WriteStaticUnsignedCharVarh(i8 zeroext %val){
; CHECK-LABEL: _Z26WriteStaticUnsignedCharVarh:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstb r3, _ZL21StaticUnsignedCharVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store i8 %val, ptr @_ZL21StaticUnsignedCharVar, align 1
  ret void
}

 define void @_Z25WriteStaticSignedShortVars(i16 signext %val) {
; CHECK-LABEL: _Z25WriteStaticSignedShortVars:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    psth r3, _ZL20StaticSignedShortVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store i16 %val, ptr @_ZL20StaticSignedShortVar, align 2
  ret void
}

 define void @_Z27WriteStaticUnsignedShortVart(i16 zeroext %val) {
; CHECK-LABEL: _Z27WriteStaticUnsignedShortVart:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    psth r3, _ZL22StaticUnsignedShortVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store i16 %val, ptr @_ZL22StaticUnsignedShortVar, align 2
  ret void
}

 define void @_Z23WriteStaticSignedIntVari(i32 signext %val) {
; CHECK-LABEL: _Z23WriteStaticSignedIntVari:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstw r3, _ZL18StaticSignedIntVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store i32 %val, ptr @_ZL18StaticSignedIntVar, align 4
  ret void
}

 define void @_Z25WriteStaticUnsignedIntVarj(i32 zeroext %val) {
; CHECK-LABEL: _Z25WriteStaticUnsignedIntVarj:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstw r3, _ZL20StaticUnsignedIntVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store i32 %val, ptr @_ZL20StaticUnsignedIntVar, align 4
  ret void
}

 define void @_Z24WriteStaticSignedLongVarl(i64 %val) {
; CHECK-LABEL: _Z24WriteStaticSignedLongVarl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstd r3, _ZL19StaticSignedLongVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store i64 %val, ptr @_ZL19StaticSignedLongVar, align 8
  ret void
}

 define void @_Z19WriteStaticFloatVarf(float %val) {
; CHECK-LABEL: _Z19WriteStaticFloatVarf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstfs f1, _ZL14StaticFloatVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store float %val, ptr @_ZL14StaticFloatVar, align 4
  ret void
}

 define void @_Z20WriteStaticDoubleVard(double %val) {
; CHECK-LABEL: _Z20WriteStaticDoubleVard:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstfd f1, _ZL15StaticDoubleVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store double %val, ptr @_ZL15StaticDoubleVar, align 8
  ret void
}

 ; FIXME:
define void @_Z24WriteStaticLongDoubleVarg(ppc_fp128 %val) {
; CHECK-LABEL: _Z24WriteStaticLongDoubleVarg:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstfd f2, _ZL19StaticLongDoubleVar@PCREL+8(0), 1
; CHECK-NEXT:    pstfd f1, _ZL19StaticLongDoubleVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store ppc_fp128 %val, ptr @_ZL19StaticLongDoubleVar, align 16
  ret void
}

 ; FIXME:
define void @_Z28WriteStaticSigned__Int128Varn(i128 %val) {
; CHECK-LABEL: _Z28WriteStaticSigned__Int128Varn:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstd r4, _ZL23StaticSigned__Int128Var@PCREL+8(0), 1
; CHECK-NEXT:    pstd r3, _ZL23StaticSigned__Int128Var@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store i128 %val, ptr @_ZL23StaticSigned__Int128Var, align 16
  ret void
}

 define void @_Z24WriteStatic__Float128Varu9__ieee128(fp128 %val) {
; CHECK-LABEL: _Z24WriteStatic__Float128Varu9__ieee128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstxv v2, _ZL19Static__Float128Var@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store fp128 %val, ptr @_ZL19Static__Float128Var, align 16
  ret void
}

 define void @_Z30WriteStaticVectorSignedCharVarDv16_a(<16 x i8> %val) {
; CHECK-LABEL: _Z30WriteStaticVectorSignedCharVarDv16_a:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstxv v2, _ZL25StaticVectorSignedCharVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store <16 x i8> %val, ptr @_ZL25StaticVectorSignedCharVar, align 16
  ret void
}

 define void @_Z31WriteStaticVectorSignedShortVarDv8_s(<8 x i16> %val) {
; CHECK-LABEL: _Z31WriteStaticVectorSignedShortVarDv8_s:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstxv v2, _ZL26StaticVectorSignedShortVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store <8 x i16> %val, ptr @_ZL26StaticVectorSignedShortVar, align 16
  ret void
}

 define void @_Z29WriteStaticVectorSignedIntVarDv4_i(<4 x i32> %val) {
; CHECK-LABEL: _Z29WriteStaticVectorSignedIntVarDv4_i:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstxv v2, _ZL24StaticVectorSignedIntVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store <4 x i32> %val, ptr @_ZL24StaticVectorSignedIntVar, align 16
  ret void
}

 define void @_Z34WriteStaticVectorSignedLongLongVarDv2_x(<2 x i64> %val) {
; CHECK-LABEL: _Z34WriteStaticVectorSignedLongLongVarDv2_x:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstxv v2, _ZL29StaticVectorSignedLongLongVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store <2 x i64> %val, ptr @_ZL29StaticVectorSignedLongLongVar, align 16
  ret void
}

 define void @_Z34WriteStaticVectorSigned__Int128VarDv1_n(<1 x i128> %val) {
; CHECK-LABEL: _Z34WriteStaticVectorSigned__Int128VarDv1_n:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstxv v2, _ZL29StaticVectorSigned__Int128Var@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store <1 x i128> %val, ptr @_ZL29StaticVectorSigned__Int128Var, align 16
  ret void
}

 define void @_Z25WriteStaticVectorFloatVarDv4_f(<4 x float> %val) {
; CHECK-LABEL: _Z25WriteStaticVectorFloatVarDv4_f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstxv v2, _ZL20StaticVectorFloatVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store <4 x float> %val, ptr @_ZL20StaticVectorFloatVar, align 16
  ret void
}

 define void @_Z26WriteStaticVectorDoubleVarDv2_d(<2 x double> %val) {
; CHECK-LABEL: _Z26WriteStaticVectorDoubleVarDv2_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pstxv v2, _ZL21StaticVectorDoubleVar@PCREL(0), 1
; CHECK-NEXT:    blr
entry:
  store <2 x double> %val, ptr @_ZL21StaticVectorDoubleVar, align 16
  ret void
}

 @_ZL3ptr = internal unnamed_addr global ptr null, align 8
define void @_Z14WriteStaticPtrv() {
; CHECK-LABEL: _Z14WriteStaticPtrv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pld r3, _ZL3ptr@PCREL(0), 1
; CHECK-NEXT:    li r4, 3
; CHECK-NEXT:    stw r4, 0(r3)
; CHECK-NEXT:    blr
entry:
  %0 = load ptr, ptr @_ZL3ptr, align 8
  store i32 3, ptr %0, align 4
  ret void
}

 @.str = private unnamed_addr constant [13 x i8] c"Hello World\0A\00", align 1
@str = dso_local local_unnamed_addr global ptr @.str, align 8

 define zeroext i8 @_Z17Char0InStrLiteralv() {
; CHECK-LABEL: _Z17Char0InStrLiteralv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pld r3, str@PCREL(0), 1
; CHECK-NEXT:    lbz r3, 0(r3)
; CHECK-NEXT:    blr
entry:
  %0 = load ptr, ptr @str, align 8
  %1 = load i8, ptr %0, align 1
  ret i8 %1
}

 define zeroext i8 @_Z17Char3InStrLiteralv() {
; CHECK-LABEL: _Z17Char3InStrLiteralv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pld r3, str@PCREL(0), 1
; CHECK-NEXT:    lbz r3, 3(r3)
; CHECK-NEXT:    blr
entry:
  %0 = load ptr, ptr @str, align 8
  %arrayidx = getelementptr inbounds i8, ptr %0, i64 3
  %1 = load i8, ptr %arrayidx, align 1
  ret i8 %1
}

 @_ZL5array = internal global [10 x i32] zeroinitializer, align 4

 ; FIXME:
define signext i32 @_Z15ReadStaticArrayv() {
; CHECK-LABEL: _Z15ReadStaticArrayv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plwa r3, _ZL5array@PCREL+12(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i32, ptr getelementptr inbounds ([10 x i32], ptr @_ZL5array, i64 0, i64 3), align 4
  ret i32 %0
}

 ; FIXME:
define void @_Z16WriteStaticArrayv() {
; CHECK-LABEL: _Z16WriteStaticArrayv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r3, 5
; CHECK-NEXT:    pstw r3, _ZL5array@PCREL+12(0), 1
; CHECK-NEXT:    blr
entry:
  store i32 5, ptr getelementptr inbounds ([10 x i32], ptr @_ZL5array, i64 0, i64 3), align 4
  ret void
}

 %struct.Struct = type { i8, i16, i32 }

 ; FIXME:
@_ZL9structure = internal global %struct.Struct zeroinitializer, align 4
define signext i32 @_Z16ReadStaticStructv() {
; CHECK-LABEL: _Z16ReadStaticStructv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plwa r3, _ZL9structure@PCREL+4(0), 1
; CHECK-NEXT:    blr
entry:
  %0 = load i32, ptr getelementptr inbounds (%struct.Struct, ptr @_ZL9structure, i64 0, i32 2), align 4
  ret i32 %0
}

 ; FIXME
define void @_Z17WriteStaticStructv() {
; CHECK-LABEL: _Z17WriteStaticStructv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r3, 3
; CHECK-NEXT:    pstw r3, _ZL9structure@PCREL+4(0), 1
; CHECK-NEXT:    blr
entry:
  store i32 3, ptr getelementptr inbounds (%struct.Struct, ptr @_ZL9structure, i64 0, i32 2), align 4
  ret void
}

