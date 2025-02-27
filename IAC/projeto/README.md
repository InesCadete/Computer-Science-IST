# 💻 **IAC - Introduction to the Architecture of Computers** 💻

---

## 📌 **Course Overview**

This course explores the **architecture and internal organization of computers**, covering essential topics such as:

- **Representation of digital information**: Binary and hexadecimal arithmetic, numeric and alphanumeric codes
- **Combinatory circuits**: Logic gates, Boolean algebra, decoders, and multiplexers
- **Sequential circuits**: Registers, memories, datapaths, and control units
- **Instruction Set Architecture (ISA)**: Addressing modes, stack routines, and interrupts
- **Processor architecture**: Instruction cycle, ALU, flags, special registers, and instruction encoding
- **Memory systems**: Caches, virtual memory, and memory addressing
- **Inputs/Outputs**: Communication with external devices

The project includes hands-on experience through assembly code, allowing students to implement and analyze low-level computer operations.

---

## 📝 **Project Overview**

### 🚀 **Space Rover Game Simulation**

This project implements a **space rover game** where the rover moves horizontally across the screen based on keyboard inputs. The game involves several key elements:

- **Rover Movement**: The rover moves left and right on the screen when the keys **0** (left) or **2** (right) are pressed.
- **Meteor Generation**: A meteor randomly appears in a column and descends row by row when the **B** key is pressed, accompanied by a sound effect.
- **Hexadecimal Counter**: A counter is displayed on the screen, and it can be **incremented** (key 4) or **decremented** (key 6) using the keyboard.
  
Key constants, including the screen boundaries, object sizes, colors, and various peripheral addresses (keyboard input, display, sound), are defined to control the game behavior. The program uses **assembly language** to interact with hardware components, manage memory, and handle interrupts, providing an in-depth understanding of low-level computer architecture.

### Key Features:
- **Input handling** for rover movement and meteor generation.
- **Display control** for updating the screen, including clearing and drawing objects.
- **Sound generation** for meteor and movement effects.
- **Memory management** with stack space for various processes, including meteor handling, keyboard input, and display updates.
- **Interrupt handling** to manage external events like key presses and meteor generation.

---

🎯 **This course offers a detailed exploration of computer architecture principles through hands-on assembly programming, demonstrating how basic hardware components work together to execute complex tasks!** 🚀
