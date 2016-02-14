export SHELL=/home/appleparan/usr/bin/zsh
export ESHELL=/home/appleparan/usr/bin/zsh

alias cdgist="ssh 210.110.244.101 -p 1444 -l ycse02"
alias ls="ls --color=auto"

PYENV_ROOT="$HOME/.pyenv"

FPATH=$HOME/usr/share/zsh/5.1.1/functions:$FPATH

# system wide intel fortran
#PATH=$HOME/usr/bin:$HOME/.rvm/bin:$HOME/.pyenv/bin:/engrid/enhpc/mpich3.0.4/bin:/engrid/enhpc/mpich2/intel/bin:/bin:$PATH
#source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
#source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64
#source /engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/bin/iccvars.sh intel64
#MKLROOT=/engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/

# intel 2016 (personal use)
PATH=$HOME/usr/bin:$HOME/.rvm/bin:$HOME/.pyenv/bin:$HOME/usr/local/julia/bin:$HOME/usr/local/cmake/bin:/engrid/enhpc/mpich3.0.4/bin:/bin:/usr/bin
source /home/appleparan/usr/intel/bin/compilervars.sh intel64

LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/lib:$LD_LIBRARY_PATH

export PYENV_ROOT
export PATH
export MKLROOT
export LD_LIBRARY_PATH

# remove dupliates
typeset -U PATH
typeset -U FPATH
typeset -U LD_LIBRARY_PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval `keychain --eval --agents ssh bitbucket_rsa github_rsa cdgist`
