# Docker

## Definitions

### Image

A **Docker image** is a file, comprised of multiple layers, used to execute code in a Docker container.

A Docker image is the result of a [build](https://docs.docker.com/engine/reference/commandline/build/) (defined by a Dockerfile). The build process takes:

* an existing (Docker) "base image" as a basis.
* a set of _procedures_ that will be applied on the provided "base image".

> Please note that the result of a build is a Docker image that can, in turn, be used as a (Docker) "base image" for another build.

> A catalogue of (Docker) "base images" is available [here](https://hub.docker.com/).

### Container

From a functional perspective, a Docker container is the execution of an _image_.

Technically, a container is:

* a [process](https://en.wikipedia.org/wiki/Process_(computing)) which runs on a host.
* a set of properties that make sense in a Docker perspective (for example, the state of the process - `running`, `exited`...).

A container differs from a virtual machine (VM), which encapsulates an entire OS with the executable code atop an abstraction layer from the physical hardware resources.

Please note that, basically, a Docker container is a _[process](https://en.wikipedia.org/wiki/Process_(computing))_.

* A process can use a persistent storage (typically, a file system), but this persistent storage is not part of the process itself (the process accesses the persistent storage through an intermediary).
* A process starts, executes and stops. Once stopped, the memory allocated by the OS for the process is freed, and nothing remains of the process.
* Unless specifically designed otherwise, multiple instances of the same process can be executed simultaneously.
* A process can be attached or detached from the terminal.

> If you start a,"`bash`" process on a Debian container, then you may think that what you see is a virtual machine. Thus, you may think that you can install software using the Debian packages manager (ex: `apt-get install vim`). However, once the container terminates its execution, nothing remains of your activity.

### Volume

As said earlier regarding Docker containers, containers are just processes. Due to their nature, containers cannot be used to store persistent data.

Volumes are one way to store persistent data (that will remain available after the container execution).

> Other ways are "_bind mounts_" and "_tmpfs mount_". See [this link](https://docs.docker.com/storage/).

![Volume vs Bind mount vs Tmpfs mount](https://docs.docker.com/storage/images/types-of-mounts.png)

Volumes are created using the _docker command line tool_ (`docker volume create`), on the host. And the path mapping between the host and the container is done (_explicitly or implicitly_) when the container is started through the _docker command line tool_ (`docker run ...`).

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






