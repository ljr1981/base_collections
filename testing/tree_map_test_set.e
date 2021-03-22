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
			l_total_tree: STRING
		do
				-- Build our initial map
			l_map := tree_M_A_Z
			assert_strings_equal ("M_node", "M", l_map.item)
			assert_booleans_equal ("starting_at_root", True, l_map.is_root)
				-- CONCLUSION(S): The root node is not a child. Everything else is.

				-- Now, move ... where do we go?
			l_map.child_forth
			assert_integers_equal ("A_index", 1, l_map.child_index)
			assert_strings_equal ("A_node", "A", l_map.child_item)
				-- CONCLUSION(S): The movement is starting on the left-side of
				--				the tree and moving ... but ...

				-- Move again ...
			l_map.child_forth
			assert_integers_equal ("Z_index", 2, l_map.child_index)
			assert_strings_equal ("Z_node", "Z", l_map.child_item)
				-- CONCLUSION(S): We only have two children (left and right)
				--				so, we don't have enough to go on just yet.

				-- We presume that this walking-of-children appears linear, so
				--	if we walk-back, then we end up at "A" (first child)
			l_map.child_back
			l_map.child_back
			assert_booleans_equal ("back_at_root", True, l_map.is_root)
			assert_integers_equal ("root_index", 0, l_map.child_index)
			l_map.child_start
			assert_booleans_equal ("first_child", True, l_map.child_isfirst)
				-- CONCLUSION(S): It seems right to think child-collection is behaving
				--					linear as we walk it.

				-- Now, let's add a "B" to the "A"-right-side ...
				-- And, navigate to it
			assert_strings_equal ("back_at_A_node", "A", l_map.child_item)
			assert_integers_equal ("A_node_index", 1, l_map.child_index)
			check attached {TREE_MAP [STRING, STRING]} l_map.child as al_child then
				al_child.put_right_child (tree ("B"))
				check attached al_child.right_child as al_right_child and then
						attached {TREE_MAP [STRING, STRING]} al_right_child.parent as al_parent then
					assert_strings_equal ("parent_A", "A", al_parent.item)
					assert_integers_equal ("A_node_count", 2, al_parent.count)
					al_parent.put_left_child (tree (" "))
					assert_integers_equal ("A_node_count", 3, al_parent.count)
				end
			end

			l_map.child_forth
			assert_integers_equal ("child_Z_index", 2, l_map.child_index)
			assert_strings_equal ("Z_node", "Z", l_map.child_item)
			assert_integers_equal ("count_with_new_B_and_space", 5, l_map.count)

			across
				l_map.linear_representation as ic
			from
				create l_total_tree.make_empty
			loop
				l_total_tree.append_string_general (ic.item)
			end
			assert_integers_equal ("counts_same", l_map.count, l_total_tree.count)
			assert_strings_equal ("all_items", "MA BZ", l_total_tree)
				-- CONCLUSION(S): Wow! Interesting
				--	1) A map.count starting at root will count all nodes, root down.
				--	2) A child_map.count will count all nodes from the child, down.
				--	3) Each node has but (potential) left-right child.
				--	4) Therefore, each node has count of 1, 2, 3 in terms of immediate self + children
				--	5) The across-loop reveals that linear-traversal is easy, but not "natural order"
				--	6) Natural order will come by "tracing" the tree (e.g. "MA BZ" -> " ABMZ")
				--	7) Locating an "insertion-point" will not use "tracing", but different mechanism.
				--	8) Insert-loc will start at root and look left-right and follow --> insert-point
				--	9) Insert-point will be either:
				--		a) missing left-or-right leaf
				--		b) splice-in between a less-than left-child and less-than parent
				--		c) splice-in between a greater-then right-child and less-than parent
				--		EXAMPLE: "Q" goes splices between "M" (less-than parent)
				--					and "Z" (greater-than child of "M")
		end

feature {NONE} -- Test Support

	tree_M_A_Z: TREE_MAP [STRING, STRING]
			--
		note
			design: "[
					["M"]
					/	\
				 ["A"] ["Z"]
				]"
		do
			Result := tree ("M")
			Result.put_left_child (tree ("A"))
			Result.put_right_child (tree ("Z"))
		end

	tree (s: STRING): TREE_MAP [STRING, STRING]
		do
			create Result.make (s)
		end

end


