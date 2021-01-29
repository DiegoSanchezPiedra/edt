FROM fedora:32
RUN dnf -y install krb5-server krb5-workstation tree nmap
RUN mkdir /opt/docker
COPY . /opt/docker
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]
