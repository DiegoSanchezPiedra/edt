FROM fedora:32
RUN dnf -y install nss-pam-ldapd passwd pam_mount procps nmap openldap-clients vim
RUN mkdir /opt/docker
COPY . /opt/docker
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
ENTRYPOINT [ "/bin/bash" ]
CMD [ "/opt/docker/startup.sh" ]
