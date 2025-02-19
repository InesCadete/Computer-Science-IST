# 📘 **BD- Database Systems**

## 📌 **Course Overview**
This course covers **database systems**, including:
- **Architecture and development** of databases.
- **Data modeling** using **Entity-Relationship (E-R)** and **Relational models**.
- **SQL, relational algebra, and integrity constraints**.
- **Triggers, stored procedures, and normalization techniques**.
- **Indexing structures** (B+ trees, hash, bitmap).
- **Transaction processing, security, data warehousing, OLAP, and text retrieval models**.

---

## 📑 **Practical exercises**
The folder include the lab classes ("labs") which helped with each topic addressed in the course.



## 📑 **Project Report**
The project includes a **detailed report** on the development of a **healthcare consultation management website**.

---

## 🚀 **Steps Taken to Develop the Project**

### 📌 **Step 0: Database Loading**  
🔹 Initial setup and population of the database.

### 📌 **Step 1: Implementing Integrity Constraints**  
🔹 Using **Stored Procedures and Triggers** to enforce necessary constraints.

### 📌 **Step 2: Database Population**  
🔹 **Python script** generates consistent and meaningful data.

### 📌 **Step 3: Application Development**  
🔹 Creating a **RESTful Web Service** to manage healthcare consultations.
🔹 Programmatic access to the ‘Saude’ database via an **API** that returns **JSON responses**.

### 📌 **Step 4: Complex SQL Query Formulation**  
🔹 Writing the most **concise SQL queries** for analytical tasks.
🔹 Utilizing **ROLLUP, CUBE, GROUPING SETS, or UNION of GROUP BY** where applicable.

---



## 🛠 **How to Test the Project**

### 📌 **1. Setup the Environment with Docker**
🔹 Ensure **Docker** is installed and running.  
🔹 Navigate to the project directory and run:
```bash
docker-compose up -d
```
🔹 This will set up the necessary **PostgreSQL database**.

### 📌 **2. Populate the Database**
🔹 Run the **Python script** to generate and execute SQL **INSERT statements**:
```bash
python populate_database.py
```
🔹 Alternatively, manually run the generated **SQL INSERT statements** in **Jupyter Labs**.

### 📌 **3. Access the Database via Jupyter Labs**
🔹 Open **Jupyter Labs** and connect to the database using a Jupyter SQL extension.  
🔹 Execute SQL queries to verify the data:
```sql
SELECT * FROM consultations LIMIT 10;
```
🔹 Test various constraints and integrity rules applied.

### 📌 **4. Test the RESTful API**
🔹 Start the web service
```bash
curl -X GET http://localhost:5000/api/consultations
```
🔹 Ensure the API returns expected JSON responses.

---

✨ *This course provides hands-on experience in designing and implementing database-driven applications!* 🚀
