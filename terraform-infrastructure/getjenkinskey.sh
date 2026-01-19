#!/bin/bash
aws ssm send-command \
  --instance-ids i-0d98d44a0c347bb28 \
  --document-name "AWS-RunShellScript" \
  --parameters commands="sudo cat /var/lib/jenkins/secrets/initialAdminPassword" \
  --query "Command.CommandId" \
  --output text