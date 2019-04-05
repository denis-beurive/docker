# Docker

## Definitions

### Image

A _Docker image_ is a file, comprised of multiple layers, used to execute code in a Docker container.

A Docker image is the result of a [build](https://docs.docker.com/engine/reference/commandline/build/) (defined by a Dockerfile). The build process takes:

* an existing (Docker) "base image" as a basis.
* a set of _commands_ that will be applied on the specified "base image".

> Please note that the result of a build is a Docker image that can, in turn, be used as a (Docker) "base image" for another build.

> A catalogue of (Docker) "base images" is available [here](https://hub.docker.com/).

### Container

From a functional perspective, a _Docker container_ is a _preconfigured executable image_.

Usually a container is created when an image is _executed_: `docker run...`. However, a container can be created before being executed: `docker create...`. A container can also be restarted (even while it is executing): `docker restart...`.

To give the analogy with what occurs within an operating system, we could say that:

* the image is an executable file.
* the container is an executable file (an image) _along with its configuration_.

> However, unlike what happens within an operating system, the Docker daemon that orchestrates the container executions keeps data about all executions.

A container differs from a virtual machine (VM), which encapsulates an entire OS with the executable code atop an abstraction layer from the physical hardware resources.

> Please note that a container can use a persistent storage (typically, a directory within the host file system), but this persistent storage is not part of the container itself (the container accesses the persistent storage through an intermediary).

### Volume

As said earlier, due to their nature, containers cannot be used to store persistent data.

Volumes are one way to store persistent data (that will remain available after the container execution).

> Other ways are "_bind mounts_" and "_tmpfs mount_". See [this link](https://docs.docker.com/storage/).

![Volume vs Bind mount vs Tmpfs mount](https://docs.docker.com/storage/images/types-of-mounts.png)

Volumes are created explicitly using the _docker command line tool_ (`docker volume create`), on the host.

And the path mapping between the host and the container is done (_explicitly or implicitly_) when the container is created (`docker create...` or `docker run ...`). If no volume is explicitly specified during the creation of the process, then the Docker Daemon automatically creates and maps volumes.

### Dockerfile

A **Dockerfile** is a file that describes how to build a Docker image.

It contains:

* the name of an existing (Docker) "base image" as a basis.
* a set of _procedures_ that will be applied on the specified "base image".

## Notes

* [Installation](install.md)
* [Images management](images.md)
* [Dockerfile](dockerfile.md)
* [Container](container.md)
* [Volumes](volume.md)
* [Formating outputs](format.md)
* [Tips and tricks](tips.md)
* [Troubleshooting](troubleshooting.md)

## Links

* [Docker Hub](https://hub.docker.com/): catalog of images.
* [Docker image](https://searchitoperations.techtarget.com/definition/Docker-image): good introduction to Docker.






