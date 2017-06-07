#!/bin/bash

TERRAFORM_STATE=../terraform/terraform.tfstate
KEY_FILE=../secrets/server.key

IP_ADDRESS=$(jq -r '.modules[0].resources[] | select(.type == "aws_instance") | .primary.attributes.public_ip' $TERRAFORM_STATE)
DB_ENDPOINT=$(jq -r '.modules[0].resources[] | select(.type == "aws_db_instance") | .primary.attributes.endpoint' $TERRAFORM_STATE)
DB_USER=$(jq -r '.modules[0].resources[] | select(.type == "aws_db_instance") | .primary.attributes.username' $TERRAFORM_STATE)
DB_PASS=$(jq -r '.modules[0].resources[] | select(.type == "aws_db_instance") | .primary.attributes.password' $TERRAFORM_STATE)
DB_NAME=$(jq -r '.modules[0].resources[] | select(.type == "aws_db_instance") | .primary.attributes.name' $TERRAFORM_STATE)


cat << EOF
{
  "backend": [ "$IP_ADDRESS" ],
  "_meta": {
    "hostvars": {
      "$IP_ADDRESS": {
        "ansible_user" : "ec2-user",
        "ansible_ssh_private_key_file" : "$KEY_FILE",          
        "database_host": "$DB_ENDPOINT",
        "database_user": "$DB_USER",
        "database_pass": "$DB_PASS",
        "database_name": "$DB_NAME"
      }
    }
  }
}
EOF