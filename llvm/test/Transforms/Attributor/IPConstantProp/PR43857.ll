; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes --check-globals
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-annotate-decl-cs  -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,CGSCC

%struct.wobble = type { i32 }
%struct.zot = type { %struct.wobble, %struct.wobble, %struct.wobble }

declare dso_local fastcc float @bar(ptr noalias, <8 x i32>) unnamed_addr

define %struct.zot @widget(<8 x i32> %arg) local_unnamed_addr {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: define {{[^@]+}}@widget
; CHECK-SAME: (<8 x i32> [[ARG:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    ret [[STRUCT_ZOT:%.*]] undef
;
bb:
  ret %struct.zot undef
}

define void @baz(<8 x i32> %arg) local_unnamed_addr {
; TUNIT: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; TUNIT-LABEL: define {{[^@]+}}@baz
; TUNIT-SAME: (<8 x i32> [[ARG:%.*]]) local_unnamed_addr #[[ATTR0]] {
; TUNIT-NEXT:  bb:
; TUNIT-NEXT:    [[TRUETMP1:%.*]] = extractvalue [[STRUCT_ZOT:%.*]] undef, 0, 0
; TUNIT-NEXT:    ret void
;
; CGSCC: Function Attrs: mustprogress nofree nosync nounwind willreturn memory(none)
; CGSCC-LABEL: define {{[^@]+}}@baz
; CGSCC-SAME: (<8 x i32> [[ARG:%.*]]) local_unnamed_addr #[[ATTR1:[0-9]+]] {
; CGSCC-NEXT:  bb:
; CGSCC-NEXT:    ret void
;
bb:
  %tmp = call %struct.zot @widget(<8 x i32> %arg)
  %tmp1 = extractvalue %struct.zot %tmp, 0, 0
  ret void
}
;.
; TUNIT: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
;.
; CGSCC: attributes #[[ATTR0]] = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
; CGSCC: attributes #[[ATTR1]] = { mustprogress nofree nosync nounwind willreturn memory(none) }
;.
