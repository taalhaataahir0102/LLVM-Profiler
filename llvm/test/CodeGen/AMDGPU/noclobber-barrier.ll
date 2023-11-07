; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -march=amdgcn -mcpu=gfx900 -amdgpu-aa -amdgpu-aa-wrapper -amdgpu-annotate-uniform -S < %s | FileCheck %s
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs -amdgpu-atomic-optimizer-strategy=None < %s | FileCheck -check-prefix=GCN %s

; Check that barrier or fence in between of loads is not considered a clobber
; for the purpose of converting vector loads into scalar.

@LDS = linkonce_odr hidden local_unnamed_addr addrspace(3) global i32 undef

; GCN-LABEL: {{^}}simple_barrier:
; GCN: s_load_dword s
; GCN: s_waitcnt lgkmcnt(0)
; GCN: s_barrier
; GCN: s_waitcnt lgkmcnt(0)
; GCN: ; wave barrier
; GCN-NOT: global_load_dword
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @simple_barrier(ptr addrspace(1) %arg) {
; CHECK-LABEL: @simple_barrier(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr addrspace(1) [[ARG:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    tail call void @llvm.amdgcn.wave.barrier()
; CHECK-NEXT:    [[I1:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 1, !amdgpu.uniform !0
; CHECK-NEXT:    [[I2:%.*]] = load i32, ptr addrspace(1) [[I1]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    [[I3:%.*]] = add i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 2
; CHECK-NEXT:    store i32 [[I3]], ptr addrspace(1) [[I4]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr addrspace(1) %arg, align 4
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  tail call void @llvm.amdgcn.wave.barrier()
  %i1 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 1
  %i2 = load i32, ptr addrspace(1) %i1, align 4
  %i3 = add i32 %i2, %i
  %i4 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 2
  store i32 %i3, ptr addrspace(1) %i4, align 4
  ret void
}

; GCN-LABEL: {{^}}memory_phi_no_clobber:
; GCN: s_load_dword s
; GCN: s_waitcnt lgkmcnt(0)
; GCN: s_waitcnt lgkmcnt(0)
; GCN: s_barrier
; GCN-NOT: global_load_dword
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @memory_phi_no_clobber(ptr addrspace(1) %arg) {
; CHECK-LABEL: @memory_phi_no_clobber(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr addrspace(1) [[ARG:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    br i1 undef, label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]], !amdgpu.uniform !0
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br label [[IF_END:%.*]], !amdgpu.uniform !0
; CHECK:       if.else:
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    br label [[IF_END]], !amdgpu.uniform !0
; CHECK:       if.end:
; CHECK-NEXT:    [[I1:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 1, !amdgpu.uniform !0
; CHECK-NEXT:    [[I2:%.*]] = load i32, ptr addrspace(1) [[I1]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    [[I3:%.*]] = add i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 2
; CHECK-NEXT:    store i32 [[I3]], ptr addrspace(1) [[I4]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr addrspace(1) %arg, align 4
  br i1 undef, label %if.then, label %if.else

if.then:
  tail call void @llvm.amdgcn.s.barrier()
  br label %if.end

if.else:
  fence syncscope("workgroup") release
  br label %if.end

if.end:
  %i1 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 1
  %i2 = load i32, ptr addrspace(1) %i1, align 4
  %i3 = add i32 %i2, %i
  %i4 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 2
  store i32 %i3, ptr addrspace(1) %i4, align 4
  ret void
}

; GCN-LABEL: {{^}}memory_phi_clobber1:
; GCN: s_load_dword s
; GCN: s_barrier
; GCN: global_store_dword
; GCN: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @memory_phi_clobber1(ptr addrspace(1) %arg) {
; CHECK-LABEL: @memory_phi_clobber1(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr addrspace(1) [[ARG:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    br i1 undef, label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]], !amdgpu.uniform !0
; CHECK:       if.then:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 3
; CHECK-NEXT:    store i32 1, ptr addrspace(1) [[GEP]], align 4
; CHECK-NEXT:    br label [[IF_END:%.*]], !amdgpu.uniform !0
; CHECK:       if.else:
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br label [[IF_END]], !amdgpu.uniform !0
; CHECK:       if.end:
; CHECK-NEXT:    [[I1:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 1, !amdgpu.uniform !0
; CHECK-NEXT:    [[I2:%.*]] = load i32, ptr addrspace(1) [[I1]], align 4
; CHECK-NEXT:    [[I3:%.*]] = add i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 2
; CHECK-NEXT:    store i32 [[I3]], ptr addrspace(1) [[I4]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr addrspace(1) %arg, align 4
  br i1 undef, label %if.then, label %if.else

if.then:
  %gep = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 3
  store i32 1, ptr addrspace(1) %gep, align 4
  br label %if.end

if.else:
  tail call void @llvm.amdgcn.s.barrier()
  br label %if.end

if.end:
  %i1 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 1
  %i2 = load i32, ptr addrspace(1) %i1, align 4
  %i3 = add i32 %i2, %i
  %i4 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 2
  store i32 %i3, ptr addrspace(1) %i4, align 4
  ret void
}

; GCN-LABEL: {{^}}memory_phi_clobber2:
; GCN-DAG: s_load_dword s
; GCN-DAG: global_store_dword
; GCN: s_barrier
; GCN: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @memory_phi_clobber2(ptr addrspace(1) %arg) {
; CHECK-LABEL: @memory_phi_clobber2(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr addrspace(1) [[ARG:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    br i1 undef, label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]], !amdgpu.uniform !0
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br label [[IF_END:%.*]], !amdgpu.uniform !0
; CHECK:       if.else:
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 3
; CHECK-NEXT:    store i32 1, ptr addrspace(1) [[GEP]], align 4
; CHECK-NEXT:    br label [[IF_END]], !amdgpu.uniform !0
; CHECK:       if.end:
; CHECK-NEXT:    [[I1:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 1, !amdgpu.uniform !0
; CHECK-NEXT:    [[I2:%.*]] = load i32, ptr addrspace(1) [[I1]], align 4
; CHECK-NEXT:    [[I3:%.*]] = add i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 2
; CHECK-NEXT:    store i32 [[I3]], ptr addrspace(1) [[I4]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr addrspace(1) %arg, align 4
  br i1 undef, label %if.then, label %if.else

if.then:
  tail call void @llvm.amdgcn.s.barrier()
  br label %if.end

if.else:
  %gep = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 3
  store i32 1, ptr addrspace(1) %gep, align 4
  br label %if.end

if.end:
  %i1 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 1
  %i2 = load i32, ptr addrspace(1) %i1, align 4
  %i3 = add i32 %i2, %i
  %i4 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 2
  store i32 %i3, ptr addrspace(1) %i4, align 4
  ret void
}

; GCN-LABEL: {{^}}no_clobbering_loop1:
; GCN: s_load_dword s
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @no_clobbering_loop1(ptr addrspace(1) %arg, i1 %cc) {
; CHECK-LABEL: @no_clobbering_loop1(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr addrspace(1) [[ARG:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    br label [[WHILE_COND:%.*]], !amdgpu.uniform !0
; CHECK:       while.cond:
; CHECK-NEXT:    [[I1:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 1, !amdgpu.uniform !0
; CHECK-NEXT:    [[I2:%.*]] = load i32, ptr addrspace(1) [[I1]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    [[I3:%.*]] = add i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 2
; CHECK-NEXT:    store i32 [[I3]], ptr addrspace(1) [[I4]], align 4
; CHECK-NEXT:    tail call void @llvm.amdgcn.wave.barrier()
; CHECK-NEXT:    br i1 [[CC:%.*]], label [[WHILE_COND]], label [[END:%.*]], !amdgpu.uniform !0
; CHECK:       end:
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr addrspace(1) %arg, align 4
  br label %while.cond

while.cond:
  %i1 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 1
  %i2 = load i32, ptr addrspace(1) %i1, align 4
  %i3 = add i32 %i2, %i
  %i4 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 2
  store i32 %i3, ptr addrspace(1) %i4, align 4
  tail call void @llvm.amdgcn.wave.barrier()
  br i1 %cc, label %while.cond, label %end

end:
  ret void
}

; GCN-LABEL: {{^}}no_clobbering_loop2:
; GCN: s_load_dword s
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @no_clobbering_loop2(ptr addrspace(1) noalias %arg, ptr addrspace(1) noalias %out, i32 %n) {
; CHECK-LABEL: @no_clobbering_loop2(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr addrspace(1) [[ARG:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    br label [[WHILE_COND:%.*]], !amdgpu.uniform !0
; CHECK:       while.cond:
; CHECK-NEXT:    [[C:%.*]] = phi i32 [ 0, [[BB:%.*]] ], [ [[INC:%.*]], [[WHILE_COND]] ]
; CHECK-NEXT:    [[ACC:%.*]] = phi i32 [ [[I]], [[BB]] ], [ [[I3:%.*]], [[WHILE_COND]] ]
; CHECK-NEXT:    [[I1:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i32 [[C]], !amdgpu.uniform !0
; CHECK-NEXT:    [[I2:%.*]] = load i32, ptr addrspace(1) [[I1]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    [[I3]] = add i32 [[I2]], [[ACC]]
; CHECK-NEXT:    tail call void @llvm.amdgcn.wave.barrier()
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[C]], 1
; CHECK-NEXT:    [[CC:%.*]] = icmp eq i32 [[INC]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[CC]], label [[WHILE_COND]], label [[END:%.*]], !amdgpu.uniform !0
; CHECK:       end:
; CHECK-NEXT:    store i32 [[I3]], ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr addrspace(1) %arg, align 4
  br label %while.cond

while.cond:
  %c = phi i32 [ 0, %bb ], [ %inc, %while.cond ]
  %acc = phi i32 [ %i, %bb ], [ %i3, %while.cond ]
  %i1 = getelementptr inbounds i32, ptr addrspace(1) %arg, i32 %c
  %i2 = load i32, ptr addrspace(1) %i1, align 4
  %i3 = add i32 %i2, %acc
  tail call void @llvm.amdgcn.wave.barrier()
  %inc = add nuw nsw i32 %c, 1
  %cc = icmp eq i32 %inc, %n
  br i1 %cc, label %while.cond, label %end

end:
  store i32 %i3, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}clobbering_loop:
; GCN: s_load_dword s
; GCN: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @clobbering_loop(ptr addrspace(1) %arg, ptr addrspace(1) %out, i1 %cc) {
; CHECK-LABEL: @clobbering_loop(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr addrspace(1) [[ARG:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    br label [[WHILE_COND:%.*]], !amdgpu.uniform !0
; CHECK:       while.cond:
; CHECK-NEXT:    [[I1:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 1, !amdgpu.uniform !0
; CHECK-NEXT:    [[I2:%.*]] = load i32, ptr addrspace(1) [[I1]], align 4
; CHECK-NEXT:    [[I3:%.*]] = add i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[OUT:%.*]], i64 1
; CHECK-NEXT:    store i32 [[I3]], ptr addrspace(1) [[I4]], align 4
; CHECK-NEXT:    tail call void @llvm.amdgcn.wave.barrier()
; CHECK-NEXT:    br i1 [[CC:%.*]], label [[WHILE_COND]], label [[END:%.*]], !amdgpu.uniform !0
; CHECK:       end:
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr addrspace(1) %arg, align 4
  br label %while.cond

while.cond:
  %i1 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 1
  %i2 = load i32, ptr addrspace(1) %i1, align 4
  %i3 = add i32 %i2, %i
  %i4 = getelementptr inbounds i32, ptr addrspace(1) %out, i64 1
  store i32 %i3, ptr addrspace(1) %i4, align 4
  tail call void @llvm.amdgcn.wave.barrier()
  br i1 %cc, label %while.cond, label %end

end:
  ret void
}

; GCN-LABEL: {{^}}clobber_by_atomic_load:
; GCN: s_load_dword s
; GCN: global_load_dword {{.*}} glc
; GCN: global_load_dword
; GCN: global_store_dword
define amdgpu_kernel void @clobber_by_atomic_load(ptr addrspace(1) %arg) {
; CHECK-LABEL: @clobber_by_atomic_load(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = load i32, ptr addrspace(1) [[ARG:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 2, !amdgpu.uniform !0
; CHECK-NEXT:    [[VAL:%.*]] = load atomic i32, ptr addrspace(1) [[GEP]] seq_cst, align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    [[I1:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 3, !amdgpu.uniform !0
; CHECK-NEXT:    [[I2:%.*]] = load i32, ptr addrspace(1) [[I1]], align 4
; CHECK-NEXT:    [[I3:%.*]] = add i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = getelementptr inbounds i32, ptr addrspace(1) [[ARG]], i64 4
; CHECK-NEXT:    store i32 [[I3]], ptr addrspace(1) [[I4]], align 4
; CHECK-NEXT:    ret void
;
bb:
  %i = load i32, ptr addrspace(1) %arg, align 4
  %gep = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 2
  %val = load atomic i32, ptr addrspace(1) %gep  seq_cst, align 4
  %i1 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 3
  %i2 = load i32, ptr addrspace(1) %i1, align 4
  %i3 = add i32 %i2, %i
  %i4 = getelementptr inbounds i32, ptr addrspace(1) %arg, i64 4
  store i32 %i3, ptr addrspace(1) %i4, align 4
  ret void
}

; GCN-LABEL: {{^}}no_alias_store:
; GCN: ds_write_b32
; GCN: s_barrier
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @no_alias_store(ptr addrspace(1) %in, ptr addrspace(1) %out) {
; CHECK-LABEL: @no_alias_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 0, ptr addrspace(3) @LDS, align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  store i32 0, ptr addrspace(3) @LDS, align 4
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}may_alias_store:
; GCN: global_store_dword
; GCN: s_barrier
; GCN: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @may_alias_store(ptr addrspace(1) %in, ptr addrspace(1) %out) {
; CHECK-LABEL: @may_alias_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 0, ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT]], align 4
; CHECK-NEXT:    ret void
;
entry:
  store i32 0, ptr addrspace(1) %out, align 4
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}no_alias_volatile_store:
; GCN: ds_write_b32
; GCN: s_barrier
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @no_alias_volatile_store(ptr addrspace(1) %in, ptr addrspace(1) %out) {
; CHECK-LABEL: @no_alias_volatile_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store volatile i32 0, ptr addrspace(3) @LDS, align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  store volatile i32 0, ptr addrspace(3) @LDS, align 4
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}no_alias_atomic_rmw_relaxed:
; GCN: ds_add_u32
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @no_alias_atomic_rmw_relaxed(ptr addrspace(1) %in, ptr addrspace(1) %out) {
; CHECK-LABEL: @no_alias_atomic_rmw_relaxed(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UNUSED:%.*]] = atomicrmw add ptr addrspace(3) @LDS, i32 5 monotonic, align 4
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %unused = atomicrmw add ptr addrspace(3) @LDS, i32 5 monotonic
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}no_alias_atomic_cmpxchg:
; GCN: ds_cmpst_b32
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @no_alias_atomic_cmpxchg(ptr addrspace(1) %in, ptr addrspace(1) %out, i32 %swap) {
; CHECK-LABEL: @no_alias_atomic_cmpxchg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UNUSED:%.*]] = cmpxchg ptr addrspace(3) @LDS, i32 7, i32 [[SWAP:%.*]] seq_cst monotonic, align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %unused = cmpxchg ptr addrspace(3) @LDS, i32 7, i32 %swap seq_cst monotonic
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}no_alias_atomic_rmw:
; GCN: ds_add_u32
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @no_alias_atomic_rmw(ptr addrspace(1) %in, ptr addrspace(1) %out) {
; CHECK-LABEL: @no_alias_atomic_rmw(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UNUSED:%.*]] = atomicrmw add ptr addrspace(3) @LDS, i32 5 seq_cst, align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %unused = atomicrmw add ptr addrspace(3) @LDS, i32 5 seq_cst
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}may_alias_atomic_cmpxchg:
; GCN: global_atomic_cmpswap
; GCN: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @may_alias_atomic_cmpxchg(ptr addrspace(1) %in, ptr addrspace(1) %out, i32 %swap) {
; CHECK-LABEL: @may_alias_atomic_cmpxchg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UNUSED:%.*]] = cmpxchg ptr addrspace(1) [[OUT:%.*]], i32 7, i32 [[SWAP:%.*]] seq_cst monotonic, align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %unused = cmpxchg ptr addrspace(1) %out, i32 7, i32 %swap seq_cst monotonic
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}may_alias_atomic_rmw:
; GCN: global_atomic_add
; GCN: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @may_alias_atomic_rmw(ptr addrspace(1) %in, ptr addrspace(1) %out) {
; CHECK-LABEL: @may_alias_atomic_rmw(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[UNUSED:%.*]] = atomicrmw add ptr addrspace(1) [[OUT:%.*]], i32 5 syncscope("agent") seq_cst, align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %unused = atomicrmw add ptr addrspace(1) %out, i32 5 syncscope("agent") seq_cst
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}no_alias_atomic_rmw_then_clobber:
; GCN: global_store_dword
; GCN: global_store_dword
; GCN: ds_add_u32
; GCN: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @no_alias_atomic_rmw_then_clobber(ptr addrspace(1) %in, ptr addrspace(1) %out, ptr addrspace(1) noalias %noalias) {
; CHECK-LABEL: @no_alias_atomic_rmw_then_clobber(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 1, ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    store i32 2, ptr addrspace(1) [[NOALIAS:%.*]], align 4
; CHECK-NEXT:    [[UNUSED:%.*]] = atomicrmw add ptr addrspace(3) @LDS, i32 5 seq_cst, align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT]], align 4
; CHECK-NEXT:    ret void
;
entry:
  store i32 1, ptr addrspace(1) %out, align 4
  store i32 2, ptr addrspace(1) %noalias, align 4
  %unused = atomicrmw add ptr addrspace(3) @LDS, i32 5 seq_cst
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

; GCN-LABEL: {{^}}no_alias_atomic_rmw_then_no_alias_store:
; GCN: global_store_dword
; GCN: ds_add_u32
; GCN: s_load_dword s
; GCN-NOT: global_load_dword
; GCN: global_store_dword
define protected amdgpu_kernel void @no_alias_atomic_rmw_then_no_alias_store(ptr addrspace(1) %in, ptr addrspace(1) %out, ptr addrspace(1) noalias %noalias) {
; CHECK-LABEL: @no_alias_atomic_rmw_then_no_alias_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 2, ptr addrspace(1) [[NOALIAS:%.*]], align 4
; CHECK-NEXT:    [[UNUSED:%.*]] = atomicrmw add ptr addrspace(3) @LDS, i32 5 seq_cst, align 4
; CHECK-NEXT:    fence syncscope("workgroup") release
; CHECK-NEXT:    tail call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    fence syncscope("workgroup") acquire
; CHECK-NEXT:    [[LD:%.*]] = load i32, ptr addrspace(1) [[IN:%.*]], align 4, !amdgpu.noclobber !0
; CHECK-NEXT:    store i32 [[LD]], ptr addrspace(1) [[OUT:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  store i32 2, ptr addrspace(1) %noalias, align 4
  %unused = atomicrmw add ptr addrspace(3) @LDS, i32 5 seq_cst
  fence syncscope("workgroup") release
  tail call void @llvm.amdgcn.s.barrier()
  fence syncscope("workgroup") acquire
  %ld = load i32, ptr addrspace(1) %in, align 4
  store i32 %ld, ptr addrspace(1) %out, align 4
  ret void
}

declare void @llvm.amdgcn.s.barrier()
declare void @llvm.amdgcn.wave.barrier()
