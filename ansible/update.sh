#!/bin/sh

#
# This script runs only part of Ansible Playbook to update 
# application configuration.
#

ansible-playbook -i terraform.sh --tags config playbook.yml
 