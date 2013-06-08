# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

#alias ift='ifort -r8 mps_new.f -o mps_js'
#alias runt='qsub a.sh'
#alias cplot='ifort -r8 mo.f -o plot'
# User specific environment and startup programs

source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64

PATH=$HOME/usr/bin:$HOME/bin:/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich2/intel/bin:$PATH
PYTHONPATH=$HOME/usr/lib64/python2.6/site-packages:$PYTHONPATH:

LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/lib:$LD_LIBRARY_PATH

GDFONTPATH=/usr/share/fonts/dejavu/
GNUPLOT_DEFAULT_GDFONT="DejaVuSans"

export PATH
export GDFONTPATH
export GNUPLOT_DEFAULT_GDFONT
export PYTHONPATH
export LD_LIBRARY_PATH

unset USERNAME

[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"
pythonbrew switch 2.7.3
source ~/.virtualenvs/fluid2/bin/activate

if [ -z "$TMUX" ]; then
  if [ ! -z "$SSH_TTY" ]; then
      if [ ! -z "SSH_AUTH_SOCK" ]; then
          ln -sf "$SSH_AUTH_SOCK" "$HOME/.wrap_auth_sock"
      fi
      export SSH_AUTH_SOCK="$HOME/.wrap_auth_sock"

      exec "$HOME/bin/tmux-session" "sshwrap"
  fi
fi
