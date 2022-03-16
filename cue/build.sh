#!/bin/bash

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

