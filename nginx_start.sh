#!/bin/bash

ls -a


sudo nginx -p `pwd`/ -c /usr/local/openresty/nginx/conf/nginx.conf
