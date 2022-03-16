#!/bin/bash
# Set up environment variables

module unload gcc   # Let's do everything with 4.8.5
cd gx_jana2_containers/cue
source bash_profile
gxenv jana2_gluex_version.xml
# Note that this complains about gluex_root_analysis,halld_sim, and hdgeant. We'll get to those.
