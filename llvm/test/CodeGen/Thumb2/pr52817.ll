; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv7-apple-ios9.0.0 -verify-machineinstrs < %s | FileCheck %s

; Make sure machine verification does not fail due to incorrect bundle kill
; flags.

target triple = "thumbv7-apple-ios9.0.0"

%struct.ham = type { [1024 x i32], %struct.zot }
%struct.zot = type { [1 x i32], [1 x [32 x i32]] }

define i32 @test(ptr %arg, ptr %arg1, ptr %arg2) #0 !dbg !6 {
; CHECK-LABEL: test:
; CHECK:       Lfunc_begin0:
; CHECK-NEXT:    .file 1 "/" "test.cpp"
; CHECK-NEXT:    .loc 1 50 0 @ test.cpp:50:0
; CHECK-NEXT:  @ %bb.0: @ %bb
; CHECK-NEXT:    push {r4, r5, r6, r7, lr}
; CHECK-NEXT:    add r7, sp, #12
; CHECK-NEXT:    str r8, [sp, #-4]!
; CHECK-NEXT:    mov.w lr, #0
; CHECK-NEXT:    mov.w r9, #1
; CHECK-NEXT:    movw r12, #4100
; CHECK-NEXT:    movs r3, #0
; CHECK-NEXT:  LBB0_1: @ %bb3
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    adds r5, r3, #1
; CHECK-NEXT:    str.w lr, [r2]
; CHECK-NEXT:    cmp.w lr, #0
; CHECK-NEXT:    add.w r4, r0, r5, lsl #2
; CHECK-NEXT:    add.w r8, r4, r12
; CHECK-NEXT:    lsl.w r4, r9, r3
; CHECK-NEXT:    and.w r3, r3, r4
; CHECK-NEXT:    add.w r4, r1, r5, lsl #2
; CHECK-NEXT:    itte ne
; CHECK-NEXT:    movne r6, #0
; CHECK-NEXT:  Ltmp0:
; CHECK-NEXT:    @DEBUG_VALUE: test:this <- [DW_OP_LLVM_arg 0, DW_OP_plus_uconst 135168, DW_OP_LLVM_arg 1, DW_OP_constu 4, DW_OP_mul, DW_OP_plus, DW_OP_plus_uconst 4, DW_OP_stack_value] $r0, $r5
; CHECK-NEXT:    .loc 1 28 24 prologue_end @ test.cpp:28:24
; CHECK-NEXT:    strne.w r6, [r8]
; CHECK-NEXT:    moveq r6, #1
; CHECK-NEXT:    ldr r4, [r4, #4]
; CHECK-NEXT:    orrs r4, r6
; CHECK-NEXT:    str.w r4, [r8]
; CHECK-NEXT:    b LBB0_1
; CHECK-NEXT:  Ltmp1:
; CHECK-NEXT:  Lfunc_end0:
bb:
  br label %bb3

bb3:                                              ; preds = %bb14, %bb
  %tmp4 = phi i32 [ %tmp8, %bb14 ], [ 0, %bb ]
  %tmp5 = add i32 %tmp4, 1
  %tmp6 = shl nuw i32 1, %tmp4
  %tmp8 = and i32 %tmp4, %tmp6
  store i32 0, ptr %arg2, align 4
  %tmp10 = getelementptr inbounds %struct.ham, ptr %arg, i32 0, i32 1, i32 1, i32 0, i32 %tmp5
  br i1 undef, label %bb11, label %bb13

bb11:                                             ; preds = %bb3
  %tmp12 = load i32, ptr null, align 4
  br label %bb14

bb13:                                             ; preds = %bb3
  call void @llvm.dbg.value(metadata !DIArgList(ptr %arg, i32 %tmp5), metadata !11, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_plus_uconst, 135168, DW_OP_LLVM_arg, 1, DW_OP_constu, 4, DW_OP_mul, DW_OP_plus, DW_OP_plus_uconst, 4, DW_OP_stack_value)), !dbg !14
  store i32 0, ptr %tmp10, align 4, !dbg !16
  br label %bb14

bb14:                                             ; preds = %bb13, %bb11
  %tmp15 = phi i32 [ 1, %bb11 ], [ 0, %bb13 ]
  %tmp16 = getelementptr inbounds %struct.zot, ptr %arg1, i32 0, i32 1, i32 0, i32 %tmp5
  %tmp17 = load i32, ptr %tmp16, align 4
  %tmp18 = or i32 %tmp17, %tmp15
  store i32 %tmp18, ptr %tmp10, align 4
  br label %bb3
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { "frame-pointer"="all" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.dbg.cu = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 7, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !4, producer: "clang version 14.0.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !5, retainedTypes: !5, imports: !5, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!4 = !DIFile(filename: "test.cpp", directory: "/")
!5 = !{}
!6 = distinct !DISubprogram(name: "test", linkageName: "test", scope: !7, file: !4, line: 49, type: !9, scopeLine: 50, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !3, declaration: !10, retainedNodes: !5)
!7 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "BVGraph<__sanitizer::TwoLevelBitVector<1UL, __sanitizer::BasicBitVector<unsigned long> > >", scope: !8, file: !4, line: 25, size: 1083456, flags: DIFlagTypePassByValue, elements: !5, templateParams: !5, identifier: "_ZTSN11__sanitizer7BVGraphINS_17TwoLevelBitVectorILm1ENS_14BasicBitVectorImEEEEEE")
!8 = !DINamespace(name: "__sanitizer", scope: null)
!9 = !DISubroutineType(types: !5)
!10 = !DISubprogram(name: "test", linkageName: "test", scope: !7, file: !4, line: 49, type: !9, scopeLine: 49, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!11 = !DILocalVariable(name: "this", arg: 1, scope: !6, type: !12, flags: DIFlagArtificial | DIFlagObjectPointer)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 32)
!13 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "BasicBitVector<unsigned long>", scope: !8, file: !4, line: 22, size: 32, flags: DIFlagTypePassByValue, elements: !5, templateParams: !5, identifier: "_ZTSN11__sanitizer14BasicBitVectorImEE")
!14 = !DILocation(line: 0, scope: !6, inlinedAt: !15)
!15 = distinct !DILocation(line: 204, column: 23, scope: !6)
!16 = !DILocation(line: 28, column: 24, scope: !6, inlinedAt: !15)
