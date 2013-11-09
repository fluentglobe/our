# VERSION			0.1
# DOCKER VERSION	0.6.6

FROM ubuntu:12.10
MAINTAINER Henrik Vendelbo "hvendelbo@gmail.com"
RUN apt-get -qq update
RUN apt-get install -y python-dev python-setuptools supervisor git-core
RUN easy_install pip
RUN pip install virtualenv
RUN pip install uwsgi
RUN virtualenv --no-site-packages /opt/ve/weblate
ADD . /opt/apps/weblate
ADD .docker/supervisor.conf /opt/supervisor.conf
ADD .docker/run.sh /usr/local/bin/run
RUN (cd /opt/apps/weblate && git remote rm origin)
RUN (cd /opt/apps/weblate && git remote add origin https://github.com/fluentglobe/weblate.git)
RUN /opt/ve/weblate/bin/pip install -r /opt/apps/weblate/requirements.txt
# RUN (cd /opt/apps/weblate && /opt/ve/weblate/bin/python manage.py syncdb --noinput)
# RUN (cd /opt/apps/weblate && /opt/ve/weblate/bin/python manage.py collectstatic --noinput)
# EXPOSE 8000
# CMD ["/bin/sh", "-e", "/usr/local/bin/run"]
