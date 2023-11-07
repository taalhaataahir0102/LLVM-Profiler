; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=irce -S < %s | FileCheck %s
; RUN: opt -passes='require<branch-prob>,irce' -S < %s | FileCheck %s

@array = external global [1528 x i16], align 1

; Make sure we do not crash here.
define void @test_01() {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[CONT48:%.*]]
; CHECK:       cont48:
; CHECK-NEXT:    [[A2_0121:%.*]] = phi ptr [ [[ADD_PTR74:%.*]], [[CONT76:%.*]] ], [ @array, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[I41_0119:%.*]] = phi i16 [ [[ADD73:%.*]], [[CONT76]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    [[ADD73]] = add nuw nsw i16 [[I41_0119]], 2
; CHECK-NEXT:    [[ADD_PTR74]] = getelementptr inbounds i16, ptr [[A2_0121]], i16 2
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ult ptr [[A2_0121]], inttoptr (i16 -2 to ptr)
; CHECK-NEXT:    br i1 [[TMP0]], label [[CONT76]], label [[HANDLER_POINTER_OVERFLOW75:%.*]]
; CHECK:       handler.pointer_overflow75:
; CHECK-NEXT:    unreachable
; CHECK:       cont76:
; CHECK-NEXT:    [[CMP43:%.*]] = icmp ult i16 [[ADD73]], 16
; CHECK-NEXT:    br i1 [[CMP43]], label [[CONT48]], label [[FOR_END77:%.*]]
; CHECK:       for.end77:
; CHECK-NEXT:    unreachable
;
entry:
  br label %cont48

cont48:                                           ; preds = %cont76, %entry
  %a2.0121 = phi ptr [ %add.ptr74, %cont76 ], [ @array, %entry ]
  %i41.0119 = phi i16 [ %add73, %cont76 ], [ 0, %entry ]
  %add73 = add nuw nsw i16 %i41.0119, 2
  %add.ptr74 = getelementptr inbounds i16, ptr %a2.0121, i16 2
  %0 = icmp ult ptr %a2.0121, inttoptr (i16 -2 to ptr)
  br i1 %0, label %cont76, label %handler.pointer_overflow75

handler.pointer_overflow75:                       ; preds = %cont48
  unreachable

cont76:                                           ; preds = %cont48
  %cmp43 = icmp ult i16 %add73, 16
  br i1 %cmp43, label %cont48, label %for.end77

for.end77:                                        ; preds = %cont76
  unreachable
}
