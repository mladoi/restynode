#!/usr/bin/env bash

apt-get update

# Install build tools
apt-get install -y make g++ git curl vim libcairo2-dev libav-tools portmap imagemagick subversion
apt-get install -y python-software-properties python g++ make

# Install Subversion 1.7
add-apt-repository -y ppa:svn/ppa
apt-get update
apt-get install -y subversion

# Install nodejs
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get install -y nodejs

# Update apt-get to get 10gen stable packages
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
apt-get update
# Install specific stable version
apt-get install -y mongodb-10gen=2.4.4
# Pin to the exact version above, so it's not auto upgraded by apt-get
echo "mongodb-10gen hold" | dpkg --set-selections

# Redis
add-apt-repository -y ppa:chris-lea/redis-server
apt-get update
apt-get install -y redis-server

# git
echo "deb-src http://archive.ubuntu.com/ubuntu precise main" >> /etc/apt/sources.list
sed -i 's/main$/main universe/' /etc/apt/sources.list
apt-get update
apt-get -y install wget vim git libpq-dev

# Openresty (Nginx)
apt-get -y build-dep nginx
wget http://openresty.org/download/ngx_openresty-1.7.4.1.tar.gz
tar xvfz ngx_openresty-1.7.4.1.tar.gz
cd ngx_openresty-1.7.4.1 ; ./configure --with-luajit  --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-ipv6 --with-http_postgres_module --with-pcre-jit;  make ; make install

# Example for starting nginx 
# /usr/local/openresty/nginx/sbin/nginx -p `pwd` -c nginx.conf
