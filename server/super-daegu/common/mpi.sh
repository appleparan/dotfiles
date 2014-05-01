#!/bin/bash
#PBS -l select=8:ncpus=1:ngpus=1
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
#PBS -j oe
cd $PBS_O_WORKDIR
[ -f stdout.out ] && rm stdout.out
date > stdout.out
cat $PBS_NODEFILE >> stdout.out

NP=`/usr/bin/wc -l $PBS_NODEFILE | awk '{ print $1 }'`

echo $NP >> stdout.out

#### mpirun config
mpirun -genv I_MPI_FABRICS=shm:ofa -genv I_MPI_OFA_USE_XRC=1 -genv I_MPI_OFA_DYNAMIC_QPS=1 -genv I_MPI_DEBUG=5 -np $NP -machinefile $PBS_NODEFILE /a.out >> stdout.out
