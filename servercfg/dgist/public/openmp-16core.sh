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

# openmp environmental variables
export OMP_NUM_THREADS=16
export OMP_STACKSIZE=4000M

# load modules
module load INTEL/2019_UP5

# log node information
cd $PBS_O_WORKDIR
[ -f jobout.out ] && rm jobout.out
date > jobout.out
cat $PBS_NODEFILE >> jobout.out

NP=`/usr/bin/wc -l $PBS_NODEFILE | awk '{ print $1 }'`

echo $NP >> jobout.out

# redirect stdout to stderr
./a.out >> jobout.out 2>&1
