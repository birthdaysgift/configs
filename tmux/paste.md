cat -v should show escape chars for bracketed paste if it works

script for bracketed paste in tmux:
```bash
#!/usr/bin/env bash
# tmux-paste.sh — safely paste clipboard into tmux with bracketed paste

# Read the system clipboard (adjust for your OS)
# Kitty / Linux: use xclip or wl-paste
CLIPBOARD="$(xclip -selection clipboard -o 2>/dev/null || wl-paste 2>/dev/null)"

if [ -z "$CLIPBOARD" ]; then
    echo "Clipboard is empty or no clipboard command found" >&2
    exit 1
fi

# Wrap in bracketed paste sequences
echo -ne "\e[200~$CLIPBOARD\e[201~" | tmux load-buffer - && tmux paste-buffer
```
