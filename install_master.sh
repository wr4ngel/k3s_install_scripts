#!/bin/bash

# Usage:
#   On first master (cluster init): ./install-master.sh
#   On joining master: ./install-master.sh <MASTER_IP> <NODE_TOKEN>

set -e

if [ "$#" -eq 0 ]; then
    echo "[INFO] Installing first K3s master (cluster init)..."
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --node-taint CriticalAddonsOnly=true:NoExecute" sh -
    echo "[INFO] K3s master initialized."
    echo "[INFO] Your node token is:"
    sudo cat /var/lib/rancher/k3s/server/node-token
else
    SERVER_IP="$1"
    NODE_TOKEN="$2"

    echo "[INFO] Joining existing K3s cluster at $SERVER_IP"
    curl -sfL https://get.k3s.io | \
        INSTALL_K3S_EXEC="server --server https://$SERVER_IP:6443 --node-taint CriticalAddonsOnly=true:NoExecute" \
        K3S_TOKEN="$NODE_TOKEN" \
        sh -
    echo "[INFO] Joined as additional master node."
fi
