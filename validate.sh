#!/bin/bash

HOST="demo.res.ch"

function stop_all {
    echo "Stopping all launched container"
    docker kill $(docker ps -aq)
    docker rm $(docker ps -aq)
}

function validate {
    local site_port=8080
    local monitor_port=9090
    
    echo "Beginning validation of the entire infrastructure"
    
    docker build -t res/apache_php ./docker-images/apache-php-image
    docker run -d --name apache_static res/apache_php
    docker run -d res/apache_php
    
    docker build -t res/express_addresses ./docker-images/express-image
    docker run -d --name express_dynamic res/express_addresses
    docker run -d res/express_addresses

    docker build -t res/traefik ./docker-images/traefik 
    docker run -d --name traefik -p $monitor_port:8080 -p $site_port:80 -v /var/run/docker.sock:/var/run/docker.sock res/traefik

    start "http://$HOST:$site_port/"
    start "http://$HOST:$monitor_port/"
    docker attach traefik
}

# Main
validate
read -p "Press any key to close all docker container ..."
stop_all