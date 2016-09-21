#!/bin/bash

if [ ! -f /usr/local/tomcat/bin/catalina.sh ]; then
	sudo cp -R /usr/local/tomcat.bak/* /usr/local/tomcat
	sudo chown -R solutions:nfq /usr/local/tomcat
	sudo chmod -R 777 /usr/local/tomcat
	sudo chmod +x /usr/local/tomcat/bin/catalina.sh
fi

catalina.sh run