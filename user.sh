#!/bin/bash


#Create a group named nautilus_sftp_users in all App servers in Stratos Datacenter.
#Add the user mohammed to nautilus_sftp_users group in all App servers. (create the user if doesn't exist).


grp_name=nautilus_developers
username=rajesh

users=("tony" "steve" "banner")
hosts=("stapp01" "stapp02" "stapp03")

ssh_key(){
   echo "Generating ssh key..."
   ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
   echo "SSH key generated."
}


for ((i=0; i < ${#users[@]}; i++)); do
      user="${users[i]}"
      host="${hosts[i]}"
      echo "Copying ssh key to the remote host $host" 
      ssh-copy-id "$user"@"$host"
      echo "SSH key copied."
      ssh -t "$user"@"$host" "sudo useradd $username && usermod -aG $grp_name $username && echo '$user ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/$user"
      echo
      id $username
      echo "added to the sudoers list"
