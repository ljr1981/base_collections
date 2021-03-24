note
	description: "Treemap modelled after Java."

class
	TREE_MAP [G -> COMPARABLE]

inherit
	DS_RED_BLACK_TREE [G, G]
		rename
			put as put_key_value
		end

create
	make_comparable

feature {NONE} -- Initialization

	make_comparable
			-- Initialize Current with key:value of same data type (e.g. [G, G])
		do
			make (comparator)
		end

feature -- Basic Ops

	put (v: G)
			-- `put' of `v' as key:value pair.
		do
			put_key_value (v, v)
		end

feature {NONE} -- Ops: Comparators

	comparator: TREE_MAP_COMPARATOR [G]
		attribute
			create Result
		end

end
