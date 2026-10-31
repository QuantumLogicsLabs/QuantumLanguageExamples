# 500 Ruby Programs

Five hundred self-contained Ruby programs in 25 topics of 20, from the basics to
metaprogramming, algorithms and puzzles. They are written as a Ruby programmer
would write them, not in a subset chosen for Quantum, so they also measure how
much real Ruby the compiler runs.

Every program:

- runs in Ruby 3.4 (checked with `ruby` from MSYS2) and exits cleanly,
- is deterministic (no `rand`, clock or input; random-looking data comes from a
  seeded generator written in the program) and prints its results,
- reads no standard input and writes no files, so `quantum --test` can run it.

```bash
ruby 16_graphs/03_dijkstra.rb          # the reference
qrun 16_graphs/03_dijkstra.rb          # Quantum
quantum --test examples                # the whole examples tree
```

A few programs use the standard library (`json`, `uri`, `date`, `yaml`, `set`,
`strscan`, `forwardable`) and Ruby 3.x features (endless methods, `Data`,
pattern matching, `it`).

## 01_basics/ — Basics (20 programs)

- `01_hello_variables.rb` — Variables, interpolation and the classes of basic values.
- `02_temperature_table.rb` — A Celsius to Fahrenheit and Kelvin conversion table.
- `03_grade_calculator.rb` — Letter grades from numeric scores, with a class summary.
- `04_multiplication_table.rb` — A multiplication table with aligned columns.
- `05_leap_years.rb` — Leap years by the Gregorian rules.
- `06_number_classifier.rb` — Classifies numbers: parity, sign, primality and perfect squares.
- `07_while_until.rb` — while and until loops: Collatz sequences and a countdown.
- `08_case_ranges.rb` — case expressions over ranges, classes and lists.
- `09_ternary_and_unless.rb` — Ternaries, unless and statement modifiers.
- `10_loop_control.rb` — next, break and loop do.
- `11_digit_operations.rb` — Digit sums, reversal, palindromes and Armstrong numbers.
- `12_bmi_report.rb` — Body mass index for a few people, with categories.
- `13_integer_iterators.rb` — times, upto, downto and step.
- `14_string_formatting.rb` — format, % and padding helpers.
- `15_constants.rb` — Constants, frozen objects and a lookup table.
- `16_simple_interest.rb` — Simple and compound interest over several years.
- `17_triangle_types.rb` — Classifies triangles by sides and by angles.
- `18_parallel_assignment.rb` — Multiple assignment, swaps and splats.
- `19_boolean_logic.rb` — Truth tables, truthiness and safe navigation.
- `20_symbols.rb` — Symbols versus strings.

## 02_strings/ — Strings (20 programs)

- `01_string_basics.rb` — Everyday String methods.
- `02_palindromes.rb` — Palindrome detection on phrases, ignoring case and punctuation.
- `03_vowel_counter.rb` — Counts vowels, consonants and letter frequencies.
- `04_caesar_cipher.rb` — Caesar cipher: shift letters, keep case and punctuation.
- `05_word_frequency.rb` — Word frequencies in a paragraph.
- `06_title_case.rb` — Title case that keeps small words lower case (except at the start).
- `07_anagrams.rb` — Anagram checks and grouping.
- `08_string_slicing.rb` — Indexing and slicing strings.
- `09_string_building.rb` — Building strings: <<, +, concat, * and join.
- `10_substitution.rb` — sub and gsub with strings, hashes and blocks.
- `11_text_box.rb` — Draws text inside boxes with center, ljust and rjust.
- `12_run_length_encoding.rb` — Run-length encoding and decoding.
- `13_character_codes.rb` — Characters, codes and bytes.
- `14_word_wrap.rb` — Greedy word wrapping to a fixed width.
- `15_acronyms.rb` — Builds acronyms and initials.
- `16_string_comparison.rb` — Comparing and sorting strings.
- `17_heredoc_report.rb` — Heredocs with interpolation for a small report.
- `18_split_and_join.rb` — Splitting strings in different ways.
- `19_cleaning_strings.rb` — strip, squeeze, delete, chomp and friends.
- `20_pig_latin.rb` — Translates sentences to Pig Latin.

## 03_arrays/ — Arrays (20 programs)

- `01_array_basics.rb` — Creating and changing arrays.
- `02_statistics.rb` — Mean, median, mode, range and standard deviation.
- `03_rotate_reverse.rb` — Rotating and reversing arrays.
- `04_flatten_compact_uniq.rb` — Nested arrays, nils and duplicates.
- `05_matrix_operations.rb` — Matrices as arrays of arrays.
- `06_slices_and_runs.rb` — each_slice, each_cons, chunk_while and slice_when.
- `07_set_operations.rb` — Union, intersection and difference on arrays.
- `08_array_searching.rb` — Finding elements and positions.
- `09_partition_group.rb` — Splitting arrays into groups.
- `10_sorting_records.rb` — Sorting records by several keys.
- `11_moving_average.rb` — Simple moving averages over a price series.
- `12_combinatorics.rb` — product, combination and permutation.
- `13_two_sum.rb` — Two-sum and three-sum with hashes and sorting.
- `14_kth_largest.rb` — Second largest, k-th largest and top-k elements.
- `15_array_construction.rb` — Array.new, fill, ranges and %w.
- `16_trapping_rain_water.rb` — Water trapped between bars, two ways.
- `17_max_subarray.rb` — Kadane's algorithm with the subarray bounds.
- `18_merge_sorted.rb` — Merging sorted arrays.
- `19_rotation_check.rb` — Detecting rotations of arrays and strings.
- `20_pascal_triangle.rb` — Pascal's triangle and its properties.

## 04_hashes/ — Hashes (20 programs)

- `01_hash_basics.rb` — Creating, reading and changing hashes.
- `02_inventory.rb` — A small warehouse inventory.
- `03_word_index.rb` — Maps each word to the lines it appears on.
- `04_default_values.rb` — Hash defaults: values and blocks.
- `05_nested_hashes.rb` — Nested configuration with dig.
- `06_invert_and_group.rb` — Inverting hashes and grouping keys by value.
- `07_hash_iteration.rb` — Iterating hashes in various ways.
- `08_transform.rb` — transform_values, transform_keys, filter_map and to_h.
- `09_merge.rb` — Merging hashes, with and without conflict blocks.
- `10_phone_book.rb` — A phone book with searches.
- `11_character_histogram.rb` — A vertical and horizontal histogram of letters.
- `12_memoization.rb` — Memoized recursion with a hash.
- `13_adjacency.rb` — An undirected graph as a hash of neighbour lists.
- `14_hash_sorting.rb` — Sorting hash entries by key and by value.
- `15_vote_counting.rb` — Counts ballots and runs an instant-runoff election.
- `16_pretty_print.rb` — Recursively pretty-prints nested hashes and arrays.
- `17_hash_keys.rb` — Keys of different types, equality and comparison.
- `18_roman_numerals.rb` — Roman numerals in both directions.
- `19_morse_code.rb` — Morse code encoder and decoder.
- `20_student_records.rb` — A gradebook as a hash of hashes.

## 05_numbers_math/ — Numbers and math (20 programs)

- `01_integer_division.rb` — Integer division, modulo and their signs.
- `02_rounding.rb` — Rounding floats in different directions.
- `03_gcd_lcm.rb` — Greatest common divisor and least common multiple.
- `04_prime_sieve.rb` — Sieve of Eratosthenes and prime statistics.
- `05_prime_factors.rb` — Prime factorisation and divisor counts.
- `06_number_bases.rb` — Converting between bases.
- `07_big_integers.rb` — Arbitrary precision integers.
- `08_rationals.rb` — Exact fractions with Rational.
- `09_complex_numbers.rb` — Complex arithmetic.
- `10_perfect_numbers.rb` — Perfect, abundant and deficient numbers, and amicable pairs.
- `11_fibonacci_variants.rb` — Fibonacci numbers computed several ways.
- `12_math_functions.rb` — The Math module.
- `13_number_formatting.rb` — Thousands separators, percentages and currency.
- `14_digital_persistence.rb` — Multiplicative and additive persistence of numbers.
- `15_pythagorean_triples.rb` — Pythagorean triples, primitive ones via Euclid's formula.
- `16_newton_sqrt.rb` — Square roots by Newton's method, integer and float.
- `17_base_conversion.rb` — Converting bases by hand.
- `18_lcg_generator.rb` — A deterministic linear congruential generator and dice statistics.
- `19_making_change.rb` — Greedy change making in coins and notes.
- `20_ranges.rb` — Ranges: inclusion, stepping and arithmetic.

## 06_methods_blocks/ — Methods, blocks, procs and lambdas (20 programs)

- `01_default_keyword_args.rb` — Default values and keyword arguments.
- `02_splat_arguments.rb` — *args, **options and explicit &block parameters.
- `03_yield_basics.rb` — Methods that take blocks.
- `04_custom_iterators.rb` — Re-implementing each, map, select and reduce with yield.
- `05_procs_vs_lambdas.rb` — Differences between procs and lambdas.
- `06_closures.rb` — Closures capture their surrounding variables.
- `07_method_objects.rb` — Methods as objects.
- `08_higher_order_functions.rb` — Functions that build and combine functions.
- `09_currying.rb` — Currying and partial application.
- `10_block_local_variables.rb` — Block parameters, block-local variables and shadowing.
- `11_recursive_lambdas.rb` — Recursion with lambdas and methods.
- `12_retry_helper.rb` — A retry helper built on blocks, with a fake flaky service.
- `13_call_counter.rb` — Wraps methods to count calls, using blocks and define_method.
- `14_ensure_resource.rb` — Resource handling with blocks and ensure.
- `15_bang_and_predicate_methods.rb` — Conventions: ? for predicates, ! for dangerous versions.
- `16_endless_methods.rb` — One-line endless method definitions.
- `17_multiple_return_values.rb` — Returning and destructuring several values.
- `18_symbol_to_proc.rb` — &:symbol shorthand and its equivalents.
- `19_memoize.rb` — A generic memoize helper based on closures.
- `20_then_pipelines.rb` — Chaining transformations with then and tap.

## 07_classes_objects/ — Classes and objects (20 programs)

- `01_bank_account.rb` — A bank account with a transaction history.
- `02_point_equality.rb` — Value objects with ==, eql? and hash.
- `03_class_methods.rb` — Class methods, class-level counters and factories.
- `04_accessors_validation.rb` — Readers, writers and validating setters.
- `05_temperature_operators.rb` — Operator overloading on a Temperature class.
- `06_money.rb` — Money stored in cents, with arithmetic and allocation.
- `07_stack_class.rb` — A stack class used to evaluate postfix expressions.
- `08_copying_objects.rb` — Identity, equality, dup and clone.
- `09_visibility.rb` — Public, private and protected methods.
- `10_singleton_methods.rb` — Methods defined on single objects and class << self.
- `11_inspect_and_to_s.rb` — Custom string representations.
- `12_fraction.rb` — A Fraction class with normalised arithmetic.
- `13_class_instance_variables.rb` — Class-level state that subclasses keep separately.
- `14_shopping_cart.rb` — A shopping cart with discounts.
- `15_matrix_class.rb` — A Matrix class with [] access, each and multiplication.
- `16_respond_to_and_ivars.rb` — Introspecting objects: instance variables and capabilities.
- `17_clock.rb` — A 24-hour clock with modular arithmetic.
- `18_queue_simulation_class.rb` — A ticket queue at a service desk.
- `19_object_comparison.rb` — Spaceship-based sorting of custom objects.
- `20_library_system.rb` — Books, members and loans.

## 08_inheritance_modules/ — Inheritance and modules (20 programs)

- `01_animal_hierarchy.rb` — Inheritance, super and polymorphism.
- `02_shapes_polymorphism.rb` — An abstract base class with concrete shapes.
- `03_comparable.rb` — Including Comparable for ordering by a key.
- `04_enumerable_collection.rb` — A custom collection that gains Enumerable by defining each.
- `05_mixins.rb` — Sharing behaviour through modules.
- `06_namespaces.rb` — Modules as namespaces with constants and nested classes.
- `07_module_functions.rb` — module_function and extend self for utility modules.
- `08_method_lookup.rb` — Method resolution order with include, prepend and super.
- `09_prepend_wrapper.rb` — Using prepend to add logging around existing methods.
- `10_hooks.rb` — included, extended and inherited callbacks.
- `11_super_arguments.rb` — super with implicit, explicit and empty arguments.
- `12_template_method.rb` — The template method pattern with hooks.
- `13_strategy_modules.rb` — Swapping pricing strategies at runtime.
- `14_refinements.rb` — Refinements: scoped monkey patches.
- `15_mixin_conflicts.rb` — When two modules define the same method, the last included wins.
- `16_hierarchy_queries.rb` — Asking classes and objects about their relationships.
- `17_vehicles.rb` — A vehicle hierarchy with shared trip costs.
- `18_observer.rb` — A hand-written observer pattern.
- `19_enumerable_tree.rb` — A binary search tree that is Enumerable.
- `20_extend_objects.rb` — Adding behaviour to individual objects with extend.

## 09_enumerables/ — Enumerable and iterators (20 programs)

- `01_map_select_reject.rb` — The core transformations.
- `02_reduce_inject.rb` — Folding collections with reduce/inject.
- `03_each_with_object.rb` — Building results with each_with_object.
- `04_zip_and_index.rb` — Combining sequences with zip and indexes.
- `05_lazy_sequences.rb` — Lazy enumerators over infinite ranges.
- `06_external_enumerators.rb` — Driving enumerators manually with next and peek.
- `07_enumerator_generators.rb` — Custom sequences with Enumerator.new.
- `08_chunk_and_slice.rb` — Grouping consecutive elements.
- `09_min_max_sum_by.rb` — Finding extremes and totals by a key.
- `10_take_drop_while.rb` — take, drop, take_while and drop_while.
- `11_cycle_and_each_entry.rb` — Repeating sequences with cycle.
- `12_flat_map.rb` — Flattening as you map.
- `13_tally_group.rb` — Counting and grouping elements.
- `14_stable_sorting.rb` — Sorting by computed keys, ties and stability.
- `15_float_sums.rb` — Floating point totals: sum versus naive addition.
- `16_zip_transpose.rb` — Rows, columns and unzipping.
- `17_monotonic_runs.rb` — Detecting increasing and decreasing runs.
- `18_with_index_and_object.rb` — with_index offsets and with_object.
- `19_filter_map_compact.rb` — filter_map, compact and sum with transformations.
- `20_sales_pipeline.rb` — A data pipeline over sales records.

## 10_exceptions/ — Exceptions (20 programs)

- `01_rescue_basics.rb` — begin / rescue / else / ensure.
- `02_custom_exceptions.rb` — A small hierarchy of application errors.
- `03_raise_and_cause.rb` — Re-raising, wrapping errors and the cause chain.
- `04_ensure_order.rb` — The order in which bodies, rescues and ensures run.
- `05_rescue_modifier.rb` — Inline rescue modifiers and defaults.
- `06_exception_hierarchy.rb` — Where common exceptions sit in the hierarchy.
- `07_form_validation.rb` — Collecting all validation errors instead of stopping at the first.
- `08_retry_backoff.rb` — Retrying with exponential backoff (simulated clock, no sleeping).
- `09_throw_catch.rb` — Leaving nested loops with throw and catch.
- `10_exception_objects.rb` — What exception objects carry.
- `11_method_rescue.rb` — rescue and ensure attached directly to def bodies.
- `12_common_errors.rb` — Triggering and identifying the common built-in errors.
- `13_circuit_breaker.rb` — A circuit breaker that stops calling a failing dependency.
- `14_result_objects.rb` — Returning result objects instead of raising.
- `15_parse_errors.rb` — A tiny arithmetic parser that reports error positions.
- `16_transfer_rollback.rb` — Rolling back a transfer when a step fails.
- `17_nested_rescue.rb` — Translating low-level errors at each layer.
- `18_batch_errors.rb` — Processing a batch and summarising the failures.
- `19_frozen_objects.rb` — Freezing objects and the errors it causes.
- `20_flow_order.rb` — Tracing begin/rescue/else/ensure for success and failure.

## 11_structs_sets/ — Struct, Data and Set (20 programs)

- `01_struct_basics.rb` — Struct: lightweight records.
- `02_struct_methods.rb` — Structs with behaviour defined in a block.
- `03_data_define.rb` — Immutable value objects with Data.define.
- `04_set_basics.rb` — Set operations.
- `05_unique_visitors.rb` — Counting unique visitors with sets.
- `06_sorting_structs.rb` — Sorting and querying a list of structs.
- `07_data_points.rb` — Data value objects as hash keys and in sets.
- `08_struct_defaults.rb` — Structs with defaults through a custom initializer.
- `09_set_relations.rb` — Subsets, supersets and set algebra on skills.
- `10_ordered_sets.rb` — Keeping sets in order, with sorting on demand.
- `11_struct_patterns.rb` — Pattern matching on structs and Data.
- `12_deque.rb` — A double-ended queue built on an array, used for a sliding window maximum.
- `13_priority_queue.rb` — A binary heap priority queue holding tasks.
- `14_directory.rb` — An employee directory: a hash of structs with lookups.
- `15_comparable_struct.rb` — Structs that compare and sort naturally.
- `16_visited_positions.rb` — Tracking visited grid positions with a Set of arrays.
- `17_validated_values.rb` — Value objects that validate on creation.
- `18_bitset.rb` — A bit set stored in an Integer.
- `19_ring_buffer.rb` — A fixed-size ring buffer that overwrites the oldest entries.
- `20_sparse_matrix.rb` — A sparse matrix stored as a hash of coordinates.

## 12_recursion/ — Recursion (20 programs)

- `01_factorial_fibonacci.rb` — Classic recursive definitions.
- `02_towers_of_hanoi.rb` — Towers of Hanoi, printing moves and counting them.
- `03_permutations.rb` — Generating permutations recursively.
- `04_power_set.rb` — All subsets of a set, recursively and with bitmasks.
- `05_binary_search.rb` — Recursive binary search, with first and last occurrences.
- `06_deep_flatten.rb` — Flattening, summing and measuring nested structures.
- `07_recursive_strings.rb` — String recursion: reverse, palindromes, counting.
- `08_digit_recursion.rb` — Recursion over digits.
- `09_ackermann.rb` — The Ackermann function and call counting.
- `10_mutual_recursion.rb` — Mutually recursive functions.
- `11_tree_recursion.rb` — Recursion over a nested hash tree.
- `12_merge_sort.rb` — Recursive merge sort with an inversion count.
- `13_quicksort.rb` — Recursive quicksort, functional and in place.
- `14_combination_sum.rb` — Backtracking: combinations that add up to a target.
- `15_sierpinski.rb` — Sierpinski triangle drawn recursively as text.
- `16_directory_tree.rb` — Printing a nested file tree with sizes.
- `17_count_change.rb` — Counting the ways to make change, recursively with memoization.
- `18_gray_codes.rb` — Recursive generation of Gray codes and binary strings.
- `19_call_counting.rb` — Plain versus memoized recursion, measured by call counts.
- `20_flood_fill.rb` — Recursive flood fill on a character grid.

## 13_sorting/ — Sorting algorithms (20 programs)

- `01_bubble_sort.rb` — Bubble sort with early exit and a swap count.
- `02_selection_sort.rb` — Selection sort, tracing each pass.
- `03_insertion_sort.rb` — Insertion sort counting element shifts.
- `04_bottom_up_merge_sort.rb` — Iterative bottom-up merge sort.
- `05_three_way_quicksort.rb` — Dutch national flag partitioning and three-way quicksort.
- `06_heap_sort.rb` — Heap sort with an explicit sift-down.
- `07_counting_sort.rb` — Counting sort for small integer ranges.
- `08_radix_sort.rb` — LSD radix sort, showing each digit pass.
- `09_bucket_sort.rb` — Bucket sort for floats in [0, 1).
- `10_shell_sort.rb` — Shell sort with two gap sequences.
- `11_comb_sort.rb` — Comb sort with a shrinking gap.
- `12_cocktail_sort.rb` — Cocktail shaker sort: bubbling in both directions.
- `13_gnome_sort.rb` — Gnome sort: a garden gnome sorting flower pots.
- `14_odd_even_sort.rb` — Odd-even transposition sort.
- `15_pancake_sort.rb` — Pancake sort: only prefix reversals allowed.
- `16_cycle_sort.rb` — Cycle sort: the minimum number of writes.
- `17_natural_merge_sort.rb` — Natural merge sort: merge the runs already present in the data.
- `18_custom_comparators.rb` — Sorting with custom ordering rules.
- `19_stability.rb` — Stable versus unstable sorts on equal keys.
- `20_comparison_counts.rb` — Comparing algorithms by the number of comparisons they make.

## 14_searching/ — Searching (20 programs)

- `01_linear_search.rb` — Linear search variants with comparison counts.
- `02_bounds.rb` — Lower and upper bounds with binary search.
- `03_jump_search.rb` — Jump search in blocks of sqrt(n).
- `04_interpolation_search.rb` — Interpolation search on uniformly spread data.
- `05_exponential_search.rb` — Exponential search for unbounded-style lookups.
- `06_ternary_search.rb` — Ternary search for the maximum of a unimodal function.
- `07_rotated_array.rb` — Searching a sorted array that has been rotated.
- `08_peak_finding.rb` — Finding peaks in arrays and grids.
- `09_quickselect.rb` — Quickselect for k-th smallest and the median.
- `10_two_pointers.rb` — Two-pointer techniques on sorted arrays.
- `11_substring_search.rb` — Finding all occurrences of a pattern, naively and with String#index.
- `12_matrix_search.rb` — Searching a matrix sorted by rows and columns.
- `13_majority_vote.rb` — Boyer-Moore majority vote.
- `14_missing_numbers.rb` — Finding missing and repeated numbers.
- `15_floyd_cycle.rb` — Floyd's tortoise and hare: duplicates and cycle detection.
- `16_binary_search_answer.rb` — Binary search over the answer: minimum ship capacity.
- `17_closest_value.rb` — Finding values closest to a target.
- `18_insert_position.rb` — Where would a value go in a sorted list?
- `19_spelling_suggestions.rb` — Suggesting words by edit distance.
- `20_word_grid_search.rb` — Finding words in a letter grid in all eight directions.

## 15_data_structures/ — Data structures (20 programs)

- `01_singly_linked_list.rb` — A singly linked list with common operations.
- `02_doubly_linked_list.rb` — A doubly linked list with insertion and removal at both ends.
- `03_bracket_matching.rb` — Checking brackets with a stack.
- `04_queue_from_stacks.rb` — A FIFO queue built from two stacks.
- `05_circular_queue.rb` — A fixed-capacity circular queue.
- `06_bst.rb` — Binary search tree: insert, search, delete and traversals.
- `07_min_heap.rb` — A min-heap with push, pop and heapify.
- `08_trie.rb` — A trie for prefix search and autocomplete.
- `09_union_find.rb` — Disjoint sets with union by rank and path compression.
- `10_lru_cache.rb` — A least-recently-used cache built on Hash ordering.
- `11_hash_table.rb` — A hash table with separate chaining and resizing.
- `12_monotonic_stack.rb` — Next greater elements and stock spans with a monotonic stack.
- `13_segment_tree.rb` — A segment tree for range sums with point updates.
- `14_fenwick_tree.rb` — A Fenwick (binary indexed) tree for prefix sums.
- `15_avl_tree.rb` — A self-balancing AVL tree.
- `16_sparse_table.rb` — A sparse table answering range-minimum queries in O(1).
- `17_bloom_filter.rb` — A Bloom filter with deterministic hash functions.
- `18_interval_set.rb` — A set of disjoint intervals with merging on insert.
- `19_undo_redo.rb` — Undo and redo stacks for a text editor.
- `20_multiset.rb` — A multiset (bag) with counts.

## 16_graphs/ — Graph algorithms (20 programs)

- `01_bfs_shortest_path.rb` — Breadth-first search for shortest paths in an unweighted graph.
- `02_dfs.rb` — Depth-first search, recursive and with an explicit stack.
- `03_dijkstra.rb` — Dijkstra's algorithm on a weighted road map.
- `04_bellman_ford.rb` — Bellman-Ford with negative edges and cycle detection.
- `05_floyd_warshall.rb` — All-pairs shortest paths with Floyd-Warshall.
- `06_topological_sort.rb` — Kahn's algorithm for a build order.
- `07_cycle_detection.rb` — Detecting cycles in directed graphs with three colours.
- `08_connected_components.rb` — Connected components of an undirected graph.
- `09_kruskal.rb` — Kruskal's minimum spanning tree with union-find.
- `10_prim.rb` — Prim's algorithm growing a spanning tree from one vertex.
- `11_bipartite.rb` — Two-colouring graphs to test whether they are bipartite.
- `12_maze_solver.rb` — Solving a text maze with BFS and drawing the path.
- `13_kosaraju.rb` — Strongly connected components with Kosaraju's algorithm.
- `14_bridges.rb` — Bridges and articulation points (Tarjan's low-link).
- `15_a_star.rb` — A* search on a weighted grid with a Manhattan heuristic.
- `16_word_ladder.rb` — Word ladder: shortest chain changing one letter at a time.
- `17_course_schedule.rb` — Planning semesters from course prerequisites.
- `18_max_flow.rb` — Maximum flow with Edmonds-Karp.
- `19_graph_coloring.rb` — Greedy colouring for an exam timetable.
- `20_eulerian_path.rb` — Hierholzer's algorithm for an Eulerian path.

## 17_dynamic_programming/ — Dynamic programming (20 programs)

- `01_knapsack.rb` — 0/1 knapsack with the chosen items reconstructed.
- `02_lcs.rb` — Longest common subsequence with the subsequence itself.
- `03_lis.rb` — Longest increasing subsequence in O(n log n), with reconstruction.
- `04_coin_change.rb` — Fewest coins for an amount, and which coins.
- `05_edit_operations.rb` — Edit distance with the list of operations.
- `06_palindromic_subsequence.rb` — Longest palindromic subsequence and minimum insertions to make a palindrome.
- `07_matrix_chain.rb` — Matrix chain multiplication order.
- `08_rod_cutting.rb` — Rod cutting for maximum revenue.
- `09_unique_paths.rb` — Counting lattice paths around obstacles.
- `10_min_path_sum.rb` — Minimum path sum through a grid, moving right or down.
- `11_house_robber.rb` — Maximum loot without robbing adjacent houses (line and circle).
- `12_word_break.rb` — Can a string be split into dictionary words? All the ways.
- `13_partition_subset.rb` — Splitting numbers into two groups of equal (or closest) sums.
- `14_climbing_stairs.rb` — Counting ways to climb stairs with different step sets.
- `15_decode_ways.rb` — Counting decodings of digit strings (A=1 ... Z=26).
- `16_max_product_subarray.rb` — Maximum product subarray, tracking min and max.
- `17_egg_drop.rb` — The egg dropping puzzle.
- `18_longest_common_substring.rb` — Longest common substring by dynamic programming.
- `19_tsp_bitmask.rb` — The travelling salesman problem with bitmask DP.
- `20_stock_trading.rb` — Best profit from stock trades with at most k transactions.

## 18_number_theory/ — Number theory (20 programs)

- `01_modular_power.rb` — Fast modular exponentiation and the Fermat primality test.
- `02_miller_rabin.rb` — Deterministic Miller-Rabin for 64-bit integers.
- `03_chinese_remainder.rb` — Solving simultaneous congruences.
- `04_euler_totient.rb` — Euler's totient by factorisation and by sieve.
- `05_modular_inverse.rb` — Modular inverses and solving linear congruences.
- `06_catalan.rb` — Catalan numbers and what they count.
- `07_bell_stirling.rb` — Stirling numbers of the second kind and Bell numbers.
- `08_integer_partitions.rb` — Counting and listing integer partitions.
- `09_continued_fractions.rb` — Continued fractions and convergents.
- `10_pell_equation.rb` — Fundamental solutions of Pell's equation x^2 - n*y^2 = 1.
- `11_magic_squares.rb` — Odd-order magic squares by the Siamese method.
- `12_happy_numbers.rb` — Happy numbers: repeated digit-square sums reaching 1.
- `13_kaprekar.rb` — Kaprekar's routine converging to 6174.
- `14_look_and_say.rb` — The look-and-say sequence.
- `15_goldbach.rb` — Checking Goldbach's conjecture for small even numbers.
- `16_ulam_spiral.rb` — An Ulam spiral marking primes.
- `17_pi_series.rb` — Approximating pi with several series.
- `18_exact_determinants.rb` — Determinants and inverses with exact rational arithmetic.
- `19_polynomials.rb` — Polynomial arithmetic with coefficient arrays.
- `20_egyptian_fractions.rb` — Greedy Egyptian fraction decompositions.

## 19_string_algorithms/ — String algorithms (20 programs)

- `01_kmp.rb` — Knuth-Morris-Pratt search with its failure table.
- `02_rabin_karp.rb` — Rabin-Karp search with a rolling hash.
- `03_z_algorithm.rb` — The Z-array and pattern matching with it.
- `04_horspool.rb` — Boyer-Moore-Horspool search with the bad-character shift table.
- `05_manacher.rb` — Manacher's algorithm for the longest palindromic substring.
- `06_suffix_array.rb` — Suffix array and LCP array (simple construction).
- `07_longest_repeat.rb` — Longest repeated substring, by sorting suffixes.
- `08_anagram_windows.rb` — Finding anagrams of a pattern with a sliding window.
- `09_minimum_window.rb` — The smallest window of a string containing all letters of another.
- `10_unique_substring.rb` — Longest substring without repeating characters.
- `11_lz77.rb` — A small LZ77 compressor and decompressor.
- `12_huffman.rb` — Huffman codes: build the tree, encode and decode.
- `13_burrows_wheeler.rb` — The Burrows-Wheeler transform and its inverse.
- `14_soundex.rb` — Soundex codes for matching similar-sounding names.
- `15_similarity.rb` — Hamming distance and Jaro-Winkler similarity.
- `16_text_justify.rb` — Full justification of text to a fixed width.
- `17_vigenere.rb` — The Vigenere cipher and a key-length hint from repeated trigrams.
- `18_classic_ciphers.rb` — Atbash and rail fence ciphers.
- `19_tokenizer.rb` — A hand-written tokenizer for a small expression language.
- `20_word_patterns.rb` — Isomorphic strings, word patterns and minimal rotations.

## 20_text_processing/ — Text processing and the standard library (20 programs)

- `01_csv_parser.rb` — A small CSV parser that handles quoted fields.
- `02_log_analysis.rb` — Parsing log lines and summarising them.
- `03_word_count.rb` — A wc-like report for a block of text.
- `04_template_engine.rb` — A tiny template engine with variables, loops and conditionals.
- `05_markdown_lite.rb` — Converting a subset of Markdown to HTML.
- `06_ini_parser.rb` — Parsing INI-style configuration with sections and types.
- `07_json_roundtrip.rb` — Generating and parsing JSON with the standard library.
- `08_url_parsing.rb` — Breaking URLs into parts with URI.
- `09_dates.rb` — Date arithmetic with the Date class.
- `10_ascii_table.rb` — Rendering rows as an ASCII table.
- `11_line_diff.rb` — A line-based diff using the longest common subsequence.
- `12_readability.rb` — Readability statistics for a short passage.
- `13_config_rewrite.rb` — Rewriting configuration with regex captures.
- `14_query_strings.rb` — Parsing and building query strings by hand.
- `15_slugs.rb` — Turning titles into URL slugs, with collisions handled.
- `16_align_assignments.rb` — Aligning '=' signs and comments in code.
- `17_length_histogram.rb` — A histogram of word lengths in a text.
- `18_email_extraction.rb` — Extracting and validating email addresses with regular expressions.
- `19_invoice.rb` — Generating a formatted invoice.
- `20_yaml_config.rb` — Reading and writing YAML with the standard library.

## 21_simulations/ — Simulations and games (20 programs)

- `01_game_of_life.rb` — Conway's Game of Life on a wrapping board.
- `02_elevator.rb` — An elevator serving requests with a simple SCAN strategy.
- `03_bank_queue.rb` — A discrete-event simulation of a bank with tellers.
- `04_traffic_light.rb` — A traffic light state machine with a pedestrian button.
- `05_vending_machine.rb` — A vending machine with coins, stock and change.
- `06_tic_tac_toe.rb` — Tic-tac-toe with two perfect minimax players.
- `07_inventory_simulation.rb` — Inventory over 20 days with a reorder point and lead time.
- `08_predator_prey.rb` — A discrete Lotka-Volterra predator-prey model.
- `09_bouncing_ball.rb` — A ball dropped with gravity and energy loss on each bounce.
- `10_parking_lot.rb` — A parking lot with sized spots and hourly fees.
- `11_round_robin.rb` — A round-robin tournament schedule and results table.
- `12_elementary_automata.rb` — Wolfram's elementary cellular automata.
- `13_langtons_ant.rb` — Langton's ant on a small wrapping grid.
- `14_connect_four.rb` — Connect Four with scripted moves and win detection.
- `15_snake.rb` — A scripted game of Snake.
- `16_epidemic_sir.rb` — The SIR epidemic model with daily steps.
- `17_robot_commands.rb` — A robot following commands on a grid with obstacles.
- `18_war_card_game.rb` — The card game War with a deterministically shuffled deck.
- `19_loan_amortization.rb` — A loan amortization schedule.
- `20_pig_dice.rb` — The dice game Pig with fixed dice rolls and two strategies.

## 22_functional/ — Functional programming (20 programs)

- `01_immutability.rb` — Pure functions and immutable updates.
- `02_composition.rb` — Building pipelines from small functions.
- `03_reduce_everything.rb` — Implementing common operations with reduce alone.
- `04_y_combinator.rb` — Anonymous recursion with the Y (Z) combinator.
- `05_church_numerals.rb` — Numbers and booleans encoded as functions.
- `06_cons_lists.rb` — An immutable linked list made of cons cells.
- `07_maybe.rb` — An Option type to avoid nil checks.
- `08_validation.rb` — Accumulating validation errors functionally.
- `09_transducers.rb` — Transducers: composable transformations independent of the collection.
- `10_functional_queue.rb` — A persistent queue built from two immutable lists.
- `11_expression_fold.rb` — Folding over an expression tree to evaluate, print and simplify.
- `12_lenses.rb` — Lenses for reading and updating nested immutable hashes.
- `13_monoids.rb` — Combining values with monoids.
- `14_dispatch_tables.rb` — Replacing conditionals with tables of functions.
- `15_unfold.rb` — Generating sequences by unfolding from a seed.
- `16_trampoline.rb` — Trampolines: deep recursion without growing the stack.
- `17_pattern_match_sort.rb` — Recursive algorithms written with pattern matching.
- `18_event_sourcing.rb` — Rebuilding account state by folding over events.
- `19_lazy_pipelines.rb` — Lazy pipelines that stop as soon as they have enough.
- `20_partial_application.rb` — Partial application and argument flipping.

## 23_regex_patterns/ — Regular expressions and pattern matching (20 programs)

- `01_regex_basics.rb` — Matching, captures and named groups.
- `02_scan_gsub.rb` — Finding all matches and replacing with blocks.
- `03_validators.rb` — Common validation patterns.
- `04_array_patterns.rb` — case/in with array patterns.
- `05_hash_patterns.rb` — case/in with hash patterns and nested data.
- `06_find_and_pin.rb` — Find patterns and the pin operator.
- `07_custom_deconstruct.rb` — Classes that support pattern matching.
- `08_lookaround.rb` — Lookahead and lookbehind assertions.
- `09_string_scanner.rb` — Tokenizing with StringScanner.
- `10_greedy_lazy.rb` — Greedy versus lazy quantifiers.
- `11_router.rb` — A URL router that matches patterns and extracts parameters.
- `12_command_parser.rb` — Parsing commands with pattern matching on split words.
- `13_nested_data_match.rb` — Matching deeply nested API responses.
- `14_password_checker.rb` — Scoring password strength with regular expressions.
- `15_wildcards.rb` — Glob-style wildcard matching: by regex and by dynamic programming.
- `16_date_reformat.rb` — Rewriting date formats with backreferences.
- `17_alternatives_guards.rb` — Alternative patterns, guards and binding.
- `18_rightward_and_in.rb` — One-line pattern matching: => for destructuring, in for testing.
- `19_query_parser.rb` — Parsing a tiny SQL-like query language and running it.
- `20_tiny_regex_engine.rb` — A tiny regex matcher supporting literals, ., *, ^ and $ (after Pike and Kernighan).

## 24_metaprogramming/ — Metaprogramming (20 programs)

- `01_send.rb` — Calling methods by name with send and public_send.
- `02_define_method.rb` — Generating methods with define_method.
- `03_method_missing.rb` — A dynamic proxy using method_missing and respond_to_missing?.
- `04_attribute_dsl.rb` — A class-level DSL for typed attributes with defaults.
- `05_html_builder.rb` — An HTML builder DSL using instance_eval and method_missing.
- `06_constants.rb` — Looking up constants and classes by name.
- `07_method_added_hook.rb` — Reacting to method definitions with method_added.
- `08_generated_comparisons.rb` — Generating comparison helpers from a single key.
- `09_memoize_macro.rb` — A memoize class macro built with prepend and define_method.
- `10_validation_dsl.rb` — A validates DSL in the style of web frameworks.
- `11_state_machine_dsl.rb` — A small state machine DSL.
- `12_dynamic_finders.rb` — find_by_* methods generated on the fly.
- `13_singleton_class.rb` — Singleton classes, class methods and extend.
- `14_anonymous_classes.rb` — Creating classes at runtime with Class.new.
- `15_forwardable.rb` — Delegation with Forwardable.
- `16_generic_serializer.rb` — Serialising any object through its instance variables.
- `17_alias_wrapping.rb` — Wrapping existing methods with alias_method.
- `18_config_dsl.rb` — A configuration DSL evaluated with instance_eval.
- `19_coerce.rb` — Making numbers work on the left of custom operators with coerce.
- `20_instance_exec_callbacks.rb` — Before and after callbacks run with instance_exec.

## 25_puzzles/ — Puzzles (20 programs)

- `01_n_queens.rb` — The N-queens puzzle by backtracking.
- `02_sudoku.rb` — A backtracking Sudoku solver.
- `03_knights_tour.rb` — A knight's tour using Warnsdorff's heuristic.
- `04_water_jugs.rb` — Measuring water with two jugs, solved by breadth-first search.
- `05_river_crossing.rb` — Missionaries and cannibals: three of each must cross with a two-seat boat.
- `06_eight_puzzle.rb` — Solving the 8-puzzle with A* and the Manhattan distance.
- `07_twenty_four.rb` — The 24 game: combine four numbers with + - * / to make 24.
- `08_cryptarithm.rb` — Solving letter-arithmetic puzzles with backtracking.
- `09_logic_puzzle.rb` — A small logic puzzle solved by trying all assignments.
- `10_boggle.rb` — Finding dictionary words in a Boggle board.
- `11_josephus.rb` — The Josephus problem: simulation and closed form.
- `12_fake_coin.rb` — Finding a lighter fake coin among 12 with a balance scale.
- `13_maze_generator.rb` — Generating a maze with a deterministic recursive backtracker.
- `14_nim.rb` — Nim and Sprague-Grundy values for a subtraction game.
- `15_mastermind.rb` — Mastermind: guessing a code by keeping only consistent candidates.
- `16_longest_word.rb` — The longest dictionary words that can be built from a rack of letters.
- `17_monty_hall.rb` — The Monty Hall problem by exact enumeration.
- `18_bridge_and_torch.rb` — Four people crossing a bridge at night with one torch (shortest time by Dijkstra).
- `19_latin_squares.rb` — Building and checking Latin squares.
- `20_lights_out.rb` — Lights Out on a 3x3 board, solved by trying all press patterns.
