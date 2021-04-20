From centos:8

USER root
RUN echo 'fastestmirror=true' >> /etc/dnf/dnf.conf
RUN echo '[main]' >> /etc/yum/pluginconf.d/fastestmirror.conf
RUN echo 'include_only=.jp' >> /etc/yum/pluginconf.d/fastestmirror.conf

RUN yum install epel-release -y
RUN sed -i 's/https:/http:/g' /etc/yum.repos.d/epel.repo

# Install openssh-clients
RUN yum install -y openssh-clients

# Install ansible
RUN yum install -y ansible

RUN echo 'eval `ssh-agent`' > /root/.bashrc
RUN echo 'ssh-add ~/.ssh/id_rsa' >> /root/.bashrc

WORKDIR /etc/ansible
