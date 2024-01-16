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
	assert(p.key_comp() == a);
	assert(p.contains(5) == 0);
	assert(p.contains(8) == 0);
	assert(p.count(6) == 0); // as said, count is always a 1 or 0 as set priotitizes uniqueness. 
	assert(p.count(9) == 0);
	assert(p.count(8) == 0);

}
