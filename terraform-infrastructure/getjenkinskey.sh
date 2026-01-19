#!/bin/bash
aws ssm send-command \
  --instance-ids i-089b8ae0ffd5419d6 \
  --document-name "AWS-RunShellScript" \
  --parameters commands="sudo cat /var/lib/jenkins/secrets/initialAdminPassword" \
  --query "Command.CommandId" \
  --output text