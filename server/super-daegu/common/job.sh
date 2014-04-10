#!/bin/sh
#### Requesting job resources
### PBS -l select=[nodes]:ncpus=[cpus]:ngpus=[gpus]
#PBS -l select=8:ncpus=16:ngpus=1

#### Setting email recipient list
#PBS -M Enter Email Address

#### mail option(Specifying email notification)
### a send mail when job is aborted by batch system
### b send mail when job begins execution
### e send mail when job ends execution
### n do not send mail
#PBS -m abe

#### Specifying queue and/or server
#PBS -q workq

#### Marking a job as re-runnable or not
#PBS -r n

#### Exporting environment variables
#PBS -V

#### Specifying a job name
### PBS -N [jobname]
#PBS -N 8node-16

#### Create Stdout.out File 
cd $PBS_O_WORKDIR
date > stdout.out
cat $PBS_NODEFILE >> stdout.out

NP=`/usr/bin/wc -l $PBS_NODEFILE | awk '{ print $1 }'`

echo $NP >> stdout.out

#### mpirun config
mpirun -genv I_MPI_FABRICS=shm:ofa -genv I_MPI_OFA_USE_XRC=1 -genv I_MPI_OFA_DYNAMIC_QPS=1 -genv I_MPI_DEBUG=5 -np $NP -machinefile $PBS_NODEFILE /hello.out >> stdout.out
