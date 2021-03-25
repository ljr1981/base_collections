note
	description: "Treemap modelled after Java."
	EIS: "name=treemap_java_spec", "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html"

class
	TREE_MAP [V -> HASHABLE, K -> COMPARABLE]

inherit
	DS_RED_BLACK_TREE [V, K]
		redefine
			default_create
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	default_create
			--<Precursor>
		do
			make (create {COMPARABLE_COMPARATOR [K]})
		end

feature -- Java-eque Features: Queries

	containsKey, contains_key (a_key: K): BOOLEAN
			-- containsKey(Object key) --> boolean
			-- Returns true if this map contains a mapping for the specified key.
			-- Eiffel version: `has'
		note
			EIS: "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html#containsKey"
			java_api_specification: "[
			    containsKey

			    public boolean containsKey(Object key)

			    Returns true if this map contains a mapping for the specified key.

			    Specified by:
			        containsKey in interface Map<K,V>
			    Overrides:
			        containsKey in class AbstractMap<K,V>
			    Parameters:
			        key - key whose presence in this map is to be tested
			    Returns:
			        true if this map contains a mapping for the specified key
			    Throws:
			        ClassCastException - 	if the specified key cannot be compared with the keys currently in the map
			        NullPointerException - 	if the specified key is null and this map uses natural ordering, or
			        							its comparator does not permit null keys
				]"
		do
			Result := has (a_key)
		ensure
			valid: Result and then has (a_key)
		end

	get (a_key: K): detachable V
			-- get(Object key) --> V
			-- Returns the value to which the specified key is mapped, or null (Void)
			--	if this map contains no mapping for the key.
		note
			java_v_eiffel: "[
				Eiffel `item' makes a requirement demand that `a_key' is actually
				in Current. Because Java has no obvious sense of Void-safety checking,
				the `get' can offer the statement: "... or null ..." and get away with it.
				Eiffel's Void-safety gives it the quality of being much more precise.
				This code water's that down to behave like Java. This puts the onus on
				the programmer to do a Void-safety check after rather than before.
				]"
			EIS: "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html#get"
			java_api_specification: "[
			    get

			    public V get(Object key)

			    Returns the value to which the specified key is mapped, or null if this map contains no
			    mapping for the key.

			    More formally, if this map contains a mapping from a key k to a value v such that key
			    compares equal to k according to the map's ordering, then this method returns v; otherwise
			    it returns null. (There can be at most one such mapping.)

			    A return value of null does not necessarily indicate that the map contains no mapping
			    for the key; it's also possible that the map explicitly maps the key to null. The containsKey
			    operation may be used to distinguish these two cases.

			    Specified by:
			        get in interface Map<K,V>
			    Overrides:
			        get in class AbstractMap<K,V>
			    Parameters:
			        key - the key whose associated value is to be returned
			    Returns:
			        the value to which the specified key is mapped, or null if this map contains no mapping for the key
			    Throws:
			        ClassCastException - 	if the specified key cannot be compared with the keys currently in the map
			        NullPointerException - 	if the specified key is null and this map uses natural ordering, or
			        							its comparator does not permit null keys
				]"
		do
			if has (a_key) then
				Result := item (a_key)
			end
		ensure
			valid: attached Result implies
					attached item (a_key) and then
					has (a_key)
		end

feature -- Java-eque Features: Status Report

	size: INTEGER
			-- size() --> int
			-- Returns the number of key-value mappings in this map.
		note
			EIS: "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html#size"
			java_api_spec: "[
			    size

			    public int size()

			    Returns the number of key-value mappings in this map.

			    Specified by:
			        size in interface Map<K,V>
			    Overrides:
			        size in class AbstractMap<K,V>
			    Returns:
			        the number of key-value mappings in this map
				]"
		do
			Result := count
		ensure
			same: Result = count
		end

feature -- Java-eque Features: Ascending Versions

	keySet, key_set: ARRAYED_LIST [K]
			-- Set<K> 	keySet()
			-- Returns a Set view of the keys contained in this map.
		note
			java_v_eiffel: "[
				In this case, Eiffel does not have a corresponding exported API feature.
				So, we are forced to create one. it's not difficult, but it does have to
				be built to meet the java-esque API.
				]"
			EIS: "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html#keySet"
			java_api_specification: "[
			    keySet

			    public Set<K> keySet()

			    Returns a Set view of the keys contained in this map. The set's iterator returns the keys
			    in ascending order. The set is backed by the map, so changes to the map are reflected in
			    the set, and vice-versa. If the map is modified while an iteration over the set is in

			    progress (except through the iterator's own remove operation), the results of the iteration
			    are undefined. The set supports element removal, which removes the corresponding mapping f
			    rom the map, via the Iterator.remove, Set.remove, removeAll, retainAll, and clear operations.
			    It does not support the add or addAll operations.

			    Specified by:
			        keySet in interface Map<K,V>
			    Specified by:
			        keySet in interface SortedMap<K,V>
			    Overrides:
			        keySet in class AbstractMap<K,V>
			    Returns:
			        a set view of the keys contained in this map
				]"
		do
			from
				create Result.make (count)
				start
			until
				off
			loop
				Result.force (key_for_iteration)
				forth
			end
		ensure
			all_here: across Result as ic all has (ic.item) end
		end

	entrySet, entry_set: ARRAYED_LIST [TUPLE [key: K; value: V]]
			--
		note
			EIS: "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html#entrySet"
			java_api_spec: "[
				public Set<Map.Entry<K,V>> entrySet()

				Returns a Set view of the mappings contained in this map. The set's iterator
				returns the entries in ascending key order. The set is backed by the map,
				so changes to the map are reflected in the set, and vice-versa. If the map
				is modified while an iteration over the set is in progress (except through
				the iterator's own remove operation, or through the setValue operation on a
				map entry returned by the iterator) the results of the iteration are undefined.
				The set supports element removal, which removes the corresponding mapping from
				the map, via the Iterator.remove, Set.remove, removeAll, retainAll and clear
				operations. It does not support the add or addAll operations.

				Specified by:
				    entrySet in interface Map<K,V>
				Specified by:
				    entrySet in interface SortedMap<K,V>
				Specified by:
				    entrySet in class AbstractMap<K,V>
				Returns:
				    a set view of the mappings contained in this map
				]"
		do
			from
				create Result.make (count)
				start
			until
				off
			loop
				Result.force ([key_for_iteration, item_for_iteration])
				forth
			end
		ensure
			all_here: across Result as ic all
								has (ic.item.key) and then
								attached values.has (ic.item.value)
						end
		end

	values: ARRAYED_LIST [V]
		note
			EIS: "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html#values"
			java_api_specification: "[
				public Collection<V> values()

				Returns a Collection view of the values contained in this map. The collection's iterator
				returns the values in ascending order of the corresponding keys. The collection is backed
				by the map, so changes to the map are reflected in the collection, and vice-versa. If the
				map is modified while an iteration over the collection is in progress (except through
				the iterator's own remove operation), the results of the iteration are undefined. The
				collection supports element removal, which removes the corresponding mapping from the map,
				via the Iterator.remove, Collection.remove, removeAll, retainAll and clear operations. It
				does not support the add or addAll operations.

				Specified by:
				    values in interface Map<K,V>
				Specified by:
				    values in interface SortedMap<K,V>
				Overrides:
				    values in class AbstractMap<K,V>
				Returns:
				    a collection view of the values contained in this map
				]"
		do
			from
				create Result.make (count)
				start
			until
				off
			loop
				Result.force (item_for_iteration)
				forth
			end
		ensure
			same_count: Result.count = count
		end

feature -- Java-eque Features: Descending Versions

	descendingKeySet, descending_key_set: ARRAYED_LIST [K]
			-- descendingKeySet() --> NavigableSet<K> 	
			-- Returns a reverse order NavigableSet view of the keys contained in this map.
		note
			EIS: "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html#descendingKeySet"
			java_api_specification: "[
			    descendingKeySet

			    public NavigableSet<K> descendingKeySet()

			    Description copied from interface: NavigableMap
			    Returns a reverse order NavigableSet view of the keys contained in this map. The set's iterator returns the keys in descending order. The set is backed by the map, so changes to the map are reflected in the set, and vice-versa. If the map is modified while an iteration over the set is in progress (except through the iterator's own remove operation), the results of the iteration are undefined. The set supports element removal, which removes the corresponding mapping from the map, via the Iterator.remove, Set.remove, removeAll, retainAll, and clear operations. It does not support the add or addAll operations.

			    Specified by:
			        descendingKeySet in interface NavigableMap<K,V>
			    Returns:
			        a reverse order navigable set view of the keys in this map
			    Since:
			        1.6
				]"
		do
			across
				keySet.new_cursor.reversed as ic
			from
				create Result.make (count)
			loop
				Result.force (ic.item)
			end
		ensure
			same_count: Result.count = count
		end

	descendingMap, descending_map: ARRAYED_LIST [TUPLE [key: K; value: V]]
			-- descendingMap() --> NavigableMap<K,V>
			-- Returns a reverse order view of the mappings contained in this map.
		note
			EIS: "src=https://docs.oracle.com/javase/7/docs/api/java/util/TreeMap.html#descendingMap"
			java_api_specification: "[
			    descendingMap

			    public NavigableMap<K,V> descendingMap()

			    Description copied from interface: NavigableMap
			    Returns a reverse order view of the mappings contained in this map. The descending
			    map is backed by this map, so changes to the map are reflected in the descending map,
			    and vice-versa. If either map is modified while an iteration over a collection view
			    of either map is in progress (except through the iterator's own remove operation),
			    the results of the iteration are undefined.

			    The returned map has an ordering equivalent to Collections.reverseOrder(comparator()).
			    The expression m.descendingMap().descendingMap() returns a view of m essentially
			    equivalent to m.

			    Specified by:
			        descendingMap in interface NavigableMap<K,V>
			    Returns:
			        a reverse order view of this map
			    Since:
			        1.6
				]"
		do
			across
				entry_set.new_cursor.reversed as ic
			from
				create Result.make (count)
			loop
				Result.force (ic.item.key, ic.item.value)
			end
		end

end
