# .bashrc

# User specific aliases and functions


#[ -f $HOME/usr/bin/zsh ] && {
#        echo "Type Y to run zsh: \c"
#        read line
#        [ "$line" = Y ] && exec $HOME/usr/bin/zsh -l
#}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64
source /engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/bin/mklvars.sh intel64

PATH=/engrid/enhpc/mpich3.0.4/bin:/engrid/enhpc/mpich2/intel/bin:$PATH:/bin
MKLROOT=/engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/lib:$LD_LIBRARY_PATH

export PATH
export MKLROOT
export LD_LIBRARY_PATH

unset USERNAME


#if [[ "$TERM" != "screen" ]] &&
#        [[ "$SSH_CONNECTION" != "" ]]; then
#    # Attempt to discover a detached session and attach
#    # it, else create a new session
#
#    WHOAMI=$(whoami)
#    if tmux has-session -t $WHOAMI 2>/dev/null; then
#        tmux -2 attach-session -t $WHOAMI
#    else
#        tmux -2 new-session -s $WHOAMI
#    fi
#fi
