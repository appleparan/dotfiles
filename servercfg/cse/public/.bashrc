# .bashrc

export PATH=/engrid/enhpc/glibc-2.14.1/bin:/bin:/usr/bin:/usr/local/bin:/engrid/ensge/bin/lx24-amd64/
export LD_LIBRARY_PATH=/engrid/enhpc/glibc-2.14.1/lib:/usr/lib:/usr/lib64:/lib:/lib64

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias ls="ls --color"
alias size?='du -ah --max-depth=1 .'
fb () { find . -size "+$1" -print;  }
fb_rm () { find . -size "+$1" -print -exec rm -i {} \; ;}

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

