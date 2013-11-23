# VERSION			0.1
# DOCKER VERSION	0.6.6

FROM ubuntu:12.10
MAINTAINER Henrik Vendelbo "hvendelbo@gmail.com"
RUN apt-get -qq update

RUN apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get install -y gcc make g++ python-dev python-setuptools supervisor git-core
RUN apt-get install -y openssh-server curl wget libpq5 libpq-dev

RUN easy_install pip
RUN pip install virtualenv
RUN pip install uwsgi
RUN virtualenv --no-site-packages /opt/ve/our
ADD .docker/supervisor.conf /etc/supervisor/conf.d/our.conf

# using on production
# ADD .docker/git.sh /opt/git.sh 
# RUN . /opt/git.sh

RUN (mkdir -p /opt/apps)
ADD . /opt/apps/our
RUN (cd /opt/apps/our && git remote rm origin)
RUN (cd /opt/apps/our && git remote add origin https://github.com/fluentglobe/our.git)
RUN (cd /opt/apps/our && git config branch.master.remote 'origin')
ADD .docker/settings.py /opt/apps/our/weblate/settings.py
RUN /opt/ve/our/bin/pip install -r /opt/apps/our/requirements.txt
ENTRYPOINT ["/etc/init.d/supervisor","start","&"]

# ADD .docker/supervisor.conf /opt/supervisor.conf
# ADD .docker/run.sh /usr/local/bin/run
# RUN (cd /opt/apps/our && /opt/ve/our/bin/python manage.py syncdb --noinput)
# RUN (cd /opt/apps/our && /opt/ve/our/bin/python manage.py collectstatic --noinput)
EXPOSE 8000 22
# CMD ["/bin/sh", "-e", "/usr/local/bin/run"]
