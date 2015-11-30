export SHELL=$HOME/usr/bin/zsh

alias cdgist="ssh 210.110.244.101 -p 1444 -l ycse02"
alias ls="ls --color=auto"

PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
PATH=$HOME/usr/bin:$HOME/.rvm/bin:$HOME/.anyenv/bin:/engrid/enhpc/mpich3.0.4/bin:/engrid/enhpc/mpich2/intel/bin:$PATH:/bin

source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

MKLROOT=/engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/lib:$LD_LIBRARY_PATH

export PYENV_ROOT
export PATH
export MKLROOT
export LD_LIBRARY_PATH

# remove dupliates
typeset -U PATH
typeset -U LD_LIBRARY_PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if which anyenv > /dev/null; then eval "$(anyenv init -)"; fi

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval `keychain --eval --agents ssh bitbucket_rsa github_rsa cdgist`
