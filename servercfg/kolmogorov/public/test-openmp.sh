#!/bin/bash

# checkout https://slurm.schedmd.com/sbatch.html for more details
#SBATCH -J openmp-jobname           # Job name
#SBATCH --nodes=1                   # Total Number of Nodes
#SBATCH --ntasks=1                  # Number of "tasks". For use with distributed parallelism (i.e. MPI) 
#SBATCH --cpus-per-task=16          # # of CPUs allocated to each task. For use with shared memory parallelism. (i.e. OpenMP)
#SBATCH --ntasks-per-node=1         # Number of "tasks" per node. For use with distributed parallelism (i.e. MPI)
#SBATCH -o out.%j.%x                # Name of stdout output file (%j - job id, %x - job name)
#SBATCH -p cpu                      # queue or partiton name

# executable file 
export OMP_NUM_THREADS=16
$PWD/exec.run
# End of File.
