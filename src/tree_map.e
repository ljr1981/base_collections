note
	description: "Objects mapped within a Binary Tree."
	EIS: "name=design_guidance", "src=https://www.baeldung.com/java-treemap"
	EIS: "name=requirements", "src=$(system_path)/docs/requirements.odt"

class
	TREE_MAP [G -> COMPARABLE, K -> HASHABLE]

inherit
	BINARY_TREE [G]
		rename
			put as put_binary,
			replace as replace_binary
		export
			{ANY}
				all
		redefine
			put_left_child,
			put_right_child
		end

create
	make

feature -- Queries

	get, items: ARRAYED_LIST [G]
			-- `get' `items' of Current as a list.
		do
			create Result.make (count)
		end

feature -- Basic Ops

	plus alias "+" (v: like Current): like Current
		do
			child_put (v.item)
			across v.local_key_hash as ic loop
				local_key_hash.force (v.local_key_hash.item_for_iteration, v.local_key_hash.key_for_iteration)
			end
			Result := Current
		end

	put, add (v: ANY)
			--`put' or `add' an item `v' into Current.
		require
			G_typed: attached {G} v xor attached {TO_SPECIAL [G]} v
		local
			l_insertion: like insertion_point
		do
			if attached {G} v as al_item then -- adding single item
				if attached insertion_point (al_item) as al_insertion then
					inspect
						al_insertion.strategy_code
					when is_left_child then
						-- left_child of al_insertion.target_node
					when is_right_child then
						-- right_child of al_insertion.target_node
					when is_splice_above then
						-- splice-above al_insertion.target_node
					when is_splice_below_left then
						-- splice-below al_insertion.target_node
					when is_splice_below_right then
						-- splice-below al_insertion.target_node
					else
						check unknown_strategy: False end
					end
				end
			elseif attached {TO_SPECIAL [G]} v as al_special then -- adding a list of items
				if attached {ARRAY [G]} al_special as ic then
					across ic as ic_array loop put (ic_array.item) end
				elseif attached {ARRAYED_LIST [G]} al_special as ic then
					across ic as ic_array loop put (ic_array.item) end
				elseif attached {ARRAYED_STACK [G]} al_special as ic then
					across ic as ic_array loop put (ic_array.item) end
				end
			elseif attached {like Current} v as al_tree_map then -- adding another TREE_MAP to Current
				plus (al_tree_map).do_nothing
			else
				check unknown_type: False end
			end
		end

	put_left_child (v: like Current)
			--<Precursor>
			-- Redef includes adding to our `local_key_hash'.
		do
			Precursor (v)
			check hashable: attached {HASHABLE} v.item as al_hash then
				local_key_hash.force (v, al_hash.hash_code)
			end
		end

	put_right_child (v: like Current)
			--<Precursor>
			-- Redef includes adding to our `local_key_hash'.
		do
			Precursor (v)
			check hashable: attached {HASHABLE} v.item as al_hash then
				local_key_hash.force (v, al_hash.hash_code)
			end
		end

feature {TREE_MAP, TEST_SET_BRIDGE} -- Implementation

	local_key_hash: HASH_TABLE [like Current, HASHABLE]
			-- Keys for this node only (root + left + right)
		note
			design: "[
				We only need the key:value pair for left and right child.
				We always include the root (parent of left and right).
				]"
		attribute
			create Result.make (count)
		end

	local_key_value_pairs: ARRAYED_LIST [TUPLE [value: like Current; key: HASHABLE]]
			-- List of local key:value pairs.
		note
			use_case: "[
				The goal here is to have an easy list of key:value pairs so our
				parent node can build its `all_key_hash' and `all_items_sorted' lists.
				]"
		do
			create Result.make (local_key_hash.count)
			from
				local_key_hash.start
			until
				local_key_hash.off
			loop
				Result.force (local_key_hash.item_for_iteration, local_key_hash.key_for_iteration)
				local_key_hash.forth
			end
		end

	all_key_hash: like local_key_hash
			-- All keys for all nodes and children, recursively.
		note
			use_case: "[
				The goal here is to create a hashmapped list of all
				nodes in the tree where: key=item-hash-code value=node-reference
				
				Later, we will look up the value node-ref by the key item-hash,
				which will fetch our target insertion node (see `all_items_sorted').
				]"
		do
			Result := local_key_hash
			if attached left_child as al_left_child then
				across al_left_child.local_key_value_pairs as ic loop
					Result.force (ic.item.value, ic.item.key)
				end
			end
			if attached right_child as al_right_child then
				across al_right_child.local_key_value_pairs as ic loop
					Result.force (ic.item.value, ic.item.key)
				end
			end
		end

	all_items_sorted: PART_SORTED_TWO_WAY_LIST [G]
			-- A sorted list of all {G} items in Current.
		note
			use_case: "[
				The goal of this feature is a list that we can
				bracket-search (binary bracketing) to locate a one of three outcomes:
				1) the candidate is < our lowest list item.
				2) the candidate is > our highest list item.
				3) the candidate is between two list items (item-lesser < candidate > item-greater)
				
				Therefore, this is where we will get our target, which is one of four:
				1) lowest-item
				2) greatest-item
				3) item-lesser
				4) item-greater
				]"
		do
			create Result.make
			across
				all_key_hash as ic
			loop
				Result.put (ic.item.item)
			end
		end

	insertion_point (a_candidate_item: G): detachable TUPLE [target_node: like Current; strategy_code: INTEGER]
			-- Where do we insert `a_candidate_item' and what strategy do we use?
		local
			l_items: like all_items_sorted
			l_greater_than: detachable G
			i: INTEGER
		do
			l_items := all_items_sorted

				-- code here for determining `insertion_point' strategy
			from
				l_items.start
				i := 1
			until
				l_items.off or attached l_greater_than
			loop
				if l_items.item_for_iteration > a_candidate_item then
					l_greater_than := l_items.item_for_iteration
				else
					i := i + 1
				end
				l_items.forth
			end
			check has_item: i <= l_items.count implies attached l_greater_than end
			if l_items.is_empty implies i = 0 then				-- An empty tree
				Result := [Current, is_empty_list]				-- add item to empty
			elseif attached l_greater_than then					-- Found one and ...
				if i = 1 then
					Result := [tree (l_greater_than), is_left_child]
				elseif i > 1 and i < l_items.count then
					Result := [tree (l_greater_than), is_splice_below_left]
				elseif i = l_items.count then
					Result := [tree (l_greater_than), is_right_child]
				else
					check unknown_strategy: False end
				end
			else
				check unknown_strategy: False end
			end
		ensure
			valid_node: attached Result implies all_key_hash.has_item (Result.target_node)
			valid_strategy: attached Result implies insert_strategies.has (Result.strategy_code)
		end

	tree (v: G): like Current
		do
			create Result.make (v)
		end

feature {TEST_SET_BRIDGE} -- Imp: Constants

	is_empty_list: INTEGER = 0			-- empty list
	is_left_child: INTEGER = 1			-- no left-child (is_leaf)
	is_right_child: INTEGER = 2			-- no right-child (is_leaf)
	is_splice_above: INTEGER = 3		-- between `target_node' and `parent'
	is_splice_below_left: INTEGER = 4	-- between `target_node' and `left-child'
	is_splice_below_right: INTEGER = 5	-- between `target_node' and `right-child'

	insert_strategies: ARRAY [INTEGER]
		once
			Result := <<
						is_empty_list,
						is_left_child,
						is_right_child,
						is_splice_above,
						is_splice_below_left,
						is_splice_below_right
						>>
		end

invariant
	valid_counts: (all_key_hash.count + 1) = count

note
	insertion_strategy: "[
		This is the result of inserting {"M", "A", "Z"} or {"M", "Z", "A"}

			["M"]
			/	\
		 ["A"] ["Z"]

		"M" is first, so it goes to the root. If "A" is next, it goes left and
		down one level (e.g. left-child or child_left). If "Z" follows, then it
		will go down and right, or right-child or child_right.

		RULE: Lesser goes left and greater goes right.

		Now—we have a design-choice conundrum to resolve. If we now send in "E",
		then what happens? We can get one of two scenarios, but only one makes sense
		from an efficiency point of view.

				["M"]					["M"]
				/	\					/	\
			 ["A"] ["Z"]			 ["E"] ["Z"]
				\					 /
		 	   ["E"]			  ["A"]

		Both of these graphs are logically correct with regard to lesser-left and
		greater-right. However, the graph on the right is more computationally
		expensive. Why?

		Because the left-hand graph is a simple addition of a child-right node, whereas
		the right-hand graph involves multi-step process (replace "A" with "E" and then
		add "A" to left-child on "E"). For the sake of efficiency, we are better of
		with the simpler one-step adding of "E" as a right-child of "A".

		The replace-dance must be non-destructive because "A" might have children
		that cannot be lost. We must preserve them. So, we need a way to replace
		the parent of "A" (e.g. "M") with "E" and then assign the parent of "A"
		to "M". This will preserve the left and right tree child nodes of "A".
		]"


end
