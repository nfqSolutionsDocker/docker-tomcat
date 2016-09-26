#!/bin/bash

echo Instalando java ...
if [ ! -f /home/solutions/app/java/bin/java ]; then
	sudo wget -P /home/solutions/app/ --no-cookies --no-check-certificate --header \
    	"Cookie: oraclelicense=accept-securebackup-cookie" \
    	"http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b15/jdk-${JAVA_VERSION}-linux-x64.tar.gz"
	sudo tar -xvzf /home/solutions/app/jdk-${JAVA_VERSION}-linux-x64.tar.gz -C /home/solutions/app/
	sudo chown -R solutions:nfq $(ls -d /home/solutions/app/jdk*/)
	sudo chmod -R 777 $(ls -d /home/solutions/app/jdk*/)
	sudo ln -sf $(ls -d /home/solutions/app/jdk*/) /home/solutions/app/java
fi

echo Instalando tomcat ...
if [ ! -f /home/solutions/app/tomcat/bin/catalina.sh ]; then
	sudo wget -P /home/solutions/app/ "http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
	sudo tar -xvzf /home/solutions/app/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /home/solutions/app/
	sudo chown -R solutions:nfq $(ls -d /home/solutions/app/apache-tomcat*/)
	sudo chmod -R 777 $(ls -d /home/solutions/app/apache-tomcat*/)
	sudo ln -sf $(ls -d /home/solutions/app/apache-tomcat*/) /home/solutions/app/tomcat
	sudo chmod a+x /home/solutions/app/tomcat/bin/catalina.sh
	sudo cp /home/solutions/index.html /home/solutions/app/tomcat/webapps/ROOT/
    sudo cp /home/solutions/solutions.png /home/solutions/app/tomcat/webapps/ROOT/
    sudo mv /home/solutions/app/tomcat/webapps/ROOT/index.jsp /home/solutions/app/tomcat/webapps/ROOT/index.jsp.bak
fi

echo Ejecutando tomcat ...
catalina.sh run