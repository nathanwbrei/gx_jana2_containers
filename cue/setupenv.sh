#!/bin/bash
source /etc/profile.d/modules.sh
module unload gcc
# Puts us on 4.8.5

export JANA_SOURCE=/scratch/nbrei/jana2
export HALLD_RECON_SOURCE=/scratch/nbrei/halld_recon

export BUILD_SCRIPTS=/group/halld/Software/build_scripts
export JANA_HOME=/scratch/nbrei/jana_home
export GLUEX_TOP=/group/halld/Software/builds/Linux_CentOS7-x86_64-gcc4.8.5-cntr

source $BUILD_SCRIPTS/gluex_env_boot_jlab.sh
gxenv /scratch/nbrei/containers/cue/jana2_gluex_version.xml







