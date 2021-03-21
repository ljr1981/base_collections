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
		end

create
	make

feature -- Basic Ops

	put (v: G)
			--
		do
			if has (v) then
				-- We already have a `v' (ignore it?)
			else
				-- Find where the item goes and put it there!
			end
		end

end
