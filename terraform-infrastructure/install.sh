#!/bin/bash
#THIS COMMANDS CREATES THE JENKINS SERVER
terraform init
terraform fmt
terraform validate
terraform plan -var-file dev.tfvars
terraform apply --auto-approve -var-file dev.tfvars