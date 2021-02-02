FROM fedora:32
RUN dnf -y install krb5-workstation vim wget passwd nmap procps passwd util-linux-user
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
RUN wget https://rpmfind.net/linux/centos/7.9.2009/os/x86_64/Packages/pam_krb5-2.4.8-6.el7.x86_64.rpm
RUN dnf -y install pam_krb5-2.4.8-6.el7.x86_64.rpm 
CMD [ "/opt/docker/startup.sh" ]
