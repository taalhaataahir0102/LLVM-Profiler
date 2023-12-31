//===-- ControlFlowInterfaces.td - ControlFlow Interfaces --*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains a set of interfaces that can be used to define information
// about control flow operations, e.g. branches.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_INTERFACES_CONTROLFLOWINTERFACES
#define MLIR_INTERFACES_CONTROLFLOWINTERFACES

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// BranchOpInterface
//===----------------------------------------------------------------------===//

def BranchOpInterface : OpInterface<"BranchOpInterface"> {
  let description = [{
    This interface provides information for branching terminator operations,
    i.e. terminator operations with successors.

    This interface is meant to model well-defined cases of control-flow of
    value propagation, where what occurs along control-flow edges is assumed to
    be side-effect free. For example, corresponding successor operands and
    successor block arguments may have different types. In such cases,
    `areTypesCompatible` can be implemented to compare types along control-flow
    edges. By default, type equality is used.
  }];
  let cppNamespace = "::mlir";

  let methods = [
    InterfaceMethod<[{
        Returns the operands that correspond to the arguments of the successor
        at the given index. It consists of a number of operands that are
        internally produced by the operation, followed by a range of operands
        that are forwarded. An example operation making use of produced
        operands would be:

        ```mlir
        invoke %function(%0)
            label ^success ^error(%1 : i32)

        ^error(%e: !error, %arg0: i32):
            ...
        ```

        The operand that would map to the `^error`s `%e` operand is produced
        by the `invoke` operation, while `%1` is a forwarded operand that maps
        to `%arg0` in the successor.

        Produced operands always map to the first few block arguments of the
        successor, followed by the forwarded operands. Mapping them in any
        other order is not supported by the interface.

        By having the forwarded operands last allows users of the interface
        to append more forwarded operands to the branch operation without
        interfering with other successor operands.
      }],
      "::mlir::SuccessorOperands", "getSuccessorOperands",
      (ins "unsigned":$index)
    >,
    InterfaceMethod<[{
        Returns the `BlockArgument` corresponding to operand `operandIndex` in
        some successor, or std::nullopt if `operandIndex` isn't a successor operand
        index.
      }],
      "::std::optional<::mlir::BlockArgument>", "getSuccessorBlockArgument",
      (ins "unsigned":$operandIndex), [{
        ::mlir::Operation *opaqueOp = $_op;
        for (unsigned i = 0, e = opaqueOp->getNumSuccessors(); i != e; ++i) {
          if (::std::optional<::mlir::BlockArgument> arg = ::mlir::detail::getBranchSuccessorArgument(
                $_op.getSuccessorOperands(i), operandIndex,
                opaqueOp->getSuccessor(i)))
            return arg;
        }
        return ::std::nullopt;
      }]
    >,
    InterfaceMethod<[{
        Returns the successor that would be chosen with the given constant
        operands. Returns nullptr if a single successor could not be chosen.
      }],
      "::mlir::Block *", "getSuccessorForOperands",
      (ins "::llvm::ArrayRef<::mlir::Attribute>":$operands), [{}],
      /*defaultImplementation=*/[{ return nullptr; }]
    >,
    InterfaceMethod<[{
        This method is called to compare types along control-flow edges. By
        default, the types are checked as equal.
      }],
      "bool", "areTypesCompatible",
      (ins "::mlir::Type":$lhs, "::mlir::Type":$rhs), [{}],
       [{ return lhs == rhs; }]
    >,
  ];

  let verify = [{
    auto concreteOp = ::mlir::cast<ConcreteOp>($_op);
    for (unsigned i = 0, e = $_op->getNumSuccessors(); i != e; ++i) {
      ::mlir::SuccessorOperands operands = concreteOp.getSuccessorOperands(i);
      if (::mlir::failed(::mlir::detail::verifyBranchSuccessorOperands($_op, i, operands)))
        return ::mlir::failure();
    }
    return ::mlir::success();
  }];
}

//===----------------------------------------------------------------------===//
// RegionBranchOpInterface
//===----------------------------------------------------------------------===//

def RegionBranchOpInterface : OpInterface<"RegionBranchOpInterface"> {
  let description = [{
    This interface provides information for region operations that contain
    branching behavior between held regions, i.e. this interface allows for
    expressing control flow information for region holding operations.

    This interface is meant to model well-defined cases of control-flow of
    value propagation, where what occurs along control-flow edges is assumed to
    be side-effect free. For example, corresponding successor operands and
    successor block arguments may have different types. In such cases,
    `areTypesCompatible` can be implemented to compare types along control-flow
    edges. By default, type equality is used.
  }];
  let cppNamespace = "::mlir";

  let methods = [
    InterfaceMethod<[{
        Returns the operands of this operation used as the entry arguments when
        entering the region at `index`, which was specified as a successor of
        this operation by `getEntrySuccessorRegions`, or the operands forwarded
        to the operation's results when it branches back to itself. These operands
        should correspond 1-1 with the successor inputs specified in
        `getEntrySuccessorRegions`.
      }],
      "::mlir::OperandRange", "getEntrySuccessorOperands",
      (ins "::std::optional<unsigned>":$index), [{}],
      /*defaultImplementation=*/[{
        auto operandEnd = this->getOperation()->operand_end();
        return ::mlir::OperandRange(operandEnd, operandEnd);
      }]
    >,
    InterfaceMethod<[{
        Returns the viable region successors that are branched to when first
        executing the op.
        Unlike `getSuccessorRegions`, this method also passes along the
        constant operands of this op. Based on these, different region
        successors can be determined.
        `operands` contains an entry for every operand of the implementing
        op with a null attribute if the operand has no constant value or
        the corresponding attribute if it is a constant.

        By default, simply dispatches to `getSuccessorRegions`.
      }],
      "void", "getEntrySuccessorRegions",
      (ins "::llvm::ArrayRef<::mlir::Attribute>":$operands,
           "::llvm::SmallVectorImpl<::mlir::RegionSuccessor> &":$regions),
           [{}], [{
        $_op.getSuccessorRegions(std::nullopt, regions);
      }]
    >,
    InterfaceMethod<[{
        Returns the viable successors of a region at `index`, or the possible
        successors when branching from the parent op if `index` is None. These
        are the regions that may be selected during the flow of control. The
        parent operation, i.e. a null `index`, may specify itself as successor,
        which indicates that the control flow may not enter any region at all.
        This method allows for describing which regions may be executed when
        entering an operation, and which regions are executed after having
        executed another region of the parent op. The successor region must be
        non-empty.
      }],
      "void", "getSuccessorRegions",
      (ins "::std::optional<unsigned>":$index,
           "::llvm::SmallVectorImpl<::mlir::RegionSuccessor> &":$regions)
    >,
    InterfaceMethod<[{
        Populates `invocationBounds` with the minimum and maximum number of
        times this operation will invoke the attached regions (assuming the
        regions yield normally, i.e. do not abort or invoke an infinite loop).
        The minimum number of invocations is at least 0. If the maximum number
        of invocations cannot be statically determined, then it will not have a
        value (i.e., it is set to `std::nullopt`).

        `operands` is a set of optional attributes that either correspond to
        constant values for each operand of this operation or null if that
        operand is not a constant.

        This method may be called speculatively on operations where the provided
        operands are not necessarily the same as the operation's current
        operands. This may occur in analyses that wish to determine "what would
        be the region invocations if these were the operands?"
      }],
      "void", "getRegionInvocationBounds",
      (ins "::llvm::ArrayRef<::mlir::Attribute>":$operands,
           "::llvm::SmallVectorImpl<::mlir::InvocationBounds> &"
             :$invocationBounds), [{}],
       [{ invocationBounds.append($_op->getNumRegions(),
                                  ::mlir::InvocationBounds::getUnknown()); }]
    >,
    InterfaceMethod<[{
        This method is called to compare types along control-flow edges. By
        default, the types are checked as equal.
      }],
      "bool", "areTypesCompatible",
      (ins "::mlir::Type":$lhs, "::mlir::Type":$rhs), [{}],
       [{ return lhs == rhs; }]
    >,
  ];

  let verify = [{
    static_assert(!ConcreteOp::template hasTrait<OpTrait::ZeroRegions>(),
                  "expected operation to have non-zero regions");
    return detail::verifyTypesAlongControlFlowEdges($_op);
  }];
  let verifyWithRegions = 1;

  let extraClassDeclaration = [{
    /// Return `true` if control flow originating from the given region may
    /// eventually branch back to the same region. (Maybe after passing through
    /// other regions.)
    bool isRepetitiveRegion(unsigned index);
  }];
}

//===----------------------------------------------------------------------===//
// RegionBranchTerminatorOpInterface
//===----------------------------------------------------------------------===//

def RegionBranchTerminatorOpInterface :
  OpInterface<"RegionBranchTerminatorOpInterface"> {
  let description = [{
    This interface provides information for branching terminator operations
    in the presence of a parent RegionBranchOpInterface implementation. It
    specifies which operands are passed to which successor region.
  }];
  let cppNamespace = "::mlir";

  let methods = [
    InterfaceMethod<[{
        Returns a mutable range of operands that are semantically "returned" by
        passing them to the region successor given by `index`.  If `index` is
        None, this function returns the operands that are passed as a result to
        the parent operation.
      }],
      "::mlir::MutableOperandRange", "getMutableSuccessorOperands",
      (ins "::std::optional<unsigned>":$index)
    >,
    InterfaceMethod<[{
        Returns the viable region successors that are branched to after this
        terminator based on the given constant operands.

        `operands` contains an entry for every operand of the
        implementing op with a null attribute if the operand has no constant
        value or the corresponding attribute if it is a constant.

        Default implementation simply dispatches to the parent
        `RegionBranchOpInterface`'s `getSuccessorRegions` implementation.
      }],
      "void", "getSuccessorRegions",
      (ins "::llvm::ArrayRef<::mlir::Attribute>":$operands,
           "::llvm::SmallVectorImpl<::mlir::RegionSuccessor> &":$regions), [{}],
      [{
        ::mlir::Operation *op = $_op;
        ::llvm::cast<::mlir::RegionBranchOpInterface>(op->getParentOp())
          .getSuccessorRegions(op->getParentRegion()->getRegionNumber(),
            regions);
      }]
    >,
  ];

  let verify = [{
    static_assert(ConcreteOp::template hasTrait<OpTrait::IsTerminator>(),
                  "expected operation to be a terminator");
    static_assert(ConcreteOp::template hasTrait<OpTrait::ZeroResults>(),
                  "expected operation to have zero results");
    static_assert(ConcreteOp::template hasTrait<OpTrait::ZeroSuccessors>(),
                  "expected operation to have zero successors");
    return success();
  }];

  let extraClassDeclaration = [{
    // Returns a range of operands that are semantically "returned" by passing
    // them to the region successor given by `index`.  If `index` is None, this
    // function returns the operands that are passed as a result to the parent
    // operation.
    ::mlir::OperandRange getSuccessorOperands(std::optional<unsigned> index) {
      return getMutableSuccessorOperands(index);
    }
  }];
}

//===----------------------------------------------------------------------===//
// ControlFlow Traits
//===----------------------------------------------------------------------===//

// Op is "return-like".
def ReturnLike : TraitList<[
    DeclareOpInterfaceMethods<RegionBranchTerminatorOpInterface>,
    NativeOpTrait<
        /*name=*/"ReturnLike",
        /*traits=*/[],
        /*extraOpDeclaration=*/"",
        /*extraOpDefinition=*/[{
          ::mlir::MutableOperandRange $cppClass::getMutableSuccessorOperands(
            ::std::optional<unsigned> index) {
            return ::mlir::MutableOperandRange(*this);
          }
        }]
    >
]>;

#endif // MLIR_INTERFACES_CONTROLFLOWINTERFACES
