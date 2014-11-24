FROM ubuntu:14.04
#Thanks to https://github.com/eatnumber1/docker-plex
MAINTAINER Russ Harmon <eatnumber1@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -qy --force-yes curl

RUN echo "deb http://shell.ninthgate.se/packages/debian plexpass main" > /etc/apt/sources.list.d/plexmediaserver.list

RUN curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add -

RUN apt-get -q update

RUN apt-get install -qy --force-yes plexmediaserver

# apt clean
RUN apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

RUN mkdir /var/empty

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 32400

CMD ["/start.sh"]
