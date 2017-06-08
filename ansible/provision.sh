#!/bin/sh

ansible-galaxy install -r requirements.yml
ansible-playbook -i terraform.sh playbook.yml 