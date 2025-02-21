# Public Transportation Management System

## Description
This program simulates a public transportation management system, allowing the user to add and list lines, their stops, and possible links between them. The system supports several commands to manage and interact with the data, making it easy to handle transportation logistics. The implemented commands are:

- **q**: Quits the program.
- **c**: Adds and lists the transportation lines.
- **p**: Adds and lists the stops in the system.
- **l**: Adds and lists the links between stops.
- **i**: Lists the intersections between lines.

## Concepts Applied

This project applies key concepts from imperative programming, data structures, and algorithm analysis. It utilizes structs to model complex entities such as transportation lines and stops, while arrays are used to store them efficiently. The code includes dynamic manipulation of data structures like linked lists (for stops in lines) and uses functions to implement operations like adding, listing, and modifying transportation lines. The project also touches on searching and sorting algorithms by checking for existing lines and updating line information, ensuring the correct handling of data.

## How to Test
To test the program, you can use the provided `Makefile` (command "make") to run the regression tests automatically. The `Makefile` is set up to use public test cases located in the `tests` folder.


