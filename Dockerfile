FROM ubuntu:15.10

MAINTAINER JustAdam

RUN apt-get clean && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    apt-get clean
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates && \
    apt-get clean
ENV TIMEZONE Europe/Oslo
RUN echo $TIMEZONE > /etc/timezone &&\
  cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime &&\
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure tzdata

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y beanstalkd

RUN mkdir /binlog && chown nobody /binlog
VOLUME ["/binlog"]

ENTRYPOINT ["beanstalkd"]
CMD ["-b", "/binlog", "-u", "nobody"]
