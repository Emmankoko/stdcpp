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
	set!int q = a;
	q.swap(p);
	set!int j = a;
	q = j; // opAssign
	//set!int q = p;

//	assert(p.sizeof == 8);
//	p.insert(5);
//	assert(p.size() == 0);
//	assert(p.empty() == 1);
/*	p.erase(5);
	p.insert(6);
	p.clear;
	assert(p.size == 0);
	assert(p.empty == 1);
	set!int q = a;
	q.swap(p);
	q.insert(4);
	q.insert(4);
	q.insert(4);
	assert(q.size == 1);
	assert(q.count(4) == 1);//count for set only results in 0 for not present or 1 for present
	assert(q.count(5) == 0);
	assert(q.sizeof == 48);
	assert(q.contains(4) == 1); // q contains 4 evaluates to true
	auto iter = q.find(4);
	set!int w = q; //copy constructor
//	assert(*iter == 4);
	
*/
}
