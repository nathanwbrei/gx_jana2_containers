
A Docker container for porting GlueX software to use JANA2. 

Usage
-----
```
make mount-cvmfs. # Mount the halld /group directories just like CUE
make image # Builds the Docker image. 
make run  # Drops into bash, but also launches sshd
ssh -p 2222 root@localhost  # ssh so we can remote in from CLion or another IDE. Password is `password`.
gxenv /app/nbrei_gluex_version  # Set up GlueX environment to use checked out /app/halld_recon and /app/jana2
cd /app/halld_recon
scons  # Note that -j4 causes problems in Docker sometimes
```

