# docker-parrot

[ParrotOS Official Doc](https://parrotsec.org/docs/)

Parrot OS (Core/Security) or just Parrot Tools  in Docker with the usage of Makefile, Dockefiles and `docker-compose.yaml` for Bug Bounty, Penetration Testing, Security Research, Computer Forensics and Reverse Engineering.

For the further details how it works read the `Makefile`

## Installation of Trivy

[Trivy](https://trivy.dev) installation for Docker Image vulnerabilities:

If you are not using Debian/Ubuntu, read [docs](https://aquasecurity.github.io/trivy/v0.18.3/installation/)

One liner to install [Trivy](https://trivy.dev) by specific version (Linux/Ubuntu):

```bash
TRIVY_VERSION=0.44.0; curl -sSLO https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.deb && sudo dpkg -i trivy_${TRIVY_VERSION}_Linux-64bit.deb
```

Trivy usage:

```bash
trivy image <image>
```

### Installing Docker + Docker compose

Install Docker engine by your way you or you can install it by shell script:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh; sudo sh get-docker.sh; rm -rf get-docker.sh

#Permissions:
sudo usermod -aG docker $USER
newgrp docker
```

Docker compose installation (latest release), it is expected you're using only docker compose v2! Used version of **docker-compose.yaml** is **3.8**

```bash
mkdir -p ~/.docker/cli-plugins/; DOCKER_COMPOSE=2.20.2; curl -SL https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE}/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose; chmod +x ~/.docker/cli-plugins/docker-compose #permission

docker compose version #verify
```

## Local development

```bash
# Builds up the Parrot OS - Core
make build-core
# Run Parrot OS - Core
make run-core
# Scan for vuln. in Parrot OS Core Docker Image
make core-scan
# Docker stats for Parrot OS Core Docker Image
make core-stats
# Builds up the Parrot OS - Security
make build-security
# Run Parrot OS - Security
make run-security
# Scan for vuln. in Parrot OS Security Docker Image
make core-scan
# Docker stats for Parrot OS Security Docker Image
make core-stats
# Run Parrot Tools Docker image (read Makefile) - Nmap
make nmap
# Run Parrot Tools Docker image (read Makefile) - metasploit 
make metasploit
# Run Parrot Tools Docker image (read Makefile) - set 
make pset
# Run Parrot Tools Docker image (read Makefile) - bettercap 
make bettercap
# Run Parrot Tools Docker image (read Makefile) - sqlmap 
make sqlmap


## Docker compose:

# Starts ParrotOS Core & Parrot OS Security docker compose services defined in docker-compose.yaml
make up
# Stops and Removes ParrotOS Core & Parrot OS Security docker compose services defined in docker-compose.yaml
make down


## Cleaning

# Removes Volumes 
make rm-volumes
# Stop/remove all docker images
make rmrf
# Docker prune
make prune
# Docker volume prune
make volume-prune
```