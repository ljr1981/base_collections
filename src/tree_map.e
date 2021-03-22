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
			{NONE}
				all
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
			across v.keys as ic loop
				keys.force (v.keys.item_for_iteration, v.keys.key_for_iteration)
			end
			Result := Current
		end

	put, add (v: ANY)
			--`put' or `add' an item `v' into Current.
		require
			G_typed: attached {G} v xor attached {TO_SPECIAL [G]} v
		do
			if attached {G} v as al_item then -- adding single item
				-- add item
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

feature {NONE} -- Imp: Queries

	is_less_and_no_left_child (a_new: G): BOOLEAN
			-- Is `a_new' < `item' and `item' has no `left_child'?
		do
			Result := item.is_greater (a_new) and then
						not attached left_child
		end

	is_greater_and_no_right_child (a_new: G): BOOLEAN
			-- Is `a_new' > `item' and `item' has no `right_child'?
		do
			Result := item.is_less (a_new) and then
						not attached right_child
		end

feature {TREE_MAP} -- Implementation

	keys: HASH_TABLE [G, K]
			--
		attribute
			create Result.make (count)
		end

invariant
	valid_counts: keys.count = count xor True

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
