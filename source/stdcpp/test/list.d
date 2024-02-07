/*******************************************************************************

    Tests for std::list

*******************************************************************************/

module stdcpp.test.list;

import stdcpp.list;
version (CppRuntime_Gcc)
{
unittest
{
    auto p = list!int(5);
    p.push_back(5);
    assert(p.sizeof == 24);
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

    list!int cp_obj = p; //opAssign
    assert(cp_obj.size == 3);
    cp_obj.clear();
    cp_obj.push_back(45);
    cp_obj.push_back(56);
    assert(cp_obj.front == 45);
    assert(cp_obj.back == 56);
}
} 

version (CppRuntime_Clang)
{

unittest
{
	auto p = list!int(5,5);
	p.push_back(5);
	p.push_front(7);
/*	p.assign(5,5);
	p.pop_front();
	p.resize(3);
	p.clear();
	assert(p.empty() == 1);

	list!int cp_obj = p; //opAssign
	cp_obj.push_back(45);
	cp_obj.push_back(56);
	auto newctor = list!int(4);
	newctor.push_back(6);
	assert(newctor.front == 0);// test for front
	assert(newctor.back == 6);
	assert(newctor.empty == 0);
	assert(newctor.size() == 5); //slow testing for size
	auto cpctor = list!int(newctor); // copy constructor
	assert(cpctor.sizeof == 24); //checking for 24 byte size for list on Mac
	cp_obj.remove(45);
	cp_obj.clear();
	assert(cp_obj.empty == 1);

	auto new_list = list!int(7);
	assert(new_list.size == 7);
	assert(new_list.front == 0);
	assert(new_list.empty == 0);
	assert(new_list.back == 0);
	new_list.clear();
	assert(new_list.empty == 1);
    */
}
}
