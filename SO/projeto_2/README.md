### 📌 **Project 2 README: IST-KVS Extension**
# 📡 **IST-KVS Extension**

## 📌 **Project Overview**
This project extends **IST-KVS** by adding a **server-client API** that allows external applications to **subscribe to key-value updates** in real time.

## ⚙️ **Key Features**
- **Server-Client Architecture**: The IST-KVS server manages key-value storage, while clients subscribe to updates.
- **Real-Time Monitoring**: Clients receive **notifications on data changes**.
- **Extended Commands**: Supports all previous IST-KVS commands with **new subscription-based features**.
- **Efficient Interprocess Communication (IPC)**: Uses **FIFOs and signals** for data updates.

## 🚀 **Technical Concepts**
- **Concurrency**: Implements multi-threaded request handling.
- **IPC Mechanisms**: Uses **named pipes (FIFOs)** for client-server communication.
- **Subscription Model**: Clients can register interest in specific keys and receive updates asynchronously.

---

## 🛠️ **Build & Run**
```bash
make        # Compile the project
./ist-kvs-server   # Run the IST-KVS server 
server 3 3 ./reg
//server <jobs directory> <<max_threads> <max_backups> <name of register pipe>

./ist-kvs-client   # Run a client instance
client i ./reg
//client <name of client> <register pipe>

