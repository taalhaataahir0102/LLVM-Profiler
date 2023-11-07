; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=aarch64 -mattr=+fullfp16 < %s | FileCheck %s
; RUN: llc --mtriple=aarch64 < %s | FileCheck %s --check-prefix=CHECKNOFP16

define half @faddp_2xhalf(<2 x half> %a) {
; CHECK-LABEL: faddp_2xhalf:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    faddp h0, v0.2h
; CHECK-NEXT:    ret
;
; CHECKNOFP16-LABEL: faddp_2xhalf:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECKNOFP16-NEXT:    dup v1.4h, v0.h[1]
; CHECKNOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECKNOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECKNOFP16-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECKNOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECKNOFP16-NEXT:    // kill: def $h0 killed $h0 killed $q0
; CHECKNOFP16-NEXT:    ret
entry:
  %shift = shufflevector <2 x half> %a, <2 x half> undef, <2 x i32> <i32 1, i32 undef>
  %0 = fadd <2 x half> %a, %shift
  %1 = extractelement <2 x half> %0, i32 0
  ret half %1
}

define half @faddp_2xhalf_commute(<2 x half> %a) {
; CHECK-LABEL: faddp_2xhalf_commute:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    faddp h0, v0.2h
; CHECK-NEXT:    ret
;
; CHECKNOFP16-LABEL: faddp_2xhalf_commute:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECKNOFP16-NEXT:    dup v1.4h, v0.h[1]
; CHECKNOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECKNOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECKNOFP16-NEXT:    fadd v0.4s, v1.4s, v0.4s
; CHECKNOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECKNOFP16-NEXT:    // kill: def $h0 killed $h0 killed $q0
; CHECKNOFP16-NEXT:    ret
entry:
  %shift = shufflevector <2 x half> %a, <2 x half> undef, <2 x i32> <i32 1, i32 undef>
  %0 = fadd <2 x half> %shift, %a
  %1 = extractelement <2 x half> %0, i32 0
  ret half %1
}

define half @faddp_4xhalf(<4 x half> %a) {
; CHECK-LABEL: faddp_4xhalf:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    faddp h0, v0.2h
; CHECK-NEXT:    ret
;
; CHECKNOFP16-LABEL: faddp_4xhalf:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECKNOFP16-NEXT:    dup v1.4h, v0.h[1]
; CHECKNOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECKNOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECKNOFP16-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECKNOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECKNOFP16-NEXT:    // kill: def $h0 killed $h0 killed $q0
; CHECKNOFP16-NEXT:    ret
entry:
  %shift = shufflevector <4 x half> %a, <4 x half> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %0 = fadd <4 x half> %a, %shift
  %1 = extractelement <4 x half> %0, i32 0
  ret half %1
}

define half @faddp_4xhalf_commute(<4 x half> %a) {
; CHECK-LABEL: faddp_4xhalf_commute:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    faddp h0, v0.2h
; CHECK-NEXT:    ret
;
; CHECKNOFP16-LABEL: faddp_4xhalf_commute:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECKNOFP16-NEXT:    dup v1.4h, v0.h[1]
; CHECKNOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECKNOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECKNOFP16-NEXT:    fadd v0.4s, v1.4s, v0.4s
; CHECKNOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECKNOFP16-NEXT:    // kill: def $h0 killed $h0 killed $q0
; CHECKNOFP16-NEXT:    ret
entry:
  %shift = shufflevector <4 x half> %a, <4 x half> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %0 = fadd <4 x half> %shift, %a
  %1 = extractelement <4 x half> %0, i32 0
  ret half %1
}

define half @faddp_8xhalf(<8 x half> %a) {
; CHECK-LABEL: faddp_8xhalf:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    faddp h0, v0.2h
; CHECK-NEXT:    ret
;
; CHECKNOFP16-LABEL: faddp_8xhalf:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    dup v1.8h, v0.h[1]
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s0, s0, s1
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    ret
entry:
  %shift = shufflevector <8 x half> %a, <8 x half> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %0 = fadd <8 x half> %a, %shift
  %1 = extractelement <8 x half> %0, i32 0
  ret half %1
}

define half @faddp_8xhalf_commute(<8 x half> %a) {
; CHECK-LABEL: faddp_8xhalf_commute:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    faddp h0, v0.2h
; CHECK-NEXT:    ret
;
; CHECKNOFP16-LABEL: faddp_8xhalf_commute:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    dup v1.8h, v0.h[1]
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s0, s1, s0
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    ret
entry:
  %shift = shufflevector <8 x half> %a, <8 x half> undef, <8 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %0 = fadd <8 x half> %shift, %a
  %1 = extractelement <8 x half> %0, i32 0
  ret half %1
}

define <8 x half> @addp_v8f16(<8 x half> %a) {
; CHECK-LABEL: addp_v8f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    rev32 v1.8h, v0.8h
; CHECK-NEXT:    fadd v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    ret
;
; CHECKNOFP16-LABEL: addp_v8f16:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    rev32 v2.8h, v0.8h
; CHECKNOFP16-NEXT:    mov h1, v0.h[1]
; CHECKNOFP16-NEXT:    fcvt s4, h0
; CHECKNOFP16-NEXT:    mov h5, v0.h[2]
; CHECKNOFP16-NEXT:    mov h16, v0.h[3]
; CHECKNOFP16-NEXT:    mov h3, v2.h[1]
; CHECKNOFP16-NEXT:    fcvt s6, h2
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    mov h7, v2.h[2]
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt s16, h16
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s4, s6, s4
; CHECKNOFP16-NEXT:    mov h6, v2.h[3]
; CHECKNOFP16-NEXT:    fcvt s7, h7
; CHECKNOFP16-NEXT:    fadd s3, s3, s1
; CHECKNOFP16-NEXT:    fcvt s6, h6
; CHECKNOFP16-NEXT:    fcvt h1, s4
; CHECKNOFP16-NEXT:    fadd s4, s7, s5
; CHECKNOFP16-NEXT:    mov h5, v0.h[4]
; CHECKNOFP16-NEXT:    mov h7, v2.h[4]
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fadd s6, s6, s16
; CHECKNOFP16-NEXT:    mov h16, v2.h[5]
; CHECKNOFP16-NEXT:    fcvt h4, s4
; CHECKNOFP16-NEXT:    mov v1.h[1], v3.h[0]
; CHECKNOFP16-NEXT:    fcvt s3, h5
; CHECKNOFP16-NEXT:    fcvt s5, h7
; CHECKNOFP16-NEXT:    mov h7, v0.h[5]
; CHECKNOFP16-NEXT:    fcvt h6, s6
; CHECKNOFP16-NEXT:    fcvt s16, h16
; CHECKNOFP16-NEXT:    mov v1.h[2], v4.h[0]
; CHECKNOFP16-NEXT:    mov h4, v0.h[6]
; CHECKNOFP16-NEXT:    fadd s3, s5, s3
; CHECKNOFP16-NEXT:    mov h5, v2.h[6]
; CHECKNOFP16-NEXT:    fcvt s7, h7
; CHECKNOFP16-NEXT:    mov h0, v0.h[7]
; CHECKNOFP16-NEXT:    mov h2, v2.h[7]
; CHECKNOFP16-NEXT:    mov v1.h[3], v6.h[0]
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fadd s6, s16, s7
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    mov v1.h[4], v3.h[0]
; CHECKNOFP16-NEXT:    fadd s4, s5, s4
; CHECKNOFP16-NEXT:    fcvt h3, s6
; CHECKNOFP16-NEXT:    fadd s0, s2, s0
; CHECKNOFP16-NEXT:    mov v1.h[5], v3.h[0]
; CHECKNOFP16-NEXT:    fcvt h3, s4
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    mov v1.h[6], v3.h[0]
; CHECKNOFP16-NEXT:    mov v1.h[7], v0.h[0]
; CHECKNOFP16-NEXT:    mov v0.16b, v1.16b
; CHECKNOFP16-NEXT:    ret
entry:
  %s = shufflevector <8 x half> %a, <8 x half> poison, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %b = fadd reassoc <8 x half> %s, %a
  ret <8 x half> %b
}

define <16 x half> @addp_v16f16(<16 x half> %a) {
; CHECK-LABEL: addp_v16f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    faddp v1.8h, v0.8h, v1.8h
; CHECK-NEXT:    zip1 v0.8h, v1.8h, v1.8h
; CHECK-NEXT:    zip2 v1.8h, v1.8h, v1.8h
; CHECK-NEXT:    ret
;
; CHECKNOFP16-LABEL: addp_v16f16:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    rev32 v5.8h, v0.8h
; CHECKNOFP16-NEXT:    rev32 v4.8h, v1.8h
; CHECKNOFP16-NEXT:    mov h2, v0.h[1]
; CHECKNOFP16-NEXT:    mov h6, v1.h[1]
; CHECKNOFP16-NEXT:    fcvt s16, h0
; CHECKNOFP16-NEXT:    mov h17, v0.h[2]
; CHECKNOFP16-NEXT:    fcvt s20, h1
; CHECKNOFP16-NEXT:    mov h21, v1.h[2]
; CHECKNOFP16-NEXT:    mov h3, v5.h[1]
; CHECKNOFP16-NEXT:    mov h7, v4.h[1]
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s18, h5
; CHECKNOFP16-NEXT:    mov h19, v5.h[2]
; CHECKNOFP16-NEXT:    fcvt s6, h6
; CHECKNOFP16-NEXT:    fcvt s22, h4
; CHECKNOFP16-NEXT:    mov h23, v4.h[2]
; CHECKNOFP16-NEXT:    fcvt s17, h17
; CHECKNOFP16-NEXT:    mov h24, v5.h[3]
; CHECKNOFP16-NEXT:    fcvt s21, h21
; CHECKNOFP16-NEXT:    mov h25, v4.h[6]
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s7, h7
; CHECKNOFP16-NEXT:    fadd s16, s18, s16
; CHECKNOFP16-NEXT:    fcvt s18, h19
; CHECKNOFP16-NEXT:    mov h19, v0.h[3]
; CHECKNOFP16-NEXT:    fadd s20, s22, s20
; CHECKNOFP16-NEXT:    fcvt s22, h23
; CHECKNOFP16-NEXT:    mov h23, v4.h[3]
; CHECKNOFP16-NEXT:    fadd s3, s3, s2
; CHECKNOFP16-NEXT:    fadd s6, s7, s6
; CHECKNOFP16-NEXT:    mov h7, v1.h[3]
; CHECKNOFP16-NEXT:    fcvt h2, s16
; CHECKNOFP16-NEXT:    fadd s16, s18, s17
; CHECKNOFP16-NEXT:    fcvt s18, h19
; CHECKNOFP16-NEXT:    fcvt s19, h24
; CHECKNOFP16-NEXT:    mov h24, v5.h[6]
; CHECKNOFP16-NEXT:    fcvt h17, s3
; CHECKNOFP16-NEXT:    fcvt h3, s20
; CHECKNOFP16-NEXT:    fadd s20, s22, s21
; CHECKNOFP16-NEXT:    fcvt h6, s6
; CHECKNOFP16-NEXT:    fcvt s7, h7
; CHECKNOFP16-NEXT:    fcvt s22, h23
; CHECKNOFP16-NEXT:    mov h21, v0.h[4]
; CHECKNOFP16-NEXT:    mov h23, v5.h[4]
; CHECKNOFP16-NEXT:    fcvt h16, s16
; CHECKNOFP16-NEXT:    fadd s18, s19, s18
; CHECKNOFP16-NEXT:    mov h19, v4.h[4]
; CHECKNOFP16-NEXT:    mov v2.h[1], v17.h[0]
; CHECKNOFP16-NEXT:    mov h17, v1.h[4]
; CHECKNOFP16-NEXT:    mov v3.h[1], v6.h[0]
; CHECKNOFP16-NEXT:    fcvt h6, s20
; CHECKNOFP16-NEXT:    fadd s7, s22, s7
; CHECKNOFP16-NEXT:    fcvt s20, h21
; CHECKNOFP16-NEXT:    mov h21, v0.h[5]
; CHECKNOFP16-NEXT:    mov h22, v5.h[5]
; CHECKNOFP16-NEXT:    fcvt h18, s18
; CHECKNOFP16-NEXT:    fcvt s19, h19
; CHECKNOFP16-NEXT:    mov h5, v5.h[7]
; CHECKNOFP16-NEXT:    mov v2.h[2], v16.h[0]
; CHECKNOFP16-NEXT:    fcvt s16, h23
; CHECKNOFP16-NEXT:    fcvt s17, h17
; CHECKNOFP16-NEXT:    mov v3.h[2], v6.h[0]
; CHECKNOFP16-NEXT:    fcvt h6, s7
; CHECKNOFP16-NEXT:    mov h7, v1.h[5]
; CHECKNOFP16-NEXT:    mov h23, v4.h[5]
; CHECKNOFP16-NEXT:    mov h4, v4.h[7]
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fadd s16, s16, s20
; CHECKNOFP16-NEXT:    mov h20, v0.h[6]
; CHECKNOFP16-NEXT:    fadd s17, s19, s17
; CHECKNOFP16-NEXT:    mov h19, v1.h[6]
; CHECKNOFP16-NEXT:    mov v2.h[3], v18.h[0]
; CHECKNOFP16-NEXT:    fcvt s18, h21
; CHECKNOFP16-NEXT:    fcvt s21, h22
; CHECKNOFP16-NEXT:    mov v3.h[3], v6.h[0]
; CHECKNOFP16-NEXT:    fcvt s6, h7
; CHECKNOFP16-NEXT:    fcvt s7, h23
; CHECKNOFP16-NEXT:    fcvt s22, h24
; CHECKNOFP16-NEXT:    fcvt s23, h25
; CHECKNOFP16-NEXT:    fcvt h16, s16
; CHECKNOFP16-NEXT:    fcvt s20, h20
; CHECKNOFP16-NEXT:    fcvt h17, s17
; CHECKNOFP16-NEXT:    fcvt s19, h19
; CHECKNOFP16-NEXT:    mov h0, v0.h[7]
; CHECKNOFP16-NEXT:    mov h1, v1.h[7]
; CHECKNOFP16-NEXT:    fadd s18, s21, s18
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fadd s6, s7, s6
; CHECKNOFP16-NEXT:    mov v2.h[4], v16.h[0]
; CHECKNOFP16-NEXT:    fadd s7, s22, s20
; CHECKNOFP16-NEXT:    mov v3.h[4], v17.h[0]
; CHECKNOFP16-NEXT:    fadd s16, s23, s19
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fcvt h17, s18
; CHECKNOFP16-NEXT:    fcvt h6, s6
; CHECKNOFP16-NEXT:    fadd s0, s5, s0
; CHECKNOFP16-NEXT:    fcvt h5, s7
; CHECKNOFP16-NEXT:    fadd s1, s4, s1
; CHECKNOFP16-NEXT:    mov v2.h[5], v17.h[0]
; CHECKNOFP16-NEXT:    mov v3.h[5], v6.h[0]
; CHECKNOFP16-NEXT:    fcvt h6, s16
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    mov v2.h[6], v5.h[0]
; CHECKNOFP16-NEXT:    mov v3.h[6], v6.h[0]
; CHECKNOFP16-NEXT:    mov v2.h[7], v0.h[0]
; CHECKNOFP16-NEXT:    mov v3.h[7], v1.h[0]
; CHECKNOFP16-NEXT:    mov v0.16b, v2.16b
; CHECKNOFP16-NEXT:    mov v1.16b, v3.16b
; CHECKNOFP16-NEXT:    ret
entry:
  %s = shufflevector <16 x half> %a, <16 x half> poison, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  %b = fadd reassoc <16 x half> %s, %a
  ret <16 x half> %b
}
