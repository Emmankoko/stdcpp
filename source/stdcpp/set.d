module stdcpp.set;

import stdcpp.allocator;
import stdcpp.utility : pair;
import stdcpp.xutility : StdNamespace;
extern(C++, (StdNamespace)):

//will definately be moved(maybe to stdcpp.utilities)
extern(C++, class) struct less(T)
{

}
public:
enum def {value =0};

alias set(Key) = set!(Key, less!Key, allocator!(Key));
extern(C++, class) struct set(Key, compare, Alloc)
{
	alias size_type = size_t;

	alias difference_type = ptrdiff_t;

	alias key_compare = compare;

	alias allocator_type = Alloc;

	alias pointer = Key*; // testing in place of iterator return type for now

	//enum comp { less};

	version(CppRuntime_Gcc)
	{
		this(const ref allocator!(Key));

		/*extern(D) this(def) // allocator-extended default ctor
		{
			allocator!(Key) alloc_instance =  allocator!(Key).init;
			this(alloc_instance);
		}*/

		extern(D) this(const compare comp)
		{
			allocator!(Key) alloc_instance =  allocator!(Key).init;
			this(comp, alloc_instance);
		}

		this(const ref compare comp, ref const allocator!(Key) alloc);

		this(ref const set!(Key) __x); //copy ctor

		this(ref const set!(Key) __x, ref const allocator!(Key) );

//		~this();

		ref set opAssign(const ref set!(Key) other);

		allocator_type get_allocator() const nothrow; 

		size_type size() const nothrow;

		bool empty() const nothrow;

		size_type max_size() const nothrow;

		void clear() nothrow;

		size_type erase(ref const Key key_var);

		extern(D) size_type erase(const Key item)
		{
			return this.erase(item);
		}

		//lookup functions
		extern(D) size_type count(const Key item) const
		{
			return this.count(item);
		}

		size_type count(const ref Key key_var) const;

		//size_type count(U)(ref const U x) const; // since c++14

		pointer find(const ref Key key_var);

		extern(D) pointer find(const Key item)
		{
			return this.find(item);
		}

		pair!(pointer, bool) insert (ref const Key val);

		extern(D) pair!(pointer, bool) insert ( const Key val)
		{
			return this.insert(val);
		}

		void swap(ref const set!(Key) other) nothrow;

		void merge(C2)( ref set!(Key, C2, allocator!(Key)) source );

		bool contains(ref const Key key_var) const;

		extern(D) bool contains(const Key item) const
		{
			return contains(item);
		}

		pair!(pointer, pointer) equal_range(ref const Key key_var);

		extern(D) pair!(pointer, pointer) equal_range(const Key item)
		{
			return equal_range(item);
		}

		pointer lower_bound(ref const Key key_var);

		extern(D) pointer lower_bound( const Key item)
		{
			return lower_bound(item);
		}

		pointer lower_bound(K)(ref const K x);

		extern(D) pointer lower_bound(Y)(const Y z)
		{
			return lower_bound!(Y)(z);
		}

		pointer upper_bound(K)(ref const K x);

		extern(D) pointer upper_bound(Y)(const Y z)
		{
			return upper_bound!(Y)(z);
		}
		//observers

		key_compare key_comp() const;

		//value compare next
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
		size_type node_count;
		_Rb_tree_key_compare!compare a;
	}
		_Rb_tree _M_t;

	}
}
