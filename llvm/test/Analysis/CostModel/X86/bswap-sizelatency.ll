; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency -mattr=+sse2 | FileCheck %s --check-prefixes=SSE2
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency -mattr=+ssse3 | FileCheck %s --check-prefixes=SSSE3
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency -mattr=+sse4.2 | FileCheck %s --check-prefixes=SSE42
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency -mattr=+avx | FileCheck %s --check-prefixes=AVX1
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency -mattr=+avx2 | FileCheck %s --check-prefixes=AVX2
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency -mattr=+avx512f | FileCheck %s --check-prefixes=AVX512F
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency -mattr=+avx512vl,+avx512dq | FileCheck %s --check-prefixes=AVX512DQ
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=size-latency -mattr=+avx512vl,+avx512bw | FileCheck %s --check-prefixes=AVX512BW

;
; bswap(X)
;

define void @cost_bswap_i64(i64 %a64, <2 x i64> %a128, <4 x i64> %a256, <8 x i64> %a512) {
; SSE2-LABEL: 'cost_bswap_i64'
; SSE2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I64 = call i64 @llvm.bswap.i64(i64 %a64)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %V2I64 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 22 for instruction: %V4I64 = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 44 for instruction: %V8I64 = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SSSE3-LABEL: 'cost_bswap_i64'
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I64 = call i64 @llvm.bswap.i64(i64 %a64)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V2I64 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I64 = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I64 = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SSE42-LABEL: 'cost_bswap_i64'
; SSE42-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I64 = call i64 @llvm.bswap.i64(i64 %a64)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V2I64 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I64 = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I64 = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX1-LABEL: 'cost_bswap_i64'
; AVX1-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I64 = call i64 @llvm.bswap.i64(i64 %a64)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V2I64 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I64 = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I64 = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX2-LABEL: 'cost_bswap_i64'
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I64 = call i64 @llvm.bswap.i64(i64 %a64)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2I64 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I64 = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8I64 = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512F-LABEL: 'cost_bswap_i64'
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I64 = call i64 @llvm.bswap.i64(i64 %a64)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2I64 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I64 = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V8I64 = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512DQ-LABEL: 'cost_bswap_i64'
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I64 = call i64 @llvm.bswap.i64(i64 %a64)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2I64 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I64 = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V8I64 = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512BW-LABEL: 'cost_bswap_i64'
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I64 = call i64 @llvm.bswap.i64(i64 %a64)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2I64 = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I64 = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I64 = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %I64    = call i64 @llvm.bswap.i64(i64 %a64)
  %V2I64  = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %a128)
  %V4I64  = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %a256)
  %V8I64  = call <8 x i64> @llvm.bswap.v8i64(<8 x i64> %a512)
  ret void
}

define void @cost_bswap_i32(i32 %a32, <4 x i32> %a128, <8 x i32> %a256, <16 x i32> %a512) {
; SSE2-LABEL: 'cost_bswap_i32'
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.bswap.i32(i32 %a32)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 36 for instruction: %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SSSE3-LABEL: 'cost_bswap_i32'
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.bswap.i32(i32 %a32)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SSE42-LABEL: 'cost_bswap_i32'
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.bswap.i32(i32 %a32)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX1-LABEL: 'cost_bswap_i32'
; AVX1-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.bswap.i32(i32 %a32)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX2-LABEL: 'cost_bswap_i32'
; AVX2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.bswap.i32(i32 %a32)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512F-LABEL: 'cost_bswap_i32'
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.bswap.i32(i32 %a32)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512DQ-LABEL: 'cost_bswap_i32'
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.bswap.i32(i32 %a32)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512BW-LABEL: 'cost_bswap_i32'
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.bswap.i32(i32 %a32)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %I32   = call i32 @llvm.bswap.i32(i32 %a32)
  %V2I32 = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %a128)
  %V4I32 = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %a256)
  %V8I32 = call <16 x i32> @llvm.bswap.v16i32(<16 x i32> %a512)
  ret void
}

define void @cost_bswap_i16(i16 %a16, <8 x i16> %a128, <16 x i16> %a256, <32 x i16> %a512) {
; SSE2-LABEL: 'cost_bswap_i16'
; SSE2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I16 = call i16 @llvm.bswap.i16(i16 %a16)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V8I16 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
; SSE2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SSSE3-LABEL: 'cost_bswap_i16'
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I16 = call i16 @llvm.bswap.i16(i16 %a16)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V8I16 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
; SSSE3-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SSE42-LABEL: 'cost_bswap_i16'
; SSE42-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I16 = call i16 @llvm.bswap.i16(i16 %a16)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V8I16 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
; SSE42-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX1-LABEL: 'cost_bswap_i16'
; AVX1-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I16 = call i16 @llvm.bswap.i16(i16 %a16)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V8I16 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
; AVX1-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX2-LABEL: 'cost_bswap_i16'
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I16 = call i16 @llvm.bswap.i16(i16 %a16)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I16 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
; AVX2-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512F-LABEL: 'cost_bswap_i16'
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I16 = call i16 @llvm.bswap.i16(i16 %a16)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I16 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
; AVX512F-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512DQ-LABEL: 'cost_bswap_i16'
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I16 = call i16 @llvm.bswap.i16(i16 %a16)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I16 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
; AVX512DQ-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; AVX512BW-LABEL: 'cost_bswap_i16'
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %I16 = call i16 @llvm.bswap.i16(i16 %a16)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I16 = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
; AVX512BW-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %I16    = call i16 @llvm.bswap.i16(i16 %a16)
  %V8I16  = call <8 x i16> @llvm.bswap.v8i16(<8 x i16> %a128)
  %V16I16 = call <16 x i16> @llvm.bswap.v16i16(<16 x i16> %a256)
  %V32I16 = call <32 x i16> @llvm.bswap.v32i16(<32 x i16> %a512)
  ret void
}

declare i64 @llvm.bswap.i64(i64)
declare i32 @llvm.bswap.i32(i32)
declare i16 @llvm.bswap.i16(i16)

declare <2 x i64>  @llvm.bswap.v2i64(<2 x i64>)
declare <4 x i32>  @llvm.bswap.v4i32(<4 x i32>)
declare <8 x i16>  @llvm.bswap.v8i16(<8 x i16>)

declare <4 x i64>  @llvm.bswap.v4i64(<4 x i64>)
declare <8 x i32>  @llvm.bswap.v8i32(<8 x i32>)
declare <16 x i16> @llvm.bswap.v16i16(<16 x i16>)

declare <8 x i64>  @llvm.bswap.v8i64(<8 x i64>)
declare <16 x i32> @llvm.bswap.v16i32(<16 x i32>)
declare <32 x i16> @llvm.bswap.v32i16(<32 x i16>)
