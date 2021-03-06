LS_COLORS=$LS_COLORS:'di=32:' ; export LS_COLORS
alias ls="ls --color"
alias vim="vim -X"

# PYENV
PYENV_ROOT="$HOME/.pyenv"
# GO PATH
GOPATH=${HOME}/go
# JULIA PATH
JULIA_BINDIR=$HOME/usr/local/julia/bin

export PYENV_ROOT
export GOPATH
export JULIA_BINDIR

# basic PATH & LD_LIBRARY_PATH
PATH=/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin
LD_LIBRARY_PATH=/lib:/usr/lib:/usr/lib/x86_64-linux-gnu

# CUDA
PATH=/usr/local/cuda/bin:$PATH
LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH

# user defined executable path
PATH=$HOME/usr/bin:$HOME/.rvm/bin:$HOME/.pyenv/bin:$PATH
PATH=/usr/local/go/bin:$GOPATH/bin:$PYENV/bin:$PATH
PATH=$JULIA_BINDIR:$PATH

# user defined LD_LIBARY_PATH
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$LD_LIBRARY_PATH

# remove dupliates
typeset -U PATH
typeset -U LD_LIBRARY_PATH

export PATH
export LD_LIBRARY_PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval `keychain --eval --agents ssh github gitlab`

if [[ "$TERM" != "screen" ]] &&
    [[ "$SSH_CONNECTION" != "" ]]; then
    # Attempt to discover a detached session and attach
    # it, else create a new session

    WHOAMI=$(whoami)

    if [[ "$TMUXNAME" == "" ]]; then
        TMUXNAME=$(whoami)
    fi 

    if tmux has-session -t $TMUXNAME 2> /dev/null; then
        tmux -2 attach-session -t $TMUXNAME
    else
        tmux -2 new-session -s $TMUXNAME
    fi
fi

alias si="singularity"
alias tm="tmux -2 attach-session -t $TMUXNAME"

