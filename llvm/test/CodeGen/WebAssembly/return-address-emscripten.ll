; RUN: llc -mtriple=wasm32-unknown-emscripten < %s -asm-verbose=false | FileCheck -DPTR=32 %s
; RUN: llc -mtriple=wasm64-unknown-emscripten < %s -asm-verbose=false | FileCheck -DPTR=64 %s

; This tests the implementation of __builtin_return_address on emscripten

; CHECK-LABEL: test_returnaddress:
; CHECK-NEXT: .functype test_returnaddress () -> (i[[PTR]]){{$}}
; CHECK-NEXT: {{^}} i32.const 0{{$}}
; CHECK-NEXT: {{^}} call emscripten_return_address{{$}}
; CHECK-NEXT: {{^}} end_function{{$}}
define ptr @test_returnaddress() {
  %r = call ptr @llvm.returnaddress(i32 0)
  ret ptr %r
}

; LLVM represents __builtin_return_address as call to this function in IR.
declare ptr @llvm.returnaddress(i32 immarg)
