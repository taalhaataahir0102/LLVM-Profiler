; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -passes=instcombine -instcombine-infinite-loop-threshold=2 -S < %s | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128-p7:32:32"
target triple = "x86_64-apple-macosx10.14.0"

; Function Attrs: nounwind ssp uwtable
define i64 @weird_identity_but_ok(i64 %sz) {
; CHECK-LABEL: define i64 @weird_identity_but_ok
; CHECK-SAME: (i64 [[SZ:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ne i64 [[SZ]], -1
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    ret i64 [[SZ]]
;
entry:
  %call = tail call ptr @malloc(i64 %sz)
  %calc_size = tail call i64 @llvm.objectsize.i64.p0(ptr %call, i1 false, i1 true, i1 true)
  tail call void @free(ptr %call)
  ret i64 %calc_size
}

define i64 @phis_are_neat(i1 %which) {
; CHECK-LABEL: define i64 @phis_are_neat
; CHECK-SAME: (i1 [[WHICH:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[WHICH]], label [[FIRST_LABEL:%.*]], label [[SECOND_LABEL:%.*]]
; CHECK:       first_label:
; CHECK-NEXT:    br label [[JOIN_LABEL:%.*]]
; CHECK:       second_label:
; CHECK-NEXT:    br label [[JOIN_LABEL]]
; CHECK:       join_label:
; CHECK-NEXT:    [[TMP0:%.*]] = phi i64 [ 10, [[FIRST_LABEL]] ], [ 30, [[SECOND_LABEL]] ]
; CHECK-NEXT:    ret i64 [[TMP0]]
;
entry:
  br i1 %which, label %first_label, label %second_label

first_label:
  %first_call = call ptr @malloc(i64 10)
  br label %join_label

second_label:
  %second_call = call ptr @malloc(i64 30)
  br label %join_label

join_label:
  %joined = phi ptr [ %first_call, %first_label ], [ %second_call, %second_label ]
  %calc_size = tail call i64 @llvm.objectsize.i64.p0(ptr %joined, i1 false, i1 true, i1 true)
  ret i64 %calc_size
}

define i64 @internal_pointer(i64 %sz) {
; CHECK-LABEL: define i64 @internal_pointer
; CHECK-SAME: (i64 [[SZ:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.usub.sat.i64(i64 [[SZ]], i64 2)
; CHECK-NEXT:    ret i64 [[TMP0]]
;
entry:
  %ptr = call ptr @malloc(i64 %sz)
  %ptr2 = getelementptr inbounds i8, ptr %ptr, i32 2
  %calc_size = call i64 @llvm.objectsize.i64.p0(ptr %ptr2, i1 false, i1 true, i1 true)
  ret i64 %calc_size
}

define i64 @uses_nullptr_no_fold() {
; CHECK-LABEL: define i64 @uses_nullptr_no_fold() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RES:%.*]] = call i64 @llvm.objectsize.i64.p0(ptr null, i1 false, i1 true, i1 true)
; CHECK-NEXT:    ret i64 [[RES]]
;
entry:
  %res = call i64 @llvm.objectsize.i64.p0(ptr null, i1 false, i1 true, i1 true)
  ret i64 %res
}

define i64 @uses_nullptr_fold() {
; CHECK-LABEL: define i64 @uses_nullptr_fold() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i64 0
;
entry:
  ; NOTE: the third parameter to this call is false, unlike above.
  %res = call i64 @llvm.objectsize.i64.p0(ptr null, i1 false, i1 false, i1 true)
  ret i64 %res
}

@d = common global i8 0, align 1
@c = common global i32 0, align 4

; Function Attrs: nounwind
define void @f() {
; CHECK-LABEL: define void @f() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DOTPR:%.*]] = load i32, ptr @c, align 4
; CHECK-NEXT:    [[TOBOOL4:%.*]] = icmp eq i32 [[DOTPR]], 0
; CHECK-NEXT:    br i1 [[TOBOOL4]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[DP_05:%.*]] = phi ptr [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ @d, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = tail call i64 @llvm.objectsize.i64.p0(ptr [[DP_05]], i1 false, i1 true, i1 true)
; CHECK-NEXT:    [[CONV:%.*]] = trunc i64 [[TMP0]] to i32
; CHECK-NEXT:    tail call void @bury(i32 [[CONV]])
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr @c, align 4
; CHECK-NEXT:    [[IDX_EXT:%.*]] = sext i32 [[TMP1]] to i64
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds i8, ptr [[DP_05]], i64 [[IDX_EXT]]
; CHECK-NEXT:    [[ADD:%.*]] = shl nsw i32 [[TMP1]], 1
; CHECK-NEXT:    store i32 [[ADD]], ptr @c, align 4
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %.pr = load i32, ptr @c, align 4
  %tobool4 = icmp eq i32 %.pr, 0
  br i1 %tobool4, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %dp.05 = phi ptr [ %add.ptr, %for.body ], [ @d, %entry ]
  %0 = tail call i64 @llvm.objectsize.i64.p0(ptr %dp.05, i1 false, i1 true, i1 true)
  %conv = trunc i64 %0 to i32
  tail call void @bury(i32 %conv) #3
  %1 = load i32, ptr @c, align 4
  %idx.ext = sext i32 %1 to i64
  %add.ptr.offs = add i64 %idx.ext, 0
  %2 = add i64 undef, %add.ptr.offs
  %add.ptr = getelementptr inbounds i8, ptr %dp.05, i64 %idx.ext
  %add = shl nsw i32 %1, 1
  store i32 %add, ptr @c, align 4
  %tobool = icmp eq i32 %1, 0
  br i1 %tobool, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @bdos_cmpm1(i64 %alloc) {
; CHECK-LABEL: define void @bdos_cmpm1
; CHECK-SAME: (i64 [[ALLOC:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[OBJ:%.*]] = call ptr @malloc(i64 [[ALLOC]])
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ne i64 [[ALLOC]], -1
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    br i1 false, label [[IF_ELSE:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    call void @fortified_chk(ptr [[OBJ]], i64 [[ALLOC]])
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %obj = call ptr @malloc(i64 %alloc)
  %objsize = call i64 @llvm.objectsize.i64.p0(ptr %obj, i1 0, i1 0, i1 1)
  %cmp.not = icmp eq i64 %objsize, -1
  br i1 %cmp.not, label %if.else, label %if.then

if.then:
  call void @fortified_chk(ptr %obj, i64 %objsize)
  br label %if.end

if.else:
  call void @unfortified(ptr %obj, i64 %objsize)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

define void @bdos_cmpm1_expr(i64 %alloc, i64 %part) {
; CHECK-LABEL: define void @bdos_cmpm1_expr
; CHECK-SAME: (i64 [[ALLOC:%.*]], i64 [[PART:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SZ:%.*]] = udiv i64 [[ALLOC]], [[PART]]
; CHECK-NEXT:    [[OBJ:%.*]] = call ptr @malloc(i64 [[SZ]])
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ne i64 [[SZ]], -1
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP0]])
; CHECK-NEXT:    br i1 false, label [[IF_ELSE:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    call void @fortified_chk(ptr [[OBJ]], i64 [[SZ]])
; CHECK-NEXT:    br label [[IF_END:%.*]]
; CHECK:       if.else:
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %sz = udiv i64 %alloc, %part
  %obj = call ptr @malloc(i64 %sz)
  %objsize = call i64 @llvm.objectsize.i64.p0(ptr %obj, i1 0, i1 0, i1 1)
  %cmp.not = icmp eq i64 %objsize, -1
  br i1 %cmp.not, label %if.else, label %if.then

if.then:
  call void @fortified_chk(ptr %obj, i64 %objsize)
  br label %if.end

if.else:
  call void @unfortified(ptr %obj, i64 %objsize)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

@p7 = internal addrspace(7) global i8 0

; Gracefully handle AS cast when the address spaces have different pointer widths.
define i64 @as_cast(i1 %c) {
; CHECK-LABEL: define i64 @as_cast
; CHECK-SAME: (i1 [[C:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = select i1 [[C]], i64 64, i64 0
; CHECK-NEXT:    ret i64 [[TMP0]]
;
entry:
  %p0 = tail call ptr @malloc(i64 64)
  %gep = getelementptr i8, ptr addrspace(7) @p7, i32 1
  %as = addrspacecast ptr addrspace(7) %gep to ptr
  %select = select i1 %c, ptr %p0, ptr %as
  %calc_size = tail call i64 @llvm.objectsize.i64.p0(ptr %select, i1 false, i1 true, i1 true)
  ret i64 %calc_size
}

define i64 @constexpr_as_cast(i1 %c) {
; CHECK-LABEL: define i64 @constexpr_as_cast
; CHECK-SAME: (i1 [[C:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = select i1 [[C]], i64 64, i64 0
; CHECK-NEXT:    ret i64 [[TMP0]]
;
entry:
  %p0 = tail call ptr @malloc(i64 64)
  %select = select i1 %c, ptr %p0, ptr addrspacecast (ptr addrspace(7) getelementptr (i8, ptr addrspace(7) @p7, i32 1) to ptr)
  %calc_size = tail call i64 @llvm.objectsize.i64.p0(ptr %select, i1 false, i1 true, i1 true)
  ret i64 %calc_size
}

declare void @bury(i32) local_unnamed_addr #2

; Function Attrs: nounwind allocsize(0)
declare ptr @malloc(i64) nounwind allocsize(0) allockind("alloc,uninitialized") "alloc-family"="malloc"

declare ptr @get_unknown_buffer()

; Function Attrs: nounwind
declare void @free(ptr nocapture) nounwind allockind("free") "alloc-family"="malloc"

; Function Attrs: nounwind readnone speculatable
declare i64 @llvm.objectsize.i64.p0(ptr, i1, i1, i1)

declare void @fortified_chk(ptr, i64)

declare void @unfortified(ptr, i64)
