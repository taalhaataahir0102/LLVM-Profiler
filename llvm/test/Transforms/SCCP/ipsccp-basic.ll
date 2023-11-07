; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=ipsccp -S | FileCheck %s
; RUN: opt < %s -enable-debugify -passes=ipsccp -debugify-quiet -disable-output

;;======================== test1

define internal i32 @test1a(i32 %A) {
; CHECK-LABEL: define internal i32 @test1a
; CHECK-SAME: (i32 [[A:%.*]]) {
; CHECK-NEXT:    ret i32 undef
;
  %X = add i32 1, 2
  ret i32 %A
}

define i32 @test1b() {
; CHECK-LABEL: define i32 @test1b() {
; CHECK-NEXT:    [[X:%.*]] = call i32 @test1a(i32 17)
; CHECK-NEXT:    ret i32 17
;
  %X = call i32 @test1a( i32 17 )
  ret i32 %X

}



;;======================== test2

define internal i32 @test2a(i32 %A) {
; CHECK-LABEL: define internal i32 @test2a
; CHECK-SAME: (i32 [[A:%.*]]) {
; CHECK-NEXT:    br label [[T:%.*]]
; CHECK:       T:
; CHECK-NEXT:    [[B:%.*]] = call i32 @test2a(i32 0)
; CHECK-NEXT:    ret i32 undef
;
  %C = icmp eq i32 %A, 0
  br i1 %C, label %T, label %F
T:
  %B = call i32 @test2a( i32 0 )
  ret i32 0
F:
  %C.upgrd.1 = call i32 @test2a(i32 1)
  ret i32 %C.upgrd.1
}

define i32 @test2b() {
; CHECK-LABEL: define i32 @test2b() {
; CHECK-NEXT:    [[X:%.*]] = call i32 @test2a(i32 0)
; CHECK-NEXT:    ret i32 0
;
  %X = call i32 @test2a(i32 0)
  ret i32 %X
}

;;======================== test3

@G = internal global i32 undef

define void @test3a() {
; CHECK-LABEL: define void @test3a() {
; CHECK-NEXT:    [[X:%.*]] = load i32, ptr @G, align 4
; CHECK-NEXT:    store i32 [[X]], ptr @G, align 4
; CHECK-NEXT:    ret void
;
  %X = load i32, ptr @G
  store i32 %X, ptr @G
  ret void
}

define i32 @test3b() {
; CHECK-LABEL: define i32 @test3b() {
; CHECK-NEXT:    [[V:%.*]] = load i32, ptr @G, align 4
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[V]], 17
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       T:
; CHECK-NEXT:    store i32 17, ptr @G, align 4
; CHECK-NEXT:    ret i32 17
; CHECK:       F:
; CHECK-NEXT:    store i32 123, ptr @G, align 4
; CHECK-NEXT:    ret i32 0
;
  %V = load i32, ptr @G
  %C = icmp eq i32 %V, 17
  br i1 %C, label %T, label %F
T:
  store i32 17, ptr @G
  ret i32 %V
F:
  store i32 123, ptr @G
  ret i32 0
}

;;======================== test4

define internal {i64,i64} @test4a() {
; CHECK-LABEL: define internal { i64, i64 } @test4a() {
; CHECK-NEXT:    ret { i64, i64 } undef
;
  %a = insertvalue {i64,i64} undef, i64 4, 1
  %b = insertvalue {i64,i64} %a, i64 5, 0
  ret {i64,i64} %b
}

define i64 @test4b() personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: define i64 @test4b() personality ptr @__gxx_personality_v0 {
; CHECK-NEXT:    [[A:%.*]] = invoke { i64, i64 } @test4a()
; CHECK-NEXT:    to label [[A:%.*]] unwind label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    [[C:%.*]] = call i64 @test4c(i64 5)
; CHECK-NEXT:    ret i64 5
; CHECK:       B:
; CHECK-NEXT:    [[VAL:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    catch ptr null
; CHECK-NEXT:    ret i64 0
;
  %a = invoke {i64,i64} @test4a()
  to label %A unwind label %B
A:
  %b = extractvalue {i64,i64} %a, 0
  %c = call i64 @test4c(i64 %b)
  ret i64 %c
B:
  %val = landingpad { ptr, i32 }
  catch ptr null
  ret i64 0
}

define internal i64 @test4c(i64 %a) {
; CHECK-LABEL: define internal i64 @test4c
; CHECK-SAME: (i64 [[A:%.*]]) {
; CHECK-NEXT:    ret i64 undef
;
  ret i64 %a
}

;;======================== test5

; PR4313
define internal {i64,i64} @test5a() {
; CHECK-LABEL: define internal { i64, i64 } @test5a() {
; CHECK-NEXT:    ret { i64, i64 } undef
;
  %a = insertvalue {i64,i64} undef, i64 4, 1
  %b = insertvalue {i64,i64} %a, i64 5, 0
  ret {i64,i64} %b
}

define i64 @test5b() personality ptr @__gxx_personality_v0 {
; CHECK-LABEL: define i64 @test5b() personality ptr @__gxx_personality_v0 {
; CHECK-NEXT:    [[A:%.*]] = invoke { i64, i64 } @test5a()
; CHECK-NEXT:    to label [[A:%.*]] unwind label [[B:%.*]]
; CHECK:       A:
; CHECK-NEXT:    [[C:%.*]] = call i64 @test5c({ i64, i64 } { i64 5, i64 4 })
; CHECK-NEXT:    ret i64 5
; CHECK:       B:
; CHECK-NEXT:    [[VAL:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:    catch ptr null
; CHECK-NEXT:    ret i64 0
;
  %a = invoke {i64,i64} @test5a()
  to label %A unwind label %B
A:
  %c = call i64 @test5c({i64,i64} %a)
  ret i64 %c
B:
  %val = landingpad { ptr, i32 }
  catch ptr null
  ret i64 0
}

define internal i64 @test5c({i64,i64} %a) {
; CHECK-LABEL: define internal i64 @test5c
; CHECK-SAME: ({ i64, i64 } [[A:%.*]]) {
; CHECK-NEXT:    ret i64 undef
;
  %b = extractvalue {i64,i64} %a, 0
  ret i64 %b
}


;;======================== test6

define i64 @test6a() {
; CHECK-LABEL: define i64 @test6a() {
; CHECK-NEXT:    ret i64 0
;
  ret i64 0
}

define i64 @test6b() {
; CHECK-LABEL: define i64 @test6b() {
; CHECK-NEXT:    [[A:%.*]] = call i64 @test6a()
; CHECK-NEXT:    ret i64 0
;
  %a = call i64 @test6a()
  ret i64 %a
}

;;======================== test7

%T = type {i32,i32}

define internal %T @test7a(i32 %A) {
; CHECK-LABEL: define internal %T @test7a
; CHECK-SAME: (i32 [[A:%.*]]) {
; CHECK-NEXT:    ret [[T:%.*]] undef
;
  %X = add i32 1, %A
  %mrv0 = insertvalue %T undef, i32 %X, 0
  %mrv1 = insertvalue %T %mrv0, i32 %A, 1
  ret %T %mrv1
}

define i32 @test7b() {
; CHECK-LABEL: define i32 @test7b() {
; CHECK-NEXT:    [[X:%.*]] = call [[T:%.*]] @test7a(i32 17)
; CHECK-NEXT:    ret i32 36
;
  %X = call %T @test7a(i32 17)
  %Y = extractvalue %T %X, 0
  %Z = add i32 %Y, %Y
  ret i32 %Z
}

;;======================== test8


define internal {} @test8a(i32 %A, ptr %P) {
; CHECK-LABEL: define internal {} @test8a
; CHECK-SAME: (i32 [[A:%.*]], ptr [[P:%.*]]) {
; CHECK-NEXT:    store i32 5, ptr [[P]], align 4
; CHECK-NEXT:    ret {} undef
;
  store i32 %A, ptr %P
  ret {} {}
}

define void @test8b(ptr %P) {
; CHECK-LABEL: define void @test8b
; CHECK-SAME: (ptr [[P:%.*]]) {
; CHECK-NEXT:    [[X:%.*]] = call {} @test8a(i32 5, ptr [[P]])
; CHECK-NEXT:    ret void
;
  %X = call {} @test8a(i32 5, ptr %P)
  ret void
}

;;======================== test9

@test9g = internal global {  } zeroinitializer

define void @test9() {
; CHECK-LABEL: define void @test9() {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOCAL_FOO:%.*]] = alloca {}, align 8
; CHECK-NEXT:    store {} zeroinitializer, ptr [[LOCAL_FOO]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %local_foo = alloca {  }
  load {  }, ptr @test9g
  store {  } %0, ptr %local_foo
  ret void
}

declare i32 @__gxx_personality_v0(...)

;;======================== test10

define i32 @test10a() nounwind {
; CHECK-LABEL: define i32 @test10a
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @test10b(i32 undef)
; CHECK-NEXT:    ret i32 [[CALL]]
;
entry:
  %call = call i32 @test10b(i32 undef)
  ret i32 %call

}

define internal i32 @test10b(i32 %x) nounwind {
; CHECK-LABEL: define internal i32 @test10b
; CHECK-SAME: (i32 [[X:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[R:%.*]] = and i32 undef, 1
; CHECK-NEXT:    ret i32 [[R]]
;
entry:
  %r = and i32 %x, 1
  ret i32 %r
}

;;======================== test11

define i64 @test11a() {
; CHECK-LABEL: define i64 @test11a() {
; CHECK-NEXT:    [[XOR:%.*]] = xor i64 undef, undef
; CHECK-NEXT:    ret i64 [[XOR]]
;
  %xor = xor i64 undef, undef
  ret i64 %xor
}

define i64 @test11b() {
; CHECK-LABEL: define i64 @test11b() {
; CHECK-NEXT:    [[CALL1:%.*]] = call i64 @test11a()
; CHECK-NEXT:    [[CALL2:%.*]] = call i64 @llvm.ctpop.i64(i64 [[CALL1]])
; CHECK-NEXT:    ret i64 [[CALL2]]
;
  %call1 = call i64 @test11a()
  %call2 = call i64 @llvm.ctpop.i64(i64 %call1)
  ret i64 %call2
}

declare i64 @llvm.ctpop.i64(i64)

;;======================== test12
;; Ensure that a struct as an arg to a potentially constant-foldable
;; function does not crash SCCP (for now it'll just ignores it)

define i1 @test12() {
; CHECK-LABEL: define i1 @test12() {
; CHECK-NEXT:    [[C:%.*]] = call i1 @llvm.is.constant.sl_i32i32s({ i32, i32 } { i32 -1, i32 32 })
; CHECK-NEXT:    ret i1 [[C]]
;
  %c = call i1 @llvm.is.constant.sl_i32i32s({i32, i32} {i32 -1, i32 32})
  ret i1 %c
}

declare i1 @llvm.is.constant.sl_i32i32s({i32, i32} %a)
