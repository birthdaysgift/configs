## Tere

If tere closes shell once it's open.

Save error message to a file and read it:
```bash
tere &> error.log
```

If error is related to SerdeJSON then you history file is probably corrupted.

So you can:
    - either remove history.json file: `rm ~/.cache/tere/history.json`
    - or disable history in tere via `--history-file=''` option


## NVIM

If nvim shows error related to ShaDa files on exit.

ShaDa (Shared Data) is Neovim's system for saving state information like
command history, search history, registers, marks, and the jump list between
restarts.

You can:
    - either remove all `main.shada.tmp.X` files in `~/.local/state/nvim/shada`
    - or disable using shada files via `vim.opt.shadafile = "NONE"`

