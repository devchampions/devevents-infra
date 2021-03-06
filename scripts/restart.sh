#!/bin/sh

#
# This script restarts remote devevents-backend service.
#

TERRAFORM_STATE=../terraform/terraform.tfstate
KEY_FILE=../secrets/server.key
IP_ADDRESS=$(jq -r '.modules[0].resources[] | select(.type == "aws_instance") | .primary.attributes.public_ip' $TERRAFORM_STATE)

ssh -i $KEY_FILE ec2-user@$IP_ADDRESS "bash -c 'sudo /sbin/service devevents-backend restart'"
