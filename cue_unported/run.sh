#!/bin/bash
hd_root -PPLUGINS=danarest,regressiontest -PNTHREADS=1 -PEVENTS_TO_KEEP=3 -PEVENTS_TO_SKIP=0 -Pregressiontest:interactive=1 /scratch/nbrei/hd_rawdata_073224_003.evio
