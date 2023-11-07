; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=mergeicmps < %s | FileCheck %s

target triple = "x86_64-unknown-linux-gnu"

%"struct.a::c" = type { i32, ptr, ptr }

; The entry block cannot be merged as the comparison is not continuous.
; While it compares the highest address, it should not be moved after the
; other comparisons, as that would make the allocas non-dominating.

define i1 @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  "land.lhs.true+entry":
; CHECK-NEXT:    [[H:%.*]] = alloca %"struct.a::c", align 8
; CHECK-NEXT:    [[I:%.*]] = alloca %"struct.a::c", align 8
; CHECK-NEXT:    call void @init(ptr [[H]])
; CHECK-NEXT:    call void @init(ptr [[I]])
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds %"struct.a::c", ptr [[H]], i64 0, i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds %"struct.a::c", ptr [[I]], i64 0, i32 1
; CHECK-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(ptr [[TMP0]], ptr [[TMP1]], i64 16)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[MEMCMP]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[LAND_RHS1:%.*]], label [[LAND_END:%.*]]
; CHECK:       land.rhs1:
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr [[H]], align 8
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[I]], align 8
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP3]], [[TMP4]]
; CHECK-NEXT:    br label [[LAND_END]]
; CHECK:       land.end:
; CHECK-NEXT:    [[V9:%.*]] = phi i1 [ [[TMP5]], [[LAND_RHS1]] ], [ false, %"land.lhs.true+entry" ]
; CHECK-NEXT:    ret i1 [[V9]]
;
entry:
  %h = alloca %"struct.a::c", align 8
  %i = alloca %"struct.a::c", align 8
  call void @init(ptr %h)
  call void @init(ptr %i)
  %e = getelementptr inbounds %"struct.a::c", ptr %h, i64 0, i32 2
  %v3 = load ptr, ptr %e, align 8
  %e2 = getelementptr inbounds %"struct.a::c", ptr %i, i64 0, i32 2
  %v4 = load ptr, ptr %e2, align 8
  %cmp = icmp eq ptr %v3, %v4
  br i1 %cmp, label %land.lhs.true, label %land.end

land.lhs.true:                                    ; preds = %entry
  %d = getelementptr inbounds %"struct.a::c", ptr %h, i64 0, i32 1
  %v5 = load ptr, ptr %d, align 8
  %d3 = getelementptr inbounds %"struct.a::c", ptr %i, i64 0, i32 1
  %v6 = load ptr, ptr %d3, align 8
  %cmp4 = icmp eq ptr %v5, %v6
  br i1 %cmp4, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %land.lhs.true
  %v7 = load i32, ptr %h, align 8
  %v8 = load i32, ptr %i, align 8
  %cmp6 = icmp eq i32 %v7, %v8
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %entry
  %v9 = phi i1 [ false, %land.lhs.true ], [ false, %entry ], [ %cmp6, %land.rhs ]
  ret i1 %v9
}

declare void @init(ptr)
