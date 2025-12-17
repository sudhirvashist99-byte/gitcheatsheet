#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
# install docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
# change group permission
sudo usermod -aG docker $USER && newgrp docker
# install sonarqube
docker run -d --name sonarqube \
  -p 9000:9000 \
  sonarqube:latest
#install k3s  
curl -sfL https://get.k3s.io | sudo sh -
echo 'alias kubectl="sudo k3s kubectl"' >> ~/.bashrc
source ~/.bashrc
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
sudo su
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

#install argocd by helm
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update  
kubectl create namespace argocd
#helm install argocd argo/argo-cd -n argocd
helm install argocd argo/argo-cd \
  -n argocd \
  --create-namespace \
  --set server.service.type=NodePort \
  --set server.service.nodePortHttp=32109
#kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
