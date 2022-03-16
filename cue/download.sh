#!/bin/bash

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

