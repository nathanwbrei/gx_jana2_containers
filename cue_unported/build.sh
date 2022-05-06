#!/bin/bash

# Build halld_recon

cd /scratch/$USER/halld_recon_unported/src
nice scons -j30 install OPTIMIZATION=0

