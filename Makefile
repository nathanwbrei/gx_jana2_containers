

mount-cvmfs:
	sudo mount -t cvmfs cvmfs-config.cern.ch /cvmfs/cvmfs-config.cern.ch
	sudo mount -t cvmfs oasis.opensciencegrid.org /cvmfs/oasis.opensciencegrid.org

image:
	-docker rm nbrei_gluex_image
	docker build -t nbrei_gluex_image .

image-nc:
	-docker rm nbrei_gluex_image
	docker build --no-cache -t nbrei_gluex_image .

run:
	-docker rm nbrei_gluex_container
	ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:2222"
	docker run -it \
			   -v /Users/nbrei/projects/gluex/gluex_data:/data \
	           -v /cvmfs/oasis.opensciencegrid.org/gluex:/cvmfs/oasis.opensciencegrid.org/gluex \
	           -p 2222:22 \
			   --cap-add sys_ptrace
		       --name nbrei_gluex_container \
		       nbrei_gluex_image /sbin/sshd -D

shell:
	docker exec -it nbrei_gluex_container /bin/bash

ssh:
	ssh -p 2222 root@localhost


image-standalone:
	-docker rm nbrei_gluex_standalone_image
	docker build -f Dockerfile_standalone -t nbrei_gluex_standalone_image .

runshell-standalone:
	-docker rm nbrei_gluex_standalone_container
	docker run -it \
			   -v /Users/nbrei/projects/gluex/gluex_data:/data \
	           -p 2222:22 \
		       --name nbrei_gluex_standalone_container \
		       nbrei_gluex_standalone_image /bin/bash
