/*******************************************************************************

    Tests for `std::map`

*******************************************************************************/

module stdcpp.test.map;

import stdcpp.map;

unittest
{
    auto mymap = Map!(int, char).make();
    mymap.opIndexAssign(1, 'a');
}
