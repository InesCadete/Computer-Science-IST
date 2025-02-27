# 🧠 **Logic for Programming** 🧠

---

## 📌 **Course Overview**

The **Logic for Programming** course explores the foundations of logic as it applies to programming. It covers key concepts in both **propositional** and **first-order logic**, and how these are used in **deductive systems** and **logic programming**. The main topics include:

- **Propositional Logic**: Understanding the components of logic, logical propositions, and arguments. Studying propositional resolution and its applications.
- **First-Order Logic**: Exploring first-order logic as a deductive system and its resolution techniques.
- **Logic Programming**: Learning about **PROLOG**, a language based on formal logic for solving problems using facts, rules, and queries.
- **Applications**: How logic can be used to solve real-world problems through logical reasoning and programmatic solutions.

By the end of the course, students will be able to understand and implement propositional and first-order logic in programming languages like **PROLOG**.

---

## 📝 **Project Overview**

### 💡 **Project 1: Solucionador de Puzzles Hashi (Parte I)**

In the first project, students write the first part of a **PROLOG** program to solve **Hashi puzzles**. A Hashi puzzle consists of a grid where each cell can either be empty or contain an island, with an indication of how many bridges need to connect to that island. The goal of the program is to connect the islands according to the following rules:

- A maximum of two bridges can connect any two islands.
- Bridges must be either vertical or horizontal, and cannot cross other islands or bridges.
- The puzzle solution must allow passage between all islands.

In this project, the **PROLOG** program is responsible for:
- **Extracting islands** from the grid.
- **Identifying neighboring islands**.
- **Solving the puzzle** by adding bridges between islands, following the rules and constraints.

The puzzle is represented as a list of lists in **PROLOG**, where each island is represented by an integer, indicating the number of bridges that island needs.

Key components of the code include:

- **extrai_ilhas_linha/3**: Extracts the islands in a given row.
- **ilhas/2**: Extracts all islands from the entire puzzle, organizing them from top to bottom and left to right.
- **vizinhas/3**: Finds the neighboring islands of a given island.
- **actualiza_vizinhas_entrada/6**: Updates the neighbors of an island after adding a bridge.

---

## 🧠 **Key Concepts Applied**

### 🔑 **Propositional Logic & Deductive Systems**
- **Propositions**: Logical statements that can be true or false.
- **Arguments**: Combinations of propositions used to make logical deductions.
- **Propositional Resolution**: A method for drawing conclusions from propositions.

### 🔄 **First-Order Logic & Deductive Systems**
- **Quantifiers**: Universal and existential quantifiers that help express more complex logical relations.
- **First-Order Resolution**: Resolving logical problems using predicates and quantifiers.

### 👨‍💻 **Logic Programming (PROLOG)**
- **PROLOG Syntax**: Learning the syntax and semantics of **PROLOG**, which allows for defining facts, rules, and queries.
- **Backtracking**: The mechanism that **PROLOG** uses to explore all possible solutions to a problem.
- **Recursion**: The core concept used to solve problems in **PROLOG** by breaking them down into smaller subproblems.

---

## 🚀 **How to Test**

To test your solution, follow these steps:

1. **Clone the repository** or navigate to the project directory.

2. **Run the PROLOG code**:
   If you're using SWI-Prolog, load the file with the following command:
   ```bash
   swipl nome_do_arquivo.pl
