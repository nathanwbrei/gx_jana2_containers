FROM jeffersonlab/hdrecon:latest

USER root
WORKDIR /

# 

# Install ssh so that we can remote from CLion

RUN yum install -y openssh-server gdb
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN ssh-keygen -A -f /etc/ssh/ssh_host 
EXPOSE 22

# SSH login fix. Otherwise user is kicked off after login
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

CMD echo "sshd is listening on port 22..." && /usr/sbin/sshd -D

