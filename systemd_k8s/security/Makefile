build:

	 DOCKER_BUILDKIT=1 docker build  -t parrot-security_s .

exec:

	docker run -it -u root -p 87:8087 --rm --privileged --workdir /usr  parrot-security_s bash
tag:

	docker tag parrot-security <your_docker_repo>

push:

	docker push <your_docker_repo>