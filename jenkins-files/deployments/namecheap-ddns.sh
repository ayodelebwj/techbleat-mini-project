#!/bin/bash

DOMAIN="lennipsss.org"
HOST="@"
DDNS_PASS="6ce19656be3d4fc1912474be7c228aeb"

IP=$(curl -s https://api.ipify.org)

curl "https://dynamicdns.park-your-domain.com/update?host=$HOST&domain=$DOMAIN&password=$DDNS_PASS&ip=$IP"