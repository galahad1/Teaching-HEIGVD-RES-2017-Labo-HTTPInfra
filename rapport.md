#RES Labo HTTPinfra

auteurs: Loan Lassalle et Tano Iannetta


##Etape 1 - Serveur http statique avec apache httpd

1. Nous avons fork√©le repo disponible sur SoftEng-HEIGVD/Teaching-HEIGVD-RES-2017-Labo-HTTPInfra afin d'avoir le repo sur le quel nous avons effectu√©le laboratoir.

2. Dans le repo nous avons cr√√© un dossier qui contient l'image de notre serveur apache. Dans ce dossier nous avons un Dockerfile que nous avons √dit√ comme suit:
`FROM php:7.0-apache
COPY src/ /var/www/html`   

D√taillons un peu ces quelques lignes:
La premi√re d√finit quelle version nous utilisons
La seconde copie le dossier src/ dans le syst√me de fichier de l'image
3. Pour l'image docker nous avons pris l'image officielle php, ce choix a √t√©motiv√©car elle met a disposition php.
