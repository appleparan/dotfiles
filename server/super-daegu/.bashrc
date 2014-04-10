# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
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



############################################################
### Intel Compiler & MKL
############################################################
#
#Ver. ICC 12.1.0 & MKL 10.3.8
#export COMPILERVARS=/opt/intel/composerxe/bin/compilervars.sh intel64
#export MPIVARS=/opt/intel/impi/4.0.3/bin64/mpivars.sh
#
#Ver. ICC 12.1.0 & MKL 11.0.1
export COMPILERVARS=/opt/intel/composerxe/bin/compilervars.sh
export MPIVARS=/opt/intel/impi/4.0.3/bin64/mpivars.sh

source $COMPILERVARS intel64
source $MPIVARS

############################################################
### GCC Compiler 
############################################################
#
#Ver. 4.4.6 
PATH=/usr/bin:$PATH

############################################################
### MPI Library
############################################################
#
#Ver. 4.0[GCC] 
#export MPI_HOME=/opt/mpi/gcc-4.1/mvapich2-1.8.1
#export MPI_HOME=/opt/mpi/gcc-4.1/openmpi-1.4.4

#Ver. 4.0[ICC] 
#export MPI_HOME=/opt/mpi/intel-12.1/mvapich2-1.8.1
export MPI_HOME=/opt/mpi/intel-12.1/openmpi-1.4.4

############################################################
### Python 
############################################################
#
#Ver. 2.6.6

PATH=/usr/bin:$PATH

############################################################
### PBSPro
############################################################
#
#Ver. 11.3.0
PATH=/opt/pbs/default/bin:/opt/pbs/default/sbin:$PATH

############################################################
### GPU[CUDA]
############################################################
#
#Ver. release 5.0, V0.2.1221
LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib64:$LD_LIBRARY_PATH
PATH=/usr/local/cuda-5.0/bin:$PATH

#Ver. release 4.2, V
#export LD_LIBRARY_PATH=/usr/local/cuda-4.2/lib64:$LD_LIBRARY_PATH
#export PATH=/usr/local/cuda-4.2/bin:$PATH

############################################################
### JDK
############################################################
#
#Ver. 1.6.0
export JAVA_HOME=/usr/java/default
PATH=$JAVA_HOME/bin:$PATH

############################################################
### CUSTOM
############################################################
#
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/lib:$LD_LIBRARY_PATH
PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/bin:$HOME/bin:$HOME/usr/bin:$PATH
export PYENV_ROOT
export PATH
export LD_LIBRARY_PATH

# for python(pyenv)
eval "$(pyenv init -)"
