# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export MY_IP_ADDR="165.132.28.100"
export SSH_CLIENT_ADDR=`echo $SSH_CLIENT | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'`
if [ -z "$TMUX" ]; then
    #if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
    #    unlink "$HOME/.ssh/agent_sock" 2>/dev/null
    #    ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
    #    export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
    #fi

    if [[ "$SSH_CLIENT_ADDR" != "$MY_IP_ADDR" ]]; then
    if [ ! -z "$SSH_TTY" ]; then
        if [ ! -z "SSH_AUTH_SOCK" ]; then
            ln -sf "$SSH_AUTH_SOCK" "$HOME/.wrap_auth_sock"
        fi
        export SSH_AUTH_SOCK="$HOME/.wrap_auth_sock"

        exec "$HOME/bin/tmux-session" "sshwrap"
    fi
    fi
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export WORKON_HOME=$HOME/.virtualenvs
source  /usr/local/bin/virtualenvwrapper.sh

export LC_ALL=en_US.utf8
export LANG=en_US.utf8
