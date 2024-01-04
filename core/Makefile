build:
	 DOCKER_BUILDKIT=1 docker build  -t parrot-core .

exec:
	docker run -it -u root parrot-core bash

tag:
	docker tag parrot-core <your_docker_repo>

push:
	docker push <your_docker_repo>