## Edit nvim macro

1. Paste the macro:
    Go to a blank line and type "ap (replace a with your macro's register letter).

2. Modify the keystrokes:
    Edit the raw text of the macro as needed.

3. Insert special keys:
    If you need to add keys like Esc or Enter, press Ctrl + v
    followed by that key while in insert mode (e.g., Ctrl + v then Esc outputs ^[).

4. Yank it back:
    _"aD to delete and save the modified text back into the register.


## Append to an existing macro

1. Start appending:
    Type qA (using the uppercase letter of your register).

2. Add actions:
    Type the additional keystrokes you missed.

3. Stop recording: Type q.
