# .bashrc
#export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/opt/pbs/default/bin:/opt/pbs/default/sbin:/opt/intel/impi/4.0.3.008/intel64/bin:/opt/intel/impi/4.0.3.008/intel64/bin:/opt/intel/composer_xe_2011_sp1.6.233/bin/intel64:/opt/xcat/bin:/opt/xcat/sbin:/opt/xcat/share/xcat/tools:/usr/lib64/qt-3.3/bin:/opt/pbs/default/bin:/opt/intel/impi/4.0.3.008/intel64/bin:/opt/intel/composer_xe_2011_sp1.6.233/bin/intel64:/usr/lpp/mmfs/bin:/usr/java/default/bin:/usr/local/cuda/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ibutils/bin:/opt/intel/composer_xe_2011_sp1.6.233/mpirt/bin/intel64:/usr/local/maven/bin:/opt/intel/composer_xe_2011_sp1.6.233/mpirt/bin/intel64

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/opt/pbs/default/bin:/opt/pbs/default/sbin
export LD_LIBRARY_PATH=/lib:/usr/lib

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

#Ver. ICC 12.1.0 & MKL 11.0.1
#export COMPILERVARS=/opt/intel/composerxe/bin/compilervars.sh
#export MKLVARS=/opt/intel/composer_xe_2013_1/mkl/bin/mklvars.sh
#export MPIVARS=/opt/intel/impi/4.0.3/bin64/mpivars.sh

#source $COMPILERVARS intel64
#source $MKLVARS intel64
#source $MPIVARS

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
#export MPI_HOME=$HOME/intel/impi/2019.0.117/
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

############################################################
### GPU[CUDA]
############################################################
#
#Ver. release 7.5
#LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64:$LD_LIBRARY_PATH
#PATH=/usr/local/cuda-7.5/bin:$PATH

#Ver. release 5.0
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
#export JAVA_HOME=/usr/java/default
#PATH=$JAVA_HOME/bin:$PATH

############################################################
### CUSTOM
############################################################
#
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/lib:$HOME/usr/local/HDF5/lib:$HOME/usr/local/julia/lib:$LD_LIBRARY_PATH

#ldlibmunge $HOME/lib
#ldlibmunge $HOME/usr/lib
#ldlibmunge $HOME/usr/lib64
#ldlibmunge $HOME/usr/local/HDF5/lib
#ldlibmunge $HOME/usr/local/julia/lib
PYENV_ROOT=$HOME/.pyenv
PATH=$HOME/usr/bin:$HOME/bin:$PYENV_ROOT/bin:$PATH

export PYENV_ROOT

PATH=$HOME/usr/local/cmake/bin:$PATH
PATH=$HOME/usr/local/HDF5/bin:$PATH
PATH=$HOME/usr/local/julia/bin:$PATH
PATH=$HOME/usr/local/valgrind/bin:$PATH
PATH=$PYENV_ROOT/bin:$PATH
#pathmunge $PYENV_ROOT/bin
#pathmunge $HOME/bin
#pathmunge $HOME/usr/bin 
#pathmunge $HOME/usr/local/cmake/bin 
#pathmunge $HOME/usr/local/HDF5/bin
#pathmunge $HOME/usr/local/julia/bin 

#LD_LIBRARY_PATH=$HOME/usr/local/intel/lib64:$LD_LIBRARY_PATH
LD_LIBRARY_PATH=$HOME/usr/local/HDF5/lib:$HOME/usr/local/julia/lib:$HOME/usr/local/valgrind/lib:$LD_LIBRARY_PATH

source $HOME/intel/bin/compilervars.sh intel64
#source $HOME/intel/mkl/bin/mklvars.sh intel64
#$HOME/intel/impi/2019.0.117/bin64/mpivars.sh release
#source $HOME/intel/inspector/inspxe-vars.sh intel64
#source $HOME/intel/advisor/advixe-vars.sh intel64
#source $HOME/intel/vtune_amplifier_xe/amplxe-vars.sh

export PATH
export LD_LIBRARY_PATH

# for python(pyenv)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# User specific environment and startup programs
ulimit -s unlimited
export OMP_NUM_THREADS=4
export OMP_STACKSIZE=2000M

export I_MPI_CC=icc
export I_MPI_CXX=icpc
export I_MPI_F90=ifort
export OMPI_CC=icc
export OMPI_CXX=icpc
export OMPI_FC=ifort

export JULIA_BINDIR=$HOME/usr/local/julia/bin

eval `keychain --eval --agents ssh github`
