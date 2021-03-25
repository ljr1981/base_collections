note
	description: "Treemap modelled after Java."

class
	TREE_MAP [V -> HASHABLE, K -> COMPARABLE]

inherit
	DS_RED_BLACK_TREE [V, K]

create
	make

feature -- Temporary

	containsKey, contains_key (a_key: K): BOOLEAN
			-- containsKey(Object key) --> boolean
			-- Returns true if this map contains a mapping for the specified key.
			-- Eiffel version: `has'
		do
			Result := has (a_key)
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
		do
			if has (a_key) then
				Result := item (a_key)
			end
		end

	keySet, key_set: ARRAYED_LIST [K]
			-- Set<K> 	keySet()
			-- Returns a Set view of the keys contained in this map.
		note
			java_v_eiffel: "[
				In this case, Eiffel does not have a corresponding exported API feature.
				So, we are forced to create one. it's not difficult, but it does have to
				be built to meet the java-esque API.
				]"
		do
			create Result.make (count)
			from
				start
			until
				off
			loop
				Result.force (key_for_iteration)
				forth
			end
		end

	entrySet, entry_set: ARRAYED_LIST [TUPLE [key: K; value: V]]
			--
		note
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
			create Result.make (count)
			from
				start
			until
				off
			loop
				Result.force ([key_for_iteration, item_for_iteration])
				forth
			end
		end

	size: INTEGER
			-- size() --> int
			-- Returns the number of key-value mappings in this map.
		note
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
		end

	values: ARRAYED_LIST [V]
		note
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
			create Result.make (count)
			from
				start
			until
				off
			loop
				Result.force (item_for_iteration)
				forth
			end
		end

	descendingKeySet: ARRAYED_LIST [K]
			-- descendingKeySet() --> NavigableSet<K> 	
			-- Returns a reverse order NavigableSet view of the keys contained in this map.
		note
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
			create Result.make (count)
			across
				keySet.new_cursor.reversed as ic
			loop
				Result.force (ic.item)
			end
		end

end
