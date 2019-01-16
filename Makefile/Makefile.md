# Makefile

- `make` is a utility for building and maintaining groups of programs (and other types of files) from source code.

* The advantages of `make` over scripts is that we can specify the relationships between the elements of our program to make, and it knows through these relationships and timestamps exactly what steps need to be redone to produce the desired program each time. 
* Using this information, make can also optimize the build process avoiding unnecessary steps.

Sample Makefile:

```
jenkins:
	docker run -d biharimukund/jenkins
```    

Executing `make`:

```
$ make
docker run -d biharimukund/jenkins
68bc5f318a769913b4e8019331d971681a151de1deb63e3e8d2de49414499240

$ docker ps
CONTAINER ID        IMAGE                  COMMAND                  CREATED              STATUS              PORTS                 NAMES
68bc5f318a76        biharimukund/jenkins   "/bin/tini -- /usr/l…"   19 seconds ago       Up 18 seconds       8080/tcp, 50000/tcp   frosty_morse

```

## Targets and Prerequisites

* Essentially a makefile contains a set of rules used to build an application. 
* The first rule seen by make is used as the default rule. 
* A rule consists of three parts: 
    - **target:** file or thing that must be made.
    - **prerequisites:**  files that must exist before the target can be successfully created. 
    - **command(s):** shell commands that will create the target from the prerequisites.

    ```
    target: prereq1 prereq2
        commands
    ```   
```
```
jenkins: Dockerfile
	docker build -t biharimukund/jenkins .
```            




