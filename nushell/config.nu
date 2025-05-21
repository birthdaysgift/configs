# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

alias ac = `overlay use .venv/bin/activate.nu`
alias al = `alias`
alias b = bat --color=always
alias c = `clear`
alias d = `deactivate`
alias g = `rg -i`
alias lg = `lazygit`
alias nv = `nvim`
alias p = `python`
alias p3 = `python3`
alias vp = `.venv-poetry/bin/poetry`
alias zj = `zellij`

def --env f [] { cd (tere) }
