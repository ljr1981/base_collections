note
	description: "Comparator for TREE_MAP"

class
	TREE_MAP_COMPARATOR [G -> COMPARABLE]

inherit
	KL_COMPARATOR [G]

feature -- Status Report

	attached_less_than (u, v: attached G): BOOLEAN
			--<Precursor>
		do
			Result := u < v
		end

end
