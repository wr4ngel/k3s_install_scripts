#!/bin/bash


mkdir -p /home/$USER/.kube
cp -i /etc/kubernetes/admin.conf /home/$USER/.kube/config
chown $USER:$USER /home/$USER/.kube/config

