#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

# preventing zsh startup hangs
#autoload -U compinit
#compinit

#allow tab completion in the middle of a word
#setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

MKLROOT=/engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/lib:$LD_LIBRARY_PATH

export PATH
export MKLROOT
export LD_LIBRARY_PATH

if [[ "$TERM" != "screen" ]] &&
    [[ "$SSH_CONNECTION" != "" ]]; then
    # Attempt to discover a detached session and attach
    # it, else create a new session

    WHOAMI=$(whoami)
    if tmux has-session -t $WHOAMI 2> /dev/null; then
        tmux -2 attach-session -t $WHOAMI
    else
        tmux -2 new-session -s $WHOAMI
    fi
fi
