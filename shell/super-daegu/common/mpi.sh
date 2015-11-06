#!/bin/bash
## 8 node, 8 physical cpus per node, make 8 mpi process (logical) per node, then we have 64 mpi process
#PBS -l select=8:ncpus=8:mpiprocs=8
#PBS -M Mail Address
### mail option
## a send mail when job is aborted by batch system
## b send mail when job begins execution
## e send mail when job ends execution
## n do not send mail
#PBS -m n
#PBS -N test
#PBS -q workq
#PBS -r n
cd $PBS_O_WORKDIR
[ -f jobout.out ] && rm jobout.out
date > jobout.out
cat $PBS_NODEFILE >> jobout.out

NP=`/usr/bin/wc -l $PBS_NODEFILE | awk '{ print $1 }'`

echo $NP >> jobout.out

#### mpirun config
mpirun -genv I_MPI_FABRICS=shm:ofa -genv I_MPI_OFA_USE_XRC=1 -genv I_MPI_OFA_DYNAMIC_QPS=1 -genv I_MPI_DEBUG=5 -np $NP -machinefile $PBS_NODEFILE ./a.out >> jobout.out 2>&1
