# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

export MPIHOME=/engrid/ensge/mpich-3.2.1
PATH=/engrid/enhpc/intel/xe/bin:$MPIHOME/bin:$PATH
#PATH=/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich2/intel/bin:$PATH

export PATH
unset USERNAME

