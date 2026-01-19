#!/bin/bash
aws ssm start-session \
  --target i-089b8ae0ffd5419d6 \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'