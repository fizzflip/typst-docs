#align(center)[#text(size: 18pt, weight: "bold")[PRACTICAL - 10]]

#text(size: 14pt, weight: "bold")[Aim:] \
To write a C program to create a new process using the fork() system call and compile it using the GCC compiler.

#text(size: 14pt, weight: "bold")[Name:] \
Process Creation using fork()

#text(size: 14pt, weight: "bold")[Theory:] \
In UNIX/Linux operating systems, a new process is created using the `fork()` system call. The newly created process is called the child process, which is an almost exact duplicate of the calling process (the parent). `fork()` returns a process ID (PID): it returns 0 to the child process, a positive integer (the child's PID) to the parent, and a negative value if process creation fails. \
*Algorithm:*
- Include the necessary standard libraries (`<stdio.h>`, `<unistd.h>`, `<sys/types.h>`).
- Declare a variable of type `pid_t` to store the process ID.
- Call the `fork()` function and assign its return value to the variable.
- Use an `if-else` block to evaluate the return value:
  - If the value is less than 0, print an error message (Fork failed).
  - If the value equals 0, print a message identifying as the child process, displaying its PID (`getpid()`) and its parent's PID (`getppid()`).
  - If the value is greater than 0, print a message identifying as the parent process, displaying its own PID and the newly created child's PID.
- Exit the program.

#text(size: 14pt, weight: "bold")[Code:] \
#align(center)[
  #rect(width: 80%, fill: rgb("f4f0ef"), stroke: 1pt + luma(200), inset: 12pt)[
    #align(left)[
      ```c
      #include <stdio.h>
      #include <unistd.h>
      #include <sys/types.h>
      
      int main() {
          pid_t pid;
      
          // [Boilerplate] Call fork() to create a child process
          pid = fork();
      
          // Core Logic: Determine execution context based on fork's return value
          if (pid < 0) {
              // Fork failed
              fprintf(stderr, "Error: Process creation failed!\n");
              return 1;
          }
          else if (pid == 0) {
              // Child process context
              printf("CHILD PROCESS  -> My PID: %d | Parent's PID: %d\n",
                     getpid(), getppid());
          }
          else {
              // Parent process context
              printf("PARENT PROCESS -> My PID: %d | Created Child's PID: %d\n",
                     getpid(), pid);
          }
      
          return 0;
      }
      ```
    ]
  ]
]

#text(size: 14pt, weight: "bold")[OUTPUT:] \
#align(center)[
  #rect(width: 80%, fill: rgb("300a24"), stroke: 1pt + black, inset: 12pt)[
    #align(left)[
      #text(fill: white, font: "Courier")[
        \$ gcc process.c -o process \
        \$ ./process \
        PARENT PROCESS -> My PID: 1245 | Created Child's PID: 1246 \
        CHILD PROCESS  -> My PID: 1246 | Parent's PID: 1245
      ]
    ]
  ]
]

#text(size: 14pt, weight: "bold")[Conclusion:] \
The C program successfully demonstrates process creation using the `fork()` system call. By evaluating the return value of `fork()`, the program was able to distinguish between the parent and child execution contexts and print their respective Process IDs.


#pagebreak()
