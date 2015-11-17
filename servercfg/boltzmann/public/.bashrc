# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=/usr/local/cuda/bin:$PATH
LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/lib64/nvidia:$LD_LIBRARY_PATH
export PATH
export LD_LIBRARY_PATH

unset USERNAME

