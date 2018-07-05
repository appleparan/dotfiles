# .bashrc

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/engrid/ensge/bin/lx24-amd64/
export LD_LIBRARY_PATH=/lib:/usr/lib

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias ls="ls --color"
alias vim="/usr/bin/vim -X"

# User specific aliases and functions
source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

export MPIHOME=/engrid/enhpc/mpich-3.2.1

PATH=/engrid/enhpc/intel/xe/bin:$MPIHOME/bin:$PATH
#PATH=/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich2/intel/bin:$PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ulimit -s unlimited

export OMP_NUM_THREADS=2
export OMP_STACKSIZE=2000M

export PATH
export LD_LIBRARY_PATH

unset USERNAME

