#!/bin/bash

HOST="demo.res.ch"

if [ -z ${WINDIR+x} ]; then BROWSER=xdg-open; else BROWSER=start; fi

function show_help {
    echo "$1 is not a valid argument"
    echo "The parameter can be \"step1\",\"step2\" or \"step3\""
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

function start_step2 {    
    local port=3000
    
    echo "Starting step 2"
    docker build -t res/express_addresses ./docker-images/express-image
    docker run -d --name express_dynamic -p $port:3000 res/express_addresses
    BROWSER "http://$HOST:$port/"
}

function start_step3 {
    local port=8080
    
    echo "Starting step 3"
    echo "Do not forget to add $HOST to your hosts file for correct DNS resolving."
    
    docker build -t res/apache_php ./docker-images/apache-php-image
    docker run -d --name apache_static res/apache_php

    docker build -t res/express_addresses ./docker-images/express-image
    docker run -d --name express_dynamic res/express_addresses
    
    docker build -t res/apache_rp ./docker-images/apache-reverse-proxy
    docker run -d --name apache_rp -p $port:80 res/apache_rp
    BROWSER "http://$HOST:$port/"
    BROWSER "http://$HOST:$port/api/addresses/"
}

## Main
error=false

case $1 in
    "step1" ) start_step1
        ;;
    "step2" ) start_step2
        ;;
    "step3" ) start_step3
        ;;
      * ) error=true; show_help
esac

read -p "Press any key to close all docker container ..."

if ! $error
then
    stop_all
fi