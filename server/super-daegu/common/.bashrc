# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

source /opt/intel/composerxe/bin/compilervars.sh intel64

PATH=/opt/intel/composerxe/bin:/opt/intel/impi/4.0.3/bin64/mpivars.sh:$PATH:$HOME/bin

export PATH

export PATH
