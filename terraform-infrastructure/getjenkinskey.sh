#!/bin/bash
aws ssm send-command \
  --instance-ids i-070004020715cd7b6 \
  --document-name "AWS-RunShellScript" \
  --parameters commands="sudo cat /var/lib/jenkins/secrets/initialAdminPassword" \
  --query "Command.CommandId" \
  --output text