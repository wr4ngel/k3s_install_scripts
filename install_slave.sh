#!/bin/bash

# Usage:
#   ./install-agent.sh <MASTER_IP> <NODE_TOKEN>

set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <MASTER_IP> <NODE_TOKEN>"
    exit 1
fi

MASTER_IP="$1"
NODE_TOKEN="$2"

echo "[INFO] Installing K3s agent..."
curl -sfL https://get.k3s.io | \
    K3S_URL="https://$MASTER_IP:6443" \
    K3S_TOKEN="$NODE_TOKEN" \
    sh -
echo "[INFO] Agent node joined successfully."
