FROM php:7.0-apache

LABEL maintainer Tano Iannetta <tano.iannetta@heig-vd.ch>
LABEL maintainer Loan Lassalle <loan.lassalle@heig-vd.ch>

RUN apt-get update && apt-get install -y vim

COPY content/ /var/www/html/
