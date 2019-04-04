# Troubleshooting

## Check that Docker is running

    $ ps awx | egrep 'dockerd\s'
    11183 ?        Ssl    0:13 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

