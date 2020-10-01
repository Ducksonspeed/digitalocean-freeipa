#!/bin/bash

## This is a lightweight install script to install Ansible & terraform within a python virtual environment.
## To change install location, simply change the path within the $dir variable.
## To Change terraform version change $link variable.



## VARIABLES ##

## Customisable install location
dir="$HOME/ansible-play"

## Username lookup
usr=$(echo "$HOME" | cut -d "/" -f3)

## Terraform link
link="https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip"

## FUNCTIONS ##

## Function to setup virtual environment and install Ansible within
setup_venv_ansible () {

        ## Setup virtual environment
        virtualenv venv 
        source venv/bin/activate
        ## Install Ansible packages
        pip3 install --upgrade pip
        pip3 install ansible
		

	add_ansible_go
}


## Function to add ansible-go command to global .bashrc
add_ansible_go () {

	## Add ansible-go alias into .bashrc file
	sudo echo "alias ansible-go='cd $dir && source venv/bin/activate'" >> ~/.bashrc
	## Source .bashrc file to enable instant use of ansible-go command
	source ~/.bashrc


	setup_terraform
}

## Install Terraform within the Virtual Environment
setup_terraform () {


	cd "$dir"
	wget "$link" -O terraform.zip && unzip terraform.zip
	rm terraform.zip
	## Moves terraform into Virtual environments package manger's bin
	sudo mv terraform /snap/bin/terraform
	 

}

## MAIN ##

## Checks if install directory exists
if [ ! -d "$dir" ]
then

	## Makes install directory and CD into it
	mkdir "$dir"
	cd "$dir"
	## Install dependencies and create empty hosts file for later use
	sudo apt -y update && apt-get -y upgrade
	sudo apt install -y python3 python3-dev python3-virtualenv python3-pip unzip git
	touch hosts
	## Setup virtual environment and install Ansible
	setup_venv_ansible

else
	## CD to install directory
	cd "$dir"
	## If install directory already exists, check status of hosts file
	if [ ! -f "$dir/hosts" ]
	then
		## If no hosts file is found, make one
		touch hosts
	fi

	## Checks if virtual environment environmental variable has been set
	if [ ! -d "$dir/venv" ]
	then
                ## Setup virtual environment and install Ansible
                setup_venv_ansible
	else
                ## Upgrade Ansible if new updates available
                source venv/bin/activate
                pip3 install --upgrade ansible
	fi
fi

## Always make sure directory belongs to current user instead of root (if using non root user
if [[ ! -z "$usr" ]]
then
	sudo chown -R "$usr":"$usr" "$dir"
fi