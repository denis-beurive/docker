#!/usr/bin/env bash
#
# Please, make sure to source the file "container.sh" first.

type __functions_container &>/dev/null
if [ $? -eq 1 ]; then
    echo 
    echo "WARNING !!! The functions defined in this file need the ones defined in the file \"container.sh\"."
    echo 
fi

function delete_all_images() {
    kill_containers
    delete_all_stopped_containers
    local -r ids=$(docker images -a -q)
    if [ ! -z "${ids}" ]; then
        docker rmi "${ids}"
    fi
}

