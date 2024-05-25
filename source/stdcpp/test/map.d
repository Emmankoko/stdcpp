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
    assert(mymap.size == 3);
}
