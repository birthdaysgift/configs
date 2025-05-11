# added by Nix installer
if [ -e /home/alexey/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/alexey/.nix-profile/etc/profile.d/nix.sh;
fi

export BASHPROFILE_LOADED="true"

#==================================================================

# .bash_profile is sourced in login shell sessions.
# By default, ~/.bashrc is used in an interactive, non-login shell.
# And it won't be sourced in a login shell.
# Some tools use a login shell by default.
#
# Hence, shells started by those tools will skip ~/.bashrc.
# That's why we're sourcing .bashrc here.
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
