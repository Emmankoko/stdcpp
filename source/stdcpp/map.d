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
    extern(D) void opIndexAssign (const Key key, Value value)
    {
        this.insertOrAssign(key, value);
    }

    static Map* make();
    private void insertOrAssign(const ref Key, const ref Value); 
 }