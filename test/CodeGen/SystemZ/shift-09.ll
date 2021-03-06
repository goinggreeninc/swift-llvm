; Test three-operand shifts.
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z196 | FileCheck %s

; Check that we use SLLK over SLL where useful.
define i32 @f1(i32 %a, i32 %b, i32 %amt) {
; CHECK-LABEL: f1:
; CHECK: sllk %r2, %r3, 15(%r4)
; CHECK: br %r14
  %add = add i32 %amt, 15
  %shift = shl i32 %b, %add
  ret i32 %shift
}

; Check that we use SLL over SLLK where possible.
define i32 @f2(i32 %a, i32 %amt) {
; CHECK-LABEL: f2:
; CHECK: sll %r2, 15(%r3)
; CHECK: br %r14
  %add = add i32 %amt, 15
  %shift = shl i32 %a, %add
  ret i32 %shift
}

; Check that we use SRLK over SRL where useful.
define i32 @f3(i32 %a, i32 %b, i32 %amt) {
; CHECK-LABEL: f3:
; CHECK: srlk %r2, %r3, 15(%r4)
; CHECK: br %r14
  %add = add i32 %amt, 15
  %shift = lshr i32 %b, %add
  ret i32 %shift
}

; Check that we use SRL over SRLK where possible.
define i32 @f4(i32 %a, i32 %amt) {
; CHECK-LABEL: f4:
; CHECK: srl %r2, 15(%r3)
; CHECK: br %r14
  %add = add i32 %amt, 15
  %shift = lshr i32 %a, %add
  ret i32 %shift
}

; Check that we use SRAK over SRA where useful.
define i32 @f5(i32 %a, i32 %b, i32 %amt) {
; CHECK-LABEL: f5:
; CHECK: srak %r2, %r3, 15(%r4)
; CHECK: br %r14
  %add = add i32 %amt, 15
  %shift = ashr i32 %b, %add
  ret i32 %shift
}

; Check that we use SRA over SRAK where possible.
define i32 @f6(i32 %a, i32 %amt) {
; CHECK-LABEL: f6:
; CHECK: sra %r2, 15(%r3)
; CHECK: br %r14
  %add = add i32 %amt, 15
  %shift = ashr i32 %a, %add
  ret i32 %shift
}
