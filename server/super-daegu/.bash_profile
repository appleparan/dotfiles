# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

source /opt/intel/composerxe/bin/compilervars.sh intel64

PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/bin:/opt/intel/composerxe/bin:/opt/intel/impi/4.0.3/bin64/mpivars.sh:$PATH:$HOME/bin:$HOME/usr/bin
PYTHONPATH=$HOME/usr/lib64/python2.6/site-packages:$PYTHONPATH:

LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/lib:$LD_LIBRARY_PATH

GDFONTPATH=/usr/share/fonts/dejavu/
GNUPLOT_DEFAULT_GDFONT="DejaVuSans"

export PYENV_ROOT
export PATH
export GDFONTPATH
export GNUPLOT_DEFAULT_GDFONT
export PYTHONPATH
export LD_LIBRARY_PATH

unset USERNAME

# for python(pyenv)
eval "$(pyenv init -)"

export PATH
