/*******************************************************************************

    Tests for `std::set`

*******************************************************************************/

module stdcpp.test.set;

import stdcpp.set;

unittest
{
	less!int a;
	set!int p = a;
	assert(p.sizeof == 16);
	set!int q = a; // copy ctor
	q.swap(p);
	set!int j = a;
	q = j; // opAssign
	p.clear;
	assert(p.size == 0);
	assert(p.empty == 1);
}
