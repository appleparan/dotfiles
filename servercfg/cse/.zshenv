export SHELL=/home/appleparan/usr/bin/zsh
export ESHELL=/home/appleparan/usr/bin/zsh
export OMP_NUM_THREADS=4
export OMP_STACKSIZE=900M

LS_COLORS=$LS_COLORS:'di=32:' ; export LS_COLORS
alias cdgist="ssh 210.110.244.101 -p 1444 -l ycse02"
alias ls="ls --color"
alias vim="vim -X"
fb () { find . -size "+$1" -print;  }
fb_rm () { find . -size "+$1" -print -exec rm -i {} \; ;}

PYENV_ROOT="$HOME/.pyenv"

FPATH=$HOME/usr/local/zsh/share/zsh/5.7.1/functions

# basic PATH & LD_LIBRARY_PATH
PATH=/engrid/ensge/bin/lx24-amd64:/usr/bin:/usr/sbin:/sbin:/bin
LD_LIBRARY_PATH=/lib:/usr/lib

MKLROOT=/engrid/enhpc/intel/xe/mkl/
# system wide intel fortran
source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64
source /engrid/enhpc/intel/xe/mkl/bin/mklvars.sh intel64

# MPIPATH
MPIHOME=/engrid/enhpc/mpich-3.2.1
PATH=$MPIHOME/bin:$PATH

# user defined executable path
PATH=$HOME/usr/bin:$HOME/.rvm/bin:$HOME/.pyenv/bin:$PATH
PATH=$HOME/usr/local/zsh/bin:$PATH
PATH=$HOME/usr/local/tmux/bin:$PATH
PATH=$HOME/usr/local/vim/bin:$PATH
PATH=$HOME/usr/local/HDF5/bin:$PATH
PATH=$HOME/usr/local/cmake/bin:$PATH
PATH=$HOME/usr/local/git/bin:$PATH
PATH=$HOME/usr/local/julia/bin:$PATH

# user defined LD_LIBARY_PATH
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$LD_LIBRARY_PATH
#LD_LIBRARY_PATH=$HOME/usr/local/HDF5/lib:$LD_LIBRARY_PATH

#source /home/appleparan/intel/bin/compilervars.sh intel64
#source /home/appleparan/intel/mkl/bin/mklvars.sh intel64
#source /home/appleparan/intel/inspector/inspxe-vars.sh intel64
#source /home/appleparan/intel/advisor/advixe-vars.sh intel64
#source /home/appleparan/intel/vtune_amplifier_xe/amplxe-vars.sh 

# remove dupliates
typeset -U PATH
typeset -U FPATH
typeset -U LD_LIBRARY_PATH
typeset -U MANPATH
typeset -U MIC_LD_LIBRARY_PATH
typeset -U CPATH
typeset -U INTEL_LICENSE_FILE
typeset -U NLSPATH

#export PYENV_ROOT
export MPIHOME
export PATH
export MKLROOT
export LD_LIBRARY_PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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
