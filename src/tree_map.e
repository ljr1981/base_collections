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
			Result := Current
		end

	put, add (v: ANY)
			--`put' or `add' an item `v' into Current.
		require
			G_typed: attached {G} v xor attached {TO_SPECIAL [G]} v
		do
			if attached {G} v as al_item then -- adding single item
				-- add item
			elseif attached {TO_SPECIAL [G]} v as al_array then -- adding a list of items
				-- add items
			elseif attached {like Current} v as al_tree_map then -- adding another TREE_MAP to Current
				plus (al_tree_map).do_nothing
			else
				check unknown_type: False end
			end
		end

end
