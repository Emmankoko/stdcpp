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
    static Map<K,V>* make()         {return new Map<K, V>(); }

};
