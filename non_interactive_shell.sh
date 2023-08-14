#!/bin/bash


host="stapp01"
user="tony"

new_usr="javed"

ssh -t "$user@$host" -o StrictHostKeyChecking=no "sudo useradd -s /sbin/nologin $new_usr && sleep 5 && echo -e && id $new_usr && echo -e"
