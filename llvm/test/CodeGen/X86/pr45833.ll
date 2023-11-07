; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O3 -mtriple=x86_64-linux-generic -mattr=avx < %s | FileCheck %s

; Bug 45833:
; The SplitVecRes_MSTORE method should split a extended value type
; according to the halving of the enveloping type to avoid all sorts
; of inconsistencies downstream. For example for a extended value type
; with VL=14 and enveloping type VL=16 that is split 8/8, the extended
; type should be split 8/6 and not 7/7. This also accounts for hi masked
; store that get zero storage size (and are unused).

define void @mstore_split9(<9 x float> %value, ptr %addr, <9 x i1> %mask) {
; CHECK-LABEL: mstore_split9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1],xmm6[0],xmm4[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1,2],xmm7[0]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; CHECK-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; CHECK-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; CHECK-NEXT:    vmovd %esi, %xmm2
; CHECK-NEXT:    vpinsrb $1, %edx, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $2, %ecx, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $3, %r8d, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $4, %r9d, %xmm2, %xmm3
; CHECK-NEXT:    vpinsrb $5, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $7, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $8, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpshufb {{.*#+}} xmm4 = xmm3[8,u,u,u],zero,xmm3[u,u,u],zero,xmm3[u,u,u],zero,xmm3[u,u,u]
; CHECK-NEXT:    vpslld $31, %xmm4, %xmm4
; CHECK-NEXT:    vmaskmovps %ymm1, %ymm4, 32(%rdi)
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm1 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm1, %xmm1
; CHECK-NEXT:    vpshufd {{.*#+}} xmm2 = xmm3[1,1,1,1]
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm2, %xmm2
; CHECK-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; CHECK-NEXT:    vmaskmovps %ymm0, %ymm1, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.masked.store.v9f32.p0(<9 x float> %value, ptr %addr, i32 4, <9 x i1>%mask)
  ret void
}

define void @mstore_split13(<13 x float> %value, ptr %addr, <13 x i1> %mask) {
; CHECK-LABEL: mstore_split13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1],xmm6[0],xmm4[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1,2],xmm7[0]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; CHECK-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; CHECK-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0],mem[0],xmm1[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1],mem[0],xmm1[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1,2],mem[0]
; CHECK-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; CHECK-NEXT:    vmovd %esi, %xmm2
; CHECK-NEXT:    vpinsrb $1, %edx, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $2, %ecx, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $3, %r8d, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $4, %r9d, %xmm2, %xmm3
; CHECK-NEXT:    vpinsrb $5, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $7, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $8, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $9, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $10, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $11, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $12, {{[0-9]+}}(%rsp), %xmm3, %xmm4
; CHECK-NEXT:    vpunpckhbw {{.*#+}} xmm3 = xmm3[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; CHECK-NEXT:    vpmovzxwd {{.*#+}} xmm3 = xmm3[0],zero,xmm3[1],zero,xmm3[2],zero,xmm3[3],zero
; CHECK-NEXT:    vpslld $31, %xmm3, %xmm3
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm5 = xmm4[12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm5, %xmm5
; CHECK-NEXT:    vinsertf128 $1, %xmm5, %ymm3, %ymm3
; CHECK-NEXT:    vmaskmovps %ymm1, %ymm3, 32(%rdi)
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm1 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm1, %xmm1
; CHECK-NEXT:    vpshufd {{.*#+}} xmm2 = xmm4[1,1,1,1]
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm2, %xmm2
; CHECK-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; CHECK-NEXT:    vmaskmovps %ymm0, %ymm1, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.masked.store.v13f32.p0(<13 x float> %value, ptr %addr, i32 4, <13 x i1>%mask)
  ret void
}

define void @mstore_split14(<14 x float> %value, ptr %addr, <14 x i1> %mask) {
; CHECK-LABEL: mstore_split14:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1],xmm6[0],xmm4[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1,2],xmm7[0]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; CHECK-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; CHECK-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0],mem[0],xmm1[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1],mem[0],xmm1[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1,2],mem[0]
; CHECK-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0],mem[0],xmm2[2,3]
; CHECK-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; CHECK-NEXT:    vmovd %esi, %xmm2
; CHECK-NEXT:    vpinsrb $1, %edx, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $2, %ecx, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $3, %r8d, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $4, %r9d, %xmm2, %xmm3
; CHECK-NEXT:    vpinsrb $5, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $7, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $8, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $9, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $10, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $11, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $12, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $13, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm2, %xmm2
; CHECK-NEXT:    vpshufd {{.*#+}} xmm4 = xmm3[1,1,1,1]
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm4 = xmm4[0],zero,zero,zero,xmm4[1],zero,zero,zero,xmm4[2],zero,zero,zero,xmm4[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm4, %xmm4
; CHECK-NEXT:    vinsertf128 $1, %xmm4, %ymm2, %ymm2
; CHECK-NEXT:    vmaskmovps %ymm0, %ymm2, (%rdi)
; CHECK-NEXT:    vpshufb {{.*#+}} xmm0 = xmm3[8,u,9,u,10,u,11,u,12,u,13,u],zero,xmm3[u],zero,xmm3[u]
; CHECK-NEXT:    vpmovzxwd {{.*#+}} xmm2 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; CHECK-NEXT:    vpslld $31, %xmm2, %xmm2
; CHECK-NEXT:    vpunpckhwd {{.*#+}} xmm0 = xmm0[4,4,5,5,6,6,7,7]
; CHECK-NEXT:    vpslld $31, %xmm0, %xmm0
; CHECK-NEXT:    vinsertf128 $1, %xmm0, %ymm2, %ymm0
; CHECK-NEXT:    vmaskmovps %ymm1, %ymm0, 32(%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.masked.store.v14f32.p0(<14 x float> %value, ptr %addr, i32 4, <14 x i1>%mask)
  ret void
}

define void @mstore_split17(<17 x float> %value, ptr %addr, <17 x i1> %mask) {
; CHECK-LABEL: mstore_split17:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1],xmm6[0],xmm4[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1,2],xmm7[0]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; CHECK-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; CHECK-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0],mem[0],xmm1[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1],mem[0],xmm1[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1,2],mem[0]
; CHECK-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0],mem[0],xmm2[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1],mem[0],xmm2[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1,2],mem[0]
; CHECK-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; CHECK-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    movzbl {{[0-9]+}}(%rsp), %eax
; CHECK-NEXT:    vmovd %eax, %xmm3
; CHECK-NEXT:    vpslld $31, %xmm3, %xmm3
; CHECK-NEXT:    vmaskmovps %ymm2, %ymm3, 64(%rdi)
; CHECK-NEXT:    vmovd {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    vpinsrb $2, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $4, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpmovzxwd {{.*#+}} xmm3 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero
; CHECK-NEXT:    vpslld $31, %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $8, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $10, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $12, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $14, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpunpckhwd {{.*#+}} xmm2 = xmm2[4,4,5,5,6,6,7,7]
; CHECK-NEXT:    vpslld $31, %xmm2, %xmm2
; CHECK-NEXT:    vinsertf128 $1, %xmm2, %ymm3, %ymm2
; CHECK-NEXT:    vmaskmovps %ymm1, %ymm2, 32(%rdi)
; CHECK-NEXT:    vmovd %esi, %xmm1
; CHECK-NEXT:    vpinsrb $1, %edx, %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $2, %ecx, %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $3, %r8d, %xmm1, %xmm1
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm2 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero,xmm1[2],zero,zero,zero,xmm1[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $4, %r9d, %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $5, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $7, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; CHECK-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,1,1]
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero,xmm1[2],zero,zero,zero,xmm1[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm1, %xmm1
; CHECK-NEXT:    vinsertf128 $1, %xmm1, %ymm2, %ymm1
; CHECK-NEXT:    vmaskmovps %ymm0, %ymm1, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.masked.store.v17f32.p0(<17 x float> %value, ptr %addr, i32 4, <17 x i1>%mask)
  ret void
}

define void @mstore_split23(<23 x float> %value, ptr %addr, <23 x i1> %mask) {
; CHECK-LABEL: mstore_split23:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1],xmm6[0],xmm4[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm4 = xmm4[0,1,2],xmm7[0]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],xmm2[0],xmm0[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],xmm3[0]
; CHECK-NEXT:    vinsertf128 $1, %xmm4, %ymm0, %ymm0
; CHECK-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0],mem[0],xmm1[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1],mem[0],xmm1[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm1 = xmm1[0,1,2],mem[0]
; CHECK-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0],mem[0],xmm2[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1],mem[0],xmm2[3]
; CHECK-NEXT:    vinsertf128 $1, %xmm2, %ymm1, %ymm1
; CHECK-NEXT:    vmovss {{.*#+}} xmm2 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0],mem[0],xmm2[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1],mem[0],xmm2[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm2 = xmm2[0,1,2],mem[0]
; CHECK-NEXT:    vmovss {{.*#+}} xmm3 = mem[0],zero,zero,zero
; CHECK-NEXT:    vinsertps {{.*#+}} xmm3 = xmm3[0],mem[0],xmm3[2,3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm3 = xmm3[0,1],mem[0],xmm3[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm3 = xmm3[0,1,2],mem[0]
; CHECK-NEXT:    vinsertf128 $1, %xmm3, %ymm2, %ymm2
; CHECK-NEXT:    movzbl {{[0-9]+}}(%rsp), %eax
; CHECK-NEXT:    vmovd {{.*#+}} xmm3 = mem[0],zero,zero,zero
; CHECK-NEXT:    vpinsrb $2, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $4, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpmovzxwd {{.*#+}} xmm4 = xmm3[0],zero,xmm3[1],zero,xmm3[2],zero,xmm3[3],zero
; CHECK-NEXT:    vpslld $31, %xmm4, %xmm4
; CHECK-NEXT:    vpinsrb $8, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $10, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $12, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $14, {{[0-9]+}}(%rsp), %xmm3, %xmm3
; CHECK-NEXT:    vpunpckhwd {{.*#+}} xmm3 = xmm3[4,4,5,5,6,6,7,7]
; CHECK-NEXT:    vpslld $31, %xmm3, %xmm3
; CHECK-NEXT:    vinsertf128 $1, %xmm3, %ymm4, %ymm3
; CHECK-NEXT:    vmaskmovps %ymm2, %ymm3, 32(%rdi)
; CHECK-NEXT:    vmovd %eax, %xmm2
; CHECK-NEXT:    vpinsrb $1, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $2, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $3, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm3 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm3, %xmm3
; CHECK-NEXT:    vpinsrb $4, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $5, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm2, %xmm2
; CHECK-NEXT:    vpshufd {{.*#+}} xmm2 = xmm2[1,1,1,1]
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero,xmm2[2],zero,zero,zero,xmm2[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm2, %xmm2
; CHECK-NEXT:    vinsertf128 $1, %xmm2, %ymm3, %ymm2
; CHECK-NEXT:    vmaskmovps %ymm1, %ymm2, 64(%rdi)
; CHECK-NEXT:    vmovd %esi, %xmm1
; CHECK-NEXT:    vpinsrb $1, %edx, %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $2, %ecx, %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $3, %r8d, %xmm1, %xmm1
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm2 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero,xmm1[2],zero,zero,zero,xmm1[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm2, %xmm2
; CHECK-NEXT:    vpinsrb $4, %r9d, %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $5, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $6, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; CHECK-NEXT:    vpinsrb $7, {{[0-9]+}}(%rsp), %xmm1, %xmm1
; CHECK-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,1,1]
; CHECK-NEXT:    vpmovzxbd {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero,xmm1[2],zero,zero,zero,xmm1[3],zero,zero,zero
; CHECK-NEXT:    vpslld $31, %xmm1, %xmm1
; CHECK-NEXT:    vinsertf128 $1, %xmm1, %ymm2, %ymm1
; CHECK-NEXT:    vmaskmovps %ymm0, %ymm1, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.masked.store.v23f32.p0(<23 x float> %value, ptr %addr, i32 4, <23 x i1>%mask)
  ret void
}

declare void @llvm.masked.store.v9f32.p0(<9 x float>, ptr, i32, <9 x i1>)
declare void @llvm.masked.store.v13f32.p0(<13 x float>, ptr, i32, <13 x i1>)
declare void @llvm.masked.store.v14f32.p0(<14 x float>, ptr, i32, <14 x i1>)
declare void @llvm.masked.store.v17f32.p0(<17 x float>, ptr, i32, <17 x i1>)
declare void @llvm.masked.store.v23f32.p0(<23 x float>, ptr, i32, <23 x i1>)
