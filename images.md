# Images management

See [docker image](https://docs.docker.com/engine/reference/commandline/image/).

## Search for an image

    sudo docker search debian

## Pull an image

    sudo docker pull debian

> The image is pulled from [Docker Hub](https://hub.docker.com/) and added to your (local) repository.

## List the images

### Basic

    $ sudo docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    debian              latest              2d337f242f07        6 days ago          101MB
    hello-world         latest              fce289e99eb9        3 months ago        1.84kB

> You get the same result with the command `sudo docker image ls`.

### With formating

    sudo docker images --format "{{.Tag}}:{{.ID}}"

See [the list of formatting options](https://docs.docker.com/engine/reference/commandline/images/).

### With filtering

    sudo docker images --filter "dangling=true"

> This will display untagged images that are the leaves of the images tree (not intermediary layers).

See [the list of filtering options](https://docs.docker.com/engine/reference/commandline/images/).

## Delete an image

    sudo docker rmi <image ID>

Delate all dangling images:

    sudo docker rmi $(sudo docker images -f "dangling=true" -q)

## Get information about a given image

    sudo docker image inspect debian




