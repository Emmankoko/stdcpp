/*******************************

	test for std::list
******************************/

module stdcpp.test.list;

import stdcpp.list;

unittest
{
	auto p = list!int(5,5);
	p.push_back(5);
	p.push_front(7);
	p.assign(5,5);
	p.pop_front();
	p.resize(3);

	list!int cp_obj = p; //opAssign
	cp_obj.push_back(45);
	cp_obj.push_back(56);
	auto newctor = list!int(4);
	newctor.push_back(6);
}
