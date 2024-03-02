/*******************************************************************************

    Tests for std::unordered_map

*******************************************************************************/

module stdcpp.test.unordered_map;

//import stdcpp.test.base;
import stdcpp.unordered_map;

/// Test that the sizes matches
//unittest
//{
//    assert(cppSizeOf!(list!int) == list!int.sizeof);
//}
unittest
{
    auto p = unordered_map!(int, char)(5);
	p.insert(1, 'a');
	p.insert(2, 'b');
	assert(p.size == 2);
	p.insert(3, 'c');
	assert(p.size == 3);
	assert(p.bucket_count == 5);
	assert(p.bucket_size(1) == 1); //return number of elements with index 0
	assert(p.empty == 0);
	p.clear();
	assert(p.empty == 1);
	
	
	
}
