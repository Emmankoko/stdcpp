/*******************************************************************************

    Tests for std::list

*******************************************************************************/

module stdcpp.test.list;

import stdcpp.test.base;
import stdcpp.list;

/// Test that the sizes matches
unittest
{
    assert(cppSizeOf!(list!int) == list!int.sizeof);
}

unittest
{
    auto p = list!int(5);
    p.push_back(5);
    assert(p.size() == 6);
    assert(p.front() == 0);
    assert(p.back() == 5);
    p.push_front(7);
    assert(p.front() == 7);
    p.clear();
    assert(p.size() == 0);
    p.assign(5,5);
    assert(p.size == 5);
    p.pop_front();
    assert(p.size == 4);
    p.resize(3);
    assert(p.size == 3);

    list!int cp_obj = p; // copy ctor
    assert(cp_obj.size == 3);
    cp_obj.clear();
    cp_obj.push_back(45);
    cp_obj.push_back(56);
    assert(cp_obj.front == 45);
    assert(cp_obj.back == 56);
}

unittest
{
    import stdcpp.allocator;
    allocator!int alloc_instance = allocator!(int).init;
    auto q = list!int(8, 9);
    assert(q.get_allocator == alloc_instance);
    assert(q.size == 8);
    auto p = list!int(3);
    q = p; // opAssign
    assert(q.size == 3); // after opAssign
}
