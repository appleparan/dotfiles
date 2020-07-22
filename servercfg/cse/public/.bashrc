# .bashrc
unset CPATh
unset FPATH
unset INCLUDE
unset LIBRARY_PATH
unset MANPATH
unset CLASSPATH
unset NLSPATH
unset PKG_CONFIG_PATH
unset INTEL_LICENSE_FILE

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=/bin:/usr/bin:/usr/local/bin:/engrid/ensge/bin/lx24-amd64/
export LD_LIBRARY_PATH=/usr/lib:/usr/lib64:/lib:/lib64

alias ls="ls --color"
alias size?='du -ah --max-depth=1 .'
fb () { find . -size "+$1" -print;  }
fb_rm () { find . -size "+$1" -print -exec rm -i {} \; ;}

# User specific aliases and functions
# GCC-10.1
#PATH=/engrid/enhpc/gcc-10.1/bin:$PATH
#LD_LIBRARY_PATH=/engrid/enhpc/gcc-10.1/lib64:$LD_LIBRARY_PATH
#
## binutils-2.32
#PATH=/engrid/enhpc/binutils-2.32/bin:$PATH
#LD_LIBRARY_PATH=/engrid/enhpc/binutils-2.32/lib:$LD_LIBRARY_PATH
#
## GLIBC-2.14.1
#PATH=/engrid/enhpc/glibc-2.14.1/bin:$PATH
#LD_LIBRARY_PATH=/engrid/enhpc/glibc-2.14.1/lib:$LD_LIBRARY_PATH

# MPI
export MPIHOME=/engrid/enhpc/mpich-3.2.1
PATH=$MPIHOME/bin:$PATH

#PATH=/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich2/intel/bin:$PATH
source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# unlimited stack size
ulimit -s unlimited

export OMP_NUM_THREADS=2
export OMP_STACKSIZE=2000M

export PATH
export LD_LIBRARY_PATH

unset USERNAME

