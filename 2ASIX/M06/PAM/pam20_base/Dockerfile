FROM fedora:32
RUN dnf -y install vim procps util-linux-user finger passwd cracklib-dicts pam_mount nfs-utils
RUN mkdir /opt/docker
COPY . /opt/docker
WORKDIR /opt/docker
#RUN bash startup.sh
ENTRYPOINT [ "/bin/bash" ]
CMD [ "/opt/docker/startup.sh" ]
