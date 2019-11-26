; RUN: %clang -c -emit-llvm %S/../inputs/input_for_inject.c -o - \
; RUN:   | opt -load ../lib/libInjectFuncCall%shlibext -legacy-inject-func-call -verify -o instrumented.bin
; RUN: not lli ./instrumented.bin 123 | FileCheck %s

; This test instruments the input file (input_for_inject.c) with InjectFuncCall and runs it via lli.
; Below is the expected output.

; CHECK: (llvm-tutor) Hello from: main
; CHECK-NEXT: (llvm-tutor)   number of arguments: 2
; CHECK-NEXT: (llvm-tutor) Hello from: foo
; CHECK-NEXT: (llvm-tutor)   number of arguments: 1
; CHECK-NEXT: (llvm-tutor) Hello from: bar
; CHECK-NEXT: (llvm-tutor)   number of arguments: 2
; CHECK-NEXT: (llvm-tutor) Hello from: foo
; CHECK-NEXT: (llvm-tutor)   number of arguments: 1
; CHECK-NEXT: (llvm-tutor) Hello from: fez
; CHECK-NEXT: (llvm-tutor)   number of arguments: 3
; CHECK-NEXT: (llvm-tutor) Hello from: bar
; CHECK-NEXT: (llvm-tutor)   number of arguments: 2
; CHECK-NEXT: (llvm-tutor) Hello from: foo
; CHECK-NEXT: (llvm-tutor)   number of arguments: 1