
module stdcpp.map;
/*
import core.stdcpp.allocator;
import core.stdcpp.utility : pair;
import core.stdcpp.xutility : StdNamespace;
extern(C++, (StdNamespace)):

struct less(T)
{
}
alias map(Key, Mapped_value) = map!(Key, Mapped_value, less!Key, allocator!(pair!(const(Key), Mapped_value)));
extern(C++, class) struct map(Key, Mapped_value, compare, Alloc)
{
	alias key = Key;

	alias value = Mapped_value;

	alias size_type = size_t;

	alias difference_type = ptrdiff_t;

	alias key_compare = compare;

	alias allocator_type = Alloc;

	version(CppRuntime_Gcc)
	{
		this(const ref Alloc);

		extern(D) this(ref const map __x)
		{
			allocator_type alloc_instance = allocator_type.init;
			this(__x, alloc_instance);
		}

		extern(D) this(const key_compare comp)
		{
			allocator_type alloc_instance = allocator_type.init;
			this(comp, alloc_instance);
		}

		extern(D) ref value opIndex(const key val)
		{
			return this.opIndex(val);
		}

		this(const ref key_compare comp, const ref allocator_type alloc);

		this(ref const map!(key, value) __x, ref const allocator!(pair!(const key, value)));

//		~this();

		ref value opIndex(ref const key var);
		{
			
		}

		ref map opAssign(const ref map other);

		allocator_type get_allocator() const nothrow;

		ref value at(ref const key item) const; 

		size_type size() const nothrow;

		bool empty() const nothrow;

		size_type max_size() const nothrow;

		void clear() nothrow;

		size_type erase(ref const key key_var);

		extern(D) size_type erase(const key item)
		{
			return this.erase(item);
		}

		size_type count(const ref key key_var) const;

		size_type count(U)(ref const U x) const; // since c++14

		bool contains(const ref Key key_var) const;

		//observers

		key_compare key_comp() const;

		key_compare value_comp() const;

		 _Rb_tree _M_t;
	}
}
	
private:

	enum _Rb_tree_color { red = false, black = true};
    struct _Tree_node
    {
		_Rb_tree_color _M_color;
        _Tree_node* parent;
        _Tree_node* left;
        _Tree_node* right;
    }

	struct _Rb_tree_key_compare(U)
	{
		U _M_key_compare;
	}


	struct _Rb_tree
	{

		_Tree_node _M_header;
		size_t node_count;
		_Rb_tree_key_compare!(less!int) a;

	} 



*/
