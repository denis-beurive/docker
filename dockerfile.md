# Dockerfile

## Build

Help:

    docker help build

Give a name to the image:

    docker build [--tag <name>] .

> See [Doc](https://docs.docker.com/engine/reference/commandline/build/).

> Please note that an image is decoupled from the host environment in terms of IOs. The mappings between the host and the image, for the storage and network resources, are not done yet. These mappings will be done when a container is created from the image.

Example:

    $ docker build --tag my_image .

    $ docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    my_image            latest              3d963fe5c637        11 minutes ago      222MB

> Then you can use the newly created image "`my_image`" as a "base image" for building another image: `FORM my_image...`.

## Commands

* [ENV](env.md)
* [ENTRYPOINT](entrypoint.md)


