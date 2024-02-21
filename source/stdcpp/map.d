module stdcpp.map;

import stdcpp.tree;
import stdcpp.utility;
import stdcpp.allocator;
import stdcpp.xutility : StdNamespace;

extern(C++, (StdNamespace)):
extern(C++, class) struct map(T, V)