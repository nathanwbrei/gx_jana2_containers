#!/bin/bash

# Download all of the code to scratch directory

cd /scratch/$USER
git clone -b nbrei_gluex_port https://github.com/JeffersonLab/JANA2
git clone -b nbrei_jana2 http://github.com/nathanwbrei/halld_recon
# git clone http://github.com/nathanwbrei/gx_jana2_containers containers


