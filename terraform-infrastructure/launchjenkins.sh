#!/bin/bash
aws ssm start-session \
  --target i-0d98d44a0c347bb28 \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'