# Docker overview

* Docker is an open platform for developing, shipping, and running applications. 
* Docker enable us to separate applications from the infrastructure so we can deliver software quickly.

* Author: [Solomon Hykes](https://www.linkedin.com/in/solomonhykes/)
* Initial release: March 13, 2013
* [Stable release](https://docs.docker.com/engine/release-notes/): 18.09.0/ November 8, 2018

* Repository: [github.com/docker/docker-ce](https://github.com/docker/docker-ce)
* Language: Go

* Operating system:	Linux, Windows, macOS

## The Docker platform

* Docker provides the ability to package and run an application in a loosely isolated environment called a **container**. 
* The isolation and security allow us to run many containers simultaneously on a given host. 
* Containers are lightweight because they don’t need the extra load of a hypervisor, but run directly within the host machine’s kernel. 
* We can run more containers on a given hardware combination than if we were using virtual machines. 
* We can even run Docker containers within host machines that are actually virtual machines!

## Benefits of docker containers:

1. Containers offer a logical packaging mechanism in which applications can be abstracted from the environment in which they actually run. This the key benefit of Docker which allows users to package an application with all of its dependencies into a standardized unit for software development.
2. Decoupling allows container-based applications to be deployed easily and consistently, regardless of whether the target environment is a private data center, the public cloud, or even a developer’s personal laptop. This gives developers the ability to create predictable environments that are isolated from rest of the applications and can be run anywhere.
3. Unlike virtual machines, containers do not have the high overhead and hence enable more efficient usage of the underlying system and resources.
4. From an operations standpoint, apart from portability containers also give more granular control over resources giving your infrastructure improved efficiency which can result in better utilization of the compute resources.
5. Docker is lightweight and fast. It provides a viable, cost-effective alternative to hypervisor-based virtual machines.

## Docker container vs VMs

![VM vs docker](img/vmvs_docker.jpeg)

### Docker Engine

Docker Engine is a client-server application with these major components:

* A server which is a type of long-running program called a daemon process (the dockerd command).
* A REST API which specifies interfaces that programs can use to talk to the daemon and instruct it what to do.
* A command line interface (CLI) client (the docker command).

* The CLI uses the Docker REST API to control or interact with the Docker daemon through scripting or direct CLI commands. Many other Docker applications use the underlying API and CLI.
* The daemon creates and manages Docker objects, such as images, containers, networks, and volumes.

![Docker engine](img/docker_engine.jpeg)

## Docker architecture

* Docker uses a client-server architecture. 
* The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing Docker containers. 
* The Docker client and daemon can run on the same system, or we can connect a Docker client to a remote Docker daemon. 
* The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface.

![docker arch](img/docker_arch.jpeg)

1. **Docker Daemon**
    * The Docker daemon (dockerd) listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. 
    * A daemon can also communicate with other daemons to manage Docker services.

2. **The Docker client**
    * The Docker client (docker) is the primary way that many Docker users interact with Docker. 
    * Docker client sends docker commands to dockerd, which carries them out.
    * The docker command uses the Docker API. 
    * _The Docker client can communicate with more than one daemon._
3. **Docker registries**
    * A Docker registry stores Docker images
    * Docker Hub is a public registry that anyone can use, and Docker is configured to look for images on Docker Hub by default.
    * `docker pull` or `docker run` commands,  pull required images form configured registry. When we use the `docker push` command, the image is pushed to configured registry.    


## Docker objects
1. Images
2. Containers
3. Services
4. Networks
5. Volumes
6. Plugins

### Docker Images

* An image is a read-only template with instructions for creating a Docker container. 
* Often, an image is based on another image, with some additional customization.
* To build a image, we create a **Dockerfile** with a simple syntax for defining the steps needed to create the image and run it. 
* Each instruction in a Dockerfile creates a layer in the image. 
* When we change the Dockerfile and rebuild the image, only those layers which have changed are rebuilt. This is part of what makes images so lightweight, small, and fast, when compared to other virtualization technologies.

### Containers

* A container is a runnable instance of an image. 
* We can create, start, stop, move, or delete a container using the Docker API or CLI. 
* We can connect a container to one or more networks, attach storage to it, or even create a new image based on its current state.
* By default, a container is relatively well isolated from other containers and its host machine. 
* We can control how isolated a container’s network, storage, or other underlying subsystems are from other containers or from the host machine.

* When a container is removed, any changes to its state that are not stored in persistent storage disappear.

##### Example:

`$ docker run -i -t ubuntu /bin/bash`

When we run this command, the following happens:

- If we do not have the ubuntu image locally, Docker pulls it from configured registry, as though we had run docker pull ubuntu manually.
- Docker creates a new container, as though we had run a docker container create command manually.
- Docker allocates a read-write filesystem to the container, as its final layer. This allows a running container to create or modify files and directories in its local filesystem.
- Docker creates a network interface to connect the container to the default network, since we did not specify any networking options. This includes assigning an IP address to the container. _By default, containers can connect to external networks using the host machine’s network connection._
- Docker starts the container and executes /bin/bash. Because the container is running interactively and attached to your terminal (due to the -i and -t flags), we can provide input using keyboard while the output is logged to your terminal.
- When we type exit to terminate the /bin/bash command, the container stops but is not removed. We can start it again or remove it.

### Services

* Services allows to scale containers across multiple Docker daemons, which all work together as a swarm with multiple managers and workers. 
* Each member of a swarm is a Docker daemon, and the daemons all communicate using the Docker API. 
* A service allows us to define the desired state, such as the number of replicas of the service that must be available at any given time. _By default, the service is load-balanced across all worker nodes._









