#argocd image updater
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/config/install.yaml
 

kubectl create secret generic gitlab-credentials \
  -n argocd \
  --from-literal=username=sudhirvashist99-byte\
  --from-literal=password=glpat-Klp3rtwJw4g2k3nCdmAXe286MQp1OmprNHhsCw.01.120foufum (gitlab access token)glpat-Klp3rtwJw4g2k3nCdmAXe286MQp1OmprNHhsCw.01.120foufum

  kubectl create secret generic gitlab-credentials \
  -n argocd \
  --from-literal=username=sudhirvashist99-byte\
  --from-literal=password=glpat-Klp3rtwJw4g2k3nCdmAXe286MQp1OmprNHhsCw.01.120foufum

kubectl get secret gitlab-credentials -n argocd

#Configure Image Updater to use Git 
kubectl edit configmap argocd-image-updater-config -n argocd

#Add data on before other data

data:
  git.write-back-method: git

  git.commit-message-template: |
    chore: update image {{.Image}} to {{.NewTag}}

  registries.conf: |
    registries:
    - name: DockerHub
      api_url: https://registry-1.docker.io
      prefix: sudhirvashist99
      credentials: secret:dockerhub-credentials

  git.credentials: |
    https://gitlab.com:
      usernameSecret:
        name: gitlab-credentials
        key: username
      passwordSecret:
        name: gitlab-credentials
        key: password


kubectl rollout restart deployment argocd-image-updater-controller -n argocd
#find application name
kubectl get applications -n argocd
kubectl edit application sudd -n argocd
#Add Image Updater annotations 
metadata:
  annotations:
    argocd-image-updater.argoproj.io/image-list: php-fpm=sudhirvashist99/php-fpm-app
    argocd-image-updater.argoproj.io/php-fpm.update-strategy: latest
    argocd-image-updater.argoproj.io/write-back-method: git

kubectl describe application sudd -n argocd | grep image-updater

# ---------------- SONARQUBE SCAN ----------------
sonarqube_scan:
  stage: sonar
  image: sonarsource/sonar-scanner-cli:latest
  script:
    - |
      sonar-scanner \
        -Dsonar.host.url=$SONAR_HOST_URL \
        -Dsonar.login=$SONAR_TOKEN \
        -Dsonar.projectKey=$SONAR_PROJECT_KEY \
        -Dsonar.projectName=$SONAR_PROJECT_NAME
  only:
    - main
