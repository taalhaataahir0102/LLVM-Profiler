// RUN: mlir-opt %s -test-transform-dialect-interpreter -verify-diagnostics -allow-unregistered-dialect -split-input-file | FileCheck %s

// CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0) -> ((d0 floordiv 4) mod 2)>
// CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0)[s0] -> (d0 + s0)>

// CHECK-LABEL: func @multi_buffer
func.func @multi_buffer(%in: memref<16xf32>) {
  // CHECK: %[[A:.*]] = memref.alloc() : memref<2x4xf32>
  // expected-remark @below {{transformed}}
  %tmp = memref.alloc() : memref<4xf32>

  // CHECK: %[[C0:.*]] = arith.constant 0 : index
  // CHECK: %[[C4:.*]] = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c16 = arith.constant 16 : index

  // CHECK: scf.for %[[IV:.*]] = %[[C0]]
  scf.for %i0 = %c0 to %c16 step %c4 {
    // CHECK: %[[I:.*]] = affine.apply #[[$MAP0]](%[[IV]])
    // CHECK: %[[SV:.*]] = memref.subview %[[A]][%[[I]], 0] [1, 4] [1, 1] : memref<2x4xf32> to memref<4xf32, strided<[1], offset: ?>>
    %1 = memref.subview %in[%i0] [4] [1] : memref<16xf32> to memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>>
    // CHECK: memref.copy %{{.*}}, %[[SV]] : memref<4xf32, #[[$MAP1]]> to memref<4xf32, strided<[1], offset: ?>>
    memref.copy %1, %tmp :  memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>> to memref<4xf32>

    "some_use"(%tmp) : (memref<4xf32>) ->()
  }
  return
}

transform.sequence failures(propagate) {
^bb1(%arg1: !transform.any_op):
  %0 = transform.structured.match ops{["memref.alloc"]} in %arg1 : (!transform.any_op) -> !transform.op<"memref.alloc">
  %1 = transform.memref.multibuffer %0 {factor = 2 : i64} : (!transform.op<"memref.alloc">) -> !transform.any_op
  // Verify that the returned handle is usable.
  transform.test_print_remark_at_operand %1, "transformed" : !transform.any_op
}

// -----

// CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0) -> ((d0 floordiv 4) mod 2)>
// CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0)[s0] -> (d0 + s0)>

// CHECK-LABEL: func @multi_buffer_on_affine_loop
func.func @multi_buffer_on_affine_loop(%in: memref<16xf32>) {
  // CHECK: %[[A:.*]] = memref.alloc() : memref<2x4xf32>
  // expected-remark @below {{transformed}}
  %tmp = memref.alloc() : memref<4xf32>

  // CHECK: %[[C0:.*]] = arith.constant 0 : index
  %c0 = arith.constant 0 : index

  // CHECK: affine.for %[[IV:.*]] = 0
  affine.for %i0 = 0 to 16 step 4 {
    // CHECK: %[[I:.*]] = affine.apply #[[$MAP0]](%[[IV]])
    // CHECK: %[[SV:.*]] = memref.subview %[[A]][%[[I]], 0] [1, 4] [1, 1] : memref<2x4xf32> to memref<4xf32, strided<[1], offset: ?>>
    %1 = memref.subview %in[%i0] [4] [1] : memref<16xf32> to memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>>
    // CHECK: memref.copy %{{.*}}, %[[SV]] : memref<4xf32, #[[$MAP1]]> to memref<4xf32, strided<[1], offset: ?>>
    memref.copy %1, %tmp :  memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>> to memref<4xf32>

    "some_use"(%tmp) : (memref<4xf32>) ->()
  }
  return
}

transform.sequence failures(propagate) {
^bb1(%arg1: !transform.any_op):
  %0 = transform.structured.match ops{["memref.alloc"]} in %arg1 : (!transform.any_op) -> !transform.op<"memref.alloc">
  %1 = transform.memref.multibuffer %0 {factor = 2 : i64} : (!transform.op<"memref.alloc">) -> !transform.any_op
  // Verify that the returned handle is usable.
  transform.test_print_remark_at_operand %1, "transformed" : !transform.any_op
}

// -----

// Trying to use multibuffer on allocs that are used in different loops
// with none dominating the other is going to fail.
// Check that we emit a proper error for that.
func.func @multi_buffer_uses_with_no_loop_dominator(%in: memref<16xf32>, %cond: i1) {
  // expected-error @below {{op failed to multibuffer}}
  %tmp = memref.alloc() : memref<4xf32>

  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c16 = arith.constant 16 : index
  scf.if %cond {
    scf.for %i0 = %c0 to %c16 step %c4 {
      %var = memref.subview %in[%i0] [4] [1] : memref<16xf32> to memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>>
      memref.copy %var, %tmp :  memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>> to memref<4xf32>

      "some_use"(%tmp) : (memref<4xf32>) ->()
    }
  }

  scf.for %i0 = %c0 to %c16 step %c4 {
    %1 = memref.subview %in[%i0] [4] [1] : memref<16xf32> to memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>>
    memref.copy %1, %tmp :  memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>> to memref<4xf32>

    "some_use"(%tmp) : (memref<4xf32>) ->()
  }
  return
}

transform.sequence failures(propagate) {
^bb1(%arg1: !transform.any_op):
  %0 = transform.structured.match ops{["memref.alloc"]} in %arg1 : (!transform.any_op) -> !transform.op<"memref.alloc">
  %1 = transform.memref.multibuffer %0 {factor = 2 : i64} : (!transform.op<"memref.alloc">) -> !transform.any_op
}

// -----

// Make sure the multibuffer operation is typed so that it only supports
// memref.alloc.
// Check that we emit an error if we try to match something else.
func.func @multi_buffer_reject_alloca(%in: memref<16xf32>, %cond: i1) {
  %tmp = memref.alloca() : memref<4xf32>

  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c16 = arith.constant 16 : index
  scf.if %cond {
    scf.for %i0 = %c0 to %c16 step %c4 {
      %var = memref.subview %in[%i0] [4] [1] : memref<16xf32> to memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>>
      memref.copy %var, %tmp :  memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>> to memref<4xf32>

      "some_use"(%tmp) : (memref<4xf32>) ->()
    }
  }

  scf.for %i0 = %c0 to %c16 step %c4 {
    %1 = memref.subview %in[%i0] [4] [1] : memref<16xf32> to memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>>
    memref.copy %1, %tmp :  memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>> to memref<4xf32>

    "some_use"(%tmp) : (memref<4xf32>) ->()
  }
  return
}

transform.sequence failures(propagate) {
^bb1(%arg1: !transform.any_op):
  %0 = transform.structured.match ops{["memref.alloca"]} in %arg1 : (!transform.any_op) -> !transform.op<"memref.alloca">
  // expected-error @below {{'transform.memref.multibuffer' op operand #0 must be Transform IR handle to memref.alloc operations, but got '!transform.op<"memref.alloca">'}}
  %1 = transform.memref.multibuffer %0 {factor = 2 : i64} : (!transform.op<"memref.alloca">) -> !transform.any_op
}

// -----

// CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0) -> ((d0 floordiv 4) mod 2)>
// CHECK-DAG: #[[$MAP1:.*]] = affine_map<(d0)[s0] -> (d0 + s0)>

// CHECK-LABEL: func @multi_buffer_one_alloc_with_use_outside_of_loop
// Make sure we manage to apply multi_buffer to the memref that is used in
// the loop (%tmp) and don't error out for the one that is not (%tmp2).
func.func @multi_buffer_one_alloc_with_use_outside_of_loop(%in: memref<16xf32>) {
  // CHECK: %[[A:.*]] = memref.alloc() : memref<2x4xf32>
  // expected-remark @below {{transformed}}
  %tmp = memref.alloc() : memref<4xf32>
  %tmp2 = memref.alloc() : memref<4xf32>

  "some_use_outside_of_loop"(%tmp2) : (memref<4xf32>) -> ()

  // CHECK: %[[C0:.*]] = arith.constant 0 : index
  // CHECK: %[[C4:.*]] = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c16 = arith.constant 16 : index

  // CHECK: scf.for %[[IV:.*]] = %[[C0]]
  scf.for %i0 = %c0 to %c16 step %c4 {
    // CHECK: %[[I:.*]] = affine.apply #[[$MAP0]](%[[IV]])
    // CHECK: %[[SV:.*]] = memref.subview %[[A]][%[[I]], 0] [1, 4] [1, 1] : memref<2x4xf32> to memref<4xf32, strided<[1], offset: ?>>
    %1 = memref.subview %in[%i0] [4] [1] : memref<16xf32> to memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>>
    // CHECK: memref.copy %{{.*}}, %[[SV]] : memref<4xf32, #[[$MAP1]]> to memref<4xf32, strided<[1], offset: ?>>
    memref.copy %1, %tmp :  memref<4xf32, affine_map<(d0)[s0] -> (d0 + s0)>> to memref<4xf32>

    "some_use"(%tmp) : (memref<4xf32>) ->()
  }
  return
}

transform.sequence failures(propagate) {
^bb1(%arg1: !transform.any_op):
  %0 = transform.structured.match ops{["memref.alloc"]} in %arg1 : (!transform.any_op) -> !transform.op<"memref.alloc">
  %1 = transform.memref.multibuffer %0 {factor = 2 : i64} : (!transform.op<"memref.alloc">) -> !transform.any_op
  // Verify that the returned handle is usable.
  transform.test_print_remark_at_operand %1, "transformed" : !transform.any_op
}

// -----


// CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0) -> ((d0 floordiv 4) mod 2)>

// CHECK-LABEL: func @multi_buffer
func.func @multi_buffer_no_analysis(%in: memref<16xf32>) {
  // CHECK: %[[A:.*]] = memref.alloc() : memref<2x4xf32>
  // expected-remark @below {{transformed}}
  %tmp = memref.alloc() : memref<4xf32>

  // CHECK: %[[C0:.*]] = arith.constant 0 : index
  // CHECK: %[[C4:.*]] = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c16 = arith.constant 16 : index

  // CHECK: scf.for %[[IV:.*]] = %[[C0]]
  scf.for %i0 = %c0 to %c16 step %c4 {
  // CHECK: %[[I:.*]] = affine.apply #[[$MAP0]](%[[IV]])
  // CHECK: %[[SV:.*]] = memref.subview %[[A]][%[[I]], 0] [1, 4] [1, 1] : memref<2x4xf32> to memref<4xf32, strided<[1], offset: ?>>
    "some_write_read"(%tmp) : (memref<4xf32>) ->()
  }
  return
}

transform.sequence failures(propagate) {
^bb1(%arg1: !transform.any_op):
  %0 = transform.structured.match ops{["memref.alloc"]} in %arg1 : (!transform.any_op) -> !transform.op<"memref.alloc">
  %1 = transform.memref.multibuffer %0 {factor = 2 : i64, skip_analysis} : (!transform.op<"memref.alloc">) -> !transform.any_op
  // Verify that the returned handle is usable.
  transform.test_print_remark_at_operand %1, "transformed" : !transform.any_op
}

// -----

// CHECK-DAG: #[[$MAP0:.*]] = affine_map<(d0) -> ((d0 floordiv 4) mod 2)>

// CHECK-LABEL: func @multi_buffer_dealloc
func.func @multi_buffer_dealloc(%in: memref<16xf32>) {
  // CHECK: %[[A:.*]] = memref.alloc() : memref<2x4xf32>
  // expected-remark @below {{transformed}}
  %tmp = memref.alloc() : memref<4xf32>

  // CHECK: %[[C0:.*]] = arith.constant 0 : index
  // CHECK: %[[C4:.*]] = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c16 = arith.constant 16 : index

  // CHECK: scf.for %[[IV:.*]] = %[[C0]]
  scf.for %i0 = %c0 to %c16 step %c4 {
  // CHECK: %[[I:.*]] = affine.apply #[[$MAP0]](%[[IV]])
  // CHECK: %[[SV:.*]] = memref.subview %[[A]][%[[I]], 0] [1, 4] [1, 1] : memref<2x4xf32> to memref<4xf32, strided<[1], offset: ?>>
    "some_write_read"(%tmp) : (memref<4xf32>) ->()
  }

  // CHECK-NOT: memref.dealloc {{.*}} : memref<4xf32>
  // CHECK: memref.dealloc %[[A]] : memref<2x4xf32>
  memref.dealloc %tmp : memref<4xf32>
  return
}

transform.sequence failures(propagate) {
^bb1(%arg1: !transform.any_op):
  %0 = transform.structured.match ops{["memref.alloc"]} in %arg1 : (!transform.any_op) -> !transform.op<"memref.alloc">
  %1 = transform.memref.multibuffer %0 {factor = 2 : i64, skip_analysis} : (!transform.op<"memref.alloc">) -> !transform.any_op
  // Verify that the returned handle is usable.
  transform.test_print_remark_at_operand %1, "transformed" : !transform.any_op
}

// -----

// CHECK-LABEL: func @lower_to_llvm
//   CHECK-NOT:   memref.alloc
//       CHECK:   llvm.call @malloc
func.func @lower_to_llvm() {
  %0 = memref.alloc() : memref<2048xi8>
  return
}

transform.sequence failures(propagate) {
^bb1(%arg1: !transform.any_op):
  %0 = transform.structured.match ops{["func.func"]} in %arg1 : (!transform.any_op) -> !transform.any_op
  transform.apply_conversion_patterns to %0 {
    transform.apply_conversion_patterns.dialect_to_llvm "memref"
  } with type_converter {
    transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter
  } {legal_dialects = ["func", "llvm"]} : !transform.any_op
}
