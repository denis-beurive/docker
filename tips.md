# Tips and tricks

Get the ID of a running container, identified by its name `$NAME`:

    docker ps --filter="name=${NAME}" --filter="status=running" --format="{{.ID}}"

Print the volume mapping between the host and the container:

    $ docker container inspect 3ea302b018f5  --format '{{range $i, $v := .Mounts}} {{- printf "%2d: %s\n    %s\n" $i (index $v "Source") (index $v "Destination") -}} {{end}}'
    
     0: /var/lib/docker/volumes/bde8ff19f38f99bca7fb4873ee48a047943512b1bc9ecd88880175a1ce104bd0/_data
        /mnt/vol1
     1: /var/lib/docker/volumes/2fcda0e24bbc64ee383a409352abbf0ce3c91480fd399e395805f2868d4fb092/_data
        /mnt/vol2

Print a container configuration:

    docker container inspect fdc63c37dd5c --format '{{range $key, $value := .Config}} {{- printf "%20s: %v\n" $key $value -}} {{end}}'

         ArgsEscaped: true
        AttachStderr: true
         AttachStdin: true
        AttachStdout: true
                 Cmd: <nil>
          Domainname: 
          Entrypoint: [/bin/sh -c bash]
                 Env: [PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin]
            Hostname: fdc63c37dd5c
               Image: volumes
              Labels: map[]
             OnBuild: <nil>
           OpenStdin: true
           StdinOnce: true
                 Tty: true
                User: 
             Volumes: map[/mnt/vol1:map[] /mnt/vol2:map[]]
          WorkingDir: 

Get the "short value" of a "long ID":

    $ long_id="fdc63c37dd5c08df912f0ff28f4cf69f063e51529bea975615f460e99ccf3f9f"
    $ shord_id=${long_id:0:12}
    $ echo $shord_id
    fdc63c37dd5c



