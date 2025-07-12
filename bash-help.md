+-------------+-------+---------+---------------+
| Interactive | Login | .bashrc | .bash_profile |
+-------------+-------+---------+---------------+
|      no     |   no  |    no   |       no      |
|     yes     |   no  |   yes   |       no      |
|      no     |  yes  |    no   |      yes      |
|     yes     |  yes  |   yes   |      yes      |
+-------------+-------+---------+---------------+


### .bash_profile

    - Sourced only once at login, when Bash is started as a login shell.
 
    - Used for login-specific setup (like PATH modifications, environment variables).
 
    - Not re-sourced when opening a new terminal tab or starting new shells after logging in.

Examples that trigger .bash_profile:

    - `ssh user@host`

    - `bash --login`

    - `su - username`

    - Logging in on a tty


### .bashrc

    - Sourced every time you start a new interactive non-login Bash shell (e.g., terminal tabs, nested Bash sessions).

    - Typically contains interactive settings like:

        Aliases

        Functions

        Prompt (PS1)

        Shell options (shopt)

Examples that trigger .bashrc:

    - Starting bash in an already running terminal

    - Opening a new terminal tab (if it's not set to start a login shell)

    - Typing bash in an existing shell
