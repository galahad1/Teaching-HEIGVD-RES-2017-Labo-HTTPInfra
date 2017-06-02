# RES Laboratoire HTTPInfra

auteurs: Tano Iannetta et Loan Lassalle

## Etape 1 - Serveur http statique avec apache httpd

1. Création du repository
Nous avons forké le repository disponible sur SoftEng-HEIGVD/Teaching-HEIGVD-RES-2017-Labo-HTTPInfra afin d'avoir la même base que le professeur. Nous avons utilisé ce repository pour effectuer le laboratoire. Pour permettre au membre Loan Lassalle de push les fichiers du laboratoire, nous l'avons ajouté en tant que contributeur.

2. Mise en place de l'environnement de travail
Au sein du repository, nous avons créé un dossier qui contient l'image docker de notre serveur apache. Cette image docker est définie par :
`
FROM php:7.0-apache
COPY src/ /var/www/html
`

La première ligne définit depuis quelle image docker nous allons travailler
La seconde copie le dossier src/ dans le système de fichier de l'image ocker

3. Nous avons décidé d'utiliser l'image docker officiel php en raison de sa simplicité d'utilisation et la qualité dde la documentation.

4. Exécution de l'image docker
`
docker run -d -p 9090:80 php:7.0-apache
`

5. Récupération des containers en cours d'exécution
`
docker ps
`

6. Affichage des logs du container docker
`
docker logs adoring_spence
`

7. Démarrage d'une communication avec le container
`
telnet 192.168.99.100 9090
`

8. Requête GET
`
GET / HTTP/1.0
`

Réponse du serveur:
`
HTTP/1.1 403 Forbidden
Date: Fri, 02 Jun 2017 12:58:05 GMT
Server: Apache/2.4.10 (Debian)
Content-Length: 285
Connection: close
Content-Type: text/html; charset=iso-8859-1

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>403 Forbidden</title>
</head><body>
<h1>Forbidden</h1>
<p>You don't have permission to access /
on this server.<br />
</p>
<hr>
<address>Apache/2.4.10 (Debian) Server at 172.17.0.2 Port 80</address>
</body></html>
Connection closed by foreign host.
`

9. Inspection des informations du container
`
docker inspect adoring_spence
`
Adresse IP du container:
`
"IPAddress": "172.17.0.2"
`

10. Accès au serveur à travers un navigateur Internet
URL:
`
192.168.99.100:9090
`

11. Création et ajout de contenu au fichier index.html
`
echo "<h2>Coucou</h2>" > index.html
`
URL:
`
192.168.99.100:9090
`

12. Création d'un fichier a.html
`
echo "<h2>Coucou A </h2>" > a.html
`
URL:
`
192.168.99.100:9090/a.html
`

13. Création de dossiers
`
mkdir a
mkdir a/b
`

14. echo "C" > a/b/index.html
http://192.168.99.100:9090/a/b/

15. cd /etc/apache2/
ls

16. cd docker-images/apache-php-image/

17. 

18. docker build -t res/apache_php .

19. docker kill adoring_spence

20. docker run -p 9090:80 res/apache_php

21. http://192.168.99.100:9090/
192.168.99.1 - - [02/Jun/2017:13:16:32 +0000] "GET / HTTP/1.1" 200 430 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"

