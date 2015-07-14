# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

SSH_ENV="$HOME/.ssh/environment"
  
# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}
  
# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add ~/.ssh/bitbucket_rsa
        ssh-add ~/.ssh/github_rsa
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}
  
# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
    test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi

# for ssh keys
if [ -z "$TMUX" ]; then
  if [ ! -z "$SSH_TTY" ]; then
      if [ ! -z "SSH_AUTH_SOCK" ]; then
          ln -sf "$SSH_AUTH_SOCK" "$HOME/.wrap_auth_sock"
      fi
      export SSH_AUTH_SOCK="$HOME/.wrap_auth_sock"

      exec "$HOME/bin/tmux-session" "sshwrap"
  fi
fi


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source /engrid/enhpc/intel/xe/bin/ifortvars.sh intel64
source /engrid/enhpc/intel/xe/bin/iccvars.sh intel64

PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/bin:/engrid/enhpc/intel/xe/bin:/engrid/enhpc/mpich3.0.4/bin:/engrid/enhpc/mpich2/intel/bin:$PATH:$HOME/bin:$HOME/usr/bin
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

# for python(pyenv)
eval "$(pyenv init -)"
