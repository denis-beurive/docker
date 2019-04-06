#!/usr/bin/env bash

function __functions_container() {
    :
}

function delete_created_containers() {
    local -r pids=$(docker ps --filter="status=created" -q)
    if [ ! -z "${pids}" ]; then
        docker rm ${pids}        
    fi
}

function delete_exited_containers() {
    local -r pids=$(docker ps --filter="status=exited" -q)
    if [ ! -z "${pids}" ]; then
        docker rm ${pids}        
    fi
}

function delete_all_stopped_containers() {
    local -r pids=$(docker ps -a -q)
    if [ ! -z "${pids}" ]; then
        docker rm ${pids}        
    fi
}

function kill_containers() {
    local -r pids=$(docker ps --filter="status=running" -q)
    if [ ! -z "${pids}" ]; then
        docker kill ${pids}        
    fi
}