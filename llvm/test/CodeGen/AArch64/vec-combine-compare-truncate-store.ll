; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64-apple-darwin -mattr=+neon -verify-machineinstrs < %s | FileCheck %s

define void @store_16_elements(<16 x i8> %vec, ptr %out) {
; Bits used in mask
; CHECK-LABEL: store_16_elements:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  Lloh0:
; CHECK-NEXT:    adrp x8, lCPI0_0@PAGE
; CHECK-NEXT:    cmeq.16b v0, v0, #0
; CHECK-NEXT:  Lloh1:
; CHECK-NEXT:    ldr q1, [x8, lCPI0_0@PAGEOFF]
; CHECK-NEXT:    bic.16b v0, v1, v0
; CHECK-NEXT:    ext.16b v1, v0, v0, #8
; CHECK-NEXT:    zip1.16b v0, v0, v1
; CHECK-NEXT:    addv.8h h0, v0
; CHECK-NEXT:    str h0, [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh0, Lloh1

; Actual conversion

  %cmp_result = icmp ne <16 x i8> %vec, zeroinitializer
  store <16 x i1> %cmp_result, ptr %out
  ret void
}

define void @store_8_elements(<8 x i16> %vec, ptr %out) {
; CHECK-LABEL: store_8_elements:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  Lloh2:
; CHECK-NEXT:    adrp x8, lCPI1_0@PAGE
; CHECK-NEXT:    cmeq.8h v0, v0, #0
; CHECK-NEXT:  Lloh3:
; CHECK-NEXT:    ldr q1, [x8, lCPI1_0@PAGEOFF]
; CHECK-NEXT:    bic.16b v0, v1, v0
; CHECK-NEXT:    addv.8h h0, v0
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh2, Lloh3


  %cmp_result = icmp ne <8 x i16> %vec, zeroinitializer
  store <8 x i1> %cmp_result, ptr %out
  ret void
}

define void @store_4_elements(<4 x i32> %vec, ptr %out) {
; CHECK-LABEL: store_4_elements:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  Lloh4:
; CHECK-NEXT:    adrp x8, lCPI2_0@PAGE
; CHECK-NEXT:    cmeq.4s v0, v0, #0
; CHECK-NEXT:  Lloh5:
; CHECK-NEXT:    ldr q1, [x8, lCPI2_0@PAGEOFF]
; CHECK-NEXT:    bic.16b v0, v1, v0
; CHECK-NEXT:    addv.4s s0, v0
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh4, Lloh5


  %cmp_result = icmp ne <4 x i32> %vec, zeroinitializer
  store <4 x i1> %cmp_result, ptr %out
  ret void
}

define void @store_2_elements(<2 x i64> %vec, ptr %out) {
; CHECK-LABEL: store_2_elements:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  Lloh6:
; CHECK-NEXT:    adrp x8, lCPI3_0@PAGE
; CHECK-NEXT:    cmeq.2d v0, v0, #0
; CHECK-NEXT:  Lloh7:
; CHECK-NEXT:    ldr q1, [x8, lCPI3_0@PAGEOFF]
; CHECK-NEXT:    bic.16b v0, v1, v0
; CHECK-NEXT:    addp.2d d0, v0
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh6, Lloh7


  %cmp_result = icmp ne <2 x i64> %vec, zeroinitializer
  store <2 x i1> %cmp_result, ptr %out
  ret void
}

define void @add_trunc_compare_before_store(<4 x i32> %vec, ptr %out) {
; CHECK-LABEL: add_trunc_compare_before_store:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    shl.4s v0, v0, #31
; CHECK-NEXT:  Lloh8:
; CHECK-NEXT:    adrp x8, lCPI4_0@PAGE
; CHECK-NEXT:  Lloh9:
; CHECK-NEXT:    ldr q1, [x8, lCPI4_0@PAGEOFF]
; CHECK-NEXT:    cmlt.4s v0, v0, #0
; CHECK-NEXT:    and.16b v0, v0, v1
; CHECK-NEXT:    addv.4s s0, v0
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh8, Lloh9


  %trunc = trunc <4 x i32> %vec to <4 x i1>
  store <4 x i1> %trunc, ptr %out
  ret void
}

define void @add_trunc_mask_unknown_vector_type(<4 x i1> %vec, ptr %out) {
; CHECK-LABEL: add_trunc_mask_unknown_vector_type:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    shl.4h v0, v0, #15
; CHECK-NEXT:  Lloh10:
; CHECK-NEXT:    adrp x8, lCPI5_0@PAGE
; CHECK-NEXT:  Lloh11:
; CHECK-NEXT:    ldr d1, [x8, lCPI5_0@PAGEOFF]
; CHECK-NEXT:    cmlt.4h v0, v0, #0
; CHECK-NEXT:    and.8b v0, v0, v1
; CHECK-NEXT:    addv.4h h0, v0
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh10, Lloh11


  store <4 x i1> %vec, ptr %out
  ret void
}

define void @store_8_elements_64_bit_vector(<8 x i8> %vec, ptr %out) {
; CHECK-LABEL: store_8_elements_64_bit_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  Lloh12:
; CHECK-NEXT:    adrp x8, lCPI6_0@PAGE
; CHECK-NEXT:    cmeq.8b v0, v0, #0
; CHECK-NEXT:  Lloh13:
; CHECK-NEXT:    ldr d1, [x8, lCPI6_0@PAGEOFF]
; CHECK-NEXT:    bic.8b v0, v1, v0
; CHECK-NEXT:    addv.8b b0, v0
; CHECK-NEXT:    st1.b { v0 }[0], [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh12, Lloh13


  %cmp_result = icmp ne <8 x i8> %vec, zeroinitializer
  store <8 x i1> %cmp_result, ptr %out
  ret void
}

define void @store_4_elements_64_bit_vector(<4 x i16> %vec, ptr %out) {
; CHECK-LABEL: store_4_elements_64_bit_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  Lloh14:
; CHECK-NEXT:    adrp x8, lCPI7_0@PAGE
; CHECK-NEXT:    cmeq.4h v0, v0, #0
; CHECK-NEXT:  Lloh15:
; CHECK-NEXT:    ldr d1, [x8, lCPI7_0@PAGEOFF]
; CHECK-NEXT:    bic.8b v0, v1, v0
; CHECK-NEXT:    addv.4h h0, v0
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh14, Lloh15


  %cmp_result = icmp ne <4 x i16> %vec, zeroinitializer
  store <4 x i1> %cmp_result, ptr %out
  ret void
}

define void @store_2_elements_64_bit_vector(<2 x i32> %vec, ptr %out) {
; CHECK-LABEL: store_2_elements_64_bit_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:  Lloh16:
; CHECK-NEXT:    adrp x8, lCPI8_0@PAGE
; CHECK-NEXT:    cmeq.2s v0, v0, #0
; CHECK-NEXT:  Lloh17:
; CHECK-NEXT:    ldr d1, [x8, lCPI8_0@PAGEOFF]
; CHECK-NEXT:    bic.8b v0, v1, v0
; CHECK-NEXT:    addp.2s v0, v0, v0
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    strb w8, [x0]
; CHECK-NEXT:    ret
; CHECK-NEXT:    .loh AdrpLdr Lloh16, Lloh17


  %cmp_result = icmp ne <2 x i32> %vec, zeroinitializer
  store <2 x i1> %cmp_result, ptr %out
  ret void
}

define void @no_combine_without_truncate(<16 x i8> %vec, ptr %out) {
; CHECK-LABEL: no_combine_without_truncate:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    cmtst.16b v0, v0, v0
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

  %cmp_result = icmp ne <16 x i8> %vec, zeroinitializer
  %extended_result = sext <16 x i1> %cmp_result to <16 x i8>
  store <16 x i8> %extended_result, ptr %out
  ret void
}

define void @no_combine_for_non_bool_truncate(<4 x i32> %vec, ptr %out) {
; CHECK-LABEL: no_combine_for_non_bool_truncate:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    xtn.4h v0, v0
; CHECK-NEXT:    xtn.8b v0, v0
; CHECK-NEXT:    str s0, [x0]
; CHECK-NEXT:    ret

  %trunc = trunc <4 x i32> %vec to <4 x i8>
  store <4 x i8> %trunc, ptr %out
  ret void
}

define void @no_combine_for_build_vector(i1 %a, i1 %b, i1 %c, i1 %d, ptr %out) {
; CHECK-LABEL: no_combine_for_build_vector:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    orr w8, w0, w1, lsl #1
; CHECK-NEXT:    orr w8, w8, w2, lsl #2
; CHECK-NEXT:    orr w8, w8, w3, lsl #3
; CHECK-NEXT:    strb w8, [x4]
; CHECK-NEXT:    ret

  %1 =   insertelement <4 x i1> undef, i1 %a, i64 0
  %2 =   insertelement <4 x i1>    %1, i1 %b, i64 1
  %3 =   insertelement <4 x i1>    %2, i1 %c, i64 2
  %vec = insertelement <4 x i1>    %3, i1 %d, i64 3
  store <4 x i1> %vec, ptr %out
  ret void
}
