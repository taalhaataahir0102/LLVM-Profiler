; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d -verify-machineinstrs < %s | FileCheck %s

define void @masked_store_nxv1f16(<vscale x 1 x half> %val, <vscale x 1 x half>* %a, <vscale x 1 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv1f16.p0(<vscale x 1 x half> %val, <vscale x 1 x half>* %a, i32 2, <vscale x 1 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv1f16.p0(<vscale x 1 x half>, <vscale x 1 x half>*, i32, <vscale x 1 x i1>)

define void @masked_store_nxv1f32(<vscale x 1 x float> %val, <vscale x 1 x float>* %a, <vscale x 1 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv1f32.p0(<vscale x 1 x float> %val, <vscale x 1 x float>* %a, i32 4, <vscale x 1 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv1f32.p0(<vscale x 1 x float>, <vscale x 1 x float>*, i32, <vscale x 1 x i1>)

define void @masked_store_nxv1f64(<vscale x 1 x double> %val, <vscale x 1 x double>* %a, <vscale x 1 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv1f64.p0(<vscale x 1 x double> %val, <vscale x 1 x double>* %a, i32 8, <vscale x 1 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv1f64.p0(<vscale x 1 x double>, <vscale x 1 x double>*, i32, <vscale x 1 x i1>)

define void @masked_store_nxv2f16(<vscale x 2 x half> %val, <vscale x 2 x half>* %a, <vscale x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv2f16.p0(<vscale x 2 x half> %val, <vscale x 2 x half>* %a, i32 2, <vscale x 2 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv2f16.p0(<vscale x 2 x half>, <vscale x 2 x half>*, i32, <vscale x 2 x i1>)

define void @masked_store_nxv2f32(<vscale x 2 x float> %val, <vscale x 2 x float>* %a, <vscale x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv2f32.p0(<vscale x 2 x float> %val, <vscale x 2 x float>* %a, i32 4, <vscale x 2 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv2f32.p0(<vscale x 2 x float>, <vscale x 2 x float>*, i32, <vscale x 2 x i1>)

define void @masked_store_nxv2f64(<vscale x 2 x double> %val, <vscale x 2 x double>* %a, <vscale x 2 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m2, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv2f64.p0(<vscale x 2 x double> %val, <vscale x 2 x double>* %a, i32 8, <vscale x 2 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv2f64.p0(<vscale x 2 x double>, <vscale x 2 x double>*, i32, <vscale x 2 x i1>)

define void @masked_store_nxv4f16(<vscale x 4 x half> %val, <vscale x 4 x half>* %a, <vscale x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv4f16.p0(<vscale x 4 x half> %val, <vscale x 4 x half>* %a, i32 2, <vscale x 4 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv4f16.p0(<vscale x 4 x half>, <vscale x 4 x half>*, i32, <vscale x 4 x i1>)

define void @masked_store_nxv4f32(<vscale x 4 x float> %val, <vscale x 4 x float>* %a, <vscale x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv4f32.p0(<vscale x 4 x float> %val, <vscale x 4 x float>* %a, i32 4, <vscale x 4 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv4f32.p0(<vscale x 4 x float>, <vscale x 4 x float>*, i32, <vscale x 4 x i1>)

define void @masked_store_nxv4f64(<vscale x 4 x double> %val, <vscale x 4 x double>* %a, <vscale x 4 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m4, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv4f64.p0(<vscale x 4 x double> %val, <vscale x 4 x double>* %a, i32 8, <vscale x 4 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv4f64.p0(<vscale x 4 x double>, <vscale x 4 x double>*, i32, <vscale x 4 x i1>)

define void @masked_store_nxv8f16(<vscale x 8 x half> %val, <vscale x 8 x half>* %a, <vscale x 8 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv8f16.p0(<vscale x 8 x half> %val, <vscale x 8 x half>* %a, i32 2, <vscale x 8 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv8f16.p0(<vscale x 8 x half>, <vscale x 8 x half>*, i32, <vscale x 8 x i1>)

define void @masked_store_nxv8f32(<vscale x 8 x float> %val, <vscale x 8 x float>* %a, <vscale x 8 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv8f32.p0(<vscale x 8 x float> %val, <vscale x 8 x float>* %a, i32 4, <vscale x 8 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv8f32.p0(<vscale x 8 x float>, <vscale x 8 x float>*, i32, <vscale x 8 x i1>)

define void @masked_store_nxv8f64(<vscale x 8 x double> %val, <vscale x 8 x double>* %a, <vscale x 8 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; CHECK-NEXT:    vse64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv8f64.p0(<vscale x 8 x double> %val, <vscale x 8 x double>* %a, i32 8, <vscale x 8 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv8f64.p0(<vscale x 8 x double>, <vscale x 8 x double>*, i32, <vscale x 8 x i1>)

define void @masked_store_nxv16f16(<vscale x 16 x half> %val, <vscale x 16 x half>* %a, <vscale x 16 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv16f16.p0(<vscale x 16 x half> %val, <vscale x 16 x half>* %a, i32 2, <vscale x 16 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv16f16.p0(<vscale x 16 x half>, <vscale x 16 x half>*, i32, <vscale x 16 x i1>)

define void @masked_store_nxv16f32(<vscale x 16 x float> %val, <vscale x 16 x float>* %a, <vscale x 16 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m8, ta, ma
; CHECK-NEXT:    vse32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv16f32.p0(<vscale x 16 x float> %val, <vscale x 16 x float>* %a, i32 4, <vscale x 16 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv16f32.p0(<vscale x 16 x float>, <vscale x 16 x float>*, i32, <vscale x 16 x i1>)

define void @masked_store_nxv32f16(<vscale x 32 x half> %val, <vscale x 32 x half>* %a, <vscale x 32 x i1> %mask) nounwind {
; CHECK-LABEL: masked_store_nxv32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m8, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  call void @llvm.masked.store.nxv32f16.p0(<vscale x 32 x half> %val, <vscale x 32 x half>* %a, i32 2, <vscale x 32 x i1> %mask)
  ret void
}
declare void @llvm.masked.store.nxv32f16.p0(<vscale x 32 x half>, <vscale x 32 x half>*, i32, <vscale x 32 x i1>)
