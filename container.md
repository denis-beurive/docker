# Containers

## Create a container

    docker create [OPTIONS] IMAGE [COMMAND] [ARG...]

> See [doc](https://docs.docker.com/engine/reference/commandline/create/).

The following example shows how to create a container from an image.

    $ docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    volumes             latest              b38384b4a584        23 hours ago        101MB
    debian              latest              2d337f242f07        9 days ago          101MB
    hello-world         latest              fce289e99eb9        3 months ago        1.84kB

    $ docker create -it --name test1 --rm --volume vol1:/mnt/vol1 volumes
    fdc63c37dd5c08df912f0ff28f4cf69f063e51529bea975615f460e99ccf3f9f

    $ docker container ls --all --filter='ID=fdc63c37dd5c08df912f0ff28f4cf69f063e51529bea975615f460e99ccf3f9f'
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    fdc63c37dd5c        volumes             "/bin/sh -c bash"   2 minutes ago       Created                                 test1

> Please note the state of the container: `Created`.

You can check the container configuration:

    $ docker container inspect fdc63c37dd5c --format '{{range $key, $value := .Config}} {{- printf "%20s: %v\n" $key $value -}} {{end}}'

         ArgsEscaped: true
        AttachStderr: true
         AttachStdin: true
        AttachStdout: true
                 Cmd: <nil>
          Domainname: 
          Entrypoint: [/bin/sh -c bash]
                 Env: [PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin]
            Hostname: fdc63c37dd5c
               Image: volumes
              Labels: map[]
             OnBuild: <nil>
           OpenStdin: true
           StdinOnce: true
                 Tty: true
                User: 
             Volumes: map[/mnt/vol1:map[] /mnt/vol2:map[]]
          WorkingDir: 

Once the container has been created, you can execute it:

    $ docker start fdc63c37dd5c
    fdc63c37dd5c

Please note that, although the container has been created with the options "-it", it actually executes in the background.

To attach the container to the terminal, run the command below:

    docker attach fdc63c37dd5c

    $ docker container ls --all --filter='ID=fdc63c37dd5c'
    [sudo] password for dev: 
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    fdc63c37dd5c        volumes             "/bin/sh -c bash"   37 minutes ago      Up 4 minutes                            test1

> The state of the container is now "Up".

## Create a container and run it

    docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]

> See [doc](https://docs.docker.com/engine/reference/run/).

This command performs:

* the creation of the container: `docker create ...`.
* the start of the container: `docker start ...`.

## Start a container

There are 3 ways to start a container execution:

* `docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]`. [doc](https://docs.docker.com/engine/reference/run/).
* `docker container start [OPTIONS] CONTAINER [CONTAINER...]`. [doc](https://docs.docker.com/engine/reference/commandline/container_start/).
* `docker container restart [OPTIONS] CONTAINER [CONTAINER...]`. [doc](https://docs.docker.com/engine/reference/commandline/container_restart/).

Description:

* The first command creates a container from an image and immediately runs it.
* The second command starts a container that has already been created (using `docker create...`). [doc](https://docs.docker.com/engine/reference/commandline/create/).
* The third command restart a container (that may be still running). Please note that, when restarting a container, you cannot change the container configuration.

Useful options:

* give a name to the container: `--name <controller name>`.
* create an _self-removing_ containter: `--rm`. The container, while executed, does not remains into the container repository.
* allocate a pseudo-tty: `-t`.
* keep STDIN open **even if not attached**: `-i`.

## List the containers

    docker container ls --all

Get only the ID:

     docker container ls --all --format  "{{.ID}}"

> See the list of variables to use with `--format`: [Format the output (--format)](https://docs.docker.com/engine/reference/commandline/ps/#format)

## Inspect a container

    docker container inspect <container ID>

## Attach a container to the terminal

    docker attach <container ID>

## Delete a container

    docker rm <container ID>

## Delete all container

    docker rm $(docker container ls --all --format  "{{.ID}}")

