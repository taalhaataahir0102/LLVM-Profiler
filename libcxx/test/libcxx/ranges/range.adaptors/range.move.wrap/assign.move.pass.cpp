//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14, c++17

// <copyable-box>& operator=(<copyable-box>&&)

// ADDITIONAL_COMPILE_FLAGS: -Wno-self-move

#include <ranges>

#include <cassert>
#include <type_traits>
#include <utility> // in_place_t

#include "test_macros.h"
#include "types.h"

constexpr bool test() {
  // Test the primary template
  {
    using Box = std::ranges::__movable_box<CopyConstructible>;
    static_assert(std::is_move_assignable_v<Box>);
    static_assert(!std::is_nothrow_move_assignable_v<Box>);

    {
      Box x(std::in_place, 5);
      Box y(std::in_place, 10);
      Box& result = (x = std::move(y));

      assert(&result == &x);
      assert(x.__has_value());
      assert(y.__has_value());
      assert((*x).value == 10);
    }
    // check self-assignment
    {
      Box x(std::in_place, 5);
      Box& result = (x = std::move(x));

      assert(&result == &x);
      assert(x.__has_value());
      assert((*x).value == 5);
    }
  }

  // Make sure that we use the native move assignment in the primary template if we can.
  {
    using Box = std::ranges::__movable_box<CopyConstructibleMovable>;
    static_assert(std::is_move_assignable_v<Box>);
    static_assert(
        std::is_nothrow_move_assignable_v<Box> == std::is_nothrow_move_assignable_v<CopyConstructibleMovable>);

    {
      Box x(std::in_place, 5);
      Box y(std::in_place, 10);
      Box& result = (x = std::move(y));

      assert(&result == &x);
      assert(x.__has_value());
      assert(y.__has_value());
      assert((*x).value == 10);
      assert((*x).did_move_assign);
    }
    // check self-assignment
    {
      Box x(std::in_place, 5);
      Box& result = (x = std::move(x));

      assert(&result == &x);
      assert(x.__has_value());
      assert((*x).value == 5);
      assert((*x).did_move_assign);
    }
  }

  // Test optimization #1 for move assignment
  {
    using Box = std::ranges::__movable_box<Copyable>;
    static_assert(std::is_move_assignable_v<Box>);
    static_assert(!std::is_nothrow_move_assignable_v<Box>);

    {
      Box x(std::in_place, 5);
      Box y(std::in_place, 10);
      Box& result = (x = std::move(y));

      assert(&result == &x);
      assert(x.__has_value());
      assert(y.__has_value());
      assert((*x).value == 10);
      assert((*x).did_move_assign);
    }
    // check self-assignment (should use the underlying type's assignment too)
    {
      Box x(std::in_place, 5);
      Box& result = (x = std::move(x));

      assert(&result == &x);
      assert(x.__has_value());
      assert((*x).value == 5);
      assert((*x).did_move_assign);
    }
  }

  // Test optimization #1 for move assignment with a type that uses optimization #2 for copy assignment
  {
    using Box = std::ranges::__movable_box<MovableNothrowCopyConstructible>;
    static_assert(std::is_move_assignable_v<Box>);
    static_assert(
        std::is_nothrow_move_assignable_v<Box> == std::is_nothrow_move_assignable_v<MovableNothrowCopyConstructible>);

    {
      Box x(std::in_place, 5);
      Box y(std::in_place, 10);
      Box& result = (x = std::move(y));

      assert(&result == &x);
      assert(x.__has_value());
      assert(y.__has_value());
      assert((*x).value == 10);
      assert((*x).did_move_assign);
    }
    // check self-assignment (should use the underlying type's assignment too)
    {
      Box x(std::in_place, 5);
      Box& result = (x = std::move(x));

      assert(&result == &x);
      assert(x.__has_value());
      assert((*x).value == 5);
      assert((*x).did_move_assign);
    }
  }

  // Test optimization #2 for move assignment
  {
    using Box = std::ranges::__movable_box<NothrowCopyConstructible>;
    static_assert(std::is_move_assignable_v<Box>);
    static_assert(std::is_nothrow_move_assignable_v<Box>);

    {
      Box x(std::in_place, 5);
      Box y(std::in_place, 10);
      Box& result = (x = std::move(y));

      assert(&result == &x);
      assert(x.__has_value());
      assert(y.__has_value());
      assert((*x).value == 10);
    }
    // check self-assignment
    {
      Box x(std::in_place, 5);
      Box& result = (x = std::move(x));

      assert(&result == &x);
      assert(x.__has_value());
      assert((*x).value == 5);
    }
  }

  return true;
}

// Tests for the empty state. Those can't be constexpr, since they are only reached
// through throwing an exception.
#if !defined(TEST_HAS_NO_EXCEPTIONS)
void test_empty_state() {
  using Box = std::ranges::__movable_box<ThrowsOnCopy>;

  // assign non-empty to empty
  {
    Box x = create_empty_box();
    Box y(std::in_place, 10);
    Box& result = (x = std::move(y));

    assert(&result == &x);
    assert(x.__has_value());
    assert(y.__has_value());
    assert((*x).value == 10);
  }
  // assign empty to non-empty
  {
    Box x(std::in_place, 5);
    Box y       = create_empty_box();
    Box& result = (x = std::move(y));

    assert(&result == &x);
    assert(!x.__has_value());
    assert(!y.__has_value());
  }
  // assign empty to empty
  {
    Box x       = create_empty_box();
    Box y       = create_empty_box();
    Box& result = (x = std::move(y));

    assert(&result == &x);
    assert(!x.__has_value());
    assert(!y.__has_value());
  }
  // check self-assignment in empty case
  {
    Box x       = create_empty_box();
    Box& result = (x = std::move(x));

    assert(&result == &x);
    assert(!x.__has_value());
  }
}
#endif // !defined(TEST_HAS_NO_EXCEPTIONS)

int main(int, char**) {
  assert(test());
  static_assert(test());

#if !defined(TEST_HAS_NO_EXCEPTIONS)
  test_empty_state();
#endif

  return 0;
}
