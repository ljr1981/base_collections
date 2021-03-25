note
	description: "[
		TREE_MAP tests
	]"
	testing: "type/manual"

class
	TREE_MAP_TEST_SET

inherit
	TEST_SET_SUPPORT

feature -- Test routines: Basic red-black

	gobo_red_black_tests
			-- Tests of Java-ish Treemap.
		note
			EIS: "name=java_comparison_code", "src=https://beginnersbook.com/2013/12/treemap-in-java-with-example/"
		local
			tmap: TREE_MAP [STRING, INTEGER]
			l_print: STRING
		do
			create tmap.make (create {INTEGER_COMPARATOR})
			tmap.put ("Data1", 1)
			tmap.put ("Data2", 23)
			tmap.put ("Data3", 70)
			tmap.put ("Data4", 4)
			tmap.put ("Data5", 2)

			from tmap.start; create l_print.make_empty until tmap.off loop
				l_print.append_string_general ("key is: " + tmap.key_for_iteration.out)
				l_print.append_string_general (" & Value is: " + tmap.item_for_iteration.out + "%N")
				tmap.forth
			end
			assert_strings_equal ("gobo_red_black_tests_result", gobo_red_black_tests_result, l_print)
		end

	gobo_red_black_tests_result: STRING = "[
key is: 1 & Value is: Data1
key is: 2 & Value is: Data5
key is: 4 & Value is: Data4
key is: 23 & Value is: Data2
key is: 70 & Value is: Data3

]"

feature -- Test routines: entrySet

	tree_map_entry_set_tests
			--
		local
			tmap: TREE_MAP [STRING, INTEGER]
			l_print: STRING
		do
			create tmap.make (create {INTEGER_COMPARATOR})
			tmap.put ("Data1", 1)
			tmap.put ("Data2", 23)
			tmap.put ("Data3", 70)
			tmap.put ("Data4", 4)
			tmap.put ("Data5", 2)

			across
				tmap.entrySet as ic
			from
				create l_print.make_empty
			loop
				l_print.append_string_general ("key is: " + ic.item.key.out)
				l_print.append_string_general (" & Value is: " + ic.item.value.out + "%N")
			end
			assert_strings_equal ("gobo_red_black_tests_result", gobo_red_black_tests_result, l_print)
		end

feature -- Test routines: values

	tree_map_values_test
			--
		local
			tmap: TREE_MAP [STRING, INTEGER]
			l_print: STRING
		do
			create tmap.make (create {INTEGER_COMPARATOR})
			tmap.put ("Data1", 1)
			tmap.put ("Data2", 23)
			tmap.put ("Data3", 70)
			tmap.put ("Data4", 4)
			tmap.put ("Data5", 2)

			across
				tmap.values as ic
			from
				create l_print.make_empty
			loop
				l_print.append_string_general ("Value is: " + ic.item.out + "%N")
			end
			assert_strings_equal ("tree_map_values_test_result", tree_map_values_test_result, l_print)
		end

	tree_map_values_test_result: STRING = "[
Value is: Data1
Value is: Data5
Value is: Data4
Value is: Data2
Value is: Data3

]"

feature -- Test routines: descendingKeySet

	descendingKeySet_tests
			--
		local
			tmap: TREE_MAP [STRING, INTEGER]
			l_print: STRING
		do
			create tmap.make (create {INTEGER_COMPARATOR})
			tmap.put ("Data1", 1)
			tmap.put ("Data2", 23)
			tmap.put ("Data3", 70)
			tmap.put ("Data4", 4)
			tmap.put ("Data5", 2)

			across
				tmap.descendingKeySet as ic
			from
				create l_print.make_empty
			loop
				l_print.append_string_general ("Key is: " + ic.item.out + "%N")
			end
			assert_strings_equal ("descendingKeySet_tests_result", descendingKeySet_tests_result, l_print)
		end

		descendingKeySet_tests_result: STRING = "[
Key is: 70
Key is: 23
Key is: 4
Key is: 2
Key is: 1

]"

feature -- Test routines: descendingMap

	descendingMap_test
			--
		local
			tmap: TREE_MAP [STRING, INTEGER]
			l_print: STRING
		do
			create tmap.make (create {INTEGER_COMPARATOR})
			tmap.put ("Data1", 1)
			tmap.put ("Data2", 23)
			tmap.put ("Data3", 70)
			tmap.put ("Data4", 4)
			tmap.put ("Data5", 2)

			across
				tmap.descendingMap as ic
			from
				create l_print.make_empty
			loop
				l_print.append_string_general ("key is: " + ic.item.key.out)
				l_print.append_string_general (" & Value is: " + ic.item.value.out + "%N")
			end
			assert_strings_equal ("descendingMap_tests_result", descendingMap_tests_result, l_print)
		end

		descendingMap_tests_result: STRING = "[
key is: 70 & Value is: Data3
key is: 23 & Value is: Data2
key is: 4 & Value is: Data4
key is: 2 & Value is: Data5
key is: 1 & Value is: Data1

]"

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


