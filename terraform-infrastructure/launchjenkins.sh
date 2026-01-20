#!/bin/bash
aws ssm start-session \
  --target i-017e82d7731eec2d8 \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'


