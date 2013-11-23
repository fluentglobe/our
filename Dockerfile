# VERSION			0.1
# DOCKER VERSION	0.6.6

FROM ubuntu:12.10
MAINTAINER Henrik Vendelbo "hvendelbo@gmail.com"
RUN apt-get -qq update
RUN apt-get install -y python-dev python-setuptools supervisor git-core
RUN apt-get install -y openssh-server
RUN easy_install pip
RUN pip install virtualenv
RUN pip install uwsgi
RUN virtualenv --no-site-packages /opt/ve/weblate
ADD .docker/supervisor.conf /etc/supervisor/conf.d/weblate.conf
RUN (mkdir -p /opt/apps)
# ADD .docker/git.sh /opt/git.sh #using on production
# RUN . /opt/git.sh
RUN (cd /opt/apps/weblate && git remote rm origin)
RUN (cd /opt/apps/weblate && git remote add origin https://github.com/fluentglobe/weblate.git)
RUN (cd /opt/apps/weblate && git config branch.master.remote 'origin')
ADD .docker/settings.py /opt/apps/weblate/weblate/settings.py
RUN /opt/ve/weblate/bin/pip install -r /opt/apps/weblate/requirements.txt
ENTRYPOINT ["/etc/init.d/supervisor","start","&"]

# AAD . /opt/apps/weblate
# ADD .docker/supervisor.conf /opt/supervisor.conf
# ADD .docker/run.sh /usr/local/bin/run
# RUN (cd /opt/apps/weblate && /opt/ve/weblate/bin/python manage.py syncdb --noinput)
# RUN (cd /opt/apps/weblate && /opt/ve/weblate/bin/python manage.py collectstatic --noinput)
EXPOSE 8000 22
# CMD ["/bin/sh", "-e", "/usr/local/bin/run"]
