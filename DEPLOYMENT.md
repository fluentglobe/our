
Weblate will be deployed on a Ubuntu Docker Instance

URL: our.fluentglobe.com (http://146.185.169.23)


To deploy the following command will be run,

docker build -t fluentglobe/weblate github.com/fluentglobe/weblate


OS: Ubuntu 13.04.3 x64
Docker: 0.6.6
Deis: Future
Python: 2.7.3
DB: PostgresSQL 9.1.10
pip: 1.3.1
git: 1.8.1.2


Docker info found here

https://www.docker.io/gettingstarted/#
(Future: http://deis.io/overview/)

https://www.digitalocean.com/community/articles/how-to-use-the-digitalocean-docker-application

Reference Image can be found here:

http://bitnami.com/stack/weblate


Git repo here:

https://github.com/fluentglobe/weblate


TODO
++++

Create VirtualEnv with Django 1.6 & Weblate 1.8
Start VirtualEnv Django on boot




Already run on the box
++++++++++++++++++++++

apt-get install python-pip
apt-get install nginx-naxsi
service nginx start
apt-get install postgresql-9.1 postgresql-client-9.1 postgresql-9.1-postgis
 