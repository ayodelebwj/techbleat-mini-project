#!/bin/bash
git add .
git commit -am "push to git"
git push
terraform fmt
terraform validate
terraform plan
terraform apply --auto-approve -var-file dev.tfvars
