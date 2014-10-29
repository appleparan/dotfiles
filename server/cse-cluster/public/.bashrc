# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

PATH=/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich3.0.4/bin:$PATH
#PATH=/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich2/intel/bin:$PATH

export PATH
unset USERNAME

