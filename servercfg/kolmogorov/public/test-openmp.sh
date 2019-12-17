#!/bin/bash

#SBATCH -J openmp-jobname           # Job name
#SBATCH --nodes=1                   # Total Number of Nodes
#SBATCH --ntasks=1                  # Number of "tasks". For use with distributed parallelism. See below.
#SBATCH --cpus-per-task=16          # # of CPUs allocated to each task. For use with shared memory parallelism.
#SBATCH --ntasks-per-node=1         # Number of "tasks" per node. For use with distributed parallelism. See below.
#SBATCH -o out.%j                   # Name of stdout output file (%j expands to %jobId)
#SBATCH -p cpu                      # queue or partiton name

# executable file 
$PWD/exec.run
# End of File.
