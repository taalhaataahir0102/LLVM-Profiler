; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-pc-linux -mcpu=corei7-avx | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-pc-linux -mcpu=corei7-avx | FileCheck %s --check-prefixes=X64

define <8 x i32> @shiftInput___vyuunu(<8 x i32> %input, i32 %shiftval, <8 x i32> %__mask) nounwind {
; X86-LABEL: shiftInput___vyuunu:
; X86:       # %bb.0: # %allocas
; X86-NEXT:    vextractf128 $1, %ymm0, %xmm1
; X86-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; X86-NEXT:    vpsrld %xmm2, %xmm1, %xmm1
; X86-NEXT:    vpsrld %xmm2, %xmm0, %xmm0
; X86-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: shiftInput___vyuunu:
; X64:       # %bb.0: # %allocas
; X64-NEXT:    vmovd %edi, %xmm1
; X64-NEXT:    vextractf128 $1, %ymm0, %xmm2
; X64-NEXT:    vpsrld %xmm1, %xmm2, %xmm2
; X64-NEXT:    vpsrld %xmm1, %xmm0, %xmm0
; X64-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; X64-NEXT:    retq
allocas:
  %smear.0 = insertelement <8 x i32> undef, i32 %shiftval, i32 0
  %smear.1 = insertelement <8 x i32> %smear.0, i32 %shiftval, i32 1
  %smear.2 = insertelement <8 x i32> %smear.1, i32 %shiftval, i32 2
  %smear.3 = insertelement <8 x i32> %smear.2, i32 %shiftval, i32 3
  %smear.4 = insertelement <8 x i32> %smear.3, i32 %shiftval, i32 4
  %smear.5 = insertelement <8 x i32> %smear.4, i32 %shiftval, i32 5
  %smear.6 = insertelement <8 x i32> %smear.5, i32 %shiftval, i32 6
  %smear.7 = insertelement <8 x i32> %smear.6, i32 %shiftval, i32 7
  %bitop = lshr <8 x i32> %input, %smear.7
  ret <8 x i32> %bitop
}

define <8 x i32> @shiftInput___canonical(<8 x i32> %input, i32 %shiftval, <8 x i32> %__mask) nounwind {
; X86-LABEL: shiftInput___canonical:
; X86:       # %bb.0: # %allocas
; X86-NEXT:    vextractf128 $1, %ymm0, %xmm1
; X86-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; X86-NEXT:    vpsrld %xmm2, %xmm1, %xmm1
; X86-NEXT:    vpsrld %xmm2, %xmm0, %xmm0
; X86-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: shiftInput___canonical:
; X64:       # %bb.0: # %allocas
; X64-NEXT:    vmovd %edi, %xmm1
; X64-NEXT:    vextractf128 $1, %ymm0, %xmm2
; X64-NEXT:    vpsrld %xmm1, %xmm2, %xmm2
; X64-NEXT:    vpsrld %xmm1, %xmm0, %xmm0
; X64-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; X64-NEXT:    retq
allocas:
  %smear.0 = insertelement <8 x i32> undef, i32 %shiftval, i32 0
  %smear.7 = shufflevector <8 x i32> %smear.0, <8 x i32> undef, <8 x i32> zeroinitializer
  %bitop = lshr <8 x i32> %input, %smear.7
  ret <8 x i32> %bitop
}

define <4 x i64> @shiftInput___64in32bitmode(<4 x i64> %input, i64 %shiftval) nounwind {
; X86-LABEL: shiftInput___64in32bitmode:
; X86:       # %bb.0: # %allocas
; X86-NEXT:    vextractf128 $1, %ymm0, %xmm1
; X86-NEXT:    vmovq {{.*#+}} xmm2 = mem[0],zero
; X86-NEXT:    vpsrlq %xmm2, %xmm1, %xmm1
; X86-NEXT:    vpsrlq %xmm2, %xmm0, %xmm0
; X86-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: shiftInput___64in32bitmode:
; X64:       # %bb.0: # %allocas
; X64-NEXT:    vmovq %rdi, %xmm1
; X64-NEXT:    vextractf128 $1, %ymm0, %xmm2
; X64-NEXT:    vpsrlq %xmm1, %xmm2, %xmm2
; X64-NEXT:    vpsrlq %xmm1, %xmm0, %xmm0
; X64-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; X64-NEXT:    retq
allocas:
  %smear.0 = insertelement <4 x i64> undef, i64 %shiftval, i32 0
  %smear.7 = shufflevector <4 x i64> %smear.0, <4 x i64> undef, <4 x i32> zeroinitializer
  %bitop = lshr <4 x i64> %input, %smear.7
  ret <4 x i64> %bitop
}

define <4 x i64> @shiftInput___2x32bitcast(<4 x i64> %input, i32 %shiftval) nounwind {
; X86-LABEL: shiftInput___2x32bitcast:
; X86:       # %bb.0: # %allocas
; X86-NEXT:    vextractf128 $1, %ymm0, %xmm1
; X86-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; X86-NEXT:    vpsrlq %xmm2, %xmm1, %xmm1
; X86-NEXT:    vpsrlq %xmm2, %xmm0, %xmm0
; X86-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: shiftInput___2x32bitcast:
; X64:       # %bb.0: # %allocas
; X64-NEXT:    vmovd %edi, %xmm1
; X64-NEXT:    vextractf128 $1, %ymm0, %xmm2
; X64-NEXT:    vpsrlq %xmm1, %xmm2, %xmm2
; X64-NEXT:    vpsrlq %xmm1, %xmm0, %xmm0
; X64-NEXT:    vinsertf128 $1, %xmm2, %ymm0, %ymm0
; X64-NEXT:    retq
allocas:
  %smear.0 = insertelement <8 x i32> zeroinitializer, i32 %shiftval, i32 0
  %smear.1 = insertelement <8 x i32> %smear.0, i32 %shiftval, i32 2
  %smear.2 = insertelement <8 x i32> %smear.1, i32 %shiftval, i32 4
  %smear.3 = insertelement <8 x i32> %smear.2, i32 %shiftval, i32 6
  %smear.4 = bitcast <8 x i32> %smear.3 to <4 x i64>
  %bitop = lshr <4 x i64> %input, %smear.4
  ret <4 x i64> %bitop
}
