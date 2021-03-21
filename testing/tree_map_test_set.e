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

	tree_map_creation_test
			-- New test routine
		note
			testing:  "covers/{TREE_MAP}"
		local
			l_map: TREE_MAP [STRING, STRING]
		do
			create l_map.make ("M")
			
		end

end


