# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

source /opt/intel/composerxe/bin/compilervars.sh intel64
source /opt/intel/impi/4.0.3/bin64/mpivars.sh

LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/lib:$LD_LIBRARY_PATH
PATH=/opt/intel/composerxe/bin:/opt/intel/impi/4.0.3/bin64/mpivars.sh:$PATH:$HOME/bin


export LD_LIBRARY_PATH
export PATH
