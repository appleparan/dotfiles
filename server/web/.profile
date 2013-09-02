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
  if [ ! -z "$SSH_TTY" ]; then
      if [ ! -z "SSH_AUTH_SOCK" ]; then
          ln -sf "$SSH_AUTH_SOCK" "$HOME/.wrap_auth_sock"
      fi

      export SSH_AUTH_SOCK="$HOME/.wrap_auth_sock"
      if [[ "$SSH_CLIENT_ADDR" != "$MY_IP_ADDR" ]]; then
        exec "$HOME/bin/tmux-session" "sshwrap"
      fi
  fi
fi

pythonbrew switch 2.7.3
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export WORKON_HOME=$HOME/.virtualenvs
source  /usr/local/bin/virtualenvwrapper.sh

export LC_ALL=en_US.utf8
export LANG=en_US.utf8
