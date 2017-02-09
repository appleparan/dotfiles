export SHELL=/home/appleparan/usr/bin/zsh
export ESHELL=/home/appleparan/usr/bin/zsh
export OMP_NUM_THREADS=4
export OMP_STACKSIZE=900M

LS_COLORS=$LS_COLORS:'di=32:' ; export LS_COLORS
alias cdgist="ssh 210.110.244.101 -p 1444 -l ycse02"
alias ls="ls --color"
alias vim="vim -X"

PYENV_ROOT="$HOME/.pyenv"

FPATH=$HOME/usr/share/zsh/5.3.1/functions:$FPATH

# system wide intel fortran
#PATH=/engrid/enhpc/intel/xe/bin:$HOME/usr/bin:$HOME/.rvm/bin:$HOME/.pyenv/bin:/engrid/enhpc/mpich3.0.4/bin:/engrid/enhpc/mpich2/intel/bin:/bin:$PATH
#source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
#source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64
#source /engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/bin/mklvars.sh intel64
#MKLROOT=/engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/

# intel 2016 (personal use)
PATH=/usr/local/bin:/usr/bin:/sbin:/bin:/engrid/ensge/bin/lx24-amd64
PATH=$HOME/usr/bin:$HOME/.rvm/bin:$HOME/.pyenv/bin:$HOME/usr/local/julia/bin:$HOME/usr/local/HDF5/bin:$HOME/usr/local/cmake/bin:$PATH
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/usr/local/HDF5/lib

source /home/appleparan/intel/bin/compilervars.sh intel64
source /home/appleparan/intel/mkl/bin/mklvars.sh intel64
source /home/appleparan/intel/inspector/inspxe-vars.sh intel64
source /home/appleparan/intel/advisor/advixe-vars.sh intel64
source /home/appleparan/intel/vtune_amplifier_xe/amplxe-vars.sh 

# remove dupliates
typeset -U PATH
typeset -U FPATH
typeset -U LD_LIBRARY_PATH

export PYENV_ROOT
export PATH
export MKLROOT
export LD_LIBRARY_PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval `keychain --eval --agents ssh bitbucket_rsa github_rsa cdgist`

