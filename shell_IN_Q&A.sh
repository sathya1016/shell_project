#!/bin/bash
Q)Commonly used commands in shell scripting
A)pwd, ls, ll, cd, mkdir, rmdir, touch, cat, more, less, head, tail, cp, mv, rm, find, grep, awk, sed, chmod, chown, ps, top, kill, tar, zip/unzip, curl/wget

Q)List all processes and filter using grep
A)ps -ef | grep <process_name>

Q)Print only errors from a log file
A)curl <pathfile> | grep "error" <logfile> and wget <pathfile> | grep "error" <logfile>

Q)How to find a file in the entire system
A)find / -name <filename>

Q)IF loop
A) if [ condition ]; then
       # commands
    else
       # commands
    fi

Q)FOR loop
A) for (( i=1; i<=10; i++ ))
    do
       echo "number $i"
    done
   array=("value1" "value2" "value3")
   for element in "${array[@]}"
   do
       echo "element '$element'"
   done     

Q)What are the different types of shells in Linux?
A)Bourne Shell (sh), Bourne Again Shell (bash), C Shell (csh), Korn Shell (ksh), Z Shell (zsh), Fish Shell (fish)     

Q)Explain the difference between a hard link and a soft link in Linux.
A)A hard link is a direct reference to the physical data on disk, while a soft link (symbolic link) is a pointer to another file or directory. Hard links cannot span different filesystems and cannot link to directories, whereas soft links can.

Q)How do you check the exit status of a command in a shell script?
A)You can check the exit status of the last executed command using the special variable $?. A value of 0 indicates success, while any non-zero value indicates an error.

Q)What is the purpose of the shebang (#!) at the beginning of a shell script?
A)The shebang (#!) at the beginning of a shell script specifies the interpreter that should be used to execute the script. For example, #!/bin/bash indicates that the script should be run using the Bash shell.

Q)How can you pass arguments to a shell script?
A)You can pass arguments to a shell script by including them after the script name when executing it. Inside the script, you can access these arguments using positional parameters like $1, $2, etc. $0 refers to the script name itself.

Q)What are some common debugging techniques for shell scripts?
A)Common debugging techniques include using set -x to enable debug mode, adding echo statements to print variable values, using trap to catch errors, and checking exit statuses of commands.

Q)How do you read input from a user in a shell script?
A)You can read input from a user using the read command. For example:              
   read -p "Enter your name: " name
   echo "Hello, $name!"

Q)How can you schedule a shell script to run at a specific time or interval?
A)You can schedule a shell script to run at a specific time or interval using cron jobs. You can edit the crontab file using the command crontab -e and add a line specifying the schedule and the script to be executed.

Q)What are environment variables, and how
A)Environment variables are dynamic values that can affect the behavior of processes on a computer. They are used to store configuration settings and can be accessed in shell scripts using the syntax $VARIABLE_NAME. Common environment variables include PATH, HOME, and USER.

Q)Explain the difference between single quotes ('') and double quotes ("") in shell scripting.
A)Single quotes ('') preserve the literal value of each character within the quotes, meaning that variables and special characters are not interpreted. Double quotes ("") allow for variable expansion and interpretation of special characters, such as $ for variables and \ for escape sequences.

Q)How do you create and use functions in a shell script?
A)You can create a function in a shell script using the following syntax:
   function_name() {
       # commands
   }
   You can call the function by simply using its name: function_name

Q)What is the difference between a background process and a foreground process in Linux?
A)A foreground process is one that runs in the terminal and takes input from the user, while a background process runs independently of the terminal and does not take input. You can run a command in the background by appending an ampersand (&) at the end of the command.

Q)How do you handle command-line arguments in a shell script?
A)You can handle command-line arguments using positional parameters ($1, $2, etc.) and special variables like $#, which gives the number of arguments, and $@ or $* to access all arguments as a single string. 

Q)Explain the use of pipes (|) and redirection (> , >> , <) in shell scripting.
A)Pipes (|) are used to pass the output of one command as input to another command. Redirection operators are used to control where the input and output of commands go:
   > : Redirects output to a file, overwriting the file if it exists.
   >> : Redirects output to a file, appending to the file if it exists.
   < : Redirects input from a file to a command.

Q)What are some best practices for writing maintainable shell scripts?
A)Some best practices include:
   - Use meaningful variable and function names.
   - Add comments to explain complex logic.
   - Use consistent indentation and formatting.
   - Validate input and handle errors gracefully.
   - Avoid hardcoding values; use variables instead.  

Q)How do you check if a file or directory exists in a shell script?
A)You can check if a file or directory exists using the test command or [ ] brackets. For example:
   if [ -f "filename" ]; then
       echo "File exists."
   fi
   if [ -d "directoryname" ]; then
       echo "Directory exists."

Q)How can you optimize the performance of a shell script?
A)To optimize performance, you can:
   - Minimize the number of external command calls.
   - Use built-in shell features instead of external utilities when possible.
   - Avoid unnecessary loops and use efficient algorithms.
   - Process data in bulk rather than line-by-line when feasible.

Q)Explain the concept of subshells in shell scripting.
A)A subshell is a separate instance of the shell that is created to execute a command or a group of commands. Changes made to variables or the environment in a subshell do not affect the parent shell. Subshells are created using parentheses (e.g., (command1; command2)).   

# Top 10 Difficult Shell Scripting Interview Questions and Answers for DevOps Engineers

echo "1. How would you debug a complex shell script with multiple functions and background processes?"
echo "Answer: Use 'set -x' for tracing, 'trap' for catching signals, 'ps' to monitor background jobs, and log outputs to files for analysis. Use 'bash -n' for syntax checking."

echo ""
echo "2. Explain how you would handle errors and exceptions in a shell script."
echo "Answer: Check exit codes after commands (e.g., 'if [ $? -ne 0 ]'), use 'set -e' to exit on errors, and implement custom error handling functions."

echo ""
echo "3. How can you securely store and retrieve secrets or credentials in a shell script?"
echo "Answer: Use environment variables, external secret managers (like Azure Key Vault), or encrypted files. Avoid hardcoding secrets in scripts."

echo ""
echo "4. Write a shell script to monitor disk usage and send an alert if usage exceeds a threshold."
echo "Answer:"
cat <<'EOF'
#!/bin/bash
THRESHOLD=80
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Disk usage is above $THRESHOLD%!" | mail -s "Disk Alert" admin@example.com
fi
EOF

echo ""
echo "5. How do you handle race conditions in shell scripts running in parallel?"
echo "Answer: Use file locks (e.g., 'flock'), atomic operations, or synchronization primitives to prevent concurrent access to shared resources."

echo ""
echo "6. Describe the differences between 'exec', 'source', and running a script as a subprocess."
echo "Answer: 'exec' replaces the current shell, 'source' runs in the current shell context, and running as a subprocess creates a new shell process."

echo ""
echo "7. How would you parse and process a large log file efficiently using shell scripting?"
echo "Answer: Use tools like 'awk', 'sed', and 'grep' with streaming (e.g., 'awk' line by line), avoid loading entire files into memory, and use 'sort'/'uniq' for aggregation."

echo ""
echo "8. Explain the use of traps in shell scripting and provide an example."
echo "Answer: 'trap' allows you to catch signals (e.g., SIGINT) and execute cleanup code. Example:"
cat <<'EOF'
trap 'echo "Script interrupted!"; exit 1' SIGINT
EOF

echo ""
echo "9. How do you ensure portability of your shell scripts across different Unix/Linux environments?"
echo "Answer: Use POSIX-compliant syntax, avoid system-specific commands, test on multiple shells, and specify the interpreter (e.g., '#!/bin/sh')."

echo ""
echo "10. Write a shell script to automate deployment steps, including rollback on failure."
echo "Answer:"
cat <<'EOF'
#!/bin/bash
deploy() {
    echo "Deploying app..."
    # deployment steps here
    return 0
}
rollback() {
    echo "Rolling back deployment..."
    # rollback steps here
}
deploy || rollback
EOF