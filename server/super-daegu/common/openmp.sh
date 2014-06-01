#!/bin/bash
#PBS -l select=1:ncpus=16:ngpus=0
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
#PBS -o job_output.out
#PBS -e job_error.out
export OMP_NUM_THREADS=16
cd $PBS_O_WORKDIR
[ -f stdout.out ] && rm stdout.out
date > stdout.out
cat $PBS_NODEFILE >> stdout.out

NP=`/usr/bin/wc -l $PBS_NODEFILE | awk '{ print $1 }'`

echo $NP >> stdout.out

./a.out >> stdout.out
