work_dir := $(shell pwd)/work
work_dir_metasploit := $(shell pwd)/msf
work_dir_set := $(shell pwd)/set

##############  PARROT OS - CORE

# Builds up the Parrot OS - Core
build-core:
	cd core/ && DOCKER_BUILDKIT=1 docker build -t parrot-core -f Dockerfile .

# Builds up the Parrot OS - Core - Systemd
build-core-systemd:
	cd systemd_k8s/core/ && DOCKER_BUILDKIT=1 docker build -t parrot-core-systemd -f Dockerfile .

# Run Parrot OS - Core
run-core:
	docker run -it --rm --privileged --workdir /usr --network host -v  $(work_dir):/core --name parrot-core parrot-core /bin/bash
	#Example with the --network host turned off
	#docker run -it -p 87:8087 --rm --privileged --workdir /usr -v  $(work_dir):/core --name parrot-core parrot-core /bin/bash

# Run Parrot OS - Core - systemd
run-core-s:
	docker run -it --rm --privileged --workdir /usr --network host -v  $(work_dir):/core-systemd --name parrot-core-systemd parrot-core-systemd /bin/bash
	#Example with the --network host turned off
	#docker run -it --rm --privileged --workdir /usr -v  $(work_dir):/core-systemd --name parrot-core-systemd parrot-core-systemd /bin/bash

# Scan for vuln. in Parrot OS Core Docker Image
core-scan:
	trivy image parrot-core

# Scan for vuln. in Parrot OS Core systemd  Docker Image
core-s-scan:
	trivy image parrot-core-systemd

# Docker stats for Parrot OS Core Docker Image

core-stats:
	docker stats -a parrot-core

# Docker stats for Parrot OS Core systemd Docker Image

core-s-stats:
	 docker stats -a parrot-core-systemd

##############  PARROT OS - SECURITY

# Builds up the Parrot OS - Security
build-security:
	
	cd core/ && DOCKER_BUILDKIT=1 docker build -t parrot-security -f Dockerfile . 

# Builds up the Parrot OS - Core - systemd
build-security-systemd:
	cd systemd_k8s/security/ && DOCKER_BUILDKIT=1 docker build -t parrot-security-systemd -f Dockerfile .

# Run Parrot OS - Security
run-security:
	docker run -it --rm --privileged --workdir /usr --network host -v $(work_dir):/security --name parrot-security parrot-security /bin/bash
	#Example with the --network host turned off
	#docker run -it -p 87:8087 --rm --privileged --workdir /usr -v  $(work_dir):/security  --name parrot-security parrot-security /bin/bash

# Run Parrot OS - Security - systemd
run-security-s:
	docker run -it --rm --privileged --workdir /usr --network host -v $(work_dir):/security-systemd --name parrot-security-systemd parrot-security-systemd /bin/bash
	#Example with the --network host turned off
	#docker run -it --rm --privileged --workdir /usr -v  $(work_dir):/security-systemd --name parrot-security-systemd parrot-security-systemd /bin/bash

# Scan for vuln. in Parrot OS Security Docker Image
security-scan:
	trivy image parrot-security

# Scan for vuln. in Parrot OS Security systemd Docker Image
security-s-scan:
	trivy image parrot-security-systemd

# Docker stats for Parrot OS Security Docker Image

security-stats:
	docker stats -a parrot-security

# Docker stats for Parrot OS Security systemd Docker Image

security-s-stats:
	docker stats -a parrot-security-systemd

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

##############  K8s - Kind cluster

cc:
	kind create cluster --config=kind/config.yaml

# Deletes Kind cluster

dc:
	kind delete cluster