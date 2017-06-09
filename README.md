
[![Build Status](https://travis-ci.org/devchampions/devevents-infra.svg?branch=master)](https://travis-ci.org/devchampions/devevents-infra)

# dev.events infrastructure

Infrastructure-as-code repository for <http://dev.events>.

## Secrets

Global secrets for external services (e.g. Datadog, Auth0 etc) are stored inside the `secrets` folder as JSON records. 

All sensetive information (`*.json`, `*.tfstate`, etc.) is encrypted with the help of [transcrypt](https://github.com/elasticdog/transcrypt). You need to enable it on the cloned repository in order to see and push unencrypted files. Master password should be requested from the team members.

## Terraform

[Terraform](https://www.terraform.io/) is used to provision AWS, DNS and other resources required for infrastructure. Install `0.9.6+` to use all the latest resource types and providers.

To apply infrastructure changes, run the following command from the `terraform` directory:

    terraform apply

After each `terraform apply` run, the `terraform.state` file is updated and should be committed/pushed to Git.

## Ansible

[Ansible](https://www.ansible.com/) is used to post-provision created server(s) with additional software. 

From within the `ansible` directory run:

    ./provision.sh

The script installs external roles from Ansible Galaxy, extracts inventory data from Terraform state and applies Ansible playbook to the server(s).

The `provision.sh` script depends on [jq](https://stedolan.github.io/jq/) that should be installed separately.

## Vagrant

Both Terraform and Ansible can used directly on \*nix hosts. On Windows, it is adviced to start a virtual machine (aka control machine) using `vagrant up` and then login to that machine over SSH and run provisioning commands (`terraform apply` and `provision.sh`) from there.

## Useful links

- <https://console.aws.amazon.com/codedeploy/home?region=us-east-1#/deployments>
- <https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#logStream:group=devevents-backend;streamFilter=typeLogStreamPrefix>

