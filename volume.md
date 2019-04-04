# Volume

## Create / delete a volume

    $ sudo docker volume create vol1
    vol1
    $ sudo docker volume rm vol1
    vol1

## Get data about volumes

    $ sudo docker volume inspect vol1
    [
        {
            "CreatedAt": "2019-04-04T10:30:39+02:00",
            "Driver": "local",
            "Labels": {},
            "Mountpoint": "/var/lib/docker/volumes/vol1/_data",
            "Name": "vol1",
            "Options": {},
            "Scope": "local"
        }
    ]

## Get the list of available volumes

    $ sudo docker volume ls
    DRIVER              VOLUME NAME
    local               vol1

## Using volumes

Create a Dockerfile that references 2 volumes:

    FROM debian
    VOLUME /mnt/vol1 /mnt/vol2
    ENTRYPOINT bash

Build the image:

    sudo docker build -t volumes .

Be aware that the paths that follow the `VOLUME` command (`/mnt/vol1` and `/mnt/vol2`) are just mounting points, relatively to the container. These mounting points must be mapped to directories _on the host_ at start time.

This mapping can be _explicitly specified_ (by passing options to the command `docker run`). However, if the mapping is not explicitly defined, then it is implicitly done.

### Implicit mapping

We run the container without specifying the mapping:

    sudo docker run -it --name test --rm volumes

> We give the name "`test`" to the container. And the container is started in interactive mode (`-it`). We also specify that the container will be removed from the container repository while terminated `--rm`.

Let's print the directory mapping between the host and the container:

    id=$(sudo docker ps --filter="name=test" --filter="status=running" --format="{{.ID}}")

    sudo docker container inspect $id --format '{{range $i, $v := .Mounts}} {{- printf "%2d: %s\n    %s\n" $i (index $v "Source") (index $v "Destination") -}} {{end}}'

     0: /var/lib/docker/volumes/2c7cc7bb54237e6cfba7eb8c80041f6a20e9afe737ffbe53704bdb717af0cffe/_data
        /mnt/vol2
     1: /var/lib/docker/volumes/b6d7b82f717b9b54140fb2d1e3c95b26577557623ad1c6c31e063a8d09eb518b/_data
        /mnt/vol1

We can see that `/mnt/vol1` on the container is mapped to `/var/lib/docker/volumes/b6d7b82f717b9b54140fb2d1e3c95b26577557623ad1c6c31e063a8d09eb518b/_data` on the host.

As a test, let's create a file from the container shell:

    root@fd94eff09f65:/# touch /mnt/vol1/test10

Then, let's look on the host:

    $ sudo ls /var/lib/docker/volumes/b6d7b82f717b9b54140fb2d1e3c95b26577557623ad1c6c31e063a8d09eb518b/_data
    test10

### Explicit mapping

Create 2 volumes:

    $ sudo docker volume create vol1
    vol1
    $ sudo docker volume create vol2
    vol2
    $ sudo docker volume ls
    DRIVER              VOLUME NAME
    local               vol1
    local               vol2

Now, we specify the mapping between the container and the host through the command line used to start the container:

    sudo docker run -it --name test --rm --volume vol1:/mnt/vol1 --volume vol2:/mnt/vol2 volumes

Let's print the directory mapping between the host and the container:

    id=$(sudo docker ps --filter="name=test" --filter="status=running" --format="{{.ID}}")

    sudo docker container inspect $id --format '{{range $i, $v := .Mounts}} {{- printf "%2d: %s\n    %s\n" $i (index $v "Source") (index $v "Destination") -}} {{end}}'

     0: /var/lib/docker/volumes/vol1/_data
        /mnt/vol1
     1: /var/lib/docker/volumes/vol2/_data
        /mnt/vol2

Now we can see that `/mnt/vol1` is mapped to the declared volume `vol1`. And `/mnt/vol2` is mapped to the declared volume `vol2`

