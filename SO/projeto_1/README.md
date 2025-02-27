# 📦 **IST Key Value Store (IST-KVS)**

## 📌 **Project Overview**
IST-KVS is a **concurrent key-value storage system** that supports **data creation, writing, and retrieval** using a **hash table**. It explores **parallelization techniques** and **process synchronization**.

## ⚙️ **Key Features**
- **Hash table-based storage**: Uses **key-value pairs** for efficient data lookup.
- **Collision resolution**: Manages hash collisions through linked lists.
- **Parallel processing**: Implements **multi-threading** for improved performance.
- **Interprocess communication (IPC)**: Uses **FIFOs and signals** for system-wide notifications.
- **File system integration**: Supports **POSIX file operations** for data persistence.

## 🚀 **Technical Concepts**
- **Thread synchronization**: Uses **mutexes** and **semaphores** for concurrent access.
- **Process-based backups**: Implements **fork()** to handle non-blocking backups.
- **Memory management**: Allocates and frees memory dynamically for key-value pairs.

---

## 🛠️ **Build & Run**
```bash
make        # Compile the project
./ist-kvs   # Run the key-value store

