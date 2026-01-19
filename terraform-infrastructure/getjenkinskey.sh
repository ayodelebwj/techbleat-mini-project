#!/bin/bash
aws ssm send-command \
  --instance-ids i-0c63a2185cadecf84 \
  --document-name "AWS-RunShellScript" \
  --parameters commands="sudo cat /var/lib/jenkins/secrets/initialAdminPassword" \
  --query "Command.CommandId" \
  --output text