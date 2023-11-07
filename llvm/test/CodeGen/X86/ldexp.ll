; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=x86_64-unknown-unknown -verify-machineinstrs < %s | FileCheck -check-prefixes=X64 %s
; RUN: llc -mtriple=i386-pc-win32 -verify-machineinstrs < %s | FileCheck -check-prefix=WIN32 %s

define float @ldexp_f32(i8 zeroext %x) {
; X64-LABEL: ldexp_f32:
; X64:       # %bb.0:
; X64-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X64-NEXT:    jmp ldexpf@PLT # TAILCALL
;
; WIN32-LABEL: ldexp_f32:
; WIN32:       # %bb.0:
; WIN32-NEXT:    pushl %eax
; WIN32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; WIN32-NEXT:    cmpl $381, %ecx # imm = 0x17D
; WIN32-NEXT:    movl %ecx, %eax
; WIN32-NEXT:    jl LBB0_2
; WIN32-NEXT:  # %bb.1:
; WIN32-NEXT:    movl $381, %eax # imm = 0x17D
; WIN32-NEXT:  LBB0_2:
; WIN32-NEXT:    addl $-254, %eax
; WIN32-NEXT:    leal -127(%ecx), %edx
; WIN32-NEXT:    cmpl $255, %ecx
; WIN32-NEXT:    jae LBB0_4
; WIN32-NEXT:  # %bb.3:
; WIN32-NEXT:    movl %edx, %eax
; WIN32-NEXT:  LBB0_4:
; WIN32-NEXT:    flds __real@7f800000
; WIN32-NEXT:    flds __real@7f000000
; WIN32-NEXT:    jae LBB0_6
; WIN32-NEXT:  # %bb.5:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB0_6:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    cmpl $-329, %ecx # imm = 0xFEB7
; WIN32-NEXT:    movl %ecx, %edx
; WIN32-NEXT:    jge LBB0_8
; WIN32-NEXT:  # %bb.7:
; WIN32-NEXT:    movl $-330, %edx # imm = 0xFEB6
; WIN32-NEXT:  LBB0_8:
; WIN32-NEXT:    cmpl $-228, %ecx
; WIN32-NEXT:    fldz
; WIN32-NEXT:    flds __real@0c800000
; WIN32-NEXT:    jb LBB0_9
; WIN32-NEXT:  # %bb.10:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    leal 102(%ecx), %edx
; WIN32-NEXT:    cmpl $-126, %ecx
; WIN32-NEXT:    jge LBB0_12
; WIN32-NEXT:    jmp LBB0_13
; WIN32-NEXT:  LBB0_9:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    addl $204, %edx
; WIN32-NEXT:    cmpl $-126, %ecx
; WIN32-NEXT:    jl LBB0_13
; WIN32-NEXT:  LBB0_12:
; WIN32-NEXT:    movl %ecx, %edx
; WIN32-NEXT:  LBB0_13:
; WIN32-NEXT:    fld1
; WIN32-NEXT:    jl LBB0_15
; WIN32-NEXT:  # %bb.14:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB0_15:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    cmpl $127, %ecx
; WIN32-NEXT:    jg LBB0_17
; WIN32-NEXT:  # %bb.16:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    movl %edx, %eax
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB0_17:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    shll $23, %eax
; WIN32-NEXT:    addl $1065353216, %eax # imm = 0x3F800000
; WIN32-NEXT:    movl %eax, (%esp)
; WIN32-NEXT:    fmuls (%esp)
; WIN32-NEXT:    popl %eax
; WIN32-NEXT:    retl
  %zext = zext i8 %x to i32
  %ldexp = call float @llvm.ldexp.f32.i32(float 1.000000e+00, i32 %zext)
  ret float %ldexp
}

define double @ldexp_f64(i8 zeroext %x) {
; X64-LABEL: ldexp_f64:
; X64:       # %bb.0:
; X64-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    jmp ldexp@PLT # TAILCALL
;
; WIN32-LABEL: ldexp_f64:
; WIN32:       # %bb.0:
; WIN32-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; WIN32-NEXT:    pushl %eax
; WIN32-NEXT:    pushl $1072693248 # imm = 0x3FF00000
; WIN32-NEXT:    pushl $0
; WIN32-NEXT:    calll _ldexp
; WIN32-NEXT:    addl $12, %esp
; WIN32-NEXT:    retl
  %zext = zext i8 %x to i32
  %ldexp = call double @llvm.ldexp.f64.i32(double 1.000000e+00, i32 %zext)
  ret double %ldexp
}

define <2 x float> @ldexp_v2f32(<2 x float> %val, <2 x i32> %exp) {
; X64-LABEL: ldexp_v2f32:
; X64:       # %bb.0:
; X64-NEXT:    subq $56, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 64
; X64-NEXT:    movdqa %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; X64-NEXT:    movd %xmm1, %edi
; X64-NEXT:    callq ldexpf@PLT
; X64-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; X64-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X64-NEXT:    pshufd $85, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; X64-NEXT:    # xmm1 = mem[1,1,1,1]
; X64-NEXT:    movd %xmm1, %edi
; X64-NEXT:    callq ldexpf@PLT
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; X64-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; X64-NEXT:    movaps %xmm1, %xmm0
; X64-NEXT:    addq $56, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
;
; WIN32-LABEL: ldexp_v2f32:
; WIN32:       # %bb.0:
; WIN32-NEXT:    pushl %edi
; WIN32-NEXT:    pushl %esi
; WIN32-NEXT:    subl $8, %esp
; WIN32-NEXT:    flds {{[0-9]+}}(%esp)
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; WIN32-NEXT:    cmpl $-329, %eax # imm = 0xFEB7
; WIN32-NEXT:    movl %eax, %edx
; WIN32-NEXT:    jge LBB2_2
; WIN32-NEXT:  # %bb.1:
; WIN32-NEXT:    movl $-330, %edx # imm = 0xFEB6
; WIN32-NEXT:  LBB2_2:
; WIN32-NEXT:    addl $204, %edx
; WIN32-NEXT:    leal 102(%eax), %ecx
; WIN32-NEXT:    cmpl $-228, %eax
; WIN32-NEXT:    jb LBB2_4
; WIN32-NEXT:  # %bb.3:
; WIN32-NEXT:    movl %ecx, %edx
; WIN32-NEXT:  LBB2_4:
; WIN32-NEXT:    flds __real@0c800000
; WIN32-NEXT:    fld %st(1)
; WIN32-NEXT:    fmul %st(1), %st
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(2), %st
; WIN32-NEXT:    jb LBB2_6
; WIN32-NEXT:  # %bb.5:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:  LBB2_6:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    cmpl $-126, %eax
; WIN32-NEXT:    jl LBB2_8
; WIN32-NEXT:  # %bb.7:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    fld %st(1)
; WIN32-NEXT:    movl %eax, %edx
; WIN32-NEXT:  LBB2_8:
; WIN32-NEXT:    cmpl $381, %eax # imm = 0x17D
; WIN32-NEXT:    movl %eax, %esi
; WIN32-NEXT:    jl LBB2_10
; WIN32-NEXT:  # %bb.9:
; WIN32-NEXT:    movl $381, %esi # imm = 0x17D
; WIN32-NEXT:  LBB2_10:
; WIN32-NEXT:    flds __real@7f000000
; WIN32-NEXT:    fmul %st, %st(3)
; WIN32-NEXT:    fld %st(3)
; WIN32-NEXT:    fmul %st(1), %st
; WIN32-NEXT:    leal -127(%eax), %ecx
; WIN32-NEXT:    cmpl $255, %eax
; WIN32-NEXT:    jae LBB2_11
; WIN32-NEXT:  # %bb.12:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    jmp LBB2_13
; WIN32-NEXT:  LBB2_11:
; WIN32-NEXT:    fstp %st(4)
; WIN32-NEXT:    addl $-254, %esi
; WIN32-NEXT:    movl %esi, %ecx
; WIN32-NEXT:  LBB2_13:
; WIN32-NEXT:    cmpl $127, %eax
; WIN32-NEXT:    flds {{[0-9]+}}(%esp)
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; WIN32-NEXT:    jg LBB2_15
; WIN32-NEXT:  # %bb.14:
; WIN32-NEXT:    movl %edx, %ecx
; WIN32-NEXT:  LBB2_15:
; WIN32-NEXT:    cmpl $381, %esi # imm = 0x17D
; WIN32-NEXT:    movl %esi, %edx
; WIN32-NEXT:    jl LBB2_17
; WIN32-NEXT:  # %bb.16:
; WIN32-NEXT:    movl $381, %edx # imm = 0x17D
; WIN32-NEXT:  LBB2_17:
; WIN32-NEXT:    addl $-254, %edx
; WIN32-NEXT:    leal -127(%esi), %edi
; WIN32-NEXT:    cmpl $255, %esi
; WIN32-NEXT:    jae LBB2_19
; WIN32-NEXT:  # %bb.18:
; WIN32-NEXT:    movl %edi, %edx
; WIN32-NEXT:  LBB2_19:
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(2), %st
; WIN32-NEXT:    fmul %st, %st(2)
; WIN32-NEXT:    jae LBB2_21
; WIN32-NEXT:  # %bb.20:
; WIN32-NEXT:    fstp %st(2)
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB2_21:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    cmpl $-329, %esi # imm = 0xFEB7
; WIN32-NEXT:    movl %esi, %edi
; WIN32-NEXT:    jge LBB2_23
; WIN32-NEXT:  # %bb.22:
; WIN32-NEXT:    movl $-330, %edi # imm = 0xFEB6
; WIN32-NEXT:  LBB2_23:
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(4), %st
; WIN32-NEXT:    fmul %st, %st(4)
; WIN32-NEXT:    cmpl $-228, %esi
; WIN32-NEXT:    jb LBB2_24
; WIN32-NEXT:  # %bb.25:
; WIN32-NEXT:    fstp %st(4)
; WIN32-NEXT:    leal 102(%esi), %edi
; WIN32-NEXT:    cmpl $-126, %esi
; WIN32-NEXT:    jge LBB2_27
; WIN32-NEXT:    jmp LBB2_28
; WIN32-NEXT:  LBB2_24:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    addl $204, %edi
; WIN32-NEXT:    cmpl $-126, %esi
; WIN32-NEXT:    jl LBB2_28
; WIN32-NEXT:  LBB2_27:
; WIN32-NEXT:    fstp %st(3)
; WIN32-NEXT:    movl %esi, %edi
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB2_28:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    cmpl $127, %esi
; WIN32-NEXT:    jg LBB2_30
; WIN32-NEXT:  # %bb.29:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    movl %edi, %edx
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(2)
; WIN32-NEXT:  LBB2_30:
; WIN32-NEXT:    fstp %st(2)
; WIN32-NEXT:    cmpl $127, %eax
; WIN32-NEXT:    jg LBB2_32
; WIN32-NEXT:  # %bb.31:
; WIN32-NEXT:    fstp %st(2)
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB2_32:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    shll $23, %ecx
; WIN32-NEXT:    addl $1065353216, %ecx # imm = 0x3F800000
; WIN32-NEXT:    movl %ecx, (%esp)
; WIN32-NEXT:    shll $23, %edx
; WIN32-NEXT:    addl $1065353216, %edx # imm = 0x3F800000
; WIN32-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:    fmuls (%esp)
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:    fmuls {{[0-9]+}}(%esp)
; WIN32-NEXT:    addl $8, %esp
; WIN32-NEXT:    popl %esi
; WIN32-NEXT:    popl %edi
; WIN32-NEXT:    retl
  %1 = call <2 x float> @llvm.ldexp.v2f32.v2i32(<2 x float> %val, <2 x i32> %exp)
  ret <2 x float> %1
}

define <4 x float> @ldexp_v4f32(<4 x float> %val, <4 x i32> %exp) {
; X64-LABEL: ldexp_v4f32:
; X64:       # %bb.0:
; X64-NEXT:    subq $72, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 80
; X64-NEXT:    movdqa %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,3,3,3]
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[3,3,3,3]
; X64-NEXT:    movd %xmm2, %edi
; X64-NEXT:    callq ldexpf@PLT
; X64-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; X64-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; X64-NEXT:    pshufd $238, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; X64-NEXT:    # xmm1 = mem[2,3,2,3]
; X64-NEXT:    movd %xmm1, %edi
; X64-NEXT:    callq ldexpf@PLT
; X64-NEXT:    unpcklps (%rsp), %xmm0 # 16-byte Folded Reload
; X64-NEXT:    # xmm0 = xmm0[0],mem[0],xmm0[1],mem[1]
; X64-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; X64-NEXT:    movdqa {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; X64-NEXT:    movd %xmm0, %edi
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; X64-NEXT:    callq ldexpf@PLT
; X64-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; X64-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1,1,1]
; X64-NEXT:    pshufd $85, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; X64-NEXT:    # xmm1 = mem[1,1,1,1]
; X64-NEXT:    movd %xmm1, %edi
; X64-NEXT:    callq ldexpf@PLT
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; X64-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; X64-NEXT:    unpcklpd (%rsp), %xmm1 # 16-byte Folded Reload
; X64-NEXT:    # xmm1 = xmm1[0],mem[0]
; X64-NEXT:    movaps %xmm1, %xmm0
; X64-NEXT:    addq $72, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
;
; WIN32-LABEL: ldexp_v4f32:
; WIN32:       # %bb.0:
; WIN32-NEXT:    pushl %ebp
; WIN32-NEXT:    pushl %ebx
; WIN32-NEXT:    pushl %edi
; WIN32-NEXT:    pushl %esi
; WIN32-NEXT:    subl $32, %esp
; WIN32-NEXT:    flds {{[0-9]+}}(%esp)
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; WIN32-NEXT:    flds {{[0-9]+}}(%esp)
; WIN32-NEXT:    flds __real@7f000000
; WIN32-NEXT:    fld %st(1)
; WIN32-NEXT:    fmul %st(1), %st
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(2), %st
; WIN32-NEXT:    cmpl $255, %ecx
; WIN32-NEXT:    jae LBB3_2
; WIN32-NEXT:  # %bb.1:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:  LBB3_2:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    cmpl $-329, %ecx # imm = 0xFEB7
; WIN32-NEXT:    movl %ecx, %esi
; WIN32-NEXT:    jge LBB3_4
; WIN32-NEXT:  # %bb.3:
; WIN32-NEXT:    movl $-330, %esi # imm = 0xFEB6
; WIN32-NEXT:  LBB3_4:
; WIN32-NEXT:    addl $204, %esi
; WIN32-NEXT:    leal 102(%ecx), %eax
; WIN32-NEXT:    cmpl $-228, %ecx
; WIN32-NEXT:    jb LBB3_6
; WIN32-NEXT:  # %bb.5:
; WIN32-NEXT:    movl %eax, %esi
; WIN32-NEXT:  LBB3_6:
; WIN32-NEXT:    flds __real@0c800000
; WIN32-NEXT:    fld %st(3)
; WIN32-NEXT:    fmul %st(1), %st
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(2), %st
; WIN32-NEXT:    jb LBB3_8
; WIN32-NEXT:  # %bb.7:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:  LBB3_8:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    cmpl $-126, %ecx
; WIN32-NEXT:    jl LBB3_10
; WIN32-NEXT:  # %bb.9:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(4)
; WIN32-NEXT:  LBB3_10:
; WIN32-NEXT:    fstp %st(4)
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %edi
; WIN32-NEXT:    movl %ecx, %edx
; WIN32-NEXT:    subl $127, %edx
; WIN32-NEXT:    jg LBB3_12
; WIN32-NEXT:  # %bb.11:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(3)
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:  LBB3_12:
; WIN32-NEXT:    fstp %st(3)
; WIN32-NEXT:    fld %st(3)
; WIN32-NEXT:    fmul %st(2), %st
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(3), %st
; WIN32-NEXT:    cmpl $255, %edi
; WIN32-NEXT:    jae LBB3_14
; WIN32-NEXT:  # %bb.13:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:  LBB3_14:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:    fstps {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Spill
; WIN32-NEXT:    cmpl $-329, %edi # imm = 0xFEB7
; WIN32-NEXT:    movl %edi, %eax
; WIN32-NEXT:    jge LBB3_16
; WIN32-NEXT:  # %bb.15:
; WIN32-NEXT:    movl $-330, %eax # imm = 0xFEB6
; WIN32-NEXT:  LBB3_16:
; WIN32-NEXT:    fld %st(3)
; WIN32-NEXT:    fmul %st(3), %st
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(4), %st
; WIN32-NEXT:    cmpl $-228, %edi
; WIN32-NEXT:    jb LBB3_17
; WIN32-NEXT:  # %bb.18:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    leal 102(%edi), %eax
; WIN32-NEXT:    cmpl $-126, %edi
; WIN32-NEXT:    jge LBB3_20
; WIN32-NEXT:    jmp LBB3_21
; WIN32-NEXT:  LBB3_17:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    addl $204, %eax
; WIN32-NEXT:    cmpl $-126, %edi
; WIN32-NEXT:    jl LBB3_21
; WIN32-NEXT:  LBB3_20:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    movl %edi, %eax
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(4)
; WIN32-NEXT:  LBB3_21:
; WIN32-NEXT:    fstp %st(4)
; WIN32-NEXT:    movl %eax, (%esp) # 4-byte Spill
; WIN32-NEXT:    movl %edi, %ebx
; WIN32-NEXT:    subl $127, %ebx
; WIN32-NEXT:    jg LBB3_23
; WIN32-NEXT:  # %bb.22:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(3)
; WIN32-NEXT:  LBB3_23:
; WIN32-NEXT:    fstp %st(3)
; WIN32-NEXT:    cmpl $381, %edi # imm = 0x17D
; WIN32-NEXT:    movl %edi, %eax
; WIN32-NEXT:    jge LBB3_24
; WIN32-NEXT:  # %bb.25:
; WIN32-NEXT:    cmpl $255, %edi
; WIN32-NEXT:    jae LBB3_26
; WIN32-NEXT:  LBB3_27:
; WIN32-NEXT:    cmpl $-126, %ecx
; WIN32-NEXT:    jl LBB3_29
; WIN32-NEXT:  LBB3_28:
; WIN32-NEXT:    movl %ecx, %esi
; WIN32-NEXT:  LBB3_29:
; WIN32-NEXT:    cmpl $381, %ecx # imm = 0x17D
; WIN32-NEXT:    movl %ecx, %eax
; WIN32-NEXT:    jl LBB3_31
; WIN32-NEXT:  # %bb.30:
; WIN32-NEXT:    movl $381, %eax # imm = 0x17D
; WIN32-NEXT:  LBB3_31:
; WIN32-NEXT:    cmpl $255, %ecx
; WIN32-NEXT:    flds {{[0-9]+}}(%esp)
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; WIN32-NEXT:    jb LBB3_33
; WIN32-NEXT:  # %bb.32:
; WIN32-NEXT:    addl $-254, %eax
; WIN32-NEXT:    movl %eax, %edx
; WIN32-NEXT:  LBB3_33:
; WIN32-NEXT:    fxch %st(3)
; WIN32-NEXT:    fstps {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Spill
; WIN32-NEXT:    movl %esi, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; WIN32-NEXT:    cmpl $381, %ebp # imm = 0x17D
; WIN32-NEXT:    movl %ebp, %eax
; WIN32-NEXT:    jl LBB3_35
; WIN32-NEXT:  # %bb.34:
; WIN32-NEXT:    movl $381, %eax # imm = 0x17D
; WIN32-NEXT:  LBB3_35:
; WIN32-NEXT:    fld %st(2)
; WIN32-NEXT:    fmul %st(1), %st
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(2), %st
; WIN32-NEXT:    leal -127(%ebp), %edi
; WIN32-NEXT:    cmpl $255, %ebp
; WIN32-NEXT:    jae LBB3_36
; WIN32-NEXT:  # %bb.37:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    jmp LBB3_38
; WIN32-NEXT:  LBB3_24:
; WIN32-NEXT:    movl $381, %eax # imm = 0x17D
; WIN32-NEXT:    cmpl $255, %edi
; WIN32-NEXT:    jb LBB3_27
; WIN32-NEXT:  LBB3_26:
; WIN32-NEXT:    addl $-254, %eax
; WIN32-NEXT:    movl %eax, %ebx
; WIN32-NEXT:    cmpl $-126, %ecx
; WIN32-NEXT:    jge LBB3_28
; WIN32-NEXT:    jmp LBB3_29
; WIN32-NEXT:  LBB3_36:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    addl $-254, %eax
; WIN32-NEXT:    movl %eax, %edi
; WIN32-NEXT:  LBB3_38:
; WIN32-NEXT:    cmpl $-329, %ebp # imm = 0xFEB7
; WIN32-NEXT:    movl %ebp, %ecx
; WIN32-NEXT:    jge LBB3_40
; WIN32-NEXT:  # %bb.39:
; WIN32-NEXT:    movl $-330, %ecx # imm = 0xFEB6
; WIN32-NEXT:  LBB3_40:
; WIN32-NEXT:    addl $204, %ecx
; WIN32-NEXT:    leal 102(%ebp), %eax
; WIN32-NEXT:    cmpl $-228, %ebp
; WIN32-NEXT:    jb LBB3_42
; WIN32-NEXT:  # %bb.41:
; WIN32-NEXT:    movl %eax, %ecx
; WIN32-NEXT:  LBB3_42:
; WIN32-NEXT:    fld %st(3)
; WIN32-NEXT:    fmul %st(3), %st
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(4), %st
; WIN32-NEXT:    jb LBB3_44
; WIN32-NEXT:  # %bb.43:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:  LBB3_44:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    cmpl $-126, %ebp
; WIN32-NEXT:    jl LBB3_46
; WIN32-NEXT:  # %bb.45:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    movl %ebp, %ecx
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(4)
; WIN32-NEXT:  LBB3_46:
; WIN32-NEXT:    fstp %st(4)
; WIN32-NEXT:    cmpl $127, %ebp
; WIN32-NEXT:    flds {{[0-9]+}}(%esp)
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; WIN32-NEXT:    jg LBB3_48
; WIN32-NEXT:  # %bb.47:
; WIN32-NEXT:    movl %ecx, %edi
; WIN32-NEXT:  LBB3_48:
; WIN32-NEXT:    cmpl $381, %esi # imm = 0x17D
; WIN32-NEXT:    movl %esi, %ecx
; WIN32-NEXT:    jl LBB3_50
; WIN32-NEXT:  # %bb.49:
; WIN32-NEXT:    movl $381, %ecx # imm = 0x17D
; WIN32-NEXT:  LBB3_50:
; WIN32-NEXT:    addl $-254, %ecx
; WIN32-NEXT:    leal -127(%esi), %eax
; WIN32-NEXT:    cmpl $255, %esi
; WIN32-NEXT:    jae LBB3_52
; WIN32-NEXT:  # %bb.51:
; WIN32-NEXT:    movl %eax, %ecx
; WIN32-NEXT:  LBB3_52:
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(3), %st
; WIN32-NEXT:    fmul %st, %st(3)
; WIN32-NEXT:    jae LBB3_54
; WIN32-NEXT:  # %bb.53:
; WIN32-NEXT:    fstp %st(3)
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB3_54:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    cmpl $-329, %esi # imm = 0xFEB7
; WIN32-NEXT:    movl %esi, %eax
; WIN32-NEXT:    jge LBB3_56
; WIN32-NEXT:  # %bb.55:
; WIN32-NEXT:    movl $-330, %eax # imm = 0xFEB6
; WIN32-NEXT:  LBB3_56:
; WIN32-NEXT:    fld %st(0)
; WIN32-NEXT:    fmul %st(4), %st
; WIN32-NEXT:    fmul %st, %st(4)
; WIN32-NEXT:    cmpl $-228, %esi
; WIN32-NEXT:    jb LBB3_57
; WIN32-NEXT:  # %bb.58:
; WIN32-NEXT:    fstp %st(4)
; WIN32-NEXT:    leal 102(%esi), %eax
; WIN32-NEXT:    cmpl $-126, %esi
; WIN32-NEXT:    jge LBB3_60
; WIN32-NEXT:    jmp LBB3_61
; WIN32-NEXT:  LBB3_57:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    addl $204, %eax
; WIN32-NEXT:    cmpl $-126, %esi
; WIN32-NEXT:    jl LBB3_61
; WIN32-NEXT:  LBB3_60:
; WIN32-NEXT:    fstp %st(3)
; WIN32-NEXT:    movl %esi, %eax
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB3_61:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    cmpl $127, %esi
; WIN32-NEXT:    jg LBB3_63
; WIN32-NEXT:  # %bb.62:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    movl %eax, %ecx
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(2)
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:  LBB3_63:
; WIN32-NEXT:    fstp %st(2)
; WIN32-NEXT:    cmpl $127, {{[0-9]+}}(%esp)
; WIN32-NEXT:    jg LBB3_65
; WIN32-NEXT:  # %bb.64:
; WIN32-NEXT:    movl (%esp), %ebx # 4-byte Reload
; WIN32-NEXT:  LBB3_65:
; WIN32-NEXT:    cmpl $127, {{[0-9]+}}(%esp)
; WIN32-NEXT:    flds {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; WIN32-NEXT:    jg LBB3_67
; WIN32-NEXT:  # %bb.66:
; WIN32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; WIN32-NEXT:  LBB3_67:
; WIN32-NEXT:    cmpl $127, %ebp
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; WIN32-NEXT:    jg LBB3_69
; WIN32-NEXT:  # %bb.68:
; WIN32-NEXT:    fstp %st(2)
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(3)
; WIN32-NEXT:    fxch %st(2)
; WIN32-NEXT:  LBB3_69:
; WIN32-NEXT:    fstp %st(3)
; WIN32-NEXT:    shll $23, %edi
; WIN32-NEXT:    addl $1065353216, %edi # imm = 0x3F800000
; WIN32-NEXT:    movl %edi, {{[0-9]+}}(%esp)
; WIN32-NEXT:    shll $23, %ecx
; WIN32-NEXT:    addl $1065353216, %ecx # imm = 0x3F800000
; WIN32-NEXT:    movl %ecx, {{[0-9]+}}(%esp)
; WIN32-NEXT:    shll $23, %ebx
; WIN32-NEXT:    addl $1065353216, %ebx # imm = 0x3F800000
; WIN32-NEXT:    movl %ebx, {{[0-9]+}}(%esp)
; WIN32-NEXT:    shll $23, %edx
; WIN32-NEXT:    addl $1065353216, %edx # imm = 0x3F800000
; WIN32-NEXT:    movl %edx, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:    fmuls {{[0-9]+}}(%esp)
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:    fmuls {{[0-9]+}}(%esp)
; WIN32-NEXT:    flds {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Folded Reload
; WIN32-NEXT:    fmuls {{[0-9]+}}(%esp)
; WIN32-NEXT:    fxch %st(3)
; WIN32-NEXT:    fmuls {{[0-9]+}}(%esp)
; WIN32-NEXT:    fstps 12(%eax)
; WIN32-NEXT:    fxch %st(2)
; WIN32-NEXT:    fstps 8(%eax)
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:    fstps 4(%eax)
; WIN32-NEXT:    fstps (%eax)
; WIN32-NEXT:    addl $32, %esp
; WIN32-NEXT:    popl %esi
; WIN32-NEXT:    popl %edi
; WIN32-NEXT:    popl %ebx
; WIN32-NEXT:    popl %ebp
; WIN32-NEXT:    retl
  %1 = call <4 x float> @llvm.ldexp.v4f32.v4i32(<4 x float> %val, <4 x i32> %exp)
  ret <4 x float> %1
}

define <2 x double> @ldexp_v2f64(<2 x double> %val, <2 x i32> %exp) {
; X64-LABEL: ldexp_v2f64:
; X64:       # %bb.0:
; X64-NEXT:    subq $56, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 64
; X64-NEXT:    movdqa %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; X64-NEXT:    movd %xmm1, %edi
; X64-NEXT:    callq ldexp@PLT
; X64-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; X64-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; X64-NEXT:    pshufd $85, {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Folded Reload
; X64-NEXT:    # xmm1 = mem[1,1,1,1]
; X64-NEXT:    movd %xmm1, %edi
; X64-NEXT:    callq ldexp@PLT
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; X64-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; X64-NEXT:    movaps %xmm1, %xmm0
; X64-NEXT:    addq $56, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
;
; WIN32-LABEL: ldexp_v2f64:
; WIN32:       # %bb.0:
; WIN32-NEXT:    pushl %esi
; WIN32-NEXT:    subl $28, %esp
; WIN32-NEXT:    fldl {{[0-9]+}}(%esp)
; WIN32-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; WIN32-NEXT:    fldl {{[0-9]+}}(%esp)
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; WIN32-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fstpl (%esp)
; WIN32-NEXT:    calll _ldexp
; WIN32-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; WIN32-NEXT:    movl %esi, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; WIN32-NEXT:    fstpl (%esp)
; WIN32-NEXT:    calll _ldexp
; WIN32-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:    addl $28, %esp
; WIN32-NEXT:    popl %esi
; WIN32-NEXT:    retl
  %1 = call <2 x double> @llvm.ldexp.v2f64.v2i32(<2 x double> %val, <2 x i32> %exp)
  ret <2 x double> %1
}

define <4 x double> @ldexp_v4f64(<4 x double> %val, <4 x i32> %exp) {
; X64-LABEL: ldexp_v4f64:
; X64:       # %bb.0:
; X64-NEXT:    pushq %rbp
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    pushq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 24
; X64-NEXT:    subq $72, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 96
; X64-NEXT:    .cfi_offset %rbx, -24
; X64-NEXT:    .cfi_offset %rbp, -16
; X64-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movdqa %xmm2, (%rsp) # 16-byte Spill
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[2,3,2,3]
; X64-NEXT:    movd %xmm1, %ebx
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[3,3,3,3]
; X64-NEXT:    movd %xmm1, %ebp
; X64-NEXT:    movd %xmm2, %edi
; X64-NEXT:    callq ldexp@PLT
; X64-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; X64-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; X64-NEXT:    pshufd $85, (%rsp), %xmm1 # 16-byte Folded Reload
; X64-NEXT:    # xmm1 = mem[1,1,1,1]
; X64-NEXT:    movd %xmm1, %edi
; X64-NEXT:    callq ldexp@PLT
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; X64-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; X64-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; X64-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; X64-NEXT:    movl %ebp, %edi
; X64-NEXT:    callq ldexp@PLT
; X64-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; X64-NEXT:    movl %ebx, %edi
; X64-NEXT:    callq ldexp@PLT
; X64-NEXT:    movaps %xmm0, %xmm1
; X64-NEXT:    unpcklpd (%rsp), %xmm1 # 16-byte Folded Reload
; X64-NEXT:    # xmm1 = xmm1[0],mem[0]
; X64-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; X64-NEXT:    addq $72, %rsp
; X64-NEXT:    .cfi_def_cfa_offset 24
; X64-NEXT:    popq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    popq %rbp
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
;
; WIN32-LABEL: ldexp_v4f64:
; WIN32:       # %bb.0:
; WIN32-NEXT:    pushl %ebp
; WIN32-NEXT:    pushl %ebx
; WIN32-NEXT:    pushl %edi
; WIN32-NEXT:    pushl %esi
; WIN32-NEXT:    subl $44, %esp
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; WIN32-NEXT:    fldl {{[0-9]+}}(%esp)
; WIN32-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %edi
; WIN32-NEXT:    fldl {{[0-9]+}}(%esp)
; WIN32-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; WIN32-NEXT:    fldl {{[0-9]+}}(%esp)
; WIN32-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; WIN32-NEXT:    fldl {{[0-9]+}}(%esp)
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; WIN32-NEXT:    movl %eax, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fstpl (%esp)
; WIN32-NEXT:    calll _ldexp
; WIN32-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; WIN32-NEXT:    movl %ebp, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; WIN32-NEXT:    fstpl (%esp)
; WIN32-NEXT:    calll _ldexp
; WIN32-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; WIN32-NEXT:    movl %ebx, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; WIN32-NEXT:    fstpl (%esp)
; WIN32-NEXT:    calll _ldexp
; WIN32-NEXT:    fstpl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Spill
; WIN32-NEXT:    movl %edi, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; WIN32-NEXT:    fstpl (%esp)
; WIN32-NEXT:    calll _ldexp
; WIN32-NEXT:    fstpl 24(%esi)
; WIN32-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; WIN32-NEXT:    fstpl 16(%esi)
; WIN32-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; WIN32-NEXT:    fstpl 8(%esi)
; WIN32-NEXT:    fldl {{[-0-9]+}}(%e{{[sb]}}p) # 8-byte Folded Reload
; WIN32-NEXT:    fstpl (%esi)
; WIN32-NEXT:    movl %esi, %eax
; WIN32-NEXT:    addl $44, %esp
; WIN32-NEXT:    popl %esi
; WIN32-NEXT:    popl %edi
; WIN32-NEXT:    popl %ebx
; WIN32-NEXT:    popl %ebp
; WIN32-NEXT:    retl
  %1 = call <4 x double> @llvm.ldexp.v4f64.v4i32(<4 x double> %val, <4 x i32> %exp)
  ret <4 x double> %1
}

define half @ldexp_f16(half %arg0, i32 %arg1) {
; X64-LABEL: ldexp_f16:
; X64:       # %bb.0:
; X64-NEXT:    pushq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 16
; X64-NEXT:    .cfi_offset %rbx, -16
; X64-NEXT:    movl %edi, %ebx
; X64-NEXT:    callq __extendhfsf2@PLT
; X64-NEXT:    movl %ebx, %edi
; X64-NEXT:    callq ldexpf@PLT
; X64-NEXT:    callq __truncsfhf2@PLT
; X64-NEXT:    popq %rbx
; X64-NEXT:    .cfi_def_cfa_offset 8
; X64-NEXT:    retq
;
; WIN32-LABEL: ldexp_f16:
; WIN32:       # %bb.0:
; WIN32-NEXT:    pushl %edi
; WIN32-NEXT:    pushl %esi
; WIN32-NEXT:    subl $8, %esp
; WIN32-NEXT:    movl {{[0-9]+}}(%esp), %edi
; WIN32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; WIN32-NEXT:    movl %eax, (%esp)
; WIN32-NEXT:    cmpl $381, %edi # imm = 0x17D
; WIN32-NEXT:    movl %edi, %esi
; WIN32-NEXT:    jl LBB6_2
; WIN32-NEXT:  # %bb.1:
; WIN32-NEXT:    movl $381, %esi # imm = 0x17D
; WIN32-NEXT:  LBB6_2:
; WIN32-NEXT:    addl $-254, %esi
; WIN32-NEXT:    calll ___gnu_h2f_ieee
; WIN32-NEXT:    leal -127(%edi), %eax
; WIN32-NEXT:    cmpl $255, %edi
; WIN32-NEXT:    jae LBB6_4
; WIN32-NEXT:  # %bb.3:
; WIN32-NEXT:    movl %eax, %esi
; WIN32-NEXT:  LBB6_4:
; WIN32-NEXT:    flds __real@7f000000
; WIN32-NEXT:    fld %st(1)
; WIN32-NEXT:    fmul %st(1), %st
; WIN32-NEXT:    fmul %st, %st(1)
; WIN32-NEXT:    jae LBB6_6
; WIN32-NEXT:  # %bb.5:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    fldz
; WIN32-NEXT:  LBB6_6:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    cmpl $-329, %edi # imm = 0xFEB7
; WIN32-NEXT:    movl %edi, %eax
; WIN32-NEXT:    jge LBB6_8
; WIN32-NEXT:  # %bb.7:
; WIN32-NEXT:    movl $-330, %eax # imm = 0xFEB6
; WIN32-NEXT:  LBB6_8:
; WIN32-NEXT:    flds __real@0c800000
; WIN32-NEXT:    fld %st(2)
; WIN32-NEXT:    fmul %st(1), %st
; WIN32-NEXT:    fmul %st, %st(1)
; WIN32-NEXT:    cmpl $-228, %edi
; WIN32-NEXT:    jb LBB6_9
; WIN32-NEXT:  # %bb.10:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    leal 102(%edi), %eax
; WIN32-NEXT:    cmpl $-126, %edi
; WIN32-NEXT:    jge LBB6_12
; WIN32-NEXT:    jmp LBB6_13
; WIN32-NEXT:  LBB6_9:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    addl $204, %eax
; WIN32-NEXT:    cmpl $-126, %edi
; WIN32-NEXT:    jl LBB6_13
; WIN32-NEXT:  LBB6_12:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    movl %edi, %eax
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(2)
; WIN32-NEXT:  LBB6_13:
; WIN32-NEXT:    fstp %st(2)
; WIN32-NEXT:    cmpl $127, %edi
; WIN32-NEXT:    jg LBB6_15
; WIN32-NEXT:  # %bb.14:
; WIN32-NEXT:    fstp %st(0)
; WIN32-NEXT:    movl %eax, %esi
; WIN32-NEXT:    fldz
; WIN32-NEXT:    fxch %st(1)
; WIN32-NEXT:  LBB6_15:
; WIN32-NEXT:    fstp %st(1)
; WIN32-NEXT:    shll $23, %esi
; WIN32-NEXT:    addl $1065353216, %esi # imm = 0x3F800000
; WIN32-NEXT:    movl %esi, {{[0-9]+}}(%esp)
; WIN32-NEXT:    fmuls {{[0-9]+}}(%esp)
; WIN32-NEXT:    fstps (%esp)
; WIN32-NEXT:    calll ___gnu_f2h_ieee
; WIN32-NEXT:    addl $8, %esp
; WIN32-NEXT:    popl %esi
; WIN32-NEXT:    popl %edi
; WIN32-NEXT:    retl
  %ldexp = call half @llvm.ldexp.f16.i32(half %arg0, i32 %arg1)
  ret half %ldexp
}

declare double @llvm.ldexp.f64.i32(double, i32) #0
declare float @llvm.ldexp.f32.i32(float, i32) #0
declare <2 x float> @llvm.ldexp.v2f32.v2i32(<2 x float>, <2 x i32>) #0
declare <4 x float> @llvm.ldexp.v4f32.v4i32(<4 x float>, <4 x i32>) #0
declare <2 x double> @llvm.ldexp.v2f64.v2i32(<2 x double>, <2 x i32>) #0
declare <4 x double> @llvm.ldexp.v4f64.v4i32(<4 x double>, <4 x i32>) #0
declare half @llvm.ldexp.f16.i32(half, i32) #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
