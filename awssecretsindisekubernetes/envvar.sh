#!/bin/bash
SECRET=$(aws secretsmanager get-secret-value --secret-id myapp/mysql --query SecretString --output text)

export DB_HOST=$(echo $SECRET | jq -r '.DB_HOST')
export DB_USER=$(echo $SECRET | jq -r '.DB_USER')
export DB_PASSWORD=$(echo $SECRET | jq -r '.DB_PASSWORD')
export DB_NAME=$(echo $SECRET | jq -r '.DB_NAME')
