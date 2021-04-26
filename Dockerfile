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
		czmq \
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


# Install GlueX misc dependencies (take from install_gluex)

RUN yum install -y imake openmotif-devel libXpm-devel bzip2-devel tcsh \
    perl-XML-Simple perl-XML-Writer patch perl-File-Slurp \
    mesa-libGLU-devel qt-devel boost-devel gsl-devel \
    libtool bc nano cmake tbb-devel xrootd-client-libs xrootd-client \
    libtirpc-devel vim python2-future gdb mariadb \
    && cd /usr/include \
    && ln -s freetype2/freetype freetype


# Install ssh so that we can remote from CLion

RUN yum install -y openssh-server
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN ssh-keygen -A -f /etc/ssh/ssh_host 
EXPOSE 22


# Set up /group, /u/group to point to CVMS, also as per CUE

RUN mkdir /cvmfs \
 && ln -s cvmfs/oasis.opensciencegrid.org/gluex/group /group \
 && mkdir /u \
 && ln -s ../group /u/group

VOLUME /cvmfs/oasis.opensciencegrid.org/gluex:/cvmfs/oasis.opensciencegrid.org/gluex


# GlueX environment variables
ENV JANA_HOME /app/jana2/install
ENV GLUEX_TOP /group/halld/Software/builds/Linux_CentOS7-x86_64-gcc4.8.5-cntr
ENV BUILD_SCRIPTS /group/halld/Software/build_scripts
ENV BUILD_THREADS 4

RUN mkdir /app
WORKDIR /app

# Clone JANA2 and hd_recon
RUN git clone -b nbrei_gluex_port https://github.com/JeffersonLab/JANA2 jana2
RUN git clone -b nbrei_jana2 https://github.com/nathanwbrei/halld_recon
ADD nbrei_gluex_version.xml /app/nbrei_gluex_version.xml

# Install JANA2
RUN cd jana2 \
    && cmake -B build -DCMAKE_INSTALL_PREFIX=${JANA_HOME} \
    && cmake --build build -j${BUILD_THREADS} \
    && cmake --install build

# TODO: root-6.-08.06 CMake seems broken due to missing libmathtext.a
# RUN cmake -B build -DCMAKE_INSTALL_PREFIX=${JANA_HOME} -DROOT_DIR=${GLUEX_TOP}/root/root-6.08.06/cmake/

ENV PATH ${PATH}:${JANA_HOME}/bin
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${JANA_HOME}/lib


# Add newer versions of GDB so that CLion lets us remote debug
RUN yum install -y centos-release-scl \
 && yum-config-manager --enable rhel-server-rhscl-7-rpms \
 && yum install -y devtoolset-8 
# To use: `scl enable devtoolset-8 bash`

ADD bash_profile /root/.bash_profile
ADD bash_profile /root/.bashrc

CMD /bin/bash


