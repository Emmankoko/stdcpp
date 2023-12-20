/*******************************

	test for std::list
******************************/

module stdcpp.test.list;

import stdcpp.list;

unittest
{
	auto p =list!int(5);
	p.push_back(5);
	assert(p.front == 0);//expects 0
	p.clear();
	assert(p.empty == true);//expects true
	assert(p.size == 0);//expects 0
	p.push_front(5);
	p.push_front(7);
	assert(p.size == 2); // expects 2
	assert(p.front == 7); // expects 7
	assert(p.back == 5); //expects 5
	assert(p.empty == false); //expects false
	p.sort();
	assert(p.front == 5); //expects 5
	assert(p.back == 7);//expects 7 now since there's a sort
	list!int q = 3;
	q.resize(2); //q = 0, 0
	assert(q.size == 2); // expects 2
	q.push_back(3); // q = 0,0,3
	q.push_front(6);// q = 6,0,0,3
	assert(q.size == 4); 
	q.reverse();// q = 3,0,0,6
	assert(q.front == 3);//expects 3
	assert(q.back == 6); //expects 6 since q has been reversed
	q.push_front(3); // q = 3,3,0,0,6
	q.push_back(3); //q = 3,3,0,0,6,3 && p = 5,7
	assert(p.size == 2); // expects 2
	assert(q.size == 6); // expects 6
	q.swap(p); //q is now = 5,7 && p = 3,3,0,0,6,3
	assert(p.front == 3); // expects 3
	assert(q.front == 5); //expects 5, q is now 5,7
	assert(p.size == 6); // expects 6
	auto N =list!int(p); //copy ctor
	assert(N.size == 6); // expects 6
	q.sort(); // q = 5,7
	p.sort(); // 0,0,3,3,3,6
	q.merge(p); // q = 0,0,3,3,3,5,6,7
	assert(q.size == 8); // expects 8
	assert(q.front == 0); // expects 0

}
