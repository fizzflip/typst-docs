#import "common.typ": *

<practical-10>
#practical_title("10")

#section("Aim")[
  To write a C program to create a new process using the fork() system call and compile it using the GCC compiler.
]

#section("Name")[
  Process Creation using fork()
]

#section("Theory")[
  In UNIX/Linux operating systems, a new process is created using the `fork()` system call. The newly created process is called the child process, which is an almost exact duplicate of the calling process (the parent). `fork()` returns a process ID (PID): it returns 0 to the child process, a positive integer (the child's PID) to the parent, and a negative value if process creation fails.
]

#section("Code")[
  #code_box(width: 100%, [
    #raw(read("src/process.c"), lang: "c")
  ])
]
#pagebreak()
#section("Output")[
  #output_box(width: 90%, [
    #prompt gcc process.c -o process \
    #prompt ./process \
    PARENT PROCESS -> My PID: 1245 | Created Child's PID: 1246 \
    CHILD PROCESS  -> My PID: 1246 | Parent's PID: 1245
  ])
]
#v(1em)

#section("Conclusion")[
  The C program successfully demonstrates process creation using the `fork()` system call. By evaluating the return value of `fork()`, the program was able to distinguish between the parent and child execution contexts and print their respective Process IDs.

]
