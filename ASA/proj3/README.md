# 📌 **Project 3: Linear Programming for Profit Maximization**

## 📖 **Overview**
This project focuses on **maximizing the daily profit** of the company **UbiquityInc** by optimizing the production of individual toys and bundled packages, considering **profit margins and production constraints**.

## 🛠 **Approach**
- **Identified decision variables**:
  - `x1, ..., xn`: Number of individual products to produce.
  - `y1, ..., yp`: Number of bundles (each containing 3 products) to produce.
- Formulated a **linear programming model** to **maximize profit**, considering:
  - **Individual and package profits**.
  - **Production constraints** for both individual toys and total factory capacity.
- Implemented the model using:
  - **PuLP library** for linear programming.
  - **GLPK solver** to find the optimal production strategy.

## 🚀 **How to Test**
1. Ensure you have Python installed with the required dependencies:
   ```sh
   pip install pulp
   ```
2. Run the script:
   ```sh
   python natalASA.py
   ```
3. The program will output the **optimal number of individual products and packages** to produce for maximum profit.

---

✅ **This project showcases the power of linear programming for real-world optimization challenges!**
