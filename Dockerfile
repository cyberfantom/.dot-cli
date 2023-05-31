FROM ubuntu:18.04

# Install software and configure locale
RUN apt update && apt install -y openssh-server vim tmux git python3-pip xsel mc curl locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Add test user
RUN useradd -d /home/test -ms /bin/bash -p test test

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd \
    && echo 'test:test' | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Cleanup
RUN apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# Build and run
# docker build . -t dot-cli
# docker run -dt --name dot-cli -p 127.0.0.1:2222:22 -v $(pwd):/opt dot-cli
## SSH to container, user root or test
# ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" root@127.0.0.1 -p2222
