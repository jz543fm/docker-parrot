FROM parrotsec/security

#https://github.com/moby/moby/issues/27988
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update

RUN apt-get install -y wget curl net-tools whois netcat-traditional pciutils bmon htop tor

#Sets WORKDIR to /usr

WORKDIR /usr

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]