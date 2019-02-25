# .bashrc

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/engrid/ensge/bin/lx24-amd64/
export LD_LIBRARY_PATH=/lib:/usr/lib

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias cdgist="ssh 210.110.244.101 -p 1444 -l ycse02"
alias ls="ls --color"
alias size?="du --max-depth=1 -h ."
alias vim="vim -X"

# User specific aliases and functions
source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

export MPIHOME=/engrid/ensge/mpich-3.2.1

PATH=/engrid/enhpc/intel/xe/bin:$MPIHOME/bin:$PATH
#PATH=/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich2/intel/bin:$PATH

# MPIPATH
MPIHOME=/engrid/enhpc/mpich-3.2.1
PATH=$MPIHOME/bin:$PATH

# user defined executable path
PATH=$HOME/usr/bin:$HOME/.rvm/bin:$HOME/.pyenv/bin:$PATH
PATH=$HOME/usr/local/vim/bin:$PATH
PATH=$HOME/usr/local/tmux/bin:$PATH
PATH=$HOME/usr/local/HDF5/bin:$PATH
PATH=$HOME/usr/local/cmake/bin:$PATH
PATH=$HOME/usr/local/git/bin:$PATH
PATH=$HOME/usr/local/julia/bin:$PATH

# user defined LD_LIBARY_PATH
LD_LIBRARY_PATH=$HOME/usr/local/HDF5/lib:$LD_LIBRARY_PATH
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/usr/local/intel/lib64:$LD_LIBRARY_PATH

# add julia path
PATH=$HOME/usr/local/julia/bin:$PATH

ulimit -s unlimited

export OMP_NUM_THREADS=4
export OMP_STACKSIZE=2000M

export PATH
export LD_LIBRARY_PATH

unset USERNAME

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval `keychain --eval --agents ssh bitbucket_rsa github_rsa cdgist`

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
