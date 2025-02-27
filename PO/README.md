# PO- Object-Oriented Programming 

---

## 📌 **Course Overview**

The **Object-Oriented Programming (OOP)** course with a focus on **Java** covers fundamental concepts in object-oriented design and programming. This course is designed to help students understand the key principles of OOP, including inheritance, polymorphism, encapsulation, and abstraction, while using Java and C++ for practical application.

### **Topics Covered**:
1. **Introduction to Objects**:
   - Definitions, longevity, classes, methods, programs, and coding conventions.
   
2. **Operators, Expressions, and Flow Control**:
   - Operator precedence, assignment operators, type casting, literals, and control flow structures.

3. **Object Construction**:
   - Initialization and clean-up, constructors, method overloading, the `this` keyword, and garbage collection.

4. **Code Organization and Packages**:
   - Abstract data types, interfaces vs. implementations, libraries, and member access control.

5. **Inheritance and Composition**:
   - Incremental development, the `final` keyword, and class loading.

6. **Polymorphism and Abstract Classes**:
   - Abstract classes, interfaces, and dynamic method invocation.

7. **Internal Classes**:
   - Nested and inner classes.

8. **Parametric Types**:
   - Generic types and parametric polymorphism.

9. **Enumerations, Exceptions, Collections, I/O, and Runtime Type Information**:
   - Handling exceptions, working with collections, file I/O, and utilizing runtime type information.

10. **Introduction to UML**:
    - Class diagrams, sequence diagrams, and the basics of modeling software design.

11. **Design Patterns**:
    - Discussion and application of various design patterns, including Singleton, Null Object, Composite, State, Template Method, Strategy, Decorator, Factory Method, Abstract Factory, Command, Observer, Visitor, Adapter, Facade, and Proxy.

---

## 📝 **Project Overview**

Excel-type Project.
The final project for this course involved the **development of a spreadsheet application** that manipulates integers, strings, cell references, and functions on cells. This project required the implementation of key OOP concepts in **Java** and **C++** by building the underlying structure of the application and modeling it using **UML diagrams**.

The project is divided into various components, each of which has been modeled and implemented in classes, methods, and data structures. The primary entities in the application include **cells**, **ranges of cells**, **content** (literals, references, functions), and **users**. The core features of the application include basic arithmetic operations, data entry, and the ability to cut, copy, and paste cells.
It implements the "Observer" Design Pattern for dependent results in cells to be updated when the cells that they depend on change value.

### **Key Concepts Implemented**:
- **Entities in the Domain**:
  - **Cell**: Each cell in the spreadsheet has an address defined by row and column.
  - **Range (Gama)**: Defined between two cells within the same row or column.
  - **Content**: Can be a literal (integer or string), a reference to another cell, or a function applied to cells.
  
- **Functions Supported**:
  - Basic operations like addition, subtraction, multiplication, and division on integer values.
  - Functions applied to ranges of cells, such as `AVERAGE`, `PRODUCT`, `CONCAT`, and `COALESCE`.

- **Object Construction and Design**:
  - The design follows object-oriented principles such as **inheritance**, **polymorphism**, and **composition** to model cells, functions, and operations on the spreadsheet.
  - The project utilizes **method overloading** and **constructors** to provide a flexible API for interacting with cells and their contents.

### **UML Diagram**:
The project began with the modeling of the system using **UML diagrams** to represent classes, their attributes, methods, and interactions. The UML diagrams were critical in understanding the relationships between different entities and guided the implementation of the system.

---

## 🔧 **How to Test the Project**

1. Navigate to the project directory:
   ```bash
   cd /path/to/your/project
2. Compile the Java files:
    
    javac xxl/core/*.java
    javac xxl/app/*.java
   
4. Run the application:

   java xxl.app.Main
