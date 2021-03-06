#!/bin/sh

#
# This script install Ansible Galaxy roles and runs full Ansible Playbook 
# against inventory extracted from Terraform state.
#

ansible-galaxy install -r requirements.yml
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i terraform.sh playbook.yml 