#!/bin/sh

TERRAFORM_STATE=../terraform/terraform.tfstate
KEY_FILE=../secrets/server.key
IP_ADDRESS=$(jq -r '.modules[0].resources[] | select(.type == "aws_instance") | .primary.attributes.public_ip' $TERRAFORM_STATE)

ssh -i $KEY_FILE ec2-user@$IP_ADDRESS "cat /var/log/devevents-backend.log"
