FROM ubuntu:16.04
MAINTAINER Nikita Chebykin <nikita@chebyk.in>

RUN apt-get update \
  && apt-get -y dist-upgrade \
	&& apt-get install -y wget

RUN	echo "deb http://ubuntu.kurento.org/ xenial kms6" | tee /etc/apt/sources.list.d/kurento.list \
	&& wget -O - http://ubuntu.kurento.org/kurento.gpg.key | apt-key add - \
	&& apt-get update \
	&& apt-get -y install kurento-media-server-6.0 \
	&& apt-get clean \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 8888

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV GST_DEBUG=Kurento*:5

ENTRYPOINT ["/entrypoint.sh"]
