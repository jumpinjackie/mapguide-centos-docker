# DOCKER-VERSION 1.0.0
FROM centos:centos6
ADD supervisord.conf /etc/supervisord.conf
RUN yum -y install unzip python-setuptools wget tar glibc.i686 libstdc++.i686 expat.i686 libcurl.i686 pcre.i686 libxslt.i686 libpng.i686 && \
  yum clean all && \
  easy_install supervisor
RUN wget http://192.168.0.7/downloads/fdosdk-centos6-i386-3.9.0_7090.tar.gz && \
  wget http://192.168.0.7/downloads/mapguideopensource-2.6.0.8340.i386.tar.gz && \
  wget http://192.168.0.7/downloads/mapguide-rest-0.10.zip && \
  mkdir -p /usr/local/fdo-3.9.0 && \
  tar -zxf fdosdk-centos6-i386-3.9.0_7090.tar.gz -C /usr/local/fdo-3.9.0 && \
  tar -zxf mapguideopensource-2.6.0.8340.i386.tar.gz -C / && \
  mkdir -p /usr/local/mapguideopensource-2.6.0/webserverextensions/www/rest && \
  unzip mapguide-rest-0.10.zip -d /usr/local/mapguideopensource-2.6.0/webserverextensions/www/rest && \
  chown daemon:daemon /usr/local/mapguideopensource-2.6.0/webserverextensions/www/rest/cache && \
  rm fdosdk-centos6-i386-3.9.0_7090.tar.gz && \
  rm mapguideopensource-2.6.0.8340.i386.tar.gz && \
  rm mapguide-rest-0.10.zip
EXPOSE 8008
CMD ["/usr/bin/supervisord"]
