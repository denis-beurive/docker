# Installation

Read [this document](https://docs.docker.com/install/linux/docker-ce/debian/).

Install Docker:

    sudo apt-get update

    sudo apt-get install \
         apt-transport-https \
         ca-certificates \
         curl \
         gnupg2 \
         software-properties-common


    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable"

    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io

Test the installation:

    sudo docker run hello-world

Enable Docker to start à boot time:

    systemctl enable docker

