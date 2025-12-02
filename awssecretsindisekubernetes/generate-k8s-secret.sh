#!/bin/bash

SECRET=$(aws secretsmanager get-secret-value --secret-id myapp/mysql --query SecretString --output text)

cat <<EOF > mysql-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
type: Opaque
data:
  DB_HOST: $(echo $SECRET | jq -r '.DB_HOST' | base64 -w 0)
  DB_USER: $(echo $SECRET | jq -r '.DB_USER' | base64 -w 0)
  DB_PASSWORD: $(echo $SECRET | jq -r '.DB_PASSWORD' | base64 -w 0)
  DB_NAME: $(echo $SECRET | jq -r '.DB_NAME' | base64 -w 0)
  Master_Admin: $(echo $SECRET | jq -r '.Master_Admin' | base64 -w 0)
  Master_Admin_Password: $(echo $SECRET | jq -r '.Master_Admin_Password' | base64 -w 0)

EOF

kubectl apply -f mysql-secret.yaml
