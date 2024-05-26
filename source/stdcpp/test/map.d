/*******************************************************************************

    Tests for `std::map`

*******************************************************************************/

module stdcpp.test.map;

import stdcpp.map;

unittest
{
    auto mymap = Map!(int, char).make();
    mymap.opIndexAssign(1, 'a');
    assert(mymap.size == 1);
    assert(mymap.opIndex(1) == 'a');
    mymap.opIndex(2) = 'b';
    mymap.opIndex(3) = 'c';
    assert(mymap.contains(3) == 1); // returns true
    assert(mymap.size == 3);
    assert(mymap.empty == 0);
    assert(mymap.at(2) == 'b');
    assert(mymap.count(1) == 1);
    mymap.clear();
    assert(mymap.size == 0);
    assert(mymap.empty == 1);
    assert(mymap.count(1) == 0); // container cleared
}
