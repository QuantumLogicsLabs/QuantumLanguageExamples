# 50 Advanced Ruby Programs

A collection of 50 self-contained, idiomatic Ruby programs covering data
structures, graph algorithms, string algorithms, dynamic programming, and
concurrency/systems programming. Every file can be run directly:

```bash
ruby 01_data_structures/01_singly_linked_list.rb
```

Each program guards its demo code behind `if __FILE__ == $0`, so files can
also be safely `require`-d into other scripts or specs without side effects.

## 01_data_structures/ (10 programs)
1. Singly Linked List — push/delete/reverse, middle-node & cycle detection
2. Doubly Linked List — O(1) push/pop both ends, forward & reverse iteration
3. Stack — balanced-parentheses checker
4. Circular Queue — fixed-capacity ring buffer
5. Binary Search Tree — insert/search/delete/traversal/height
6. AVL Tree — self-balancing BST with rotations
7. Binary Heap — min/max heap + heapsort
8. Trie — prefix tree with autocomplete
9. Union-Find — disjoint sets with path compression & union by rank
10. LRU Cache — Hash + doubly linked list, O(1) get/put

## 02_graph_algorithms/ (10 programs)
1. Graph — adjacency list with BFS & DFS
2. Dijkstra's shortest path
3. Bellman-Ford — handles negative weights, detects negative cycles
4. Floyd-Warshall — all-pairs shortest paths
5. Kruskal's MST
6. Prim's MST
7. Topological Sort — Kahn's algorithm & DFS-based
8. Cycle Detection — directed and undirected graphs
9. Tarjan's Strongly Connected Components
10. A* Pathfinding — grid search with Manhattan-distance heuristic

## 03_string_algorithms/ (10 programs)
1. KMP (Knuth-Morris-Pratt) pattern matching
2. Rabin-Karp — rolling hash pattern matching
3. Longest Common Subsequence (with reconstruction)
4. Longest Palindromic Substring — expand around center
5. Z-Algorithm — Z-array construction & pattern search
6. Trie-based Word Search (2D board, LeetCode "Word Search II" style)
7. Edit Distance (Levenshtein)
8. Suffix Array + LCP Array
9. Anagram Grouping + permutation generator
10. Boyer-Moore — bad character heuristic

## 04_dynamic_programming/ (10 programs)
1. 0/1 Knapsack (with item reconstruction)
2. Longest Increasing Subsequence — O(n log n) and O(n²) w/ sequence
3. Coin Change — min coins & number of ways
4. Matrix Chain Multiplication — optimal parenthesization
5. Subset Sum — existence check & reconstruction
6. Rod Cutting — optimal cut lengths
7. Fibonacci — naive vs memoized vs tabulated, benchmarked
8. Longest Common Substring (contiguous)
9. Egg Dropping Puzzle
10. Word Break — feasibility & all valid segmentations

## 05_concurrency_systems/ (10 programs)
1. Producer-Consumer — Thread + Queue
2. Thread Pool — fixed worker threads pulling from a job queue
3. Bank Account — race condition demo + Mutex-protected fix
4. Fiber Scheduler — cooperative multitasking, round-robin
5. Ractor Parallel Sum — true parallelism (Ruby 3.0+)
6. Log File Analyzer — parses log levels, extracts errors
7. TCP Echo Server/Client — sockets, one thread per connection
8. Bounded Buffer — Mutex + ConditionVariable producer/consumer
9. Fork + IPC — process-level parallelism via IO.pipe
10. Multithreaded Key-Value Store — Mutex-protected SET/GET/DEL/KEYS

## Requirements
Ruby 3.0+ recommended (program 05/05_ractor_parallel_sum.rb uses Ractors,
which require 3.0+; it gracefully no-ops on older versions). Everything
else runs on Ruby 2.7+.
