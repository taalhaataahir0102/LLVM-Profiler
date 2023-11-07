; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+f -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IF %s
; RUN: llc -mtriple=riscv64 -mattr=+f -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IF %s
; RUN: llc -mtriple=riscv32 -mattr=+zfinx -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IZFINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zfinx -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IZFINX %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

define float @frem_f32(float %a, float %b) nounwind {
; RV32IF-LABEL: frem_f32:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    tail fmodf@plt
;
; RV64IF-LABEL: frem_f32:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    addi sp, sp, -16
; RV64IF-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IF-NEXT:    call fmodf@plt
; RV64IF-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IF-NEXT:    addi sp, sp, 16
; RV64IF-NEXT:    ret
;
; RV32IZFINX-LABEL: frem_f32:
; RV32IZFINX:       # %bb.0:
; RV32IZFINX-NEXT:    tail fmodf@plt
;
; RV64IZFINX-LABEL: frem_f32:
; RV64IZFINX:       # %bb.0:
; RV64IZFINX-NEXT:    addi sp, sp, -16
; RV64IZFINX-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFINX-NEXT:    call fmodf@plt
; RV64IZFINX-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFINX-NEXT:    addi sp, sp, 16
; RV64IZFINX-NEXT:    ret
;
; RV32I-LABEL: frem_f32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call fmodf@plt
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: frem_f32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call fmodf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = frem float %a, %b
  ret float %1
}
