work_dir := $(shell pwd)/work
work_dir_metasploit := $(shell pwd)/msf
work_dir_set := $(shell pwd)/set

##############  PARROT OS - CORE

# Builds up the Parrot OS - Core
build-core:
	cd core/ && docker build -t parrot-core -f Dockerfile .

# Run Parrot OS - Core
run-core:
	docker run -it --rm --privileged --workdir /usr --network host -v  $(work_dir):/core  --name parrot-core kali /bin/bash
	#Example with the --network host turned off
	#docker run -it -p 87:8087 --rm --privileged --workdir /usr -v  $(work_dir):/security  --name parot-core kali /bin/bash

# Scan for vuln. in Parrot OS Core Docker Image
core-scan:
	trivy image parrot-core

# Docker stats for Parrot OS Core Docker Image

core-stats:
	docker stats -a parrot-core



##############  PARROT OS - SECURITY

# Builds up the Parrot OS - Security
build-security:
	cd core/ && docker build -t parrot-security -f Dockerfile . 

# Run Parrot OS - Security
run-security:
	docker run -it --rm --privileged --workdir /usr --network host -v  $(work_dir):/security  --name parrot-core kali /bin/bash
	#Example with the --network host turned off
	#docker run -it -p 87:8087 --rm --privileged --workdir /usr -v  $(work_dir):/security  --name parot-core kali /bin/bash

# Scan for vuln. in Parrot OS Security Docker Image
core-scan:
	trivy image parrot-security

# Docker stats for Parrot OS Security Docker Image

core-stats:
	docker stats -a parrot-core



############## PARROT - OS - Individual tools

nmap:
	docker run -it --rm --privileged --workdir /usr --network host -v  $(work_dir):/pnmap  --name nmap parrotsec/nmap -f localhost

metasploit:
	 docker run -it --rm --privileged --workdir /usr --network host -v  $(work_dir_metasploit):/root/ --name msf parrotsec/metasploit

pset:
	docker run -it --rm --privileged --workdir /usr --network host -v $(work_dir_set):/root/.set parrotsec/set --name set parrotsec/set

bettercap:
	docker run -it --rm --privileged --workdir /usr --network host parrotsec/bettercap

sqlmap:
	# Usage
	docker run -it --rm --privileged --workdir /usr parrotsec/sqlmap <sqlmap options>
	# Example
	docker run --rm -ti parrotsec/sqlmap -u parrotsec.org --wizard

############## DOCKER COMPOSE:

# Start all services from docker-compose.yaml

up:
	docker compose up -d --build

down:
	docker compose down -v --rmi all


##############  CLEAN:

# Removes Docker volumes
rm-volumes:
	rm -rf core/ security/ pnmap/ msf/; sudo chown $(shell whoami):$(shell whoami) ./set; rm -rf set/

# Stop and remove all docker images
rmrf:
	docker stop $$(docker ps -q) && docker rm $$(docker ps -aq)

# Docker system prune, option "-a" removes all unused images, not only dangling images
prune:
	docker system prune -a

# Docker volume prune, removes all unused volumes
volume-prune:
	docker volume prune -f