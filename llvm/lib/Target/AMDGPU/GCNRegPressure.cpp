//===- GCNRegPressure.cpp -------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements the GCNRegPressure class.
///
//===----------------------------------------------------------------------===//

#include "GCNRegPressure.h"
#include "llvm/CodeGen/RegisterPressure.h"

using namespace llvm;

#define DEBUG_TYPE "machine-scheduler"

bool llvm::isEqual(const GCNRPTracker::LiveRegSet &S1,
                   const GCNRPTracker::LiveRegSet &S2) {
  if (S1.size() != S2.size())
    return false;

  for (const auto &P : S1) {
    auto I = S2.find(P.first);
    if (I == S2.end() || I->second != P.second)
      return false;
  }
  return true;
}


///////////////////////////////////////////////////////////////////////////////
// GCNRegPressure

unsigned GCNRegPressure::getRegKind(Register Reg,
                                    const MachineRegisterInfo &MRI) {
  assert(Reg.isVirtual());
  const auto RC = MRI.getRegClass(Reg);
  auto STI = static_cast<const SIRegisterInfo*>(MRI.getTargetRegisterInfo());
  return STI->isSGPRClass(RC)
             ? (STI->getRegSizeInBits(*RC) == 32 ? SGPR32 : SGPR_TUPLE)
         : STI->isAGPRClass(RC)
             ? (STI->getRegSizeInBits(*RC) == 32 ? AGPR32 : AGPR_TUPLE)
             : (STI->getRegSizeInBits(*RC) == 32 ? VGPR32 : VGPR_TUPLE);
}

void GCNRegPressure::inc(unsigned Reg,
                         LaneBitmask PrevMask,
                         LaneBitmask NewMask,
                         const MachineRegisterInfo &MRI) {
  if (SIRegisterInfo::getNumCoveredRegs(NewMask) ==
      SIRegisterInfo::getNumCoveredRegs(PrevMask))
    return;

  int Sign = 1;
  if (NewMask < PrevMask) {
    std::swap(NewMask, PrevMask);
    Sign = -1;
  }

  switch (auto Kind = getRegKind(Reg, MRI)) {
  case SGPR32:
  case VGPR32:
  case AGPR32:
    Value[Kind] += Sign;
    break;

  case SGPR_TUPLE:
  case VGPR_TUPLE:
  case AGPR_TUPLE:
    assert(PrevMask < NewMask);

    Value[Kind == SGPR_TUPLE ? SGPR32 : Kind == AGPR_TUPLE ? AGPR32 : VGPR32] +=
      Sign * SIRegisterInfo::getNumCoveredRegs(~PrevMask & NewMask);

    if (PrevMask.none()) {
      assert(NewMask.any());
      Value[Kind] += Sign * MRI.getPressureSets(Reg).getWeight();
    }
    break;

  default: llvm_unreachable("Unknown register kind");
  }
}

bool GCNRegPressure::less(const GCNSubtarget &ST,
                          const GCNRegPressure& O,
                          unsigned MaxOccupancy) const {
  const auto SGPROcc = std::min(MaxOccupancy,
                                ST.getOccupancyWithNumSGPRs(getSGPRNum()));
  const auto VGPROcc =
    std::min(MaxOccupancy,
             ST.getOccupancyWithNumVGPRs(getVGPRNum(ST.hasGFX90AInsts())));
  const auto OtherSGPROcc = std::min(MaxOccupancy,
                                ST.getOccupancyWithNumSGPRs(O.getSGPRNum()));
  const auto OtherVGPROcc =
    std::min(MaxOccupancy,
             ST.getOccupancyWithNumVGPRs(O.getVGPRNum(ST.hasGFX90AInsts())));

  const auto Occ = std::min(SGPROcc, VGPROcc);
  const auto OtherOcc = std::min(OtherSGPROcc, OtherVGPROcc);
  if (Occ != OtherOcc)
    return Occ > OtherOcc;

  bool SGPRImportant = SGPROcc < VGPROcc;
  const bool OtherSGPRImportant = OtherSGPROcc < OtherVGPROcc;

  // if both pressures disagree on what is more important compare vgprs
  if (SGPRImportant != OtherSGPRImportant) {
    SGPRImportant = false;
  }

  // compare large regs pressure
  bool SGPRFirst = SGPRImportant;
  for (int I = 2; I > 0; --I, SGPRFirst = !SGPRFirst) {
    if (SGPRFirst) {
      auto SW = getSGPRTuplesWeight();
      auto OtherSW = O.getSGPRTuplesWeight();
      if (SW != OtherSW)
        return SW < OtherSW;
    } else {
      auto VW = getVGPRTuplesWeight();
      auto OtherVW = O.getVGPRTuplesWeight();
      if (VW != OtherVW)
        return VW < OtherVW;
    }
  }
  return SGPRImportant ? (getSGPRNum() < O.getSGPRNum()):
                         (getVGPRNum(ST.hasGFX90AInsts()) <
                          O.getVGPRNum(ST.hasGFX90AInsts()));
}

#if !defined(NDEBUG) || defined(LLVM_ENABLE_DUMP)
LLVM_DUMP_METHOD
Printable llvm::print(const GCNRegPressure &RP, const GCNSubtarget *ST) {
  return Printable([&RP, ST](raw_ostream &OS) {
    OS << "VGPRs: " << RP.Value[GCNRegPressure::VGPR32] << ' '
       << "AGPRs: " << RP.getAGPRNum();
    if (ST)
      OS << "(O"
         << ST->getOccupancyWithNumVGPRs(RP.getVGPRNum(ST->hasGFX90AInsts()))
         << ')';
    OS << ", SGPRs: " << RP.getSGPRNum();
    if (ST)
      OS << "(O" << ST->getOccupancyWithNumSGPRs(RP.getSGPRNum()) << ')';
    OS << ", LVGPR WT: " << RP.getVGPRTuplesWeight()
       << ", LSGPR WT: " << RP.getSGPRTuplesWeight();
    if (ST)
      OS << " -> Occ: " << RP.getOccupancy(*ST);
    OS << '\n';
  });
}
#endif

static LaneBitmask getDefRegMask(const MachineOperand &MO,
                                 const MachineRegisterInfo &MRI) {
  assert(MO.isDef() && MO.isReg() && MO.getReg().isVirtual());

  // We don't rely on read-undef flag because in case of tentative schedule
  // tracking it isn't set correctly yet. This works correctly however since
  // use mask has been tracked before using LIS.
  return MO.getSubReg() == 0 ?
    MRI.getMaxLaneMaskForVReg(MO.getReg()) :
    MRI.getTargetRegisterInfo()->getSubRegIndexLaneMask(MO.getSubReg());
}

static LaneBitmask getUsedRegMask(const MachineOperand &MO,
                                  const MachineRegisterInfo &MRI,
                                  const LiveIntervals &LIS) {
  assert(MO.isUse() && MO.isReg() && MO.getReg().isVirtual());

  if (auto SubReg = MO.getSubReg())
    return MRI.getTargetRegisterInfo()->getSubRegIndexLaneMask(SubReg);

  auto MaxMask = MRI.getMaxLaneMaskForVReg(MO.getReg());
  if (SIRegisterInfo::getNumCoveredRegs(MaxMask) > 1) // cannot have subregs
    return MaxMask;

  // For a tentative schedule LIS isn't updated yet but livemask should remain
  // the same on any schedule. Subreg defs can be reordered but they all must
  // dominate uses anyway.
  auto SI = LIS.getInstructionIndex(*MO.getParent()).getBaseIndex();
  return getLiveLaneMask(MO.getReg(), SI, LIS, MRI);
}

static SmallVector<RegisterMaskPair, 8>
collectVirtualRegUses(const MachineInstr &MI, const LiveIntervals &LIS,
                      const MachineRegisterInfo &MRI) {
  SmallVector<RegisterMaskPair, 8> Res;
  for (const auto &MO : MI.operands()) {
    if (!MO.isReg() || !MO.getReg().isVirtual())
      continue;
    if (!MO.isUse() || !MO.readsReg())
      continue;

    auto const UsedMask = getUsedRegMask(MO, MRI, LIS);

    auto Reg = MO.getReg();
    auto I = llvm::find_if(
        Res, [Reg](const RegisterMaskPair &RM) { return RM.RegUnit == Reg; });
    if (I != Res.end())
      I->LaneMask |= UsedMask;
    else
      Res.push_back(RegisterMaskPair(Reg, UsedMask));
  }
  return Res;
}

///////////////////////////////////////////////////////////////////////////////
// GCNRPTracker

LaneBitmask llvm::getLiveLaneMask(unsigned Reg,
                                  SlotIndex SI,
                                  const LiveIntervals &LIS,
                                  const MachineRegisterInfo &MRI) {
  LaneBitmask LiveMask;
  const auto &LI = LIS.getInterval(Reg);
  if (LI.hasSubRanges()) {
    for (const auto &S : LI.subranges())
      if (S.liveAt(SI)) {
        LiveMask |= S.LaneMask;
        assert(LiveMask < MRI.getMaxLaneMaskForVReg(Reg) ||
               LiveMask == MRI.getMaxLaneMaskForVReg(Reg));
      }
  } else if (LI.liveAt(SI)) {
    LiveMask = MRI.getMaxLaneMaskForVReg(Reg);
  }
  return LiveMask;
}

GCNRPTracker::LiveRegSet llvm::getLiveRegs(SlotIndex SI,
                                           const LiveIntervals &LIS,
                                           const MachineRegisterInfo &MRI) {
  GCNRPTracker::LiveRegSet LiveRegs;
  for (unsigned I = 0, E = MRI.getNumVirtRegs(); I != E; ++I) {
    auto Reg = Register::index2VirtReg(I);
    if (!LIS.hasInterval(Reg))
      continue;
    auto LiveMask = getLiveLaneMask(Reg, SI, LIS, MRI);
    if (LiveMask.any())
      LiveRegs[Reg] = LiveMask;
  }
  return LiveRegs;
}

void GCNRPTracker::reset(const MachineInstr &MI,
                         const LiveRegSet *LiveRegsCopy,
                         bool After) {
  const MachineFunction &MF = *MI.getMF();
  MRI = &MF.getRegInfo();
  if (LiveRegsCopy) {
    if (&LiveRegs != LiveRegsCopy)
      LiveRegs = *LiveRegsCopy;
  } else {
    LiveRegs = After ? getLiveRegsAfter(MI, LIS)
                     : getLiveRegsBefore(MI, LIS);
  }

  MaxPressure = CurPressure = getRegPressure(*MRI, LiveRegs);
}

void GCNUpwardRPTracker::reset(const MachineInstr &MI,
                               const LiveRegSet *LiveRegsCopy) {
  GCNRPTracker::reset(MI, LiveRegsCopy, true);
}

void GCNUpwardRPTracker::recede(const MachineInstr &MI) {
  assert(MRI && "call reset first");

  LastTrackedMI = &MI;

  if (MI.isDebugInstr())
    return;

  auto const RegUses = collectVirtualRegUses(MI, LIS, *MRI);

  // calc pressure at the MI (defs + uses)
  auto AtMIPressure = CurPressure;
  for (const auto &U : RegUses) {
    auto LiveMask = LiveRegs[U.RegUnit];
    AtMIPressure.inc(U.RegUnit, LiveMask, LiveMask | U.LaneMask, *MRI);
  }
  // update max pressure
  MaxPressure = max(AtMIPressure, MaxPressure);

  for (const auto &MO : MI.all_defs()) {
    if (!MO.getReg().isVirtual() || MO.isDead())
      continue;

    auto Reg = MO.getReg();
    auto I = LiveRegs.find(Reg);
    if (I == LiveRegs.end())
      continue;
    auto &LiveMask = I->second;
    auto PrevMask = LiveMask;
    LiveMask &= ~getDefRegMask(MO, *MRI);
    CurPressure.inc(Reg, PrevMask, LiveMask, *MRI);
    if (LiveMask.none())
      LiveRegs.erase(I);
  }
  for (const auto &U : RegUses) {
    auto &LiveMask = LiveRegs[U.RegUnit];
    auto PrevMask = LiveMask;
    LiveMask |= U.LaneMask;
    CurPressure.inc(U.RegUnit, PrevMask, LiveMask, *MRI);
  }
  assert(CurPressure == getRegPressure(*MRI, LiveRegs));
}

bool GCNDownwardRPTracker::reset(const MachineInstr &MI,
                                 const LiveRegSet *LiveRegsCopy) {
  MRI = &MI.getParent()->getParent()->getRegInfo();
  LastTrackedMI = nullptr;
  MBBEnd = MI.getParent()->end();
  NextMI = &MI;
  NextMI = skipDebugInstructionsForward(NextMI, MBBEnd);
  if (NextMI == MBBEnd)
    return false;
  GCNRPTracker::reset(*NextMI, LiveRegsCopy, false);
  return true;
}

bool GCNDownwardRPTracker::advanceBeforeNext() {
  assert(MRI && "call reset first");
  if (!LastTrackedMI)
    return NextMI == MBBEnd;

  assert(NextMI == MBBEnd || !NextMI->isDebugInstr());

  SlotIndex SI = NextMI == MBBEnd
                     ? LIS.getInstructionIndex(*LastTrackedMI).getDeadSlot()
                     : LIS.getInstructionIndex(*NextMI).getBaseIndex();
  assert(SI.isValid());

  // Remove dead registers or mask bits.
  SmallSet<Register, 8> SeenRegs;
  for (auto &MO : LastTrackedMI->operands()) {
    if (!MO.isReg() || !MO.getReg().isVirtual())
      continue;
    if (MO.isUse() && !MO.readsReg())
      continue;
    if (!SeenRegs.insert(MO.getReg()).second)
      continue;
    const LiveInterval &LI = LIS.getInterval(MO.getReg());
    if (LI.hasSubRanges()) {
      auto It = LiveRegs.end();
      for (const auto &S : LI.subranges()) {
        if (!S.liveAt(SI)) {
          if (It == LiveRegs.end()) {
            It = LiveRegs.find(MO.getReg());
            if (It == LiveRegs.end())
              llvm_unreachable("register isn't live");
          }
          auto PrevMask = It->second;
          It->second &= ~S.LaneMask;
          CurPressure.inc(MO.getReg(), PrevMask, It->second, *MRI);
        }
      }
      if (It != LiveRegs.end() && It->second.none())
        LiveRegs.erase(It);
    } else if (!LI.liveAt(SI)) {
      auto It = LiveRegs.find(MO.getReg());
      if (It == LiveRegs.end())
        llvm_unreachable("register isn't live");
      CurPressure.inc(MO.getReg(), It->second, LaneBitmask::getNone(), *MRI);
      LiveRegs.erase(It);
    }
  }

  MaxPressure = max(MaxPressure, CurPressure);

  LastTrackedMI = nullptr;

  return NextMI == MBBEnd;
}

void GCNDownwardRPTracker::advanceToNext() {
  LastTrackedMI = &*NextMI++;
  NextMI = skipDebugInstructionsForward(NextMI, MBBEnd);

  // Add new registers or mask bits.
  for (const auto &MO : LastTrackedMI->all_defs()) {
    Register Reg = MO.getReg();
    if (!Reg.isVirtual())
      continue;
    auto &LiveMask = LiveRegs[Reg];
    auto PrevMask = LiveMask;
    LiveMask |= getDefRegMask(MO, *MRI);
    CurPressure.inc(Reg, PrevMask, LiveMask, *MRI);
  }

  MaxPressure = max(MaxPressure, CurPressure);
}

bool GCNDownwardRPTracker::advance() {
  if (NextMI == MBBEnd)
    return false;
  advanceBeforeNext();
  advanceToNext();
  return true;
}

bool GCNDownwardRPTracker::advance(MachineBasicBlock::const_iterator End) {
  while (NextMI != End)
    if (!advance()) return false;
  return true;
}

bool GCNDownwardRPTracker::advance(MachineBasicBlock::const_iterator Begin,
                                   MachineBasicBlock::const_iterator End,
                                   const LiveRegSet *LiveRegsCopy) {
  reset(*Begin, LiveRegsCopy);
  return advance(End);
}

#if !defined(NDEBUG) || defined(LLVM_ENABLE_DUMP)
LLVM_DUMP_METHOD
Printable llvm::reportMismatch(const GCNRPTracker::LiveRegSet &LISLR,
                               const GCNRPTracker::LiveRegSet &TrackedLR,
                               const TargetRegisterInfo *TRI) {
  return Printable([&LISLR, &TrackedLR, TRI](raw_ostream &OS) {
    for (auto const &P : TrackedLR) {
      auto I = LISLR.find(P.first);
      if (I == LISLR.end()) {
        OS << "  " << printReg(P.first, TRI) << ":L" << PrintLaneMask(P.second)
           << " isn't found in LIS reported set\n";
      } else if (I->second != P.second) {
        OS << "  " << printReg(P.first, TRI)
           << " masks doesn't match: LIS reported " << PrintLaneMask(I->second)
           << ", tracked " << PrintLaneMask(P.second) << '\n';
      }
    }
    for (auto const &P : LISLR) {
      auto I = TrackedLR.find(P.first);
      if (I == TrackedLR.end()) {
        OS << "  " << printReg(P.first, TRI) << ":L" << PrintLaneMask(P.second)
           << " isn't found in tracked set\n";
      }
    }
  });
}

bool GCNUpwardRPTracker::isValid() const {
  const auto &SI = LIS.getInstructionIndex(*LastTrackedMI).getBaseIndex();
  const auto LISLR = llvm::getLiveRegs(SI, LIS, *MRI);
  const auto &TrackedLR = LiveRegs;

  if (!isEqual(LISLR, TrackedLR)) {
    dbgs() << "\nGCNUpwardRPTracker error: Tracked and"
              " LIS reported livesets mismatch:\n"
           << print(LISLR, *MRI);
    reportMismatch(LISLR, TrackedLR, MRI->getTargetRegisterInfo());
    return false;
  }

  auto LISPressure = getRegPressure(*MRI, LISLR);
  if (LISPressure != CurPressure) {
    dbgs() << "GCNUpwardRPTracker error: Pressure sets different\nTracked: "
           << print(CurPressure) << "LIS rpt: " << print(LISPressure);
    return false;
  }
  return true;
}

LLVM_DUMP_METHOD
Printable llvm::print(const GCNRPTracker::LiveRegSet &LiveRegs,
                      const MachineRegisterInfo &MRI) {
  return Printable([&LiveRegs, &MRI](raw_ostream &OS) {
    const TargetRegisterInfo *TRI = MRI.getTargetRegisterInfo();
    for (unsigned I = 0, E = MRI.getNumVirtRegs(); I != E; ++I) {
      Register Reg = Register::index2VirtReg(I);
      auto It = LiveRegs.find(Reg);
      if (It != LiveRegs.end() && It->second.any())
        OS << ' ' << printVRegOrUnit(Reg, TRI) << ':'
           << PrintLaneMask(It->second);
    }
    OS << '\n';
  });
}

LLVM_DUMP_METHOD
void GCNRegPressure::dump() const { dbgs() << print(*this); }

#endif
