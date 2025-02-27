# 💻 **Organization of Computers** 💻
---

## 📌 **Course Overview**

The **Organization of Computers** course delves into the inner workings of computer systems, from the basic architecture and memory hierarchy to complex processor operations and optimization techniques. The course includes the following key topics:

1. **Introduction and Review of Basic Concepts**:
   - Overview of computer internals, focusing on recent and future advancements.
   
2. **Computer Organization**:
   - RISC vs CISC processors: Comparing architectural models.
   - Code generation and the role of compilers in modern computer systems.
   - Memory data organization and number representation (including IEEE 754 format).
   - Performance metrics and how they affect system design.

3. **RISC Processor Operation**:
   - How RISC processors work, including pipelining.
   - Managing data, control, and structural pipeline conflicts.
   - Optimizing code for better performance in RISC architectures.

4. **Memory System**:
   - Memory hierarchy and the architecture of cache memories.
   - Techniques for program optimization, memory management, and efficient address translation.
   - The connection between memory systems and the operating system.

5. **Input/Output System**:
   - Understanding the analog-to-digital interface.
   - Analyzing the performance of peripheral communication and using standard buses.
   - Working with interrupts, exceptions, traps, and Direct Memory Access (DMA).

Through a hands-on approach, the course teaches students to apply these concepts through various projects that simulate real-world system-level tasks.

---

## 📝 **Project Overview**

### 1️⃣ **First Project: Simple Cache Simulator**

In this project, students developed a **multilevel cache hierarchy** to simulate the operation of a computer's memory system. The main goal was to build an L1 (first level) and L2 (second level) cache from scratch. The project involved completing base code provided by the faculty to create the cache simulation system and integrating these components to form a complete cache hierarchy.

**Objectives:**
- Implement L1 and L2 cache memory systems.
- Simulate cache hits, misses, and the behavior of the hierarchy.
- Integrate L1 and L2 caches to test the system's performance.

### 2️⃣ **Second Project: System Modeling and Profiling**

In the second project, students analyzed a real machine’s performance using profiling techniques to understand cache performance and memory access. This project required answering several questions based on experimental results obtained from the university's computer. Key tasks included determining the cache capacity, size of each cache block, and L1 cache miss penalty time.

**Objectives:**
- Analyze cache performance using data collected from real systems.
- Plot and analyze variations in the number of misses based on cache size and stride size.
- Optimize cache access patterns and matrix multiplication techniques.
- Characterize associativity set size in the cache and optimize CPU performance.

### 3️⃣ **Third Project: Pipelining, Assembly Code Optimization, and Pipeline Visualization**

This project focused on optimizing assembly code for pipelined processors. The students simulated a processor pipeline with and without data forwarding techniques. They applied source code optimizations, such as loop unrolling and branch delay slots, to minimize pipeline hazards and improve execution efficiency.

**Objectives:**
- Visualize and optimize processor pipeline execution.
- Apply data forwarding techniques to reduce hazards.
- Optimize source code to improve pipeline throughput.
- Implement loop unrolling and branch delay slot techniques.

---
