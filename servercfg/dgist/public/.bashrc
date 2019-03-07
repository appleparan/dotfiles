# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
fb () { find . -size "+$1" -print;  }
fb_rm () { find . -size "+$1" -print -exec rm -i {} \; ;}
#alias ls='ls -F --color=never'

ulimit -l unlimited

source /opt/intel/composerxe/bin/compilervars.sh intel64
source /opt/intel/impi/4.0.3/bin64/mpivars.sh

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
export MKLVARS=/opt/intel/composer_xe_2013_1/mkl/bin/mklvars.sh
export MPIVARS=/opt/intel/impi/4.0.3/bin64/mpivars.sh

source $COMPILERVARS intel64
source $MKLVARS intel64
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

export PATH
export LD_LIBRARY_PATH

ulimit -s unlimited
export OMP_STACKSIZE=800M

if [ -n "$PATH" ]; then
  old_PATH=$PATH:; PATH=
  while [ -n "$old_PATH" ]; do
    x=${old_PATH%%:*}       # the first remaining entry
    case $PATH: in
      *:"$x":*) ;;         # already there
      *)  PATH=$PATH:$x;;    # not there yet
    esac
    old_PATH=${old_PATH#*:}
  done
  PATH=${PATH#:}
  unset old_PATH x
fi

if [ -n "$LD_LIBRARY_PATH" ]; then
  old_LD_LIBRARY_PATH=$LD_LIBRARY_PATH:; LD_LIBRARY_PATH=
  while [ -n "$old_LD_LIBRARY_PATH" ]; do
    x=${old_LD_LIBRARY_PATH%%:*}       # the first remaining entry
    case $LD_LIBRARY_PATH: in
      *:"$x":*) ;;         # already there
      *) LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$x;;    # not there yet
    esac
    old_LD_LIBRARY_PATH=${old_LD_LIBRARY_PATH#*:}
  done
  LD_LIBRARY_PATH=${LD_LIBRARY_PATH#:}
  unset old_LD_LIBRARY_PATH x
fi
