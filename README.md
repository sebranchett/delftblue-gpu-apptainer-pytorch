# Combination of GPU, Apptainer/Singularity and PyTorch working on DelftBlue

Almost nothing in this repository is original. If you find something that is, then it is supplied under an [MIT license](./LICENSE).

## Sources

Running on GPUs and using Apptainer on DelftBlue:
- https://doc.dhpc.tudelft.nl/delftblue/howtos/pytorch/
- https://doc.dhpc.tudelft.nl/delftblue/howtos/singularity/

Apptainer general usage and GPUs:
- https://apptainer.org/docs/user/main/quick_start.html
- https://apptainer.org/docs/user/main/gpu.html

Docker container:
- https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch.
See [End User License Agreement](https://developer.nvidia.com/ngc/nvidia-deep-learning-container-license)

PyTorch example:
- https://pytorch.org/tutorials/beginner/basics/quickstart_tutorial.html - © Copyright 2022, PyTorch, and used under an [Attribution 4.0 International (CC BY 4.0) license](https://creativecommons.org/licenses/by/4.0/)

## Steps on DelftBlue
Move to your scratch directory, because this will take a lot of space. Make a temporary directory for Apptainer to use when building a `.sif` file from a Docker image.
```
cd /scratch/$USER
mkdir tmpdir
```
Set up Apptainer environment variables.
```
export APPTAINER_TMPDIR=/scratch/$USER/tmpdir
export APPTAINER_CACHEDIR=/scratch/$USER/.apptainer/cache
```
Adding these two export lines to the end of `~/.bashrc` makes life easier.

Clone this repository and move into it:
```
git clone git@github.com:sebranchett/delftblue-gpu-apptainer-pytorch.git
cd delftblue-gpu-apptainer-pytorch
```

Find the version of the image you want to use. In my case it was pytorch:22.10-py3. Pull the (Docker) image with Apptainer.
```
apptainer pull docker://nvcr.io/nvidia/pytorch:22.10-py3
```
This took nearly 2 hours and produces a file `pytorch_22.10-py3.sif`.

Find your account on DelftBlue:
```
sacctmgr list -sp user $USER
```
You will probably have access to 'innovation' and your departmental account. In the `quickstart.sh` file, edit the line:
```
#SBATCH --account=research-uco-ict
```
to an account you have access to.

Submit the job:
```
sbatch quickstart.sh
```
The job only takes a couple of minutes, once it has started. On completion, the file `quickstart.log` should end with:
```
Done!
Saved PyTorch Model State to model.pth
Predicted: "Ankle boot", Actual: "Ankle boot"
```
as described in the [PyTorch documentation](https://pytorch.org/tutorials/beginner/basics/quickstart_tutorial.html).

## Please help
In the `slurm-nnnnnnn.out` file I got:
```
13:4: not a valid test operator: (
13:4: not a valid test operator: 520.61.05
```
at the end. If anyone knows why, please let me know.

If you have corrections or improvements to this repository, please contribute an issue or a pull request. It would be much appreciated.