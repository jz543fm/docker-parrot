build:
	 DOCKER_BUILDKIT=1 docker build  -t parrot-core_s .

exec:
	docker run -it -u root -p 88:8088 --rm --privileged --workdir /usr  parrot-core_s bash

tag:
	docker tag parrot-core_s <your_docker_repo>

push:
	docker push <your_docker_repo>