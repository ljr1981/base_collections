note
	description: "[
		Class as an example of how to make a test class.
	]"
	testing: "type/manual"

class
	TEST_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines

	test_test_routine
			-- This is an example test routine.
		note
			testing: "covers/{TEST_SET_SUPPORT}"
		do
			assert ("not_implemented", True)
		end

end


