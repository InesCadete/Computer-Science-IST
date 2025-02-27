# 📌 **Project 1: Optimal Sheet Cutting**

## 📖 **Overview**
This project aims to **maximize the price** of an **M x N** sheet by cutting it into smaller pieces, each with predefined dimensions and values.

## 🛠 **Approach**
- Explored different **vertical and horizontal cuts** to determine the best piece combinations.
- Used **dynamic programming with tabulation** to store optimal values for each sheet dimension.
- Constructed an **M x N table**, where each entry represents the **maximum obtainable price** for that sheet size.
- Efficiently **reused previously computed values**, reducing redundant calculations.

## 🚀 **How to Test**
1. Compile the program using a C++ compiler:
   ```sh
   g++ -o proj1.cpp
   ```
2. Run the executable:
   ```sh
   ./proj1
   ```
3. Provide input dimensions and available piece values when prompted.
4. The program will output the **maximum price obtainable** for the given sheet.

---

✅ **This project demonstrates efficient problem-solving using dynamic programming and tabulation!**
