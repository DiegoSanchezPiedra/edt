FROM fedora:32
RUN dnf -y install xinetd httpd vsftpd tftp-server iputils iproute net-tools passwd telnet procps nmap vim
RUN mkdir /opt/docker
COPY * /opt/docker/
#RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]
