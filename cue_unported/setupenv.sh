#!/bin/bash

source /etc/profile.d/modules.sh
module unload gcc 
# Puts us on 4.8.5

export HALLD_RECON_SOURCE=/scratch/$USER/halld_recon_unported
export BUILD_SCRIPTS=/group/halld/Software/build_scripts
export GLUEX_TOP=/group/halld/Software/builds/Linux_CentOS7-x86_64-gcc4.8.5-cntr

source $BUILD_SCRIPTS/gluex_env_boot_jlab.sh
gxenv /scratch/$USER/containers/cue_unported/version_5.6.0.xml
