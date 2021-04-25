

mount-cvmfs:
	sudo mount -t cvmfs cvmfs-config.cern.ch /cvmfs/cvmfs-config.cern.ch
	sudo mount -t cvmfs oasis.opensciencegrid.org /cvmfs/oasis.opensciencegrid.org

docker-image:
	-docker rm nbrei_gluex_image
	docker build -t nbrei_gluex_image .

docker-run:
	-docker rm nbrei_gluex_container
	docker run -v /Users/nbrei/projects/gluex/gluex_data:/data \
	           -v /cvmfs/oasis.opensciencegrid.org/gluex:/cvmfs/oasis.opensciencegrid.org/gluex \
	           -p 2222:22 \
		       --name nbrei_gluex_container \
		       nbrei_gluex_image

docker-shell:
	docker exec -it nbrei_gluex_container /bin/bash

docker-ssh:
	ssh -p 2222 root@localhost




