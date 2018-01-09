#!/bin/bash

/solutions/install_packages.sh

echo Instalando tomcat ...
if [ ! -f /solutions/app/tomcat/bin/catalina.sh ]; then
	wget -P /solutions/app/ "http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
	tar -xvzf /solutions/app/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /solutions/app/
	chmod -R 777 $(ls -d /solutions/app/apache-tomcat*/)
	#ln -sf $(ls -d /solutions/app/apache-tomcat*/) /solutions/app/tomcat
	mv $(ls -d /solutions/app/apache-tomcat*/) /solutions/app/tomcat
	chmod a+x /solutions/app/tomcat/bin/catalina.sh
	cp /solutions/index.html /solutions/app/tomcat/webapps/ROOT/
    cp /solutions/solutions.png /solutions/app/tomcat/webapps/ROOT/
    mv /solutions/app/tomcat/webapps/ROOT/index.jsp /solutions/app/tomcat/webapps/ROOT/index.jsp.bak
fi

echo Configurando tomcat ...
if [ ! -f /solutions/app/tomcat/bin/setenv.sh ]; then
	cp /solutions/setenv.sh /solutions/app/tomcat/bin/
	MEMORY=$(free -m | awk '/^Mem:/{print $2}')
	let MIN=${MEMORY}/64
	let MAX=${MEMORY}/4
	echo "export CATALINA_OPTS=\"\$CATALINA_OPTS -Xms${MIN}m -Xmx${MAX}m -XX:+AggressiveOpts -XX:-UseGCOverheadLimit -XX:MaxPermSize=512m\"" >> /solutions/app/tomcat/bin/setenv.sh
	cp /tmp/web.xml /solutions/app/tomcat/conf/web.xml
	cp /tmp/404.html /solutions/app/tomcat/webapps/ROOT/404.html
	cp /tmp/badface.png /solutions/app/tomcat/webapps/ROOT/badface.png
fi

echo Ejecutando tomcat ...
catalina.sh run