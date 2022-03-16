
Usage
-----

This docker environment uses CVMFS to pull in all of the HallD software dependencies in the same directory structure that CUE uses. (Note that the docker container expects CVMFS to be installed on the host machine. You'll need to have mounted Oasis like so:

```bash
sudo mount -t cvmfs cvmfs-config.cern.ch /cvmfs/cvmfs-config.cern.ch
sudo mount -t cvmfs oasis.opensciencegrid.org /cvmfs/oasis.opensciencegrid.org
```

You can get this via `make mount-cvmfs`. The Makefile also contains a variety of other recipes for working with the Docker container, including:



```
host$  make mount-cvmfs. # Mount the halld /group directories just like CUE

host$  make image # Builds the Docker image. 

host$  make run  # Drops into bash, but also launches sshd

host$  ssh -p 2222 root@localhost  # In case we want to remote in from CLion or another IDE. Password is `password`.

container#  gxenv /app/nbrei_gluex_version  # Set up GlueX environment to use checked out /app/halld_recon and /app/jana2

container#  cd /app/halld_recon && scons  # Note that -j4 causes problems in Docker sometimes, see Issues below
```


Issues
------

When building using a large number of threads inside Docker, gcc is often mysteriously killed. This is usually because gcc hits Docker resource limits and triggers the "Out-of-memory Killer". The solution is to go into Docker > Preferences > Resources and crank up the memory and swap usage. (Might as well crank everything up, honestly). This makes the error less frequent, but doesn't make it go away entirely. To make it go away entirely, try running cmake inside docker similar to this: (obviously make the RAM and CPU resources match the Docker config)
```bash
cmake -DLOCAL_RAM_RESOURCES=2048 -DLOCAL_CPU_RESOURCES=4
```

Note that using ROOT with CMake has some problems. Namely, the `ROOTConfig-targets` expects some libraries which appear to have not been built by the ROOT distribution on CVMFS. The solution is to copy the ROOT distribution into the Docker container itself and then replace the ROOTConfig-targets* files with the ones provided. This step needs to be performed manually for now because I haven't gotten around to figuring out the symlink semantics in order to do it "correctly" in the Dockerfile. This only impacts the CMake build, not the SCons one.




