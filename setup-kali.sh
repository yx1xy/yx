
#!/bin/sh
set -eu

cd /workspaces/yx

mkdir -p .devcontainer

# Remove existing JSON files only inside .devcontainer
find .devcontainer -type f -name '*.json' -delete

# Recreate the Kali Dev Container configuration
cat > .devcontainer/devcontainer.json <<'JSON'
{
  "name": "Full Kali Linux Root SSH",
  "image": "kalilinux/kali-rolling",
  "remoteUser": "root",
  "containerUser": "root",
  "init": true,
  "overrideCommand": false,
  "forwardPorts": [2222],
  "portsAttributes": {
    "2222": {
      "label": "Kali SSH",
      "onAutoForward": "notify"
    }
  },
  "containerEnv": {
    "DEBIAN_FRONTEND": "noninteractive",
    "TERM": "xterm-256color"
  },
  "postCreateCommand": "apt-get update && apt-get install -y kali-linux-everything openssh-server sudo git curl wget nano vim less man-db ca-certificates dbus-x11 iproute2 iputils-ping net-tools dnsutils procps psmisc lsof file unzip zip tar xz-utils python3 python3-pip python3-venv build-essential && mkdir -p /run/sshd /root/.ssh && chmod 700 /root/.ssh && ssh-keygen -A && printf '\\nPort 2222\\nPermitRootLogin prohibit-password\\nPubkeyAuthentication yes\\nPasswordAuthentication no\\n' >> /etc/ssh/sshd_config && apt-get clean && rm -rf /var/lib/apt/lists/*",
  "postStartCommand": "mkdir -p /run/sshd && ( /usr/sbin/sshd -p 2222 || pgrep -x sshd >/dev/null )",
  "customizations": {
    "vscode": {
      "settings": {
        "terminal.integrated.defaultProfile.linux": "bash"
      },
      "extensions": [
        "ms-python.python",
        "ms-vscode.cpptools",
        "ms-vscode.vscode-docker"
      ]
    }
  },
  "shutdownAction": "stopContainer"
}
JSON

echo "Created .devcontainer/devcontainer.json"
echo
cat .devcontainer/devcontainer.json

echo
echo "Check the file, then commit and push it to GitHub."
