#!/bin/bash

export green="\033[1;32m"
reset=`tput sgr0`

echo -e "${green}$f Updating Deps...${reset}"

apt update

echo -e "${green}$f Adding Docker...${reset}"

sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update

echo -e "${green}$f Installing Docker...${reset}"

apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl start docker

echo -e "${green}$f Adding Docker Compose...${reset}"

sudo curl -L https://github.com/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e "${green}$f Creating Docker reverse-proxy...${reset}"

sudo docker network create reverse-proxy

echo -e "${green}$f Setupping Portainer...${reset}"

docker volume create portainer_data

#docker run -d --name portainer -p 9000:9000 -p 8000:8000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
docker run -d -p 9001:9001 --name portainer_agent --restart=always -v \\.\pipe\docker_engine:\\.\pipe\docker_engine portainer/agent:2.6.3

echo -e "${green}$f Finish...${reset}"
