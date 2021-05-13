# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/opt/pbs/default/bin:/opt/pbs/default/sbin
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/pbs/default/bin:/usr/local/pbs/default/sbin
export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/lib64

############################################################
### CUSTOM
############################################################
#

PATH=$HOME/usr/bin:$PATH
LD_LIBRARY_PATH=$HOME/usr/lib:$LD_LIBRARY_PATH

export PATH
export LD_LIBRARY_PATH

ulimit -s unlimited
export OMP_STACKSIZE=800M

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
fb () { find . -size "+$1" -print;  }
fb_rm () { find . -size "+$1" -print -exec rm -i {} \; ;}

