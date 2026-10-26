FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openssh-server sudo git curl wget nano vim less \
      ca-certificates iproute2 iputils-ping net-tools \
      dnsutils procps psmisc lsof file unzip zip \
      tar xz-utils python3 python3-pip python3-venv \
      build-essential && \
    mkdir -p /run/sshd /root/.ssh && \
    ssh-keygen -A && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN printf '%s\n' \
    'Port 2222' \
    'PermitRootLogin prohibit-password' \
    'PubkeyAuthentication yes' \
    'PasswordAuthentication no' \
    >> /etc/ssh/sshd_config

EXPOSE 2222

CMD ["/bin/bash"]