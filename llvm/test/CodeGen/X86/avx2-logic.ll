; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,X64

define <4 x i64> @vpandn(<4 x i64> %a, <4 x i64> %b) nounwind uwtable readnone ssp {
; CHECK-LABEL: vpandn:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpcmpeqd %ymm1, %ymm1, %ymm1
; CHECK-NEXT:    vpsubq %ymm1, %ymm0, %ymm1
; CHECK-NEXT:    vpandn %ymm0, %ymm1, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  ; Force the execution domain with an add.
  %a2 = add <4 x i64> %a, <i64 1, i64 1, i64 1, i64 1>
  %y = xor <4 x i64> %a2, <i64 -1, i64 -1, i64 -1, i64 -1>
  %x = and <4 x i64> %a, %y
  ret <4 x i64> %x
}

define <4 x i64> @vpand(<4 x i64> %a, <4 x i64> %b) nounwind uwtable readnone ssp {
; CHECK-LABEL: vpand:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpcmpeqd %ymm2, %ymm2, %ymm2
; CHECK-NEXT:    vpsubq %ymm2, %ymm0, %ymm0
; CHECK-NEXT:    vpand %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  ; Force the execution domain with an add.
  %a2 = add <4 x i64> %a, <i64 1, i64 1, i64 1, i64 1>
  %x = and <4 x i64> %a2, %b
  ret <4 x i64> %x
}

define <4 x i64> @vpor(<4 x i64> %a, <4 x i64> %b) nounwind uwtable readnone ssp {
; CHECK-LABEL: vpor:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpcmpeqd %ymm2, %ymm2, %ymm2
; CHECK-NEXT:    vpsubq %ymm2, %ymm0, %ymm0
; CHECK-NEXT:    vpor %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  ; Force the execution domain with an add.
  %a2 = add <4 x i64> %a, <i64 1, i64 1, i64 1, i64 1>
  %x = or <4 x i64> %a2, %b
  ret <4 x i64> %x
}

define <4 x i64> @vpxor(<4 x i64> %a, <4 x i64> %b) nounwind uwtable readnone ssp {
; CHECK-LABEL: vpxor:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpcmpeqd %ymm2, %ymm2, %ymm2
; CHECK-NEXT:    vpsubq %ymm2, %ymm0, %ymm0
; CHECK-NEXT:    vpxor %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  ; Force the execution domain with an add.
  %a2 = add <4 x i64> %a, <i64 1, i64 1, i64 1, i64 1>
  %x = xor <4 x i64> %a2, %b
  ret <4 x i64> %x
}

define <32 x i8> @vpblendvb(<32 x i1> %cond, <32 x i8> %x, <32 x i8> %y) {
; CHECK-LABEL: vpblendvb:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpsllw $7, %ymm0, %ymm0
; CHECK-NEXT:    vpblendvb %ymm0, %ymm1, %ymm2, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
  %min = select <32 x i1> %cond, <32 x i8> %x, <32 x i8> %y
  ret <32 x i8> %min
}

define <8 x i32> @allOnes() nounwind {
; CHECK-LABEL: allOnes:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
        ret <8 x i32> <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
}

define <16 x i16> @allOnes2() nounwind {
; CHECK-LABEL: allOnes2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
        ret <16 x i16> <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; X64: {{.*}}
; X86: {{.*}}
