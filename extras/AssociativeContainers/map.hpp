/*******************************************************************************

    C++ map source file to generate symbols for D using the wrapper method

    In order to make the symbols available, we call the functions from the map
    instance so we can effectively use them in D

*******************************************************************************/

#include <map>

template <typename K, typename V>
class Map
{
    void insertOrAssign(const K& key, const V& value)
    {
        this->map.insert_or_assign(key, value);
    }

    std::map<K, V> map;

public: // msvc mangles public and private static fields differently so need for public
    static Map<K,V>* make()                 { return new Map<K, V>(); }

    size_t size()                           { return this->map.size(); }

    V& operator[] (K const& key)            { return this->map[key]; }

    V& at(K const& key)                     { return this->map.at(key); }

    bool empty() const noexcept             { return this->map.empty(); }

    size_t max_size() const                 { return this->map.max_size(); }

    void clear() noexcept                   { this->map.clear(); }

    size_t count(K const& key ) const       { return this->map.count(key); }

    bool contains(K const& key ) const      { return this->map.contains(key);}

    void swap( Map* other) noexcept         { this->map.swap(other->map); } // swap with the function parameter's map

};
