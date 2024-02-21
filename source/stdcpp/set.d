module stdcpp.set;

import stdcpp.allocator;
import stdcpp.tree;
import stdcpp.utility : pair;
import stdcpp.xutility : StdNamespace;
extern(C++, (StdNamespace)):

//will definately be moved(maybe to stdcpp.utilities)
extern(C++) struct less(T)
{
	static bool opCall(const ref T left, const ref T right)
	{
		return left < right;
	}
}

extern(C++) struct _Identity(T)
{

}
public:
enum def {value =0};

alias set(Key) = set!(Key, less!Key, allocator!(Key));
extern(C++, class) struct set(Key, compare, Alloc)
{

	alias key_type = Key;

	alias value_type = Key;

	alias size_type = size_t;

	alias difference_type = ptrdiff_t;

	alias key_compare = compare;

	alias value_compare = compare;

	alias allocator_type = Alloc;

	alias pointer = Key*; // testing in place of iterator return type for now

	//enum comp { less};

	version (CppRuntime_Gcc)
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

		this(ref const set __x)
		{
			allocator!Key alloc_instance = allocator!Key.init;
			this(__x, alloc_instance);
		}

		this(ref const set!(Key) __x, ref const allocator!(Key) );

//		~this();
/*
		ref set opAssign(const ref set other)
		{
			this.Rep_type = other.Rep_type;
			return this;
		}
*/
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

		inout(pointer) find(const ref Key key_var) inout;

		extern(D) inout(pointer) find(const Key item) inout
		{
			return this.find(item);
		}

		pair!(pointer, bool) insert (ref const Key val);

		extern(D) pair!(pointer, bool) insert ( const Key val)
		{
			return this.insert(val);
		}

		void swap(ref set other) nothrow;

		void merge(C2)( ref set!(Key, C2, allocator!(Key)) source );

		bool contains(ref const Key key_var) const
		{
			return Rep_type.find(key_var) != Rep_type.end();
		}

		extern(D) bool contains(const Key item) const
		{
			return this.contains(item);
		}

		pair!(pointer, pointer) equal_range(ref const Key key_var);

		extern(D) pair!(pointer, pointer) equal_range(const Key item)
		{
			return equal_range(item);
		}

		inout(pointer) lower_bound(ref const Key key_var) inout;

		extern(D) inout(pointer) lower_bound( const Key item) inout
		{
			return lower_bound(item);
		}

		inout(pointer) lower_bound(K)(ref const K x) inout;

		extern(D) inout(pointer) lower_bound(Y)(const Y z) inout
		{
			return lower_bound!(Y)(z);
		}

		inout(pointer) upper_bound(K)(ref const K x) inout;

		extern(D) inout(pointer) upper_bound(Y)(const Y z) inout
		{
			return upper_bound!(Y)(z);
		}

		inout(pointer) upper_bound(K)(ref const K x) inout;

		extern(D) inout(pointer) upper_bound(Y)(const Y z) inout
		{
			return upper_bound!(Y)(z);
		}

		//observers

		key_compare key_comp() const;

		value_compare value_comp() const;

		_Rb_tree!(key_type, value_type, _Identity!(value_type), key_compare, Alloc) Rep_type;
	}
	else version (CppRuntime_Microsoft)
	{
		this(const ref allocator!(Key));

		this(const ref compare item)
		{
			allocator!(Key) alloc_instance =  allocator!(Key).init;
			this(item, alloc_instance);
		}
		
		this(ref const set __x);

		this(const ref compare comp, const ref allocator_type alloc);

		ref set opAssign( const ref set other);

		void clear() nothrow
		{
			this._Mybase.clear();
		}
		
		auto insert( const Key val)
		{
			return this._Mybase.insert(val);
		}
		

		size_type size() const nothrow
		{
			return this._Mybase.size();
		}

		size_type max_size() const nothrow
		{
			return this._Mybase.max_size();
		}
	
		bool empty() const nothrow
		{
			return this._Mybase.empty();
		}
	
		void swap(ref set other) nothrow;

		bool contains(const key_type key)
		{
			return this._Mybase.contains(key);
		}

		key_compare key_comp() const
		{
			return this._Mybase.key_comp();
		}

		size_type count(const key_type key_val)
		{
			return _Mybase.count(key_val);
		}

		_Tree!(_Tset_traits!(key_type,less!key_type, allocator_type, false)) _Mybase;

	}
}
		extern(C++, class) struct _Tset_traits(_Kty, _Pr, _Alloc, bool _Mf1)
		{
			alias key_type = _Kty;
			alias value_type = _Kty;
			alias key_compare = _Pr;
			alias value_compare = key_compare;
			alias allocator_type = _Alloc;
			__gshared const(bool) _Multi = _Mf1;

			
		
			static ref const(_Kty) _Kfn(const ref value_type _Val)
			{
				return _Val;
			}

			alias _In_place_key_extractor(_Args...) = _In_place_key_extract_set!(_Kty, _Args);
		}

	}
