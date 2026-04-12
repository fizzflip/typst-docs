#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid;

    // Call fork() to create a child process
    pid = fork();

    // Core Logic: Determine execution context based on fork's return value
    if (pid < 0) {
        // Fork failed
        fprintf(stderr, "Error: Process creation failed!\n");
        return 1;
    }
    else if (pid == 0) { // Child process context
        printf("CHILD PROCESS  -> My PID: %d | Parent's PID: %d\n",
               getpid(), getppid());
    }
    else { // Parent process context
        printf("PARENT PROCESS -> My PID: %d | Created Child's PID: %d\n",
               getpid(), pid);
    }

    return 0;
}
