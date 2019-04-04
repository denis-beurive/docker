
# ENV

## Description

`ENV`: define an environment variable. See [Environment replacement](https://docs.docker.com/engine/reference/builder/#Environment%20replacement). **Please note that these environment variables cannot be used with all Dockerfile commands**. In particular, it cannot be used with commands such as `ENTRYPOINT`, `RUN` or `CMD` (for example).

## Example

In this example, we set the environment variable `DEBIAN_FRONTEND` that will influence the execution of the command `apt-get install`.

    $ cat Dockerfile 
    FROM debian
    ENV DEBIAN_FRONTEND noninteractive
    RUN ["apt-get", "update"]
    RUN ["apt-get", "install", "-y", "--no-install-recommends", "apt-utils"]
    RUN ["apt-get", "install", "-y", "apache2"]
    ENV DEBIAN_FRONTEND teletype

> If we did not set the environment variable, then we would have written: `RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2`

Build:

    sudo docker build .
    ...
    Successfully built 18a61ce02991

Then check:

    $ sudo docker image ls | grep 18a61ce02991
    <none>              <none>              18a61ce02991        2 minutes ago       222MB

