note
	description: "[
		TREE_MAP tests
	]"
	testing: "type/manual"

class
	TREE_MAP_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	gobo_red_black
		local
			l_map: TREE_MAP [STRING]
		do
			create l_map.make_comparable
			l_map.put ("M")
			l_map.put ("A")
			l_map.put ("Z")
			assert_integers_equal ("three", 3, l_map.count)
		end

end


