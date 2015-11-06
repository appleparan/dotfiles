# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64
source /engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/bin/mklvars.sh intel64

PATH=$HOME/.anyenv/bin:$HOME/bin:$HOME/usr/bin:/engrid/enhpc/mpich3.0.4/bin:/engrid/enhpc/mpich2/intel/bin:$PATH:/bin
PYTHONPATH=$HOME/usr/lib64/python2.6/site-packages:$PYTHONPATH:

MKLROOT=/engrid/enhpc/intel/xe/composer_xe_2011_sp1.7.256/mkl/
GDFONTPATH=/usr/share/fonts/dejavu/
GNUPLOT_DEFAULT_GDFONT="DejaVuSans"
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/lib:$LD_LIBRARY_PATH

export PYENV_ROOT
export PATH
export GDFONTPATH
export GNUPLOT_DEFAULT_GDFONT
export PYTHONPATH
export LD_LIBRARY_PATH

unset USERNAME

eval "$(anyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [[ "$TERM" != "screen" ]] &&
        [[ "$SSH_CONNECTION" != "" ]]; then
    # Attempt to discover a detached session and attach
    # it, else create a new session

    WHOAMI=$(whoami)
    if tmux has-session -t $WHOAMI 2>/dev/null; then
    tmux -2 attach-session -t $WHOAMI
    else
        tmux -2 new-session -s $WHOAMI
    fi
fi
