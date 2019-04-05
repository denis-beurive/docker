# Dockerfile

## Build

Help:

    docker help build

Give a name to the image:

    docker build [--tag <name>] .

> See [Doc](https://docs.docker.com/engine/reference/commandline/build/).

Example:

    $ docker build --tag my_image .

    $ docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    my_image            latest              3d963fe5c637        11 minutes ago      222MB

> Then you can use the newly created image "`my_image`" as a "base image" for building another image: `FORM my_image...`.

## Commands

* [ENV](env.md)
* [ENTRYPOINT](entrypoint.md)


