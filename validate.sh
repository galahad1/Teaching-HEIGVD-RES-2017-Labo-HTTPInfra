#!/bin/bash

HOST="demo.res.ch"

function show_help
{
	echo "$1 is not a valid argument"
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
	start "http://$HOST:$port"
}

function start_step2
{    
	local port=3000
    
	echo "Starting step 2"
    docker build -t res/express_addresses ./docker-images/express-image
	docker run -d --name express_dynamic -p $port:3000 res/express_addresses
	start "http://$HOST:$port/"
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
	start "http://$HOST:$port/"
	start "http://$HOST:$port/api/addresses/"
}

function start_step4 {
	local port=8080
    
	echo "Starting step 4"
	echo "Do not forget to add $HOST to your hosts file for correct DNS resolving."
	
	docker build -t res/apache_php ./docker-images/apache-php-image
    docker run -d --name apache_static res/apache_php

    docker build -t res/express_addresses ./docker-images/express-image
	docker run -d --name express_dynamic res/express_addresses

    docker build -t res/apache_rp ./docker-images/apache-reverse-proxy
    docker run -d --name apache_rp -p $port:80 res/apache_rp
	start "http://$HOST:$port/"
}

function get_last_container_ip {
	docker inspect $1 | grep "\"IPAddress\"" -m 1 | grep -o "[0-9.]\+"
}

function start_step5 {
	local port=8080
    
	echo "Starting step 5"
	echo "Do not forget to add $HOST to your hosts file for correct DNS resolving."
	
	docker build -t res/apache_php ./docker-images/apache-php-image
    docker run -d --name apache_static res/apache_php
	local ip_apache_static=$(get_last_container_ip apache_static):80

    docker build -t res/express_addresses ./docker-images/express-image
	docker run -d --name express_dynamic res/express_addresses
	local ip_express_dynamic=$(get_last_container_ip express_dynamic):3000
    
    sed -i "s/\r$//" ./docker-images/apache-reverse-proxy/apache2-foreground.sh

    docker build -t res/apache_rp ./docker-images/apache-reverse-proxy
    docker run -d --name apache_rp -p $port:80 -e IP_APACHE_STATIC=$ip_apache_static \
        -e IP_EXPRESS_DYNAMIC=$ip_express_dynamic res/apache_rp
	start "http://$HOST:$port/"

	echo $ip_apache_static $ip_express_dynamic
}

## Main
case $1 in
	"step1" ) start_step1
		;;
	"step2" ) start_step2
		;;
	"step3" ) start_step3
		;;
	"step4" ) start_step4
		;;
	"step5" ) start_step5
		;;
	  * ) show_help
esac

read -p "Press any key to close all docker container ..."

stop_all