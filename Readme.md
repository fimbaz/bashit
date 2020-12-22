Bring home remote bash commands.

Instructions:

1. install rust
2. run make
source ~/.bashrc
ssh to anywhere
observe your history back at home in ~/.bash_universal_history.

What? - a tool to locally save commands typed in remote terminal sessions.
Constraints:
 * Can't require special permissions or configuration on the host
 * Can't open any new sockets
 * Can't modify the remote at all

Approach:
  * Using bashit, when you ssh to a server the output of your terminal is teed to a small process.
  * a custom PROMPT_COMMAND emits each history item to stdout each time the user hits 'enter'
  * The PROMPT_COMMAND also deletes the emitted history item from the screen by messing with the cursor.
  * Back on the local machine, the aforementioned small process sees the history item and emits it to a file.
