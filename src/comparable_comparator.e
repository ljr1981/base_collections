note
	description: "A Comparable Comparator"

class
	COMPARABLE_COMPARATOR [K -> COMPARABLE]

inherit
	KL_COMPARATOR [K]

feature -- Status Reports

	attached_less_than (u, v: K): BOOLEAN
			--<Precursor>
		do
			Result := u < v
		end

end
