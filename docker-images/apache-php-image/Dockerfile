FROM php:7.0-apache

LABEL maintainer Tano Iannetta <tano.iannetta@heig-vd.ch>
LABEL maintainer Loan Lassalle <loan.lassalle@heig-vd.ch>

LABEL "traefik.backend"="apache_static"
LABEL "traefik.frontend.rule"="Host: demo.res.ch;PathPrefix: /"

COPY ./content/ /var/www/html/
