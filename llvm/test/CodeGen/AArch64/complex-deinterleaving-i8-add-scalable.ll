; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s --mattr=+sve2 -o - | FileCheck %s

target triple = "aarch64-arm-none-eabi"

; Expected to not transform as the type's minimum size is less than 128 bits.
define <vscale x 8 x i8> @complex_add_v8i8(<vscale x 8 x i8> %a, <vscale x 8 x i8> %b) {
; CHECK-LABEL: complex_add_v8i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uunpkhi z2.s, z0.h
; CHECK-NEXT:    uunpklo z0.s, z0.h
; CHECK-NEXT:    uunpkhi z3.s, z1.h
; CHECK-NEXT:    uunpklo z1.s, z1.h
; CHECK-NEXT:    uzp1 z4.s, z0.s, z2.s
; CHECK-NEXT:    uzp2 z0.s, z0.s, z2.s
; CHECK-NEXT:    uzp2 z2.s, z1.s, z3.s
; CHECK-NEXT:    uzp1 z1.s, z1.s, z3.s
; CHECK-NEXT:    sub z0.s, z1.s, z0.s
; CHECK-NEXT:    add z1.s, z2.s, z4.s
; CHECK-NEXT:    zip2 z2.s, z0.s, z1.s
; CHECK-NEXT:    zip1 z0.s, z0.s, z1.s
; CHECK-NEXT:    uzp1 z0.h, z0.h, z2.h
; CHECK-NEXT:    ret
entry:
  %a.deinterleaved = tail call { <vscale x 4 x i8>, <vscale x 4 x i8> } @llvm.experimental.vector.deinterleave2.nxv8i8(<vscale x 8 x i8> %a)
  %a.real = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8> } %a.deinterleaved, 0
  %a.imag = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8> } %a.deinterleaved, 1
  %b.deinterleaved = tail call { <vscale x 4 x i8>, <vscale x 4 x i8> } @llvm.experimental.vector.deinterleave2.nxv8i8(<vscale x 8 x i8> %b)
  %b.real = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8> } %b.deinterleaved, 0
  %b.imag = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i8> } %b.deinterleaved, 1
  %0 = sub <vscale x 4 x i8> %b.real, %a.imag
  %1 = add <vscale x 4 x i8> %b.imag, %a.real
  %interleaved.vec = tail call <vscale x 8 x i8> @llvm.experimental.vector.interleave2.nxv8i8(<vscale x 4 x i8> %0, <vscale x 4 x i8> %1)
  ret <vscale x 8 x i8> %interleaved.vec
}

; Expected to transform
define <vscale x 16 x i8> @complex_add_v16i8(<vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: complex_add_v16i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cadd z1.b, z1.b, z0.b, #90
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
entry:
  %a.deinterleaved = tail call { <vscale x 8 x i8>, <vscale x 8 x i8> } @llvm.experimental.vector.deinterleave2.nxv16i8(<vscale x 16 x i8> %a)
  %a.real = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } %a.deinterleaved, 0
  %a.imag = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } %a.deinterleaved, 1
  %b.deinterleaved = tail call { <vscale x 8 x i8>, <vscale x 8 x i8> } @llvm.experimental.vector.deinterleave2.nxv16i8(<vscale x 16 x i8> %b)
  %b.real = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } %b.deinterleaved, 0
  %b.imag = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } %b.deinterleaved, 1
  %0 = sub <vscale x 8 x i8> %b.real, %a.imag
  %1 = add <vscale x 8 x i8> %b.imag, %a.real
  %interleaved.vec = tail call <vscale x 16 x i8> @llvm.experimental.vector.interleave2.nxv16i8(<vscale x 8 x i8> %0, <vscale x 8 x i8> %1)
  ret <vscale x 16 x i8> %interleaved.vec
}

; Expected to transform
define <vscale x 32 x i8> @complex_add_v32i8(<vscale x 32 x i8> %a, <vscale x 32 x i8> %b) {
; CHECK-LABEL: complex_add_v32i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    cadd z3.b, z3.b, z1.b, #90
; CHECK-NEXT:    cadd z2.b, z2.b, z0.b, #90
; CHECK-NEXT:    mov z0.d, z2.d
; CHECK-NEXT:    mov z1.d, z3.d
; CHECK-NEXT:    ret
entry:
  %a.deinterleaved = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.experimental.vector.deinterleave2.nxv32i8(<vscale x 32 x i8> %a)
  %a.real = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } %a.deinterleaved, 0
  %a.imag = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } %a.deinterleaved, 1
  %b.deinterleaved = tail call { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.experimental.vector.deinterleave2.nxv32i8(<vscale x 32 x i8> %b)
  %b.real = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } %b.deinterleaved, 0
  %b.imag = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } %b.deinterleaved, 1
  %0 = sub <vscale x 16 x i8> %b.real, %a.imag
  %1 = add <vscale x 16 x i8> %b.imag, %a.real
  %interleaved.vec = tail call <vscale x 32 x i8> @llvm.experimental.vector.interleave2.nxv32i8(<vscale x 16 x i8> %0, <vscale x 16 x i8> %1)
  ret <vscale x 32 x i8> %interleaved.vec
}

declare { <vscale x 4 x i8>, <vscale x 4 x i8> } @llvm.experimental.vector.deinterleave2.nxv8i8(<vscale x 8 x i8>)
declare <vscale x 8 x i8> @llvm.experimental.vector.interleave2.nxv8i8(<vscale x 4 x i8>, <vscale x 4 x i8>)

declare { <vscale x 8 x i8>, <vscale x 8 x i8> } @llvm.experimental.vector.deinterleave2.nxv16i8(<vscale x 16 x i8>)
declare <vscale x 16 x i8> @llvm.experimental.vector.interleave2.nxv16i8(<vscale x 8 x i8>, <vscale x 8 x i8>)

declare { <vscale x 16 x i8>, <vscale x 16 x i8> } @llvm.experimental.vector.deinterleave2.nxv32i8(<vscale x 32 x i8>)
declare <vscale x 32 x i8> @llvm.experimental.vector.interleave2.nxv32i8(<vscale x 16 x i8>, <vscale x 16 x i8>)