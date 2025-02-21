# Public Transportation Management System

## Description
 * 
    This program simulates a public transportation management system,
    allowing the user to add and list lines, their stops and possible links
    The commands implemmented are the following: 

- **q**: Quits the program.
- **c**: Adds and lists the transportation lines.
- **p**: Adds and lists the stops in the system.
- **l**: Adds and lists the links between stops.
- **i**: Lists the intersections between lines.

**Added Features to project1 **
- **r**: removes a "carreira"
- **e**: Eliminates a stop
- **i**: Erases all data

## Concepts Applied
This project leverages several key programming concepts from the course, including linked lists to dynamically manage lines and stops in the transportation system. The program utilizes structs to represent complex entities such as lines and stops, and applies pointer manipulation to efficiently manage memory and update connections. The system also demonstrates string manipulation for parsing input (e.g., handling quoted and unquoted stop names), and conditional logic to validate data before updating the transportation network, showcasing problem-solving techniques for algorithmic efficiency.

## How to Test
To test the program, you can use the provided `Makefile` (command "make") to run the regression tests automatically. The `Makefile` is set up to use public test cases located in the `tests` folder.


