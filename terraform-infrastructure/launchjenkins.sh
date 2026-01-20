#!/bin/bash
aws ssm start-session \
  --target i-00c73a6464af6954c \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'


