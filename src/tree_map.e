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

	get
		do

		end

	keySet, key_set
		do

		end

	entrySet, entry_set
		do

		end

--	put
--		do

--		end

	size
		do

		end

	values
		do

		end


end
