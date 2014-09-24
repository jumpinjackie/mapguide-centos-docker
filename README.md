mapguide-base
=============

Docker base image that bundles the latest stable release of [MapGuide Open Source](http://mapguide.osgeo.org)

Included in this image:

 - [MapGuide Open Source](http://mapguide.osgeo.org) 2.6.0
 - [FDO](http://fdo.osgeo.org) 3.9.0
 - Apache httpd 2.4.9
 - PHP 5.5.11
 - [msttcorefonts](http://corefonts.sourceforge.net/)

Use this image as the base of your own MapGuide images.

Usage
-----

Create a Dockerfile that creates an image that is based on this image

	FROM jumpinjackie/mapguide-base
	# Install additional packages, load your MapGuide applications and data, etc.
	# 
	EXPOSE 8008
	CMD ["/usr/bin/supervisord"]

Build the docker image

	docker build -t my/mapguide-app .
