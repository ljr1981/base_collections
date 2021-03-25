note
	description: "String Comparator"

class
	STRING_COMPARATOR

inherit
	KL_COMPARATOR [STRING]

feature -- Status Reports

	attached_less_than (u, v: STRING): BOOLEAN
			--<Precursor>
		do
			Result := u < v
		end

end
