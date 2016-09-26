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

echo Configurando tomcat ...
if [ ! -f /home/solutions/app/tomcat/bin/setenv.sh ]; then
	cp /home/solutions/setenv.sh /home/solutions/app/tomcat/bin/
	MEMORY=$(free -m | awk '/^Mem:/{print $2}')
	let MIN=${MEMORY}/64
	let MAX=${MEMORY}/4
	echo "export CATALINA_OPTS=\"\$CATALINA_OPTS -Xms${MIN}m -Xmx${MAX}m -XX:+AggressiveOpts -XX:-UseGCOverheadLimit -XX:MaxPermSize=512m\"" >> /home/solutions/app/tomcat/bin/setenv.sh
fi

echo Ejecutando tomcat ...
catalina.sh run