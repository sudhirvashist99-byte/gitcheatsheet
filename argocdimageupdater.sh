#argocd image updater
kubectl apply -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/config/install.yaml 

kubectl create secret generic gitlab-credentials \
  -n argocd-image-updater-system \
  --from-literal=username=sudhirvashist99-byte\  (gitlab access token) 
  --from-literal=password=glpat-7ZAkx9gKsVLgEfxHVBQ19W86MQp1OmpiM3FxCw.01.121re1is (gitlab access token)

#Configure Image Updater to use Git 
kubectl edit configmap argocd-image-updater-config \
  -n argocd-image-updater-system
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
      username: sudhirvashist99-byte
      password: glpat-7ZAkx9gKsVLgEfxHVBQ19W86MQp1OmpiM3FxCw.01.121re1is

kubectl rollout restart deployment argocd-image-updater-controller \
  -n argocd-image-updater-system
#finde status of update
kubectl get configmap argocd-image-updater-config \
  -n argocd-image-updater-system -o yaml



#find applacition name
kubectl get applications -n argocd

kubectl edit application myappargocd -n argocd
#Add Image Updater annotations 
metadata:
  annotations:
    argocd-image-updater.argoproj.io/image-list: php-fpm=sudhirvashist99/php-fpm-app
    argocd-image-updater.argoproj.io/php-fpm.update-strategy: latest
    argocd-image-updater.argoproj.io/php-fpm.write-back-method: git
    argocd-image-updater.argoproj.io/php-fpm.git-branch: main

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
