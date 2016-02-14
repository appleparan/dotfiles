# .bashrc

pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

ldlibmunge () {
    case ":${LD_LIBRARY_PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$1
            else
                LD_LIBRARY_PATH=$1:$LD_LIBRARY_PATH
            fi
    esac
}
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
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

############################################################
### MPI Library
############################################################
#
#Ver. 4.0[GCC] 
#export MPI_HOME=/opt/mpi/gcc-4.1/mvapich2-1.8.1
#export MPI_HOME=/opt/mpi/gcc-4.1/openmpi-1.4.4

#Ver. 4.0[ICC] 
#export MPI_HOME=/opt/mpi/intel-12.1/mvapich2-1.8.1
#export MPI_HOME=/opt/mpi/intel-12.1/openmpi-1.4.4
export MPI_HOME=/opt/intel/impi/4.0.3.008/

############################################################
### Python 
############################################################
#
#Ver. 2.6.6


############################################################
### PBSPro
############################################################
#
#Ver. 11.3.0
#PATH=/opt/pbs/default/bin:/opt/pbs/default/sbin:$PATH:/usr/bin

pathmunge /usr/bin
pathmunge /opt/pbs/default/sbin
pathmunge /opt/pbs/default/bin


############################################################
### GPU[CUDA]
############################################################
#
#Ver. release 5.0, V0.2.1221
#LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib64:$LD_LIBRARY_PATH
#PATH=/usr/local/cuda-5.0/bin:$PATH

#Ver. release 4.2, V
#export LD_LIBRARY_PATH=/usr/local/cuda-4.2/lib64:$LD_LIBRARY_PATH
#export PATH=/usr/local/cuda-4.2/bin:$PATH

############################################################
### JDK
############################################################
#
#Ver. 1.6.0
#export JAVA_HOME=/usr/java/default
#PATH=$JAVA_HOME/bin:$PATH

############################################################
### CUSTOM
############################################################
#
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/lib:$LD_LIBRARY_PATH

ldlibmunge $HOME/lib
ldlibmunge $HOME/usr/lib
ldlibmunge $HOME/usr/lib64
PYENV_ROOT=$HOME/.pyenv
# PATH=$HOME/usr/bin:$HOME/bin:$PYENV_ROOT/bin:$PATH

pathmunge $PYENV_ROOT/bin
pathmunge $HOME/bin
pathmunge $HOME/usr/bin 
pathmunge $HOME/usr/local/cmake/bin 
pathmunge $HOME/usr/local/julia/bin 

export PYENV_ROOT
export PATH
export LD_LIBRARY_PATH

# for python(pyenv)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# User specific environment and startup programs
ulimit -s unlimited
export OMP_STACKSIZE=900M

export I_MPICC=icc
export I_MPIFC=ifort


