# Containers

## Start a container

    sudo docker run [options] <name of the image>

* give a name to the container: `--name <controller name>`.
* create an _self-removing_ containter: `--rm`.
* allocate a pseudo-tty: `-t`.
* keep STDIN open **even if not attached**: `-i`.

## List the containers

    sudo docker container ls --all

## Inspect a container

    sudo docker container inspect <container ID>

