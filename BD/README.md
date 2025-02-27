# 🌟 **BD- Database Systems** 🌟

---

## 📌 **Course Overview**

This course explores the **fundamentals of database systems**, covering:

- **Database architecture** and development processes.
- **Data modeling**:
  - Entity-Relationship (E-R) and Relational Models.
  - Conversion of **E-R models to relational schemas**.
- **Database query languages**:
  - Relational Algebra & Relational Calculus.
  - SQL (Structured Query Language).
- **Integrity constraints**:
  - Referential integrity and SQL-based integrity enforcement.
- **Database application architecture**:
  - **Triggers**, Stored Procedures.
  - **Normalization**: Functional dependencies, normal forms, and schema decomposition.
- **Indexing structures**:
  - B+ Trees, Hash Indexes, Bitmap Indexes.
- **Transaction processing & recovery** in SQL.
- **Security & access control**.
- **Advanced topics**:
  - **Data warehousing, OLAP, data mining, and information retrieval**.

Each project includes a **detailed report (PDF)** explaining the problem domain, database design, and implementation details.

---

## 📝 **Concepts Applied in the Project**

### 🏥 **Healthcare Database Management System**

#### **Project Part 1: Data Modeling & Querying**
- **Designed an Entity-Relationship (E-R) model** for a healthcare company managing multiple clinics, healthcare professionals, and patient services.
- **Converted the E-R model into a relational schema**.
- **Implemented relational queries** using **Relational Algebra & SQL**.

#### **Project Part 2: Full-Stack Database Application**
- **Developed a Python-based API using Flask** for database interaction.
- **Created a database population script** to insert sample data.
- **Deployed the system using Docker** for containerized execution.
- **Used Jupyter Labs** for data analysis and testing.

---

## 🚀 **How to Test the Project**

### **1️⃣ Setup the Database & Populate Data**
Ensure you have **Docker** installed and running.

1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/healthcare-db.git
   cd healthcare-db
   ```
2. Run the database container:
   ```sh
   docker-compose up -d
   ```
3. Populate the database using the provided Python script:
   ```sh
   python populate_db.py
   ```

### **2️⃣ Run the API**
1. Start the Flask API:
   ```sh
   python app.py
   ```
2. The API will be available at `http://localhost:5000`
3. Test endpoints using **Postman** or **cURL**.

### **3️⃣ Query the Database**
- Access Jupyter Labs:
  ```sh
  jupyter lab
  ```
- Open the provided **notebook file (.ipynb)** and execute SQL queries.

---

✅ **This project showcases the integration of database modeling, SQL querying, API development, and containerized deployment!** 🚀

