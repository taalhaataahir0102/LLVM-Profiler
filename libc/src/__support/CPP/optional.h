//===-- Standalone implementation of std::optional --------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_SRC_SUPPORT_CPP_OPTIONAL_H
#define LLVM_LIBC_SRC_SUPPORT_CPP_OPTIONAL_H

#include "src/__support/CPP/type_traits.h"
#include "src/__support/CPP/utility.h"
#include "src/__support/macros/attributes.h"

namespace __llvm_libc {
namespace cpp {

// Trivial in_place_t struct.
struct in_place_t {
  LIBC_INLINE constexpr explicit in_place_t() = default;
};

// Trivial nullopt_t struct.
struct nullopt_t {
  LIBC_INLINE constexpr explicit nullopt_t() = default;
};

// nullopt that can be used and returned.
LIBC_INLINE_VAR constexpr nullopt_t nullopt{};

// in_place that can be used in the constructor.
LIBC_INLINE_VAR constexpr in_place_t in_place{};

// This is very simple implementation of the std::optional class. It makes
// several assumptions that the underlying type is trivially constructable,
// copyable, or movable.
template <typename T> class optional {
  template <typename U, bool = !is_trivially_destructible<U>::value>
  struct OptionalStorage {
    union {
      char empty;
      U stored_value;
    };

    LIBC_INLINE ~OptionalStorage() { stored_value.~U(); }
    LIBC_INLINE constexpr OptionalStorage() : empty() {}

    template <typename... Args>
    LIBC_INLINE constexpr explicit OptionalStorage(in_place_t, Args &&...args)
        : stored_value(forward<Args>(args)...) {}
  };

  template <typename U> struct OptionalStorage<U, false> {
    union {
      char empty;
      U stored_value;
    };

    // The only difference is that this class doesn't have a destructor.
    LIBC_INLINE constexpr OptionalStorage() : empty() {}

    template <typename... Args>
    LIBC_INLINE constexpr explicit OptionalStorage(in_place_t, Args &&...args)
        : stored_value(forward<Args>(args)...) {}
  };

  OptionalStorage<T> storage;
  bool in_use = false;

public:
  LIBC_INLINE constexpr optional() = default;
  LIBC_INLINE constexpr optional(nullopt_t) {}

  LIBC_INLINE constexpr optional(const T &t)
      : storage(in_place, t), in_use(true) {}
  LIBC_INLINE constexpr optional(const optional &) = default;

  LIBC_INLINE constexpr optional(T &&t)
      : storage(in_place, move(t)), in_use(true) {}
  LIBC_INLINE constexpr optional(optional &&O) = default;

  template <typename... ArgTypes>
  LIBC_INLINE constexpr optional(in_place_t, ArgTypes &&...Args)
      : storage(in_place, forward<ArgTypes>(Args)...), in_use(true) {}

  LIBC_INLINE constexpr optional &operator=(T &&t) {
    storage = move(t);
    return *this;
  }
  LIBC_INLINE constexpr optional &operator=(optional &&) = default;

  LIBC_INLINE constexpr optional &operator=(const T &t) {
    storage = t;
    return *this;
  }
  LIBC_INLINE constexpr optional &operator=(const optional &) = default;

  LIBC_INLINE constexpr void reset() {
    if (in_use)
      storage.~OptionalStorage();
    in_use = false;
  }

  LIBC_INLINE constexpr const T &value() const & {
    return storage.stored_value;
  }

  LIBC_INLINE constexpr T &value() & { return storage.stored_value; }

  LIBC_INLINE constexpr explicit operator bool() const { return in_use; }
  LIBC_INLINE constexpr bool has_value() const { return in_use; }
  LIBC_INLINE constexpr const T *operator->() const {
    return &storage.stored_value;
  }
  LIBC_INLINE constexpr T *operator->() { return &storage.stored_value; }
  LIBC_INLINE constexpr const T &operator*() const & {
    return storage.stored_value;
  }
  LIBC_INLINE constexpr T &operator*() & { return storage.stored_value; }

  LIBC_INLINE constexpr T &&value() && { return move(storage.stored_value); }
  LIBC_INLINE constexpr T &&operator*() && {
    return move(storage.stored_value);
  }
};

} // namespace cpp
} // namespace __llvm_libc

#endif // LLVM_LIBC_SRC_SUPPORT_CPP_OPTIONAL_H