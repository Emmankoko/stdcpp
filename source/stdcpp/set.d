module stdcpp.set;

import stdcpp.allocator;
import stdcpp.utility : pair;
import stdcpp.xutility : StdNamespace;
extern(C++, (StdNamespace)):

//will definately be moved(maybe to stdcpp.utilities)
extern(C++) struct less(T)
{

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
	/*	{
			allocator!Key alloc_instance = allocator!Key.init;
			this(__x, alloc_instance);
	*/	//}

		this(const ref compare comp, const ref allocator_type alloc);

		ref set opAssign( const ref set other);

	/*	extern(D) bool empty() const nothrow
		{
			return _Mybase.empty;
		}
		*/

		size_type size() const nothrow;

		void swap(ref set other) nothrow;

		_Tree!(_Tset_traits!(key_type,value_type, allocator_type, false)) _Mybase;

	}
}


private:
	version (CppRuntime_Gcc)
	{
		enum _Rb_tree_color { red = false, black = true};
		struct _Rb_tree_node_base
		{
			_Rb_tree_color _M_color;
			_Rb_tree_node_base* parent;
			_Rb_tree_node_base* left;
			_Rb_tree_node_base* right;
		}

		struct _Rb_tree_node(Val)
		{
			_Rb_tree_node_base _base;
			Val _M_value_field;
		}

		struct _Rb_tree_key_compare(U)
		{
			U _M_key_compare;
		}

		struct _Rb_tree_header
		{
			_Rb_tree_node_base _M_header;
			size_t _M_node_count;
		}

		extern(C++, class) struct _Rb_tree(_Key, _Val, _KeyOfValue, Compare, _Alloc)
		{
			alias pointer = _Key*;

			struct _Rb_tree_impl(_Key_compare)
			{
				_Rb_tree_header b;
				_Rb_tree_key_compare!(_Key_compare) a;
			}

			_Rb_tree_impl!Compare _M_impl;

//come back to them later, currently causing seg faults in unrelated functions
/*******************************************************************


			inout(_Rb_tree_node_base)* _M_root() inout nothrow
			{
				return this._M_impl.b._M_header.parent;
			}

			_Rb_tree_node!(_Val)* _M_copy(const ref _Rb_tree __x);

			this(const ref _Rb_tree x)
			{
				//mpl here
				this._M_impl = x._M_impl;
				if(x._M_root != null)		{ this._M_root = this._M_copy(x);}
			}


			extern(D) this(const Compare item)
			{
				allocator!_Key alloc_instance = allocator!(_Key).init;
				this(item, alloc_instance);
			}
			this(const ref Compare b, const ref _Alloc a);

			_Rb_tree_node!(_Val)* _M_begin() nothrow;

			_Rb_tree_node_base* _M_end() nothrow;

			static const ref _Key _S_key(const _Rb_tree_node!(_Val)*);

			pointer _M_lower_bound(_Const_Link_type __x, _Const_Base_ptr __y, const ref _Key __K);

****************************************************************************************************/

			inout(pointer) end() inout nothrow;

			inout(pointer) find(const ref _Key __k) inout;

			~this();
		}
		
	}
	else version (CppRuntime_Microsoft)
	{
		extern(C++) struct _Tree_node(_value_type, _voidptr)
		{
			alias _Nodeptr = allocator_traits!(allocator!(_value_type)).rebind_alloc!(_Tree_node);
			_Nodeptr _Left;
			_Nodeptr _Parent;
			_Nodeptr _Right;
			char _Color;
			char _Isnil;

			enum _Redbl {
				_Red,
				_Black
			}

		}

		extern(C++, class) struct _Tree_val(_Val_types)
		{
			
			//alias _Nodeptr = _Val_types._Nodeptr;
			
			//_Nodeptr _Myhead;
			size_t _Mysize;
			
		}
		extern(C++) struct _Tree_simple_types(_Ty)
		{
			alias _Node = _Tree_node!(_Ty, void*);
			alias _Nodeptr =  _Node*;
		}

		extern(C++) struct _Tree_iter_types(_Value_type, _size_type, _Diff_type, _Pointer, _Const_pointer, _Nodeptr_type)
		{
			alias value_type = _Value_type;
			alias size_type = _size_type;
			alias difference_type = _Diff_type;
			alias pointer = _Pointer;
			alias const_pointer = _Const_pointer;
			alias _Nodeptr = _Nodeptr_type;
		}
		//might be moved to type_traits.d
		alias conditional(_if, _Then) = coditional!(false, _if, _Then);
		extern(C++) struct conditional(bool _Cond, _if, _Then)
		{
			alias type = _if;

			static if (_Cond == false)
				alias type = _Then; 
		}

		extern(C++, class) struct _Tree(_Traits)
		{
			alias key_compare = _Traits.key_compare;
			alias value_type = _Traits.value_type;
			alias allocator_type = _Traits.allocator_type;
			alias _Node = _Tree_node!(value_type, void*);
			alias _Alnode = allocator_traits!(allocator_type).rebind_alloc!(_Node);
			alias _Alnode_traits = allocator_traits!(_Alnode);
			alias _Nodeptr = _Alnode_traits.pointer;
			alias size_type = allocator_traits!(allocator_type).rebind_alloc!(value_type);
			alias _Scary_val = _Tree_val!(conditional!(true, _Tree_simple_types!(value_type), _Tree_iter_types!(value_type, size_t, ptrdiff_t, value_type*, const(value_type)*, _Nodeptr)));


			enum _Redbl {
				_Red,
				_Black,
			}
			enum _Strategy : bool {
				_Copy,
				_Move,
			}

			ref _Tree opAssign(const ref _Tree _Right);

			bool empty() const nothrow;

			import stdcpp.xutility : _Compressed_pair;
			_Compressed_pair!(key_compare, _Compressed_pair!(_Alnode, _Scary_val)) _Mypair;

			//~this() nothrow;
		}
		extern(C++, class) struct _Tset_traits(_Kty, _Pr, _Alloc, bool _Mf1)
		{
			alias key_type = _Kty;
			alias value_type = _Kty;
			alias key_compare = _Pr;
			alias allocator_type = _Alloc;

		}

	}
