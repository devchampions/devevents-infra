#!/bin/sh

ansible-playbook -i terraform.sh --tags config playbook.yml
 