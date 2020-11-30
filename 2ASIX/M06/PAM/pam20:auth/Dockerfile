FROM fedora:27
RUN dnf -y install nss-pam-ldapd passwd pam_mount procps nmap openldap-clients vim authconfig
RUN mkdir /opt/docker
COPY . /opt/docker
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]
