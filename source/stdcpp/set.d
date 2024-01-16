module stdcpp.set;

import stdcpp.allocator;
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
		/*
		pair!(pointer, bool) insert( const Key val)
		{
			return this._Mybase.insert(val);
		}
		*/

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
		//_Ty _Returns_exactly(_Ty)() nothrow;
		extern(C++) const(bool) _DEBUG_LT_PRED(_Pr, _Ty1, _Ty2)(_Pr _Pred, _Ty1 _Left, _Ty2 _Right)
		{
			const auto __result = cast(bool)(_Pred(_Left, _Right));
			return __result;
		} 
		extern(C++) struct _Tree_node(_value_type, _voidptr)
		{
			alias _Nodeptr = _Tree_node!(value_type, void*)*;
			alias value_type = _value_type;
			_Nodeptr _Left;
			_Nodeptr _Parent;
			_Nodeptr _Right;
			char _Color;
			char _Isnil;
			_value_type _Myval;

			enum _Redbl {
				_Red,
				_Black
			}

		}

		enum _Tree_child { _Right, _Left, _Unused};

		extern(C++) struct _Tree_id(_Nodeptr)
		{
			_Nodeptr _Parent;
			_Tree_child _Child;
		}

		extern(C++) struct _Tree_find_result(_Nodeptr)
		{
			_Tree_id!(_Nodeptr) _Location;
			_Nodeptr _Bound;
		}

		extern(C++, class) struct _Tree_val(_Val_types)
		{
			alias _Nodeptr = _Val_types._Nodeptr;
			alias size_type = _Val_types.size_type;
			_Nodeptr _Myhead;
			size_type _Mysize;
			alias value_type = _Val_types.value_type;
			alias difference_type = _Val_types.difference_type;
			
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
		alias conditional_t(bool _Test, _Ty1, _Ty2) = conditional!(_Test, _Ty1, _Ty2).type;
		extern(C++) struct conditional(bool _Cond, _Ty1, _Ty2)
		{	
			static if(_Cond == true)
				alias type = _Ty1;
			else
				alias type = _Ty2;
		}

		extern(C++) struct _Iterator_base0
		{

		}

		extern(C++, class) struct _Tree_unchecked_const_iterator(_Mytree, _Base = _Iterator_base0)
		{
			alias _Nodeptr = _Mytree._Nodeptr;
			alias value_type = _Mytree.value_type;
			alias difference_type = _Mytree.difference_type;

			this(_Nodeptr _Pnode, const _Mytree* _Plist) nothrow;
		}

		extern(C++, class) struct _Tree(_Traits)
		{
			alias key_compare = _Traits.key_compare;
			alias value_type = _Traits.value_type;
			alias value_compare = _Traits.value_compare;
			alias key_type = _Traits.value_type;
			alias allocator_type = _Traits.allocator_type;
			alias _Node = _Tree_node!(value_type, void*);
			alias _Alnode = allocator_traits!(allocator_type).rebind_alloc!(_Node);
			alias _Alnode_traits = allocator_traits!(_Alnode);
			alias _Nodeptr = _Alnode_traits.pointer;
			alias size_type = allocator_traits!(allocator_type).rebind_alloc!(value_type).size_type;
			alias _Scary_val = _Tree_val!(conditional_t!(false, _Tree_simple_types!(value_type), _Tree_iter_types!(value_type, size_t, ptrdiff_t, value_type*, const(value_type)*, _Nodeptr)));
			alias pointer = value_type*;

			enum _Redbl {
				_Red,
				_Black,
			}
			enum _Strategy : bool {
				_Copy,
				_Move,
			}

			ref _Tree opAssign(const ref _Tree _Right);

			pair!(pointer, bool) insert(const ref value_type _Val);

			inout(_Scary_val)* _Get_scary() inout nothrow
			{
				return &(_Mypair._Myval2._Myval2);
			}

			void clear() nothrow;

			size_type size() const nothrow
			{
				return _Get_scary._Mysize;
			}

			key_compare key_comp() const;

		/*	value_compare value_comp() const
			{
				return value_compare(key_comp());
			}
			*/

			size_type max_size() const nothrow;
		
			bool empty() const nothrow
			{
				return _Get_scary._Mysize == 0;
			}
		
			bool contains(const ref key_type _Keyval)
			{
				return _Lower_bound_duplicate(_Find_lower_bound(_Keyval)._Bound, _Keyval);
			}
			/*
			auto find(ref const key_type _keyval)
			{
				return _Find(_keyval);
			}
			*/
			
			size_type count(const ref key_type value)
			{
				static if (_Multi)
				{
					auto _Ans = _Eqrange(value);
					return cast(size_type)(_Unchecked_const_iterator(_Ans.first, null), _Unchecked_const_iterator(_Ans.second, null));
				}
				else {
					return _Lower_bound_duplicate(_Find_lower_bound(value)._Bound, value);
				}
			}
		protected:

			ref inout(key_compare) _Getcomp() inout nothrow;
			/*
			{
				return _Mypair._Get_first();
			}
			*/

			_Tree_find_result!(_Nodeptr) _Find_lower_bound(_Keyty)(const ref _Keyty _Keyval)
			{
				auto _Scary = _Get_scary();
				_Tree_find_result!(_Nodeptr) _Result = {{_Scary._Myhead._Parent, _Tree_child._Right}, _Scary._Myhead};
				_Nodeptr _Trynode = _Result._Location._Parent;
				while(!_Trynode._Isnil)
				{
					_Result._Location._Parent = _Trynode;
					if(_DEBUG_LT_PRED(_Getcomp(),_Traits._Kfn(_Trynode._Myval), _Keyval))
					{
						_Result._Location._Child = _Tree_child._Right;
						_Trynode = _Trynode._Right;
					}
					else {
						_Result._Location._Child = _Tree_child._Left;
						_Result._Bound = _Trynode;
						_Trynode = _Trynode._Left;
					}
				}
				return _Result;
			}
		
			bool _Lower_bound_duplicate(_Keyty)(const _Nodeptr _Bound, ref const _Keyty _Keyval) const
			{
				return !_Bound._Isnil && !_DEBUG_LT_PRED(_Getcomp(), _Keyval, _Traits._Kfn(_Bound._Myval));
			}

			pair!(_Nodeptr, _Nodeptr) _Eqrange(other)(const ref other _keyval)
			{
				auto _Scary = _Get_scary();
				auto ref _Comp = _Getcomp();
				_Nodeptr _Pnode = _Scary._Myhead._Parent;
				_Nodeptr _Lonode = _Scary._Myhead;
				_Nodeptr _Hinode = _Scary._Myhead;

				while(!_Pnode._Isnil)
				{
					auto ref _Nodekey = _Traits._Kfn(_Pnode._Myval);
					if (_DEBUG_LT_PRED(_Comp, _Nodekey, _keyval)){
						_Pnode = _Pnode._Right;
					}
					else {
						if(_Hinode._Isnil && _DEBUG_LT_PRED(_Comp, _keyval, _Nodekey))
						{
							_Hinode = _Pnode;
						}

						_Lonode = _Pnode;
						_Pnode = _Pnode._Left;

					}
				}

				_Pnode = _Hinode._Isnil ? _Scary._Myhead._Parent : _Hinode._Left;
				while(!_Pnode._Isnil)
				{
					if (_DEBUG_LT_PRED(_Getcomp(), _keyval, _Traits._Kfn(_Pnode._Myval)))
					{
						_Hinode = _Pnode;
						_Pnode = _Pnode._Left;
					}
					else {
						_Pnode = _Pnode._Right;
					}
				}

				return _Lonode, _Hinode; //, _Hinode};
			}

		private:
			_Nodeptr _Find(other)(const ref other _keyval) 
			{
				_Tree_find_result!(_Nodeptr) loc = _Find_lower_bound(_keyval);
				if(_Lower_bound_duplicate(loc._Bound, _keyval))
				{
					return loc._Bound;
				}
				return _Get_scary._Myhead;
			}
			

		public:
			import stdcpp.xutility : _Compressed_pair;
			_Compressed_pair!(key_compare, _Compressed_pair!(_Alnode, _Scary_val)) _Mypair;
			

			//~this() nothrow;
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
		
		}

	}
