module stdcpp.unordered_map;

import core.stdcpp.allocator;
import core.stdcpp.utility : pair;
import core.stdcpp.xutility : StdNamespace;
extern(C++, (StdNamespace)):

struct hash(T)
{
}

struct equal_to(T = void)
{
}
alias unordered_map(Key, value) = unordered_map!(Key, value, hash!Key, equal_to!Key, allocator!(pair!(const(Key), value)));
extern(C++, class) struct unordered_map(Key, value, Hash, KeyEqual, Alloc)
{
	alias key_type = Key;

	alias mapped_value = value;

	alias size_type = size_t;

	alias difference_type = ptrdiff_t;

	alias key_equal = KeyEqual;

	alias allocator_type = Alloc;

	alias Pair = pair!(const(Key), value);

	alias pointer = allocator_traits!(allocator_type).pointer;

	version(CppRuntime_Gcc)
	{
		///
		extern(D) this(size_type __x)
		{
			allocator_type alloc_instance = allocator_type.init;
			Hash hash_instance = Hash.init;
			key_equal equal_instance = key_equal.init;
			this(__x, hash_instance, equal_instance, alloc_instance);
		}
		///
		this(size_type bucket_count, const ref allocator_type);
		///
		extern(D) this(const ref unordered_map __a)
		{
			allocator_type alloc_instance = allocator_type.init;
			this(a, alloc_instance);
		}

		//only bucket_count is non-default, rest are default. called from 'extern(D) this(size_type __x)'
		this(size_type bucket_count, const ref Hash hash, const ref key_equal equal, const ref allocator_type __x);

		this(const ref unordered_map __x, const ref allocator_type __a);

		pair!(pointer, bool) insert(const ref Pair item);

		///capacity
		bool empty() const;
		///
		size_t size() const;
		///
		size_t max_size() const;

		///Modifiers
		void clear();
		///
		extern(D) pair!(pointer, bool) insert(const key_type key, value val)
        {
            Pair item = {key, val};
            return insert(item);
        }

		///bucket interface
		size_type bucket_count() const;

		size_type bucket_size(size_type n) const;
		size_t y;
		size_t a;
		size_t b;
		size_t n;
		size_t c;
		size_t d;
		size_t e;
	}
}
