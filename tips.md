# Tips and tricks

Get the ID of a running container, identified by its name `$NAME`:

    sudo docker ps --filter="name=${NAME}" --filter="status=running" --format="{{.ID}}"

Print the volume mapping between the host and the container:

    $ sudo docker container inspect 3ea302b018f5  --format '{{range $i, $v := .Mounts}} {{- printf "%2d: %s\n    %s\n" $i (index $v "Source") (index $v "Destination") -}} {{end}}'
    
     0: /var/lib/docker/volumes/bde8ff19f38f99bca7fb4873ee48a047943512b1bc9ecd88880175a1ce104bd0/_data
        /mnt/vol1
     1: /var/lib/docker/volumes/2fcda0e24bbc64ee383a409352abbf0ce3c91480fd399e395805f2868d4fb092/_data
        /mnt/vol2





