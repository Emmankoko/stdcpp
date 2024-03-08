module stdcpp.unordered_map;

import core.stdcpp.allocator;
import core.stdcpp.utility : pair;
import core.stdcpp.xutility : StdNamespace;
extern(C++, (StdNamespace)):

alias unordered_map(Key, value) = unordered_map!(Key, value, hash!Key, equal_to!Key, allocator!(pair!(const(Key), value)));
extern(C++, class) struct unordered_map(Key, value, Hash, KeyEqual, Alloc)
{   ///
    alias key_type = Key;
    ///
    alias mapped_value = value;
    ///
    alias size_type = size_t;
    ///
    alias difference_type = ptrdiff_t;
    ///
    alias key_equal = KeyEqual;
    ///
    alias allocator_type = Alloc;
    ///
    alias Pair = pair!(const(Key), value);
    ///
    alias pointer = allocator_traits!(allocator_type).pointer;

    alias _Hashtable = __ummap_hashtable!(Key, value, Hash, KeyEqual, Alloc);

    alias __umap_traits(bool _cache) = _Hashtable_traits!(_cache, false, true);

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
        ///
        void swap(ref unordered_map other) nothrow;


        ///bucket interface
        size_type bucket_count() const;
        ///
        size_type bucket_size(size_type n) const;


        ///Hash policy
        float load_factor() const;
        ///
        void max_load_factor(float ml);
        ///
        float max_load_factor() const;
        ///
        void rehash(size_type count);
        ///
        void reserve(size_type count);


 /*       size_t y;
        size_t a;
        size_t b;
        size_t n;
        size_t c;
        size_t d;
        size_t e;
        */
    private _Hashtable _M_h;
    }
}

private:

version (CppRuntime_Gcc)
{
    struct hash(T)
    {
    }

    struct equal_to(T = void)
    {
    }

    extern(C++, "__detail") struct _Select1st
    {
    }

    extern(C++, "__detail") struct _Mod_range_hashing
    {
    }

    extern(C++, "__detail") struct _Default_ranged_hash
    {
    }

    extern(C++, "__detail") struct _Prime_rehash_policy
    {
    }

    extern(C++, "__detail") struct _Hashtable_traits(bool _Cache_hash_code, bool _Constant_iterators, bool _Unique_keys)
    {
        import stdcpp.type_traits : bool_constant;
        alias __hash_cached = bool_constant!(_Cache_hash_code);
    }

    extern(C++, "__detail") struct _Hashtable_alloc(_NodeAlloc)
    {
        alias __node_base = _Hash_node_base;
        alias __node_base_ptr = __node_base*;
        alias __buckets_ptr = __node_base_ptr*;
    }

    extern(C++, "__detail") struct _Hash_node_base
    {
        _Hash_node_base* _M_next;
    }

    extern(C++, "__detail") struct _Hash_node(_Value, bool _Cache_hash_code)
    {
        _Hash_node_base __hb;
    }

    alias __umap_hashtable(_Key, _Tp, _Hash, _Pred, Alloc, _Tr = __umap_traits!(__cache_default!(_Key, _Hash).value)) = _Hashtable!(_Key, pair!(const(_Key), _Tp), Alloc, _Select1st, _Pred, _Hash
                                                                                _Mod_range_hashing, _Default_ranged_hash, _Prime_rehash_policy, _Tr )
    extern(C++, class) struct _Hashtable(_Key, _Value, _Alloc, _ExtractKey, _Equal,
                                         _Hash, _RangeHash, _Unused, _RehashPolicy, _Traits)
    {
        alias size_type = size_t;
        alias __traits_type = _Traits;
        alias __hash_cached = __traits_type.__hash_cached;
        alias __node_type = _Hash_node!(_Value, __hash_cached.value);
        alias __node_alloc_type = allocator_traits!(_Alloc).rebind_alloc!(__node_type);
        alias __hashtable_alloc = _Hashtable_alloc!(__node_alloc_type);
        alias __node_base = __hashtable_alloc.__node_base;
        alias __buckets_ptr = __hashtable_alloc.__buckets_ptr;
        alias __node_base_ptr = __hashtable_alloc.__node_base_ptr;

        ~this();
    
    private:

        struct _Scoped_node
        {
            __hashtable_alloc* _M_h;
            __node_ptr _M_node;
        }
        __bucket_ptr _M_buckets = &_M_single_bucket;
        size_type _M_bucket_count = 1;
        __node_base _M_before_begin;
        size_type _M_element_count = 0;
        _RehashPolicy _M_rehash_policy;
        __node_base_ptr _M_single_bucket;
    }
}
