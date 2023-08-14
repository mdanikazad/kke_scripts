
: '
sudo useradd mohammed
sudo groupadd nautilus_developers
sudo usermod -a -G nautilus_developers mohammed

steps involved

- ssh to the server
- have enough privileges to run the command
- create user
- create group
- add user into the newly created group
- validate the task you've just completed.
'


#!/bin/bash

# List of servers
servers=("stapp01" "stapp02" "stapp03")

# Usernames for each server (in the same order as servers)
users=("tony" "steve" "banner")

# Command to run on each server with sudo
#sudo_command="your_sudo_command_here"

# User and group to be created
usr="kano"
grp="nautilus_sftp_users"


# SSH key generation
echo "Generating ssh key..."
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
echo "SSH key generated."

# Loop through servers, copy the SSH key, and run commands
for ((i = 0; i < ${#servers[@]}; i++)); do
  server="${servers[$i]}"
  user="${users[$i]}"
  password="${passwords[$i]}"

  echo "Connecting to $user@$server..."

  # Copy SSH key using sshpass
  sshpass -p "$password" ssh-copy-id -o StrictHostKeyChecking=no "$user@$server"
  echo "SSH key copied to $server"

  # SSH and run the command with sudo
  ssh -t "$user@$server" "sudo useradd $usr && sudo groupadd $grp && sudo usermod -a -G $grp $usr"
  echo
  echo "$usr created and $usr added to the $grp" 
  echo 
done
