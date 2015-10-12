#!/bin/bash
#PBS -l select=1:ncpus=16
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
export OMP_NUM_THREADS=16
cd $PBS_O_WORKDIR
[ -f jobout.out ] && rm jobout.out
date > jobout.out
cat $PBS_NODEFILE >> jobout.out

NP=`/usr/bin/wc -l $PBS_NODEFILE | awk '{ print $1 }'`

echo $NP >> jobout.out

./a.out &> jobout.out
