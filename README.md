
# Getting started with GlueX+JANA2

## How to obtain

The JANA2 code lives at http://github.com/nathanwbrei/JANA2. The branch that is known to work with the GlueX code is `nbrei_gluex_port`. Documentation can be found at https://jeffersonlab.github.io/JANA2/. 

The forked halld_recon code (that has been modified to use JANA2) lives at http://github.com/nathanwbrei/halld_recon on the branch `nbrei_jana2`. This fork can be built using SCons like before, but it can also be built using CMake. This allows us to effectively use IDEs such as CLion with halld_recon. 

The CMake configuration leverages the environment that was set up by the existing Hall D build scripts. This means that all of the GlueX dependencies (except for JANA) are exactly the same as before. This means that we can switch over to JANA2 by modifying two lines in the version set file.

An example of such a modified version set file can be found in the repository https://github.com/nathanwbrei/gx_jana2_containers, on the `master` branch. (Note that this has hardcoded paths which include my personal scratch directory, so you'll need to modify it to match your environment). 

This repository also contains a Dockerfile which lets you build halld_recon on a non-CUE system. 

## How to run

### On CUE

```bash

# Download all of the code to scratch directory

cd /scratch/$USER
git clone -b nbrei_gluex_port https://github.com/JeffersonLab/JANA2
git clone -b nbrei_jana2 http://github.com/nathanwbrei/halld_recon
git clone http://github.com/nathanwbrei/gx_jana2_containers


# Set up environment variables

module unload gcc   # Let's do everything with 4.8.5
cd gx_jana2_containers/cue
source bash_profile
gxenv jana2_gluex_version.xml
# Note that this complains about gluex_root_analysis,halld_sim, and hdgeant. We'll get to those.


# Build JANA2

mkdir /scratch/$USER/jana_home
cd /scratch/$USER/JANA2
mkdir build
cd build 
cmake .. -DUSE_XERCES=1 -DUSE_ROOT=1
nice make -j20 install


# Build halld_recon

cd /scratch/$USER/halld_recon/src
nice scons -j30 install OPTIMIZATION=0


# Run against your favorite EVIO file 

cp /cache/halld/RunPeriod-2021-11/rawdata/Run090719/hd_rawdata_090719_001.evio /scratch/nbrei
hd_root -Pplugins=danarest,regressiontest -Pnthreads=1 -Pjana:nevents=3 /scratch/nbrei/hd_rawdata_072995_006.evio > jana2_stdout.txt 2> jana2_stderr.txt

```




### On Docker

See docker-with-cvmfs README.md. 


