# ldapserver
FROM fedora:32
LABEL version="1.0"
LABEL author="@edt ASIX-M06"
LABEL subject="ldapserver"
RUN dnf -y install openldap-servers openldap-clients procps iproute iputils tree nmap
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
ENTRYPOINT [ "/bin/bash","/opt/docker/startup.sh" ]
EXPOSE 389
