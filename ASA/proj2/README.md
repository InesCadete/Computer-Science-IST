# 📌 **Project 2: Longest Path in a Virus Spread Network**

## 📖 **Overview**
This project aims to determine the **maximum number of propagation jumps** made by a virus, given information about social connections within a population. The goal is to **map possible transmission paths** while eliminating cycles where everyone is instantly infected, ultimately computing the **worst-case scenario (longest path).**

## 🛠 **Approach**
- Represented the **social network as a graph** using an **adjacency list**.
- Used the **Kosaraju-Sharir algorithm** (which applies **Depth-First Search (DFS)** to both the graph and its transpose) to **identify strongly connected components** (cycles).
- Constructed a **Directed Acyclic Graph (DAG)** by reducing cycles.
- Applied **DFS on the DAG** to determine the **longest path** in the simplified graph.

## 🚀 **How to Test**
1. Compile the program using a C++ compiler:
   ```sh
   g++ -o longest_path longest_path.cpp
   ```
2. Run the executable:
   ```sh
   ./longest_path
   ```
3. Provide input representing the **social connections** as a graph.
4. The program will output the **maximum number of propagation jumps** in the worst case.

---

✅ **This project demonstrates the application of graph theory and DFS-based algorithms to model virus transmission!**

