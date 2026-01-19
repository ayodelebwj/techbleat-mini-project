#!/bin/bash
aws ssm start-session \
  --target i-0c63a2185cadecf84 \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'