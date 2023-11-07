// WebAssemblyInstPrinter.h - Print wasm MCInst to assembly syntax -*- C++ -*-//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This class prints an WebAssembly MCInst to wasm file syntax.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_WEBASSEMBLY_INSTPRINTER_WEBASSEMBLYINSTPRINTER_H
#define LLVM_LIB_TARGET_WEBASSEMBLY_INSTPRINTER_WEBASSEMBLYINSTPRINTER_H

#include "llvm/ADT/SmallVector.h"
#include "llvm/BinaryFormat/Wasm.h"
#include "llvm/CodeGen/MachineValueType.h"
#include "llvm/MC/MCInstPrinter.h"

namespace llvm {

class MCSubtargetInfo;

class WebAssemblyInstPrinter final : public MCInstPrinter {
  uint64_t ControlFlowCounter = 0;
  SmallVector<std::pair<uint64_t, bool>, 4> ControlFlowStack;
  SmallVector<uint64_t, 4> TryStack;

  enum EHInstKind { TRY, CATCH, CATCH_ALL };
  SmallVector<EHInstKind, 4> EHInstStack;

public:
  WebAssemblyInstPrinter(const MCAsmInfo &MAI, const MCInstrInfo &MII,
                         const MCRegisterInfo &MRI);

  void printRegName(raw_ostream &OS, MCRegister Reg) const override;
  void printInst(const MCInst *MI, uint64_t Address, StringRef Annot,
                 const MCSubtargetInfo &STI, raw_ostream &OS) override;

  // Used by tblegen code.
  void printOperand(const MCInst *MI, unsigned OpNo, raw_ostream &O,
                    bool IsVariadicDef = false);
  void printBrList(const MCInst *MI, unsigned OpNo, raw_ostream &O);
  void printWebAssemblyP2AlignOperand(const MCInst *MI, unsigned OpNo,
                                      raw_ostream &O);
  void printWebAssemblySignatureOperand(const MCInst *MI, unsigned OpNo,
                                        raw_ostream &O);

  // Autogenerated by tblgen.
  std::pair<const char *, uint64_t> getMnemonic(const MCInst *MI) override;
  void printInstruction(const MCInst *MI, uint64_t Address, raw_ostream &O);
  static const char *getRegisterName(MCRegister Reg);
};

} // end namespace llvm

#endif
