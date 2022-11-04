#!/bin/bash

#SBATCH --job-name=quickstart
#SBATCH --partition=gpu
#SBATCH --account=research-uco-ict
#SBATCH --time=00:10:00
#SBATCH --gpus=1
#SBATCH --mem=8G

# find your account with:
# sacctmgr list -sp user $USER

module load 2022r2 openmpi py-torch

# -s flag is to avoid underlay bind mounts warnings
srun apptainer -s exec --nv pytorch_22.10-py3.sif python \
    < quickstart.py \
    > quickstart.log
