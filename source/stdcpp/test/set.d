/*******************************************************************************

    Tests for `std::set`

*******************************************************************************/

module stdcpp.test.set;

import stdcpp.set;

unittest
{
	less!int a;
	auto p = set!int(a);
	p.insert(5);
	assert(p.size == 1);
	assert(p.empty == 0);
	p.erase(5);
	assert(p.size == 0);
	assert(p.empty == 1);
}
