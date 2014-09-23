# DOCKER-VERSION 1.0.0
FROM centos:centos6
ADD supervisord.conf /etc/supervisord.conf
RUN yum -y update
RUN yum -y install python-setuptools wget tar glibc.i686 libstdc++.i686 expat.i686 libcurl.i686 pcre.i686 libxslt.i686 libpng.i686
RUN easy_install supervisor
RUN yum clean all
RUN wget http://192.168.0.7/downloads/fdosdk-centos6-i386-3.9.0_7090.tar.gz
RUN wget http://192.168.0.7/downloads/mapguideopensource-2.6.0.8340.i386.tar.gz
RUN mkdir -p /usr/local/fdo-3.9.0
RUN tar -zxf fdosdk-centos6-i386-3.9.0_7090.tar.gz -C /usr/local/fdo-3.9.0
RUN tar -zxf mapguideopensource-2.6.0.8340.i386.tar.gz -C /
RUN rm fdosdk-centos6-i386-3.9.0_7090.tar.gz
RUN rm mapguideopensource-2.6.0.8340.i386.tar.gz
EXPOSE 8008
CMD ["/usr/bin/supervisord"]
