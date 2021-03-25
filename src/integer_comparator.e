note
	description: "Summary description for {INTEGER_COMPARATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_COMPARATOR

inherit
	KL_COMPARATOR [INTEGER]

feature -- Status Reports

	attached_less_than (u, v: INTEGER): BOOLEAN
			--<Precursor>
		do
			Result := u < v
		end

end
