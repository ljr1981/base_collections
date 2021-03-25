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

	gobo_red_black_tests
			-- Tests of Java-ish Treemap.
		note
			EIS: "name=java_comparison_code", "src=https://beginnersbook.com/2013/12/treemap-in-java-with-example/"
		local
			tmap: TREE_MAP [STRING, INTEGER]
		do
			create tmap.make (create {INTEGER_COMPARATOR})
			tmap.put ("Data1", 1)
			tmap.put ("Data2", 23)
			tmap.put ("Data3", 70)
			tmap.put ("Data4", 4)
			tmap.put ("Data5", 2)

			from tmap.start until tmap.off loop
				print ("key is: " + tmap.key_for_iteration.out)
				print (" & Value is: " + tmap.item_for_iteration.out + "%N")
				tmap.forth
			end

-- Eiffel OUTPUT:
-- key is: 1 & Value is: Data1
-- key is: 2 & Value is: Data5
-- key is: 4 & Value is: Data4
-- key is: 23 & Value is: Data2
-- key is: 70 & Value is: Data3

-- Vs Java output:
-- key is: 1 & Value is: Data1
-- key is: 2 & Value is: Data5
-- key is: 4 & Value is: Data4
-- key is: 23 & Value is: Data2
-- key is: 70 & Value is: Data3
		end

note
	java_code_example: "[
import java.util.TreeMap;
import java.util.Set;
import java.util.Iterator;
import java.util.Map;

public class Details {

   public static void main(String args[]) {

      TreeMap<Integer, String> tmap =
      	new TreeMap<Integer, String>();

      tmap.put(1, "Data1");
      tmap.put(23, "Data2");
      tmap.put(70, "Data3");
      tmap.put(4, "Data4");
      tmap.put(2, "Data5");

      /* Display content using Iterator*/
      Set set = tmap.entrySet();
      Iterator iterator = set.iterator();
      while(iterator.hasNext()) {
         Map.Entry mentry = (Map.Entry)iterator.next();
         System.out.print("key is: "+ mentry.getKey() + " & Value is: ");
         System.out.println(mentry.getValue());
      }

   }
}
]"

end


