﻿# ASCII-name-sum
A 16 bit assembler program running on DOS which takes a "full name" from the data segment, comprised of a first name and a last name divided by a space, 
and it jumps letter by letter until it reaches the last name and it prints the first name. Then it takes every letter, converts it to ASCII decimal 
and adds it to the sum. 
When the program reaches the end of the word it prints the sum and returns the control to DOS.

To run the program I recommend using a dos emulator such as Dosbox.

1. Mount the drive where the project is located, and navigate to tema.asm 
2. Run the command ```tasm tema /zi /la```
3. Run the command ```tlink /v tema ``` 
4. Open the program by typing ```tema```
5. (Optional) The program can be debugged with the command ```td tema```
