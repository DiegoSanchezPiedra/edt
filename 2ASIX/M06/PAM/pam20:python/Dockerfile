FROM fedora:32
RUN dnf -y install procs util-linux-user finger passwd cracklib-dicts pam_mount sphinx python3-sphinx python2 gcc pam-devel redhat-rpm-config python-devel make python3 pip
RUN mkdir /opt/docker
COPY . /opt/docker
WORKDIR /opt/docker
#RUN bash startup.sh
#ENTRYPOINT [ "/bin/bash" ]
CMD [ "/opt/docker/startup.sh" ]
