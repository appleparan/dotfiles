#!/bin/bash

#SBATCH -J  tensor-1GPU                   # Job name
#SBATCH -o  out.test-tensorflow-1GPU.%j   # Name of stdout output file (%j expands to %jobId)
#SBATCH -p  gpu                           # queue or partiton name
#SBATCH --gres=gpu:1                      # Num Devices

echo
python3 -V
which python3
which pip3
echo
pip3 list | grep tensorflow
echo
python3 "your_python_file.py"

# End of File.
