#!/bin/bash
aws ssm start-session \
  --target i-070004020715cd7b6 \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'