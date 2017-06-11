FROM php:7.0-apache

LABEL maintainer Tano Iannetta <tano.iannetta@heig-vd.ch>
LABEL maintainer Loan Lassalle <loan.lassalle@heig-vd.ch>

LABEL "traefik.backend"="apache_static"
LABEL "traefik.frontend.rule"="Host: demo.res.ch;PathPrefix: /"
LABEL "traefik.backend.loadbalancer.sticky"="true"

RUN apt-get update && apt-get install -y vim

COPY ./content/ /var/www/html/
