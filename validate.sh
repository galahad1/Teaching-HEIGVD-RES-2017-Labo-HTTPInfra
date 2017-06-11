#!/bin/bash

HOST="demo.res.ch"

function show_help
{
	echo "$1 is not a valid argument"
}

function stop_all
{
	echo "Stopping all launched container"
	docker kill $(docker ps -aq)
	docker rm $(docker ps -aq)
}

function start_step1
{
	local port=9090
    
	echo "Starting step 1"
	docker build -t res/apache_php ./docker-images/apache-php-image
    docker run -d --name apache_static -p $port:80 res/apache_php
	start "http://$HOST:$port"
}

## Main
case $1 in
	"step1" ) start_step1
		;;
	  * ) show_help
esac

read -p "Press any key to close all docker container ..."

stop_all