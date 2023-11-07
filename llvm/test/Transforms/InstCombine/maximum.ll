; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

declare float @llvm.maximum.f32(float, float)
declare <2 x float> @llvm.maximum.v2f32(<2 x float>, <2 x float>)
declare <4 x float> @llvm.maximum.v4f32(<4 x float>, <4 x float>)

declare double @llvm.maximum.f64(double, double)
declare <2 x double> @llvm.maximum.v2f64(<2 x double>, <2 x double>)

define float @constant_fold_maximum_f32() {
; CHECK-LABEL: @constant_fold_maximum_f32(
; CHECK-NEXT:    ret float 2.000000e+00
;
  %x = call float @llvm.maximum.f32(float 1.0, float 2.0)
  ret float %x
}

define float @constant_fold_maximum_f32_inv() {
; CHECK-LABEL: @constant_fold_maximum_f32_inv(
; CHECK-NEXT:    ret float 2.000000e+00
;
  %x = call float @llvm.maximum.f32(float 2.0, float 1.0)
  ret float %x
}

define float @constant_fold_maximum_f32_nan0() {
; CHECK-LABEL: @constant_fold_maximum_f32_nan0(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %x = call float @llvm.maximum.f32(float 0x7FF8000000000000, float 2.0)
  ret float %x
}

define float @constant_fold_maximum_f32_nan1() {
; CHECK-LABEL: @constant_fold_maximum_f32_nan1(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %x = call float @llvm.maximum.f32(float 2.0, float 0x7FF8000000000000)
  ret float %x
}

define float @constant_fold_maximum_f32_nan_nan() {
; CHECK-LABEL: @constant_fold_maximum_f32_nan_nan(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %x = call float @llvm.maximum.f32(float 0x7FF8000000000000, float 0x7FF8000000000000)
  ret float %x
}

define float @constant_fold_maximum_f32_p0_p0() {
; CHECK-LABEL: @constant_fold_maximum_f32_p0_p0(
; CHECK-NEXT:    ret float 0.000000e+00
;
  %x = call float @llvm.maximum.f32(float 0.0, float 0.0)
  ret float %x
}

define float @constant_fold_maximum_f32_p0_n0() {
; CHECK-LABEL: @constant_fold_maximum_f32_p0_n0(
; CHECK-NEXT:    ret float 0.000000e+00
;
  %x = call float @llvm.maximum.f32(float 0.0, float -0.0)
  ret float %x
}

define float @constant_fold_maximum_f32_n0_p0() {
; CHECK-LABEL: @constant_fold_maximum_f32_n0_p0(
; CHECK-NEXT:    ret float 0.000000e+00
;
  %x = call float @llvm.maximum.f32(float -0.0, float 0.0)
  ret float %x
}

define float @constant_fold_maximum_f32_n0_n0() {
; CHECK-LABEL: @constant_fold_maximum_f32_n0_n0(
; CHECK-NEXT:    ret float -0.000000e+00
;
  %x = call float @llvm.maximum.f32(float -0.0, float -0.0)
  ret float %x
}

define <4 x float> @constant_fold_maximum_v4f32() {
; CHECK-LABEL: @constant_fold_maximum_v4f32(
; CHECK-NEXT:    ret <4 x float> <float 2.000000e+00, float 8.000000e+00, float 1.000000e+01, float 9.000000e+00>
;
  %x = call <4 x float> @llvm.maximum.v4f32(<4 x float> <float 1.0, float 8.0, float 3.0, float 9.0>, <4 x float> <float 2.0, float 2.0, float 10.0, float 5.0>)
  ret <4 x float> %x
}

define double @constant_fold_maximum_f64() {
; CHECK-LABEL: @constant_fold_maximum_f64(
; CHECK-NEXT:    ret double 2.000000e+00
;
  %x = call double @llvm.maximum.f64(double 1.0, double 2.0)
  ret double %x
}

define double @constant_fold_maximum_f64_nan0() {
; CHECK-LABEL: @constant_fold_maximum_f64_nan0(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %x = call double @llvm.maximum.f64(double 0x7FF8000000000000, double 2.0)
  ret double %x
}

define double @constant_fold_maximum_f64_nan1() {
; CHECK-LABEL: @constant_fold_maximum_f64_nan1(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %x = call double @llvm.maximum.f64(double 2.0, double 0x7FF8000000000000)
  ret double %x
}

define double @constant_fold_maximum_f64_nan_nan() {
; CHECK-LABEL: @constant_fold_maximum_f64_nan_nan(
; CHECK-NEXT:    ret double 0x7FF8000000000000
;
  %x = call double @llvm.maximum.f64(double 0x7FF8000000000000, double 0x7FF8000000000000)
  ret double %x
}

define float @canonicalize_constant_maximum_f32(float %x) {
; CHECK-LABEL: @canonicalize_constant_maximum_f32(
; CHECK-NEXT:    [[Y:%.*]] = call float @llvm.maximum.f32(float [[X:%.*]], float 1.000000e+00)
; CHECK-NEXT:    ret float [[Y]]
;
  %y = call float @llvm.maximum.f32(float 1.0, float %x)
  ret float %y
}

define float @maximum_f32_nan_val(float %x) {
; CHECK-LABEL: @maximum_f32_nan_val(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %y = call float @llvm.maximum.f32(float 0x7FF8000000000000, float %x)
  ret float %y
}

define float @maximum_f32_val_nan(float %x) {
; CHECK-LABEL: @maximum_f32_val_nan(
; CHECK-NEXT:    ret float 0x7FF8000000000000
;
  %y = call float @llvm.maximum.f32(float %x, float 0x7FF8000000000000)
  ret float %y
}

define float @maximum_f32_1_maximum_val_p0(float %x) {
; CHECK-LABEL: @maximum_f32_1_maximum_val_p0(
; CHECK-NEXT:    [[Z:%.*]] = call float @llvm.maximum.f32(float [[X:%.*]], float 1.000000e+00)
; CHECK-NEXT:    ret float [[Z]]
;
  %y = call float @llvm.maximum.f32(float %x, float 0.0)
  %z = call float @llvm.maximum.f32(float %y, float 1.0)
  ret float %z
}

define float @maximum_f32_1_maximum_p0_val_fast(float %x) {
; CHECK-LABEL: @maximum_f32_1_maximum_p0_val_fast(
; CHECK-NEXT:    [[Z:%.*]] = call float @llvm.maximum.f32(float [[X:%.*]], float 1.000000e+00)
; CHECK-NEXT:    ret float [[Z]]
;
  %y = call float @llvm.maximum.f32(float 0.0, float %x)
  %z = call fast float @llvm.maximum.f32(float %y, float 1.0)
  ret float %z
}

define float @maximum_f32_1_maximum_p0_val_fmf1(float %x) {
; CHECK-LABEL: @maximum_f32_1_maximum_p0_val_fmf1(
; CHECK-NEXT:    [[Z:%.*]] = call nnan arcp float @llvm.maximum.f32(float [[X:%.*]], float 1.000000e+00)
; CHECK-NEXT:    ret float [[Z]]
;
  %y = call arcp nnan float @llvm.maximum.f32(float 0.0, float %x)
  %z = call arcp nnan ninf float @llvm.maximum.f32(float %y, float 1.0)
  ret float %z
}

define float @maximum_f32_1_maximum_p0_val_fmf2(float %x) {
; CHECK-LABEL: @maximum_f32_1_maximum_p0_val_fmf2(
; CHECK-NEXT:    [[Z:%.*]] = call nnan float @llvm.maximum.f32(float [[X:%.*]], float 1.000000e+00)
; CHECK-NEXT:    ret float [[Z]]
;
  %y = call arcp nnan ninf float @llvm.maximum.f32(float 0.0, float %x)
  %z = call nnan float @llvm.maximum.f32(float %y, float 1.0)
  ret float %z
}

define float @maximum_f32_1_maximum_p0_val_fmf3(float %x) {
; CHECK-LABEL: @maximum_f32_1_maximum_p0_val_fmf3(
; CHECK-NEXT:    [[Z:%.*]] = call nnan ninf float @llvm.maximum.f32(float [[X:%.*]], float 1.000000e+00)
; CHECK-NEXT:    ret float [[Z]]
;
  %y = call nnan ninf float @llvm.maximum.f32(float 0.0, float %x)
  %z = call arcp nnan ninf float @llvm.maximum.f32(float %y, float 1.0)
  ret float %z
}

define float @maximum_f32_p0_maximum_val_n0(float %x) {
; CHECK-LABEL: @maximum_f32_p0_maximum_val_n0(
; CHECK-NEXT:    [[Z:%.*]] = call float @llvm.maximum.f32(float [[X:%.*]], float 0.000000e+00)
; CHECK-NEXT:    ret float [[Z]]
;
  %y = call float @llvm.maximum.f32(float %x, float -0.0)
  %z = call float @llvm.maximum.f32(float %y, float 0.0)
  ret float %z
}

define float @maximum_f32_1_maximum_p0_val(float %x) {
; CHECK-LABEL: @maximum_f32_1_maximum_p0_val(
; CHECK-NEXT:    [[Z:%.*]] = call float @llvm.maximum.f32(float [[X:%.*]], float 1.000000e+00)
; CHECK-NEXT:    ret float [[Z]]
;
  %y = call float @llvm.maximum.f32(float 0.0, float %x)
  %z = call float @llvm.maximum.f32(float %y, float 1.0)
  ret float %z
}

define <2 x float> @maximum_f32_1_maximum_val_p0_val_v2f32(<2 x float> %x) {
; CHECK-LABEL: @maximum_f32_1_maximum_val_p0_val_v2f32(
; CHECK-NEXT:    [[Z:%.*]] = call <2 x float> @llvm.maximum.v2f32(<2 x float> [[X:%.*]], <2 x float> <float 1.000000e+00, float 1.000000e+00>)
; CHECK-NEXT:    ret <2 x float> [[Z]]
;
  %y = call <2 x float> @llvm.maximum.v2f32(<2 x float> %x, <2 x float> zeroinitializer)
  %z = call <2 x float> @llvm.maximum.v2f32(<2 x float> %y, <2 x float><float 1.0, float 1.0>)
  ret <2 x float> %z
}

define float @maximum4(float %x, float %y, float %z, float %w) {
; CHECK-LABEL: @maximum4(
; CHECK-NEXT:    [[A:%.*]] = call float @llvm.maximum.f32(float [[X:%.*]], float [[Y:%.*]])
; CHECK-NEXT:    [[B:%.*]] = call float @llvm.maximum.f32(float [[Z:%.*]], float [[W:%.*]])
; CHECK-NEXT:    [[C:%.*]] = call float @llvm.maximum.f32(float [[A]], float [[B]])
; CHECK-NEXT:    ret float [[C]]
;
  %a = call float @llvm.maximum.f32(float %x, float %y)
  %b = call float @llvm.maximum.f32(float %z, float %w)
  %c = call float @llvm.maximum.f32(float %a, float %b)
  ret float %c
}

; PR37404 - https://bugs.llvm.org/show_bug.cgi?id=37404

define <2 x float> @neg_neg(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @neg_neg(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x float> @llvm.minimum.v2f32(<2 x float> [[X:%.*]], <2 x float> [[Y:%.*]])
; CHECK-NEXT:    [[R:%.*]] = fneg <2 x float> [[TMP1]]
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %negx = fsub <2 x float> <float -0.0, float -0.0>, %x
  %negy = fsub <2 x float> <float -0.0, float -0.0>, %y
  %r = call <2 x float> @llvm.maximum.v2f32(<2 x float> %negx, <2 x float> %negy)
  ret <2 x float> %r
}

define <2 x float> @unary_neg_neg(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @unary_neg_neg(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x float> @llvm.minimum.v2f32(<2 x float> [[X:%.*]], <2 x float> [[Y:%.*]])
; CHECK-NEXT:    [[R:%.*]] = fneg <2 x float> [[TMP1]]
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %negx = fneg <2 x float> %x
  %negy = fneg <2 x float> %y
  %r = call <2 x float> @llvm.maximum.v2f32(<2 x float> %negx, <2 x float> %negy)
  ret <2 x float> %r
}

; FMF is not required, but it should be propagated from the intrinsic (not the fnegs).

define float @neg_neg_vec_fmf(float %x, float %y) {
; CHECK-LABEL: @neg_neg_vec_fmf(
; CHECK-NEXT:    [[TMP1:%.*]] = call fast float @llvm.minimum.f32(float [[X:%.*]], float [[Y:%.*]])
; CHECK-NEXT:    [[R:%.*]] = fneg fast float [[TMP1]]
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fsub arcp float -0.0, %x
  %negy = fsub afn float -0.0, %y
  %r = call fast float @llvm.maximum.f32(float %negx, float %negy)
  ret float %r
}

define float @unary_neg_neg_vec_fmf(float %x, float %y) {
; CHECK-LABEL: @unary_neg_neg_vec_fmf(
; CHECK-NEXT:    [[TMP1:%.*]] = call fast float @llvm.minimum.f32(float [[X:%.*]], float [[Y:%.*]])
; CHECK-NEXT:    [[R:%.*]] = fneg fast float [[TMP1]]
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fneg arcp float %x
  %negy = fneg afn float %y
  %r = call fast float @llvm.maximum.f32(float %negx, float %negy)
  ret float %r
}

; 1 extra use of an intermediate value should still allow the fold,
; but 2 would require more instructions than we started with.

declare void @use(float)
define float @neg_neg_extra_use_x(float %x, float %y) {
; CHECK-LABEL: @neg_neg_extra_use_x(
; CHECK-NEXT:    [[NEGX:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call float @llvm.minimum.f32(float [[X]], float [[Y:%.*]])
; CHECK-NEXT:    [[R:%.*]] = fneg float [[TMP1]]
; CHECK-NEXT:    call void @use(float [[NEGX]])
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fsub float -0.0, %x
  %negy = fsub float -0.0, %y
  %r = call float @llvm.maximum.f32(float %negx, float %negy)
  call void @use(float %negx)
  ret float %r
}

define float @unary_neg_neg_extra_use_x(float %x, float %y) {
; CHECK-LABEL: @unary_neg_neg_extra_use_x(
; CHECK-NEXT:    [[NEGX:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call float @llvm.minimum.f32(float [[X]], float [[Y:%.*]])
; CHECK-NEXT:    [[R:%.*]] = fneg float [[TMP1]]
; CHECK-NEXT:    call void @use(float [[NEGX]])
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fneg float %x
  %negy = fneg float %y
  %r = call float @llvm.maximum.f32(float %negx, float %negy)
  call void @use(float %negx)
  ret float %r
}

define float @neg_neg_extra_use_y(float %x, float %y) {
; CHECK-LABEL: @neg_neg_extra_use_y(
; CHECK-NEXT:    [[NEGY:%.*]] = fneg float [[Y:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call float @llvm.minimum.f32(float [[X:%.*]], float [[Y]])
; CHECK-NEXT:    [[R:%.*]] = fneg float [[TMP1]]
; CHECK-NEXT:    call void @use(float [[NEGY]])
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fsub float -0.0, %x
  %negy = fsub float -0.0, %y
  %r = call float @llvm.maximum.f32(float %negx, float %negy)
  call void @use(float %negy)
  ret float %r
}

define float @unary_neg_neg_extra_use_y(float %x, float %y) {
; CHECK-LABEL: @unary_neg_neg_extra_use_y(
; CHECK-NEXT:    [[NEGY:%.*]] = fneg float [[Y:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call float @llvm.minimum.f32(float [[X:%.*]], float [[Y]])
; CHECK-NEXT:    [[R:%.*]] = fneg float [[TMP1]]
; CHECK-NEXT:    call void @use(float [[NEGY]])
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fneg float %x
  %negy = fneg float %y
  %r = call float @llvm.maximum.f32(float %negx, float %negy)
  call void @use(float %negy)
  ret float %r
}

define float @neg_neg_extra_use_x_and_y(float %x, float %y) {
; CHECK-LABEL: @neg_neg_extra_use_x_and_y(
; CHECK-NEXT:    [[NEGX:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    [[NEGY:%.*]] = fneg float [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.maximum.f32(float [[NEGX]], float [[NEGY]])
; CHECK-NEXT:    call void @use(float [[NEGX]])
; CHECK-NEXT:    call void @use(float [[NEGY]])
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fsub float -0.0, %x
  %negy = fsub float -0.0, %y
  %r = call float @llvm.maximum.f32(float %negx, float %negy)
  call void @use(float %negx)
  call void @use(float %negy)
  ret float %r
}

define float @unary_neg_neg_extra_use_x_and_y(float %x, float %y) {
; CHECK-LABEL: @unary_neg_neg_extra_use_x_and_y(
; CHECK-NEXT:    [[NEGX:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    [[NEGY:%.*]] = fneg float [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.maximum.f32(float [[NEGX]], float [[NEGY]])
; CHECK-NEXT:    call void @use(float [[NEGX]])
; CHECK-NEXT:    call void @use(float [[NEGY]])
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fneg float %x
  %negy = fneg float %y
  %r = call float @llvm.maximum.f32(float %negx, float %negy)
  call void @use(float %negx)
  call void @use(float %negy)
  ret float %r
}

define float @reduce_precision(float %x, float %y) {
; CHECK-LABEL: @reduce_precision(
; CHECK-NEXT:    [[MAXIMUM1:%.*]] = call float @llvm.maximum.f32(float [[X:%.*]], float [[Y:%.*]])
; CHECK-NEXT:    ret float [[MAXIMUM1]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %maximum = call double @llvm.maximum.f64(double %x.ext, double %y.ext)
  %trunc = fptrunc double %maximum to float
  ret float %trunc
}

define float @reduce_precision_fmf(float %x, float %y) {
; CHECK-LABEL: @reduce_precision_fmf(
; CHECK-NEXT:    [[MAXIMUM1:%.*]] = call nnan float @llvm.maximum.f32(float [[X:%.*]], float [[Y:%.*]])
; CHECK-NEXT:    ret float [[MAXIMUM1]]
;
  %x.ext = fpext float %x to double
  %y.ext = fpext float %y to double
  %maximum = call nnan double @llvm.maximum.f64(double %x.ext, double %y.ext)
  %trunc = fptrunc double %maximum to float
  ret float %trunc
}

define float @negated_op(float %x) {
; CHECK-LABEL: @negated_op(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.fabs.f32(float [[X:%.*]])
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fneg float %x
  %r = call float @llvm.maximum.f32(float %x, float %negx)
  ret float %r
}

define <2 x double> @negated_op_fmf_commute_vec(<2 x double> %x) {
; CHECK-LABEL: @negated_op_fmf_commute_vec(
; CHECK-NEXT:    [[R:%.*]] = call nnan ninf nsz <2 x double> @llvm.fabs.v2f64(<2 x double> [[X:%.*]])
; CHECK-NEXT:    ret <2 x double> [[R]]
;
  %negx = fneg <2 x double> %x
  %r = call nsz nnan ninf <2 x double> @llvm.maximum.v2f64(<2 x double> %negx, <2 x double> %x)
  ret <2 x double> %r
}

define float @negated_op_extra_use(float %x) {
; CHECK-LABEL: @negated_op_extra_use(
; CHECK-NEXT:    [[NEGX:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    call void @use(float [[NEGX]])
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.maximum.f32(float [[NEGX]], float [[X]])
; CHECK-NEXT:    ret float [[R]]
;
  %negx = fneg float %x
  call void @use(float %negx)
  %r = call float @llvm.maximum.f32(float %negx, float %x)
  ret float %r
}
