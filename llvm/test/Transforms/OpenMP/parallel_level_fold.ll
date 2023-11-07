; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -passes=openmp-opt < %s | FileCheck %s
target triple = "nvptx64"

%struct.KernelEnvironmentTy = type { %struct.ConfigurationEnvironmentTy, ptr, ptr }
%struct.ConfigurationEnvironmentTy = type { i8, i8, i8 }

@G = external global i16
@none_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 1 }, ptr null, ptr null }
@spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 2 }, ptr null, ptr null }
@parallel_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 2 }, ptr null, ptr null }

;.
; CHECK: @[[G:[a-zA-Z0-9_$"\\.-]+]] = external global i16
; CHECK: @[[NONE_SPMD_KERNEL_ENVIRONMENT:[a-zA-Z0-9_$"\\.-]+]] = local_unnamed_addr constant [[STRUCT_KERNELENVIRONMENTTY:%.*]] { [[STRUCT_CONFIGURATIONENVIRONMENTTY:%.*]] { i8 0, i8 0, i8 1 }, ptr null, ptr null }
; CHECK: @[[SPMD_KERNEL_ENVIRONMENT:[a-zA-Z0-9_$"\\.-]+]] = local_unnamed_addr constant [[STRUCT_KERNELENVIRONMENTTY:%.*]] { [[STRUCT_CONFIGURATIONENVIRONMENTTY:%.*]] { i8 0, i8 0, i8 2 }, ptr null, ptr null }
; CHECK: @[[PARALLEL_KERNEL_ENVIRONMENT:[a-zA-Z0-9_$"\\.-]+]] = local_unnamed_addr constant [[STRUCT_KERNELENVIRONMENTTY:%.*]] { [[STRUCT_CONFIGURATIONENVIRONMENTTY:%.*]] { i8 0, i8 0, i8 2 }, ptr null, ptr null }
;.
define weak void @none_spmd() "kernel" {
; CHECK-LABEL: define {{[^@]+}}@none_spmd
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[I:%.*]] = call i32 @__kmpc_target_init(ptr @none_spmd_kernel_environment)
; CHECK-NEXT:    call void @none_spmd_helper()
; CHECK-NEXT:    call void @mixed_helper()
; CHECK-NEXT:    call void @__kmpc_target_deinit()
; CHECK-NEXT:    ret void
;
  %i = call i32 @__kmpc_target_init(ptr @none_spmd_kernel_environment)
  call void @none_spmd_helper()
  call void @mixed_helper()
  call void @__kmpc_target_deinit()
  ret void
}

define weak void @spmd() "kernel" {
; CHECK-LABEL: define {{[^@]+}}@spmd
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    [[I:%.*]] = call i32 @__kmpc_target_init(ptr @spmd_kernel_environment)
; CHECK-NEXT:    call void @spmd_helper()
; CHECK-NEXT:    call void @mixed_helper()
; CHECK-NEXT:    call void @__kmpc_target_deinit()
; CHECK-NEXT:    ret void
;
  %i = call i32 @__kmpc_target_init(ptr @spmd_kernel_environment)
  call void @spmd_helper()
  call void @mixed_helper()
  call void @__kmpc_target_deinit()
  ret void
}

define weak void @parallel() "kernel" {
; CHECK-LABEL: define {{[^@]+}}@parallel
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    [[I:%.*]] = call i32 @__kmpc_target_init(ptr @parallel_kernel_environment)
; CHECK-NEXT:    call void @spmd_helper()
; CHECK-NEXT:    call void @__kmpc_parallel_51(ptr null, i32 0, i32 0, i32 0, i32 0, ptr null, ptr null, ptr null, i64 0)
; CHECK-NEXT:    call void @__kmpc_target_deinit()
; CHECK-NEXT:    ret void
;
  %i = call i32 @__kmpc_target_init(ptr @parallel_kernel_environment)
  call void @spmd_helper()
  call void @__kmpc_parallel_51(ptr null, i32 0, i32 0, i32 0, i32 0, ptr null, ptr null, ptr null, i64 0)
  call void @__kmpc_target_deinit()
  ret void
}

define internal void @mixed_helper() {
; CHECK-LABEL: define {{[^@]+}}@mixed_helper() {
; CHECK-NEXT:    [[LEVEL:%.*]] = call zeroext i16 @__kmpc_parallel_level(ptr null, i32 0)
; CHECK-NEXT:    store i16 [[LEVEL]], ptr @G, align 2
; CHECK-NEXT:    ret void
;
  %level = call zeroext i16 @__kmpc_parallel_level(ptr null, i32 0)
  store i16 %level, ptr @G
  ret void
}

define internal void @none_spmd_helper() {
; CHECK-LABEL: define {{[^@]+}}@none_spmd_helper() {
; CHECK-NEXT:    [[LEVEL12:%.*]] = call zeroext i16 @__kmpc_parallel_level(ptr null, i32 0)
; CHECK-NEXT:    [[C:%.*]] = icmp eq i16 [[LEVEL12]], 0
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    ret void
; CHECK:       f:
; CHECK-NEXT:    call void @bar()
; CHECK-NEXT:    ret void
;
  %level12 = call zeroext i16 @__kmpc_parallel_level(ptr null, i32 0)
  %c = icmp eq i16 %level12, 0
  br i1 %c, label %t, label %f
t:
  call void @foo()
  ret void
f:
  call void @bar()
  ret void
}

define internal void @spmd_helper() {
; CHECK-LABEL: define {{[^@]+}}@spmd_helper() {
; CHECK-NEXT:    store i8 1, ptr @G, align 2
; CHECK-NEXT:    ret void
;
  %level = call zeroext i16 @__kmpc_parallel_level(ptr null, i32 0)
  store i16 %level, ptr @G
  ret void
}

define internal void @__kmpc_parallel_51(ptr, i32, i32, i32, i32, ptr, ptr, ptr, i64) {
; CHECK-LABEL: define {{[^@]+}}@__kmpc_parallel_51
; CHECK-SAME: (ptr [[TMP0:%.*]], i32 [[TMP1:%.*]], i32 [[TMP2:%.*]], i32 [[TMP3:%.*]], i32 [[TMP4:%.*]], ptr [[TMP5:%.*]], ptr [[TMP6:%.*]], ptr [[TMP7:%.*]], i64 [[TMP8:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    call void @parallel_helper()
; CHECK-NEXT:    ret void
;
  call void @parallel_helper()
  ret void
}

define internal void @parallel_helper() {
; CHECK-LABEL: define {{[^@]+}}@parallel_helper() {
; CHECK-NEXT:    [[LEVEL:%.*]] = call zeroext i16 @__kmpc_parallel_level(ptr null, i32 0)
; CHECK-NEXT:    store i16 [[LEVEL]], ptr @G, align 2
; CHECK-NEXT:    ret void
;
  %level = call zeroext i16 @__kmpc_parallel_level(ptr null, i32 0)
  store i16 %level, ptr @G
  ret void
}

declare void @foo()
declare void @bar()
declare zeroext i16 @__kmpc_parallel_level(ptr, i32)
declare i32 @__kmpc_target_init(ptr) #1
declare void @__kmpc_target_deinit() #1

!llvm.module.flags = !{!0, !1}
!nvvm.annotations = !{!2, !3, !4}

!0 = !{i32 7, !"openmp", i32 50}
!1 = !{i32 7, !"openmp-device", i32 50}
!2 = !{ptr @none_spmd, !"kernel", i32 1}
!3 = !{ptr @spmd, !"kernel", i32 1}
!4 = !{ptr @parallel, !"kernel", i32 1}
;.
; CHECK: attributes #[[ATTR0]] = { "kernel" }
; CHECK: attributes #[[ATTR1]] = { alwaysinline }
;.
; CHECK: [[META0:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; CHECK: [[META1:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
; CHECK: [[META2:![0-9]+]] = !{ptr @none_spmd, !"kernel", i32 1}
; CHECK: [[META3:![0-9]+]] = !{ptr @spmd, !"kernel", i32 1}
; CHECK: [[META4:![0-9]+]] = !{ptr @parallel, !"kernel", i32 1}
;.
