# Network configuration

## Typical Dockerfile

This Dockerfile will perform the following actions:

* install the SSH server.
* create a user which login is "`dev`".
* set pricate SSH keys for "`dev`" and "`root`".
* start the SSH server.

Dockerfile:

    FROM debian
    ENV DEBIAN_FRONTEND noninteractive
    RUN ["apt-get", "update"]
    RUN ["apt-get", "install", "-y", "--no-install-recommends", "apt-utils"]
    RUN ["apt-get", "install", "-y", "openssh-client"]
    RUN ["apt-get", "install", "-y", "openssh-server"]
    RUN ["apt-get", "install", "-y", "dumb-init"]
    RUN ["apt-get", "install", "-y", "wget"]
    ENV DEBIAN_FRONTEND teletype

    # Create a user "dev" with password "dev".
    RUN ["/usr/sbin/adduser", "--disabled-password", "--gecos", "dev", "dev"]
    RUN ["/bin/bash", "-c", "echo -e \"dev\\ndev\" | passwd dev"]
    RUN ["/usr/sbin/usermod", "-aG", "sudo", "dev"]

    # Install SSH key for the "root" user.
    WORKDIR /tmp
    RUN ["/usr/bin/wget", "https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/install/install_ssh_keys.sh"]
    RUN ["/bin/chmod", "+x", "install_ssh_keys.sh"]
    RUN ["/bin/bash", "-c", "/tmp/install_ssh_keys.sh"]

    # Install SSH key for the "dev" user.
    USER dev
    RUN ["/bin/bash", "-c", "/tmp/install_ssh_keys.sh"]    
    USER root

    EXPOSE 22/TCP
    ENTRYPOINT ["/usr/bin/dumb-init", "--"]
    CMD ["/bin/bash", "-c", "/etc/init.d/ssh start && /bin/bash"]

Notes:

* The tool "`dumb-init`" is as replacement for the init process. See [this document](https://github.com/Yelp/dumb-init).
* Since a container does not have an init process, you cannot configure it to "auto-start" a service as you would do with a VM. You must explicitly start the service manually within the entry point. That's the purpose of the command `CMD ["/bin/bash", "-c", "/etc/init.d/ssh start && /bin/bash"]`.
* The command `EXPOSE` does not actually configure the port forwarding between the host and the container. It acts as a documentation.
* See [Gecos fields](https://en.wikipedia.org/wiki/Gecos_field) for the creation of the user.

Build the image:

    sudo docker build -t net_test .

Run the container without any port forwarding configurations:

    sudo docker run -it --rm net_test

If you inspect the container, then you can see:

    "Ports": {
        "22/tcp": null
    }

Run the container with port forwarding configurations:

    sudo docker run -it --rm -p 2222:22/tcp net_test

If you inspect the container, then you can see:

    "Ports": {
        "22/tcp": [
            {
                "HostIp": "0.0.0.0",
                "HostPort": "2222"
            }
        ]
    }

Then you can connect to the container using [this private key](https://raw.githubusercontent.com/denis-beurive/preseed-stretch/master/data/vbox.key).

    chmod 0600 vbox.key

    ssh -o IdentitiesOnly=yes \
        -o IdentityFile=vbox.key \
        -p 2222 \
        dev@localhost 

    ssh -o IdentitiesOnly=yes \
        -o IdentityFile=vbox.key \
        -p 2222 \
        root@localhost 
