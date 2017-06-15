#!/bin/bash

HOST="demo.res.ch"

if [ -z ${WINDIR+x} ]
then
    START_UTILITY=xdg-open
else
    START_UTILITY=start
fi

function show_help {
    echo "$1 is not a valid argument"
    echo "The parameter can be \"step1\""
}

function stop_all {
    echo "Stopping all launched container"
    docker kill $(docker ps -aq)
    docker rm $(docker ps -aq)
}

function start_step1 {
    local port=9090
    
    echo "Starting step 1"
    docker build -t res/apache_php ./docker-images/apache-php-image
    docker run -d --name apache_static -p $port:80 res/apache_php
    BROWSER "http://$HOST:$port"
}

## Main
error=false

case $1 in
    "step1" ) start_step1
        ;;
    * ) error=true; show_help
esac

read -p "Press any key to close all docker container ..."

if ! $error
then
    stop_all
fi