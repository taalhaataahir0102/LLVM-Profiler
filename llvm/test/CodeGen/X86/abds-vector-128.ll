; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux                  | FileCheck %s --check-prefixes=SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+sse4.2   | FileCheck %s --check-prefixes=SSE,SSE42
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx      | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx2     | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx512vl | FileCheck %s --check-prefixes=AVX,AVX512

;
; trunc(abs(sub(sext(a),sext(b)))) -> abds(a,b)
;

define <16 x i8> @abd_ext_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_ext_v16i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    psubb %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtb %xmm1, %xmm3
; SSE2-NEXT:    psubb %xmm1, %xmm0
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v16i8:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsb %xmm1, %xmm2
; SSE42-NEXT:    pmaxsb %xmm1, %xmm0
; SSE42-NEXT:    psubb %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_ext_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsb %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <16 x i8> %a to <16 x i64>
  %bext = sext <16 x i8> %b to <16 x i64>
  %sub = sub <16 x i64> %aext, %bext
  %abs = call <16 x i64> @llvm.abs.v16i64(<16 x i64> %sub, i1 false)
  %trunc = trunc <16 x i64> %abs to <16 x i8>
  ret <16 x i8> %trunc
}

define <16 x i8> @abd_ext_v16i8_undef(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_ext_v16i8_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    psubb %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtb %xmm1, %xmm3
; SSE2-NEXT:    psubb %xmm1, %xmm0
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v16i8_undef:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsb %xmm1, %xmm2
; SSE42-NEXT:    pmaxsb %xmm1, %xmm0
; SSE42-NEXT:    psubb %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_ext_v16i8_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsb %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <16 x i8> %a to <16 x i64>
  %bext = sext <16 x i8> %b to <16 x i64>
  %sub = sub <16 x i64> %aext, %bext
  %abs = call <16 x i64> @llvm.abs.v16i64(<16 x i64> %sub, i1 true)
  %trunc = trunc <16 x i64> %abs to <16 x i8>
  ret <16 x i8> %trunc
}

define <8 x i16> @abd_ext_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: abd_ext_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pminsw %xmm1, %xmm2
; SSE-NEXT:    pmaxsw %xmm1, %xmm0
; SSE-NEXT:    psubw %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: abd_ext_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsw %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubw %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <8 x i16> %a to <8 x i64>
  %bext = sext <8 x i16> %b to <8 x i64>
  %sub = sub <8 x i64> %aext, %bext
  %abs = call <8 x i64> @llvm.abs.v8i64(<8 x i64> %sub, i1 false)
  %trunc = trunc <8 x i64> %abs to <8 x i16>
  ret <8 x i16> %trunc
}

define <8 x i16> @abd_ext_v8i16_undef(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: abd_ext_v8i16_undef:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pminsw %xmm1, %xmm2
; SSE-NEXT:    pmaxsw %xmm1, %xmm0
; SSE-NEXT:    psubw %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: abd_ext_v8i16_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsw %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubw %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <8 x i16> %a to <8 x i64>
  %bext = sext <8 x i16> %b to <8 x i64>
  %sub = sub <8 x i64> %aext, %bext
  %abs = call <8 x i64> @llvm.abs.v8i64(<8 x i64> %sub, i1 true)
  %trunc = trunc <8 x i64> %abs to <8 x i16>
  ret <8 x i16> %trunc
}

define <4 x i32> @abd_ext_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_ext_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    psubd %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm3
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v4i32:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsd %xmm1, %xmm2
; SSE42-NEXT:    pmaxsd %xmm1, %xmm0
; SSE42-NEXT:    psubd %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_ext_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsd %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <4 x i32> %a to <4 x i64>
  %bext = sext <4 x i32> %b to <4 x i64>
  %sub = sub <4 x i64> %aext, %bext
  %abs = call <4 x i64> @llvm.abs.v4i64(<4 x i64> %sub, i1 false)
  %trunc = trunc <4 x i64> %abs to <4 x i32>
  ret <4 x i32> %trunc
}

define <4 x i32> @abd_ext_v4i32_undef(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_ext_v4i32_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    psubd %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm3
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v4i32_undef:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsd %xmm1, %xmm2
; SSE42-NEXT:    pmaxsd %xmm1, %xmm0
; SSE42-NEXT:    psubd %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_ext_v4i32_undef:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsd %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %aext = sext <4 x i32> %a to <4 x i64>
  %bext = sext <4 x i32> %b to <4 x i64>
  %sub = sub <4 x i64> %aext, %bext
  %abs = call <4 x i64> @llvm.abs.v4i64(<4 x i64> %sub, i1 true)
  %trunc = trunc <4 x i64> %abs to <4 x i32>
  ret <4 x i32> %trunc
}

define <2 x i64> @abd_ext_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_ext_v2i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,2,3]
; SSE2-NEXT:    movq %xmm2, %rax
; SSE2-NEXT:    movq %rax, %rcx
; SSE2-NEXT:    sarq $63, %rcx
; SSE2-NEXT:    movq %xmm0, %rdx
; SSE2-NEXT:    movq %rdx, %rsi
; SSE2-NEXT:    sarq $63, %rsi
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; SSE2-NEXT:    movq %xmm0, %rdi
; SSE2-NEXT:    movq %rdi, %r8
; SSE2-NEXT:    sarq $63, %r8
; SSE2-NEXT:    movq %xmm1, %r9
; SSE2-NEXT:    movq %r9, %r10
; SSE2-NEXT:    sarq $63, %r10
; SSE2-NEXT:    subq %r9, %rdx
; SSE2-NEXT:    sbbq %r10, %rsi
; SSE2-NEXT:    subq %rdi, %rax
; SSE2-NEXT:    sbbq %r8, %rcx
; SSE2-NEXT:    sarq $63, %rcx
; SSE2-NEXT:    xorq %rcx, %rax
; SSE2-NEXT:    subq %rcx, %rax
; SSE2-NEXT:    sarq $63, %rsi
; SSE2-NEXT:    xorq %rsi, %rdx
; SSE2-NEXT:    subq %rsi, %rdx
; SSE2-NEXT:    movq %rdx, %xmm0
; SSE2-NEXT:    movq %rax, %xmm1
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v2i64:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pcmpgtq %xmm1, %xmm2
; SSE42-NEXT:    movdqa %xmm0, %xmm3
; SSE42-NEXT:    psubq %xmm1, %xmm3
; SSE42-NEXT:    psubq %xmm0, %xmm1
; SSE42-NEXT:    movdqa %xmm2, %xmm0
; SSE42-NEXT:    blendvpd %xmm0, %xmm3, %xmm1
; SSE42-NEXT:    movapd %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_ext_v2i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vblendvpd %xmm2, %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v2i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX2-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX2-NEXT:    vpsubq %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    vblendvpd %xmm2, %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v2i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %xmm1, %xmm0, %xmm2
; AVX512-NEXT:    vpmaxsq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsubq %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %aext = sext <2 x i64> %a to <2 x i128>
  %bext = sext <2 x i64> %b to <2 x i128>
  %sub = sub <2 x i128> %aext, %bext
  %abs = call <2 x i128> @llvm.abs.v2i128(<2 x i128> %sub, i1 false)
  %trunc = trunc <2 x i128> %abs to <2 x i64>
  ret <2 x i64> %trunc
}

define <2 x i64> @abd_ext_v2i64_undef(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_ext_v2i64_undef:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,2,3]
; SSE2-NEXT:    movq %xmm2, %rax
; SSE2-NEXT:    movq %rax, %rcx
; SSE2-NEXT:    sarq $63, %rcx
; SSE2-NEXT:    movq %xmm0, %rdx
; SSE2-NEXT:    movq %rdx, %rsi
; SSE2-NEXT:    sarq $63, %rsi
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,2,3]
; SSE2-NEXT:    movq %xmm0, %rdi
; SSE2-NEXT:    movq %rdi, %r8
; SSE2-NEXT:    sarq $63, %r8
; SSE2-NEXT:    movq %xmm1, %r9
; SSE2-NEXT:    movq %r9, %r10
; SSE2-NEXT:    sarq $63, %r10
; SSE2-NEXT:    subq %r9, %rdx
; SSE2-NEXT:    sbbq %r10, %rsi
; SSE2-NEXT:    subq %rdi, %rax
; SSE2-NEXT:    sbbq %r8, %rcx
; SSE2-NEXT:    sarq $63, %rcx
; SSE2-NEXT:    xorq %rcx, %rax
; SSE2-NEXT:    subq %rcx, %rax
; SSE2-NEXT:    sarq $63, %rsi
; SSE2-NEXT:    xorq %rsi, %rdx
; SSE2-NEXT:    subq %rsi, %rdx
; SSE2-NEXT:    movq %rdx, %xmm0
; SSE2-NEXT:    movq %rax, %xmm1
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_ext_v2i64_undef:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pcmpgtq %xmm1, %xmm2
; SSE42-NEXT:    movdqa %xmm0, %xmm3
; SSE42-NEXT:    psubq %xmm1, %xmm3
; SSE42-NEXT:    psubq %xmm0, %xmm1
; SSE42-NEXT:    movdqa %xmm2, %xmm0
; SSE42-NEXT:    blendvpd %xmm0, %xmm3, %xmm1
; SSE42-NEXT:    movapd %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_ext_v2i64_undef:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vblendvpd %xmm2, %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_ext_v2i64_undef:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX2-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX2-NEXT:    vpsubq %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    vblendvpd %xmm2, %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_ext_v2i64_undef:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %xmm1, %xmm0, %xmm2
; AVX512-NEXT:    vpmaxsq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsubq %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %aext = sext <2 x i64> %a to <2 x i128>
  %bext = sext <2 x i64> %b to <2 x i128>
  %sub = sub <2 x i128> %aext, %bext
  %abs = call <2 x i128> @llvm.abs.v2i128(<2 x i128> %sub, i1 true)
  %trunc = trunc <2 x i128> %abs to <2 x i64>
  ret <2 x i64> %trunc
}

;
; sub(smax(a,b),smin(a,b)) -> abds(a,b)
;

define <16 x i8> @abd_minmax_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_minmax_v16i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    psubb %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtb %xmm1, %xmm3
; SSE2-NEXT:    psubb %xmm1, %xmm0
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_minmax_v16i8:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsb %xmm1, %xmm2
; SSE42-NEXT:    pmaxsb %xmm1, %xmm0
; SSE42-NEXT:    psubb %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_minmax_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsb %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %min = call <16 x i8> @llvm.smin.v16i8(<16 x i8> %a, <16 x i8> %b)
  %max = call <16 x i8> @llvm.smax.v16i8(<16 x i8> %a, <16 x i8> %b)
  %sub = sub <16 x i8> %max, %min
  ret <16 x i8> %sub
}

define <8 x i16> @abd_minmax_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: abd_minmax_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pminsw %xmm1, %xmm2
; SSE-NEXT:    pmaxsw %xmm1, %xmm0
; SSE-NEXT:    psubw %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: abd_minmax_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsw %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubw %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %min = call <8 x i16> @llvm.smin.v8i16(<8 x i16> %a, <8 x i16> %b)
  %max = call <8 x i16> @llvm.smax.v8i16(<8 x i16> %a, <8 x i16> %b)
  %sub = sub <8 x i16> %max, %min
  ret <8 x i16> %sub
}

define <4 x i32> @abd_minmax_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_minmax_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    psubd %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm3
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_minmax_v4i32:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsd %xmm1, %xmm2
; SSE42-NEXT:    pmaxsd %xmm1, %xmm0
; SSE42-NEXT:    psubd %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_minmax_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsd %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %min = call <4 x i32> @llvm.smin.v4i32(<4 x i32> %a, <4 x i32> %b)
  %max = call <4 x i32> @llvm.smax.v4i32(<4 x i32> %a, <4 x i32> %b)
  %sub = sub <4 x i32> %max, %min
  ret <4 x i32> %sub
}

define <2 x i64> @abd_minmax_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_minmax_v2i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; SSE2-NEXT:    movdqa %xmm1, %xmm3
; SSE2-NEXT:    pxor %xmm2, %xmm3
; SSE2-NEXT:    pxor %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm2, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm3, %xmm4
; SSE2-NEXT:    pshufd {{.*#+}} xmm5 = xmm4[0,0,2,2]
; SSE2-NEXT:    pcmpeqd %xmm3, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,1,3,3]
; SSE2-NEXT:    pand %xmm5, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm4[1,1,3,3]
; SSE2-NEXT:    por %xmm2, %xmm3
; SSE2-NEXT:    movdqa %xmm3, %xmm2
; SSE2-NEXT:    pandn %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm3, %xmm4
; SSE2-NEXT:    pandn %xmm1, %xmm4
; SSE2-NEXT:    pand %xmm3, %xmm1
; SSE2-NEXT:    por %xmm2, %xmm1
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    por %xmm4, %xmm0
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_minmax_v2i64:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pcmpgtq %xmm1, %xmm2
; SSE42-NEXT:    movdqa %xmm0, %xmm3
; SSE42-NEXT:    psubq %xmm1, %xmm3
; SSE42-NEXT:    psubq %xmm0, %xmm1
; SSE42-NEXT:    movdqa %xmm2, %xmm0
; SSE42-NEXT:    blendvpd %xmm0, %xmm3, %xmm1
; SSE42-NEXT:    movapd %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_minmax_v2i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vblendvpd %xmm2, %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_minmax_v2i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX2-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX2-NEXT:    vpsubq %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    vblendvpd %xmm2, %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_minmax_v2i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %xmm1, %xmm0, %xmm2
; AVX512-NEXT:    vpmaxsq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsubq %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %min = call <2 x i64> @llvm.smin.v2i64(<2 x i64> %a, <2 x i64> %b)
  %max = call <2 x i64> @llvm.smax.v2i64(<2 x i64> %a, <2 x i64> %b)
  %sub = sub <2 x i64> %max, %min
  ret <2 x i64> %sub
}

;
; select(icmp(a,b),sub(a,b),sub(b,a)) -> abds(a,b)
;

define <16 x i8> @abd_cmp_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_cmp_v16i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    psubb %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtb %xmm1, %xmm3
; SSE2-NEXT:    psubb %xmm1, %xmm0
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_cmp_v16i8:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsb %xmm1, %xmm2
; SSE42-NEXT:    pmaxsb %xmm1, %xmm0
; SSE42-NEXT:    psubb %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_cmp_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsb %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubb %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %cmp = icmp sgt <16 x i8> %a, %b
  %ab = sub <16 x i8> %a, %b
  %ba = sub <16 x i8> %b, %a
  %sel = select <16 x i1> %cmp, <16 x i8> %ab, <16 x i8> %ba
  ret <16 x i8> %sel
}

define <8 x i16> @abd_cmp_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: abd_cmp_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    pminsw %xmm1, %xmm2
; SSE-NEXT:    pmaxsw %xmm1, %xmm0
; SSE-NEXT:    psubw %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: abd_cmp_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsw %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubw %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %cmp = icmp sge <8 x i16> %a, %b
  %ab = sub <8 x i16> %a, %b
  %ba = sub <8 x i16> %b, %a
  %sel = select <8 x i1> %cmp, <8 x i16> %ab, <8 x i16> %ba
  ret <8 x i16> %sel
}

define <4 x i32> @abd_cmp_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_cmp_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    psubd %xmm0, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pcmpgtd %xmm1, %xmm3
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    pand %xmm3, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm3
; SSE2-NEXT:    por %xmm3, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_cmp_v4i32:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pminsd %xmm1, %xmm2
; SSE42-NEXT:    pmaxsd %xmm1, %xmm0
; SSE42-NEXT:    psubd %xmm2, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_cmp_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpminsd %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpmaxsd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubd %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %cmp = icmp slt <4 x i32> %a, %b
  %ab = sub <4 x i32> %a, %b
  %ba = sub <4 x i32> %b, %a
  %sel = select <4 x i1> %cmp, <4 x i32> %ba, <4 x i32> %ab
  ret <4 x i32> %sel
}

define <2 x i64> @abd_cmp_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_cmp_v2i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pxor %xmm2, %xmm3
; SSE2-NEXT:    pxor %xmm1, %xmm2
; SSE2-NEXT:    movdqa %xmm2, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm3, %xmm4
; SSE2-NEXT:    pshufd {{.*#+}} xmm5 = xmm4[0,0,2,2]
; SSE2-NEXT:    pcmpeqd %xmm3, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[1,1,3,3]
; SSE2-NEXT:    pand %xmm5, %xmm3
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm4[1,1,3,3]
; SSE2-NEXT:    por %xmm3, %xmm2
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    psubq %xmm1, %xmm3
; SSE2-NEXT:    psubq %xmm0, %xmm1
; SSE2-NEXT:    pand %xmm2, %xmm1
; SSE2-NEXT:    pandn %xmm3, %xmm2
; SSE2-NEXT:    por %xmm1, %xmm2
; SSE2-NEXT:    movdqa %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_cmp_v2i64:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pcmpgtq %xmm1, %xmm2
; SSE42-NEXT:    movdqa %xmm0, %xmm3
; SSE42-NEXT:    psubq %xmm1, %xmm3
; SSE42-NEXT:    psubq %xmm0, %xmm1
; SSE42-NEXT:    movdqa %xmm2, %xmm0
; SSE42-NEXT:    blendvpd %xmm0, %xmm3, %xmm1
; SSE42-NEXT:    movapd %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_cmp_v2i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vblendvpd %xmm2, %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_cmp_v2i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX2-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX2-NEXT:    vpsubq %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    vblendvpd %xmm2, %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_cmp_v2i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %xmm1, %xmm0, %xmm2
; AVX512-NEXT:    vpmaxsq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpsubq %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %cmp = icmp sge <2 x i64> %a, %b
  %ab = sub <2 x i64> %a, %b
  %ba = sub <2 x i64> %b, %a
  %sel = select <2 x i1> %cmp, <2 x i64> %ab, <2 x i64> %ba
  ret <2 x i64> %sel
}

;
; abs(sub_nsw(x, y)) -> abds(a,b)
;

define <16 x i8> @abd_subnsw_v16i8(<16 x i8> %a, <16 x i8> %b) nounwind {
; SSE2-LABEL: abd_subnsw_v16i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psubb %xmm1, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    psubb %xmm0, %xmm1
; SSE2-NEXT:    pminub %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_subnsw_v16i8:
; SSE42:       # %bb.0:
; SSE42-NEXT:    psubb %xmm1, %xmm0
; SSE42-NEXT:    pabsb %xmm0, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_subnsw_v16i8:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpabsb %xmm0, %xmm0
; AVX-NEXT:    retq
  %sub = sub nsw <16 x i8> %a, %b
  %abs = call <16 x i8> @llvm.abs.v16i8(<16 x i8> %sub, i1 false)
  ret <16 x i8> %abs
}

define <8 x i16> @abd_subnsw_v8i16(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE2-LABEL: abd_subnsw_v8i16:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psubw %xmm1, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm1
; SSE2-NEXT:    psubw %xmm0, %xmm1
; SSE2-NEXT:    pmaxsw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_subnsw_v8i16:
; SSE42:       # %bb.0:
; SSE42-NEXT:    psubw %xmm1, %xmm0
; SSE42-NEXT:    pabsw %xmm0, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_subnsw_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpabsw %xmm0, %xmm0
; AVX-NEXT:    retq
  %sub = sub nsw <8 x i16> %a, %b
  %abs = call <8 x i16> @llvm.abs.v8i16(<8 x i16> %sub, i1 false)
  ret <8 x i16> %abs
}

define <4 x i32> @abd_subnsw_v4i32(<4 x i32> %a, <4 x i32> %b) nounwind {
; SSE2-LABEL: abd_subnsw_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    psubd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_subnsw_v4i32:
; SSE42:       # %bb.0:
; SSE42-NEXT:    psubd %xmm1, %xmm0
; SSE42-NEXT:    pabsd %xmm0, %xmm0
; SSE42-NEXT:    retq
;
; AVX-LABEL: abd_subnsw_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpabsd %xmm0, %xmm0
; AVX-NEXT:    retq
  %sub = sub nsw <4 x i32> %a, %b
  %abs = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %sub, i1 false)
  ret <4 x i32> %abs
}

define <2 x i64> @abd_subnsw_v2i64(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_subnsw_v2i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; SSE2-NEXT:    psrad $31, %xmm1
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    psubq %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_subnsw_v2i64:
; SSE42:       # %bb.0:
; SSE42-NEXT:    psubq %xmm1, %xmm0
; SSE42-NEXT:    pxor %xmm1, %xmm1
; SSE42-NEXT:    psubq %xmm0, %xmm1
; SSE42-NEXT:    blendvpd %xmm0, %xmm1, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_subnsw_v2i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX1-NEXT:    vpsubq %xmm0, %xmm1, %xmm1
; AVX1-NEXT:    vblendvpd %xmm0, %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_subnsw_v2i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vpsubq %xmm0, %xmm1, %xmm1
; AVX2-NEXT:    vblendvpd %xmm0, %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_subnsw_v2i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsubq %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    vpabsq %xmm0, %xmm0
; AVX512-NEXT:    retq
  %sub = sub nsw <2 x i64> %a, %b
  %abs = call <2 x i64> @llvm.abs.v2i64(<2 x i64> %sub, i1 false)
  ret <2 x i64> %abs
}

;
; Special cases
;

define <2 x i64> @abd_cmp_v2i64_multiuse_cmp(<2 x i64> %a, <2 x i64> %b) nounwind {
; SSE2-LABEL: abd_cmp_v2i64_multiuse_cmp:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    psubq %xmm1, %xmm2
; SSE2-NEXT:    movdqa %xmm1, %xmm3
; SSE2-NEXT:    psubq %xmm0, %xmm3
; SSE2-NEXT:    movdqa {{.*#+}} xmm4 = [2147483648,2147483648]
; SSE2-NEXT:    pxor %xmm4, %xmm0
; SSE2-NEXT:    pxor %xmm4, %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm4
; SSE2-NEXT:    pcmpgtd %xmm0, %xmm4
; SSE2-NEXT:    pshufd {{.*#+}} xmm5 = xmm4[0,0,2,2]
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,3,3]
; SSE2-NEXT:    pand %xmm5, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm4[1,1,3,3]
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    pand %xmm1, %xmm3
; SSE2-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE2-NEXT:    pxor %xmm1, %xmm0
; SSE2-NEXT:    pandn %xmm2, %xmm1
; SSE2-NEXT:    por %xmm3, %xmm1
; SSE2-NEXT:    paddq %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE42-LABEL: abd_cmp_v2i64_multiuse_cmp:
; SSE42:       # %bb.0:
; SSE42-NEXT:    movdqa %xmm0, %xmm2
; SSE42-NEXT:    pcmpgtq %xmm1, %xmm0
; SSE42-NEXT:    movdqa %xmm2, %xmm3
; SSE42-NEXT:    psubq %xmm1, %xmm3
; SSE42-NEXT:    movdqa %xmm1, %xmm4
; SSE42-NEXT:    psubq %xmm2, %xmm4
; SSE42-NEXT:    blendvpd %xmm0, %xmm3, %xmm4
; SSE42-NEXT:    pcmpgtq %xmm2, %xmm1
; SSE42-NEXT:    pcmpeqd %xmm0, %xmm0
; SSE42-NEXT:    pxor %xmm1, %xmm0
; SSE42-NEXT:    paddq %xmm4, %xmm0
; SSE42-NEXT:    retq
;
; AVX1-LABEL: abd_cmp_v2i64_multiuse_cmp:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX1-NEXT:    vpsubq %xmm0, %xmm1, %xmm4
; AVX1-NEXT:    vblendvpd %xmm2, %xmm3, %xmm4, %xmm2
; AVX1-NEXT:    vpcmpgtq %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX1-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpaddq %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: abd_cmp_v2i64_multiuse_cmp:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm2
; AVX2-NEXT:    vpsubq %xmm1, %xmm0, %xmm3
; AVX2-NEXT:    vpsubq %xmm0, %xmm1, %xmm4
; AVX2-NEXT:    vblendvpd %xmm2, %xmm3, %xmm4, %xmm2
; AVX2-NEXT:    vpcmpgtq %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    vpcmpeqd %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vpxor %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpaddq %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: abd_cmp_v2i64_multiuse_cmp:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpminsq %xmm1, %xmm0, %xmm2
; AVX512-NEXT:    vpmaxsq %xmm1, %xmm0, %xmm3
; AVX512-NEXT:    vpsubq %xmm2, %xmm3, %xmm2
; AVX512-NEXT:    vpcmpgtq %xmm0, %xmm1, %xmm0
; AVX512-NEXT:    vpternlogq $15, %xmm0, %xmm0, %xmm0
; AVX512-NEXT:    vpaddq %xmm2, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %cmp = icmp sge <2 x i64> %a, %b
  %ab = sub <2 x i64> %a, %b
  %ba = sub <2 x i64> %b, %a
  %sel = select <2 x i1> %cmp, <2 x i64> %ab, <2 x i64> %ba
  %ext = sext <2 x i1> %cmp to <2 x i64>
  %res = add <2 x i64> %ext, %sel
  ret <2 x i64> %res
}

define <8 x i16> @abd_cmp_v8i16_multiuse_sub(<8 x i16> %a, <8 x i16> %b) nounwind {
; SSE-LABEL: abd_cmp_v8i16_multiuse_sub:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm2
; SSE-NEXT:    psubw %xmm1, %xmm2
; SSE-NEXT:    movdqa %xmm0, %xmm3
; SSE-NEXT:    pminsw %xmm1, %xmm3
; SSE-NEXT:    pmaxsw %xmm1, %xmm0
; SSE-NEXT:    psubw %xmm3, %xmm0
; SSE-NEXT:    paddw %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: abd_cmp_v8i16_multiuse_sub:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubw %xmm1, %xmm0, %xmm2
; AVX-NEXT:    vpminsw %xmm1, %xmm0, %xmm3
; AVX-NEXT:    vpmaxsw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpsubw %xmm3, %xmm0, %xmm0
; AVX-NEXT:    vpaddw %xmm0, %xmm2, %xmm0
; AVX-NEXT:    retq
  %cmp = icmp sgt <8 x i16> %a, %b
  %ab = sub <8 x i16> %a, %b
  %ba = sub <8 x i16> %b, %a
  %sel = select <8 x i1> %cmp, <8 x i16> %ab, <8 x i16> %ba
  %res = add <8 x i16> %ab, %sel
  ret <8 x i16> %res
}

declare <16 x i8> @llvm.abs.v16i8(<16 x i8>, i1)
declare <8 x i16> @llvm.abs.v8i16(<8 x i16>, i1)
declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1)
declare <2 x i64> @llvm.abs.v2i64(<2 x i64>, i1)
declare <4 x i64> @llvm.abs.v4i64(<4 x i64>, i1)
declare <8 x i64> @llvm.abs.v8i64(<8 x i64>, i1)
declare <16 x i64> @llvm.abs.v16i64(<16 x i64>, i1)
declare <2 x i128> @llvm.abs.v2i128(<2 x i128>, i1)

declare <16 x i8> @llvm.smax.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.smax.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.smax.v4i32(<4 x i32>, <4 x i32>)
declare <2 x i64> @llvm.smax.v2i64(<2 x i64>, <2 x i64>)

declare <16 x i8> @llvm.smin.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.smin.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.smin.v4i32(<4 x i32>, <4 x i32>)
declare <2 x i64> @llvm.smin.v2i64(<2 x i64>, <2 x i64>)
