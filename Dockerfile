FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
RUN sudo yum install -y wget

# Variables de entorno
ENV JAVA_HOME=/home/solutions/app/java \
	JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
	CATALINA_HOME=/home/solutions/app/tomcat \
	PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin \
	JAVA_VERSION=7u80 \
	TOMCAT_VERSION=7.0.70

# Modificacion para solutions
COPY [./index.html,./solutions.png,./setenv.sh /home/solutions/]
RUN sudo chown solutions:nfq /home/solutions/setenv.sh && \
	chmod 777 /home/solutions/setenv.sh && \
	chmod a+x /home/solutions/setenv.sh && \
	sed -i -e 's/\r$//' /home/solutions/setenv.sh

# Script de arranque
COPY tomcat.sh /home/solutions/
RUN sudo chown solutions:nfq /home/solutions/tomcat.sh && \
	chmod 777 /home/solutions/tomcat.sh && \
	chmod a+x /home/solutions/tomcat.sh && \
	sed -i -e 's/\r$//' /home/solutions/tomcat.sh

# Volumenes para el tomcat
VOLUME /home/solutions/app

# Puerto de salida del tomcat
EXPOSE 8080

# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]