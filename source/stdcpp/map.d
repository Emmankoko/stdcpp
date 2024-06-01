/**
 * D bindings for std::map
 * see_Also:
 * https://en.cppreference.com/w/cpp/container/map
 * Copyright: Copyright (c) 2023 D Language Foundation
 * License: Distributed under the
 *      $(LINK2 http://www.boost.org/LICENSE_1.0.txt, Boost Software License 1.0).
 *      (See accompanying file License)
 * Authors: Emmanuel Nyarko, Mathias Lang
 */
module stdcpp.map;

 extern(C++, class):
 struct Map(Key, Value)
 {
    ///
    extern(D) void opIndexAssign (const Key key, Value value)
    {
        this.insertOrAssign(key, value);
    }
    ///
    static Map* make();
    ///
    private void insertOrAssign(const ref Key, const ref Value);
    ///
    size_t size();
    ///
    ref Value opIndex( ref const Key key);
    ///
    ref Value opIndex(const Key key)
    {
        return this.opIndex(key); // handle rvalue-ref
    }
    ///
    ref Value at( ref const Key key);
    ///
    extern(D) ref Value at(const Key key)
    {
        return this.at(key);
    }
    ///
    bool empty() const nothrow;
    ///
    size_t max_size() const;
    ///
    void clear() nothrow;
    ///
    size_t count(ref const Key key) const;
    ///
    extern(D) size_t count(const Key key) const
    {
        return this.count(key);
    }
    ///
    bool contains( ref const Key key) const;
    ///
    extern(D) bool contains(const Key key) const
    {
        return this.contains(key);
    }
    ///
    void swap( Map* other) nothrow;
 }