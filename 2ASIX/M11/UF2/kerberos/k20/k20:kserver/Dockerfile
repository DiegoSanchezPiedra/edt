FROM fedora:32
RUN dnf -y install krb5-server krb5-workstation krb5-libs procps nmap tree vim
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
EXPOSE  88 749 464
CMD [ "/opt/docker/startup.sh" ]
