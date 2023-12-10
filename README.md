# docker-parrot

[ParrotOS Official Doc](https://parrotsec.org/docs/)

Parrot OS (Core/Security) or just Parrot Tools  in Docker with the usage of Makefile, Dockefiles and `docker-compose.yaml` for Bug Bounty, Penetration Testing, Security Research, Computer Forensics and Reverse Engineering.

For the further details how it works read the `Makefile`

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