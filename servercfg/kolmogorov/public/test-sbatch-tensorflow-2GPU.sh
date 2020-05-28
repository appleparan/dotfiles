#!/bin/bash

#SBATCH -J  tensor-2GPU                   # Job name
#SBATCH -o  out.test-tensorflow-2GPU.%j   # Name of stdout output file (%j expands to %jobId)
#SBATCH -p  gpu                           # queue or partiton name
#SBATCH --gpus-per-task=2                 # Each task use 2 GPUs
#SBATCH --gres=gpu:2                      # Num Devices

echo
python3 -V
which python3
which pip3
echo
pip3 list | grep tensorflow
echo
python3 "your_python_file.py"

# End of File.
