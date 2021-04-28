
A Docker container for porting GlueX software to use JANA2. 

Usage
-----
```
host$  make mount-cvmfs. # Mount the halld /group directories just like CUE
host$  make image # Builds the Docker image. 
host$  make run  # Drops into bash, but also launches sshd
host$  ssh -p 2222 root@localhost  # In case we want to remote in from CLion or another IDE. Password is `password`.

container#  gxenv /app/nbrei_gluex_version  # Set up GlueX environment to use checked out /app/halld_recon and /app/jana2
container#  cd /app/halld_recon && scons  # Note that -j4 causes problems in Docker sometimes
```

