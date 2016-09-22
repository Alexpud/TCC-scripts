#!/bin/bash
#Creates the socket for nginx
sudo nginx -p `pwd`/ -c /usr/local/openresty/nginx/conf/nginx.conf
