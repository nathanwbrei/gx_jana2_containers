FROM centos:centos7.7.1908

USER root
WORKDIR /


# Install development environment ala CUE

RUN yum install -y epel-release && \
    yum install -y \
		bzip2-devel \
		cmake3 \
		file \
		gcc-c++ \
		gcc-gfortran \
		git \
		subversion \
		make \
		mysql-devel \
		python \
		python-devel \
		protobuf-c-devel \
		scons \
		sudo \
		tree \
		wget \
		which \
		expat-devel \
		libX11-devel \
		libXt-devel \
		libXmu-devel \
		libXrender-devel \
		libXpm-devel \
		libXft-devel \
		xerces-c-devel \
		xkeyboard-config \
	&& ln -s /usr/bin/cmake3 /usr/local/bin/cmake \
	&& rm -rf /var/cache/yum


# Install ssh so that we can remote from CLion

RUN yum install -y openssh-server gdb
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN ssh-keygen -A -f /etc/ssh/ssh_host 
EXPOSE 22

# This came from StackOverflow. Consider deleting. 
# SSH login fix. Otherwise user is kicked off after login
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile




# Set up /group, /u/group to point to CVMS, also as per CUE

RUN mkdir /cvmfs
RUN ln -s cvmfs/oasis.opensciencegrid.org/gluex/group /group
RUN mkdir /u
RUN ln -s ../group /u/group

VOLUME /cvmfs/oasis.opensciencegrid.org/gluex:/cvmfs/oasis.opensciencegrid.org/gluex


RUN mkdir /app
WORKDIR /app

ENV JANA_HOME /app/jana2/install
ENV BUILD_THREADS 4
RUN git clone https://github.com/JeffersonLab/JANA2 jana2
RUN git clone -b nbrei_jana2 https://github.com/nathanwbrei/halld_recon

# Install JANA2
RUN cd jana2 \
    && cmake -B build -D CMAKE_INSTALL_PREFIX=${JANA_HOME} \
    && cmake --build build -j ${BUILD_THREADS} \
    && cmake --install build

ENV PATH ${PATH}:${JANA_HOME}/bin
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${JANA_HOME}/lib

# Install halld_recon

CMD echo "sshd is listening on port 22..." && /usr/sbin/sshd -D

