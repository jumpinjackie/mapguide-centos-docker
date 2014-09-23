# DOCKER-VERSION 1.0.0
#
# Dockerfile for MapGuide / CentOS 6 / Apache httpd / PHP
#
#  - MapGuide Open Source 2.6.0
#  - FDO 3.9.0
#  - Apache httpd 2.4.9
#  - PHP 5.5.11
#
FROM centos:centos6
MAINTAINER Jackie Ng "jumpinjackie@gmail.com"

# Write the /etc/supervisord.conf file inline
# This will start the MapGuide Server and httpd web server
RUN echo "[supervisord]" > /etc/supervisord.conf
RUN echo -e "\nnodaemon=true" >> /etc/supervisord.conf
RUN echo -e "\n[program:mgserver]" >> /etc/supervisord.conf
RUN echo -e "\ncommand=/usr/local/mapguideopensource-2.6.0/server/bin/mgserver.sh" >> /etc/supervisord.conf
RUN echo -e "\n[program:apache2]" >> /etc/supervisord.conf
RUN echo -e "\ncommand=/usr/local/mapguideopensource-2.6.0/webserverextensions/apache2/bin/apachectl start" >> /etc/supervisord.conf

# Fetch the required dependencies for MapGuide/Apache/PHP to work. Clean afterwards to reduce size footprint on the final image
RUN yum -y install unzip python-setuptools wget tar glibc.i686 libstdc++.i686 expat.i686 libcurl.i686 pcre.i686 libxslt.i686 libpng.i686 && \
  yum clean all && \
  easy_install supervisor

# Download the required tarballs, install them and wipe the tarballs afterwards. Do this in a single chained
# command to reduce size footprint on the final image
RUN wget http://download.osgeo.org/mapguide/releases/2.6.0/Release/fdosdk-centos6-i386-3.9.0_7090.tar.gz && \
  wget http://download.osgeo.org/mapguide/releases/2.6.0/Release/mapguideopensource-2.6.0.8335.i386.tar.gz && \
  mkdir -p /usr/local/fdo-3.9.0 && \
  tar -zxf fdosdk-centos6-i386-3.9.0_7090.tar.gz -C /usr/local/fdo-3.9.0 && \
  tar -zxf mapguideopensource-2.6.0.8335.i386.tar.gz -C / && \
  rm fdosdk-centos6-i386-3.9.0_7090.tar.gz && \
  rm mapguideopensource-2.6.0.8335.i386.tar.gz

# Expose the web server port
EXPOSE 8008
CMD ["/usr/bin/supervisord"]
