FROM fedora:32
RUN dnf -y install nss-pam-ldapd passwd pam_mount procps nmap openldap-clients vim openssh openssh-server openssh-clients file openssl
RUN mkdir /opt/docker
COPY . /opt/docker
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
ENTRYPOINT [ "/bin/bash" ]
EXPOSE 22
CMD [ "/opt/docker/startup.sh" ]
