; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -disable-wasm-fallthrough-return-opt -wasm-keep-registers | FileCheck %s

; Test that basic 64-bit floating-point comparison operations assemble as
; expected.

target triple = "wasm32-unknown-unknown"

define i32 @ord_f64(double %x, double %y) {
; CHECK-LABEL: ord_f64:
; CHECK:         .functype ord_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push4=, 0
; CHECK-NEXT:    local.get $push3=, 0
; CHECK-NEXT:    f64.eq $push1=, $pop4, $pop3
; CHECK-NEXT:    local.get $push6=, 1
; CHECK-NEXT:    local.get $push5=, 1
; CHECK-NEXT:    f64.eq $push0=, $pop6, $pop5
; CHECK-NEXT:    i32.and $push2=, $pop1, $pop0
; CHECK-NEXT:    return $pop2
  %a = fcmp ord double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @uno_f64(double %x, double %y) {
; CHECK-LABEL: uno_f64:
; CHECK:         .functype uno_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push4=, 0
; CHECK-NEXT:    local.get $push3=, 0
; CHECK-NEXT:    f64.ne $push1=, $pop4, $pop3
; CHECK-NEXT:    local.get $push6=, 1
; CHECK-NEXT:    local.get $push5=, 1
; CHECK-NEXT:    f64.ne $push0=, $pop6, $pop5
; CHECK-NEXT:    i32.or $push2=, $pop1, $pop0
; CHECK-NEXT:    return $pop2
  %a = fcmp uno double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @oeq_f64(double %x, double %y) {
; CHECK-LABEL: oeq_f64:
; CHECK:         .functype oeq_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.eq $push0=, $pop2, $pop1
; CHECK-NEXT:    return $pop0
  %a = fcmp oeq double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @une_f64(double %x, double %y) {
; CHECK-LABEL: une_f64:
; CHECK:         .functype une_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.ne $push0=, $pop2, $pop1
; CHECK-NEXT:    return $pop0
  %a = fcmp une double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @olt_f64(double %x, double %y) {
; CHECK-LABEL: olt_f64:
; CHECK:         .functype olt_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.lt $push0=, $pop2, $pop1
; CHECK-NEXT:    return $pop0
  %a = fcmp olt double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @ole_f64(double %x, double %y) {
; CHECK-LABEL: ole_f64:
; CHECK:         .functype ole_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.le $push0=, $pop2, $pop1
; CHECK-NEXT:    return $pop0
  %a = fcmp ole double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @ogt_f64(double %x, double %y) {
; CHECK-LABEL: ogt_f64:
; CHECK:         .functype ogt_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.gt $push0=, $pop2, $pop1
; CHECK-NEXT:    return $pop0
  %a = fcmp ogt double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @oge_f64(double %x, double %y) {
; CHECK-LABEL: oge_f64:
; CHECK:         .functype oge_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.ge $push0=, $pop2, $pop1
; CHECK-NEXT:    return $pop0
  %a = fcmp oge double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

; Expanded comparisons, which also check for NaN.

define i32 @ueq_f64(double %x, double %y) {
; CHECK-LABEL: ueq_f64:
; CHECK:         .functype ueq_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push6=, 0
; CHECK-NEXT:    local.get $push5=, 1
; CHECK-NEXT:    f64.gt $push1=, $pop6, $pop5
; CHECK-NEXT:    local.get $push8=, 0
; CHECK-NEXT:    local.get $push7=, 1
; CHECK-NEXT:    f64.lt $push0=, $pop8, $pop7
; CHECK-NEXT:    i32.or $push2=, $pop1, $pop0
; CHECK-NEXT:    i32.const $push3=, 1
; CHECK-NEXT:    i32.xor $push4=, $pop2, $pop3
; CHECK-NEXT:    return $pop4
  %a = fcmp ueq double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @one_f64(double %x, double %y) {
; CHECK-LABEL: one_f64:
; CHECK:         .functype one_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push4=, 0
; CHECK-NEXT:    local.get $push3=, 1
; CHECK-NEXT:    f64.gt $push1=, $pop4, $pop3
; CHECK-NEXT:    local.get $push6=, 0
; CHECK-NEXT:    local.get $push5=, 1
; CHECK-NEXT:    f64.lt $push0=, $pop6, $pop5
; CHECK-NEXT:    i32.or $push2=, $pop1, $pop0
; CHECK-NEXT:    return $pop2
  %a = fcmp one double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @ult_f64(double %x, double %y) {
; CHECK-LABEL: ult_f64:
; CHECK:         .functype ult_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push4=, 0
; CHECK-NEXT:    local.get $push3=, 1
; CHECK-NEXT:    f64.ge $push0=, $pop4, $pop3
; CHECK-NEXT:    i32.const $push1=, 1
; CHECK-NEXT:    i32.xor $push2=, $pop0, $pop1
; CHECK-NEXT:    return $pop2
  %a = fcmp ult double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @ule_f64(double %x, double %y) {
; CHECK-LABEL: ule_f64:
; CHECK:         .functype ule_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push4=, 0
; CHECK-NEXT:    local.get $push3=, 1
; CHECK-NEXT:    f64.gt $push0=, $pop4, $pop3
; CHECK-NEXT:    i32.const $push1=, 1
; CHECK-NEXT:    i32.xor $push2=, $pop0, $pop1
; CHECK-NEXT:    return $pop2
  %a = fcmp ule double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @ugt_f64(double %x, double %y) {
; CHECK-LABEL: ugt_f64:
; CHECK:         .functype ugt_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push4=, 0
; CHECK-NEXT:    local.get $push3=, 1
; CHECK-NEXT:    f64.le $push0=, $pop4, $pop3
; CHECK-NEXT:    i32.const $push1=, 1
; CHECK-NEXT:    i32.xor $push2=, $pop0, $pop1
; CHECK-NEXT:    return $pop2
  %a = fcmp ugt double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define i32 @uge_f64(double %x, double %y) {
; CHECK-LABEL: uge_f64:
; CHECK:         .functype uge_f64 (f64, f64) -> (i32)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    local.get $push4=, 0
; CHECK-NEXT:    local.get $push3=, 1
; CHECK-NEXT:    f64.lt $push0=, $pop4, $pop3
; CHECK-NEXT:    i32.const $push1=, 1
; CHECK-NEXT:    i32.xor $push2=, $pop0, $pop1
; CHECK-NEXT:    return $pop2
  %a = fcmp uge double %x, %y
  %b = zext i1 %a to i32
  ret i32 %b
}

define void @olt_f64_branch(double %a, double %b) {
; CHECK-LABEL: olt_f64_branch:
; CHECK:         .functype olt_f64_branch (f64, f64) -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.lt $push0=, $pop2, $pop1
; CHECK-NEXT:    i32.eqz $push3=, $pop0
; CHECK-NEXT:    br_if 0, $pop3 # 0: down to label0
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    call call1
; CHECK-NEXT:  .LBB14_2: # %if.end
; CHECK-NEXT:    end_block # label0:
; CHECK-NEXT:    return
entry:
  %cmp = fcmp olt double %a, %b
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @call1()
  br label %if.end

if.end:
  ret void
}

define void @ole_f64_branch(double %a, double %b) {
; CHECK-LABEL: ole_f64_branch:
; CHECK:         .functype ole_f64_branch (f64, f64) -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.le $push0=, $pop2, $pop1
; CHECK-NEXT:    i32.eqz $push3=, $pop0
; CHECK-NEXT:    br_if 0, $pop3 # 0: down to label1
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    call call1
; CHECK-NEXT:  .LBB15_2: # %if.end
; CHECK-NEXT:    end_block # label1:
; CHECK-NEXT:    return
entry:
  %cmp = fcmp ole double %a, %b
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @call1()
  br label %if.end

if.end:
  ret void
}

define void @ugt_f64_branch(double %a, double %b) {
; CHECK-LABEL: ugt_f64_branch:
; CHECK:         .functype ugt_f64_branch (f64, f64) -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.le $push0=, $pop2, $pop1
; CHECK-NEXT:    i32.eqz $push3=, $pop0
; CHECK-NEXT:    br_if 0, $pop3 # 0: down to label2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    call call1
; CHECK-NEXT:  .LBB16_2: # %if.end
; CHECK-NEXT:    end_block # label2:
; CHECK-NEXT:    return
entry:
  %cmp = fcmp ugt double %a, %b
  br i1 %cmp, label %if.end, label %if.then

if.then:
  tail call void @call1()
  br label %if.end

if.end:
  ret void
}

define void @ogt_f64_branch(double %a, double %b) {
; CHECK-LABEL: ogt_f64_branch:
; CHECK:         .functype ogt_f64_branch (f64, f64) -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.gt $push0=, $pop2, $pop1
; CHECK-NEXT:    i32.eqz $push3=, $pop0
; CHECK-NEXT:    br_if 0, $pop3 # 0: down to label3
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    call call1
; CHECK-NEXT:  .LBB17_2: # %if.end
; CHECK-NEXT:    end_block # label3:
; CHECK-NEXT:    return
entry:
  %cmp = fcmp ogt double %a, %b
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @call1()
  br label %if.end

if.end:
  ret void
}

define void @ult_f64_branch(double %a, double %b) {
; CHECK-LABEL: ult_f64_branch:
; CHECK:         .functype ult_f64_branch (f64, f64) -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.ge $push0=, $pop2, $pop1
; CHECK-NEXT:    i32.eqz $push3=, $pop0
; CHECK-NEXT:    br_if 0, $pop3 # 0: down to label4
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    call call1
; CHECK-NEXT:  .LBB18_2: # %if.end
; CHECK-NEXT:    end_block # label4:
; CHECK-NEXT:    return
entry:
  %cmp = fcmp ult double %a, %b
  br i1 %cmp, label %if.end, label %if.then

if.then:
  tail call void @call1()
  br label %if.end

if.end:
  ret void
}

define void @ule_f64_branch(double %a, double %b) {
; CHECK-LABEL: ule_f64_branch:
; CHECK:         .functype ule_f64_branch (f64, f64) -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    local.get $push2=, 0
; CHECK-NEXT:    local.get $push1=, 1
; CHECK-NEXT:    f64.gt $push0=, $pop2, $pop1
; CHECK-NEXT:    i32.eqz $push3=, $pop0
; CHECK-NEXT:    br_if 0, $pop3 # 0: down to label5
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    call call1
; CHECK-NEXT:  .LBB19_2: # %if.end
; CHECK-NEXT:    end_block # label5:
; CHECK-NEXT:    return
entry:
  %cmp = fcmp ule double %a, %b
  br i1 %cmp, label %if.end, label %if.then

if.then:
  tail call void @call1()
  br label %if.end

if.end:
  ret void
}

define void @xor_zext_switch(double %a, double %b) {
; CHECK-LABEL: xor_zext_switch:
; CHECK:         .functype xor_zext_switch (f64, f64) -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    i32.const $push1=, 0
; CHECK-NEXT:    br_if 0, $pop1 # 0: down to label6
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    block
; CHECK-NEXT:    local.get $push3=, 0
; CHECK-NEXT:    local.get $push2=, 1
; CHECK-NEXT:    f64.ge $push0=, $pop3, $pop2
; CHECK-NEXT:    br_table $pop0, 0, 1, 0 # 0: down to label8
; CHECK-NEXT:    # 1: down to label7
; CHECK-NEXT:  .LBB20_2: # %sw.bb.1
; CHECK-NEXT:    end_block # label8:
; CHECK-NEXT:    call foo1
; CHECK-NEXT:    return
; CHECK-NEXT:  .LBB20_3: # %sw.bb.2
; CHECK-NEXT:    end_block # label7:
; CHECK-NEXT:    call foo2
; CHECK-NEXT:  .LBB20_4: # %exit
; CHECK-NEXT:    end_block # label6:
; CHECK-NEXT:    return
entry:
  %cmp = fcmp ult double %a, %b
  %zext = zext i1 %cmp to i32
  %xor = xor i32 %zext, 1
  switch i32 %xor, label %exit [
    i32 0, label %sw.bb.1
    i32 1, label %sw.bb.2
  ]

sw.bb.1:
  tail call void @foo1()
  br label %exit

sw.bb.2:
  tail call void @foo2()
  br label %exit

exit:
  ret void
}

define void @xor_add_switch(double %a, double %b) {
; CHECK-LABEL: xor_add_switch:
; CHECK:         .functype xor_add_switch (f64, f64) -> ()
; CHECK-NEXT:  # %bb.0: # %entry
; CHECK-NEXT:    block
; CHECK-NEXT:    block
; CHECK-NEXT:    block
; CHECK-NEXT:    block
; CHECK-NEXT:    local.get $push8=, 0
; CHECK-NEXT:    local.get $push7=, 1
; CHECK-NEXT:    f64.ge $push1=, $pop8, $pop7
; CHECK-NEXT:    i32.const $push2=, 1
; CHECK-NEXT:    i32.xor $push3=, $pop1, $pop2
; CHECK-NEXT:    i32.const $push6=, 1
; CHECK-NEXT:    i32.add $push4=, $pop3, $pop6
; CHECK-NEXT:    i32.const $push5=, 1
; CHECK-NEXT:    i32.xor $push0=, $pop4, $pop5
; CHECK-NEXT:    br_table $pop0, 0, 1, 2, 3 # 0: down to label12
; CHECK-NEXT:    # 1: down to label11
; CHECK-NEXT:    # 2: down to label10
; CHECK-NEXT:    # 3: down to label9
; CHECK-NEXT:  .LBB21_1: # %sw.bb.1
; CHECK-NEXT:    end_block # label12:
; CHECK-NEXT:    call foo1
; CHECK-NEXT:    return
; CHECK-NEXT:  .LBB21_2: # %sw.bb.2
; CHECK-NEXT:    end_block # label11:
; CHECK-NEXT:    call foo2
; CHECK-NEXT:    return
; CHECK-NEXT:  .LBB21_3: # %sw.bb.3
; CHECK-NEXT:    end_block # label10:
; CHECK-NEXT:    call foo3
; CHECK-NEXT:  .LBB21_4: # %exit
; CHECK-NEXT:    end_block # label9:
; CHECK-NEXT:    return
entry:
  %cmp = fcmp ult double %a, %b
  %zext = zext i1 %cmp to i32
  %add = add nsw nuw i32 %zext, 1
  %xor = xor i32 %add, 1
  switch i32 %xor, label %exit [
    i32 0, label %sw.bb.1
    i32 1, label %sw.bb.2
    i32 2, label %sw.bb.3
  ]

sw.bb.1:
  tail call void @foo1()
  br label %exit

sw.bb.2:
  tail call void @foo2()
  br label %exit

sw.bb.3:
  tail call void @foo3()
  br label %exit

exit:
  ret void
}

declare void @foo1()
declare void @foo2()
declare void @foo3()
declare void @call1()
