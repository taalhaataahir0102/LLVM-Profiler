; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=sccp -S %s | FileCheck %s

; When marking the edge from bb2 -> exit as executable first, %p will be NaN
; first and %v.1 will simplify to NaN. But when marking bb1 -> exit executable,
; %p will we overdefined and %v.1 will be simplified to 0.0. Make sure we go to
; overdefined, instead of crashing.
; TODO: Can we do better, i.e. choose the 'conservative' 0.0 initially?
define float @test1(float %a, i1 %bc) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[BC:%.*]], label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[P:%.*]] = phi float [ [[A:%.*]], [[BB1]] ], [ 0x7FF8000000000000, [[BB2]] ]
; CHECK-NEXT:    [[V_1:%.*]] = fmul float [[P]], 0.000000e+00
; CHECK-NEXT:    [[V_2:%.*]] = fadd float [[V_1]], 0xFFF8000000000000
; CHECK-NEXT:    ret float [[V_2]]
;
entry:
  br i1 %bc, label %bb1, label %bb2

bb1:
  br label %exit

bb2:
  br label %exit

exit:
  %p = phi float [ %a, %bb1 ], [ 0x7FF8000000000000, %bb2 ]
  %v.1 = fmul float %p, 0.000000e+00
  %v.2 = fadd float %v.1, 0xFFF8000000000000
  ret float %v.2
}

; Same as @test1, but with the incoming values switched.
define float @test2(float %a, i1 %bc) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[BC:%.*]], label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[P:%.*]] = phi float [ 0x7FF8000000000000, [[BB1]] ], [ [[A:%.*]], [[BB2]] ]
; CHECK-NEXT:    [[V_1:%.*]] = fmul float [[P]], 0.000000e+00
; CHECK-NEXT:    ret float 0xFFF8000000000000
;
entry:
  br i1 %bc, label %bb1, label %bb2

bb1:
  br label %exit

bb2:
  br label %exit

exit:
  %p = phi float [ 0x7FF8000000000000, %bb1 ], [ %a, %bb2 ]
  %v.1 = fmul float %p, 0.000000e+00
  %v.2 = fadd float %v.1, 0xFFF8000000000000
  ret float %v.2
}
