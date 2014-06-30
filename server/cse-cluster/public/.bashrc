# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/bin:/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich3.0.4/bin:/engrid/enhpc/mpich2/intel/bin:$PATH:$HOME/bin:$HOME/usr/bin
PYTHONPATH=$HOME/usr/lib64/python2.6/site-packages:$PYTHONPATH:

LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/lib:$LD_LIBRARY_PATH

export PYENV_ROOT
export PATH
export PYTHONPATH
export LD_LIBRARY_PATH

unset USERNAME

# for ruby(rvm & rubygem)
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
# source /home/appleparan/.rvm/scripts/rvm
