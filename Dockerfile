FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
RUN sudo yum install -y wget java-1.7.0-openjdk

# Variables de entorno
ENV CATALINA_HOME=/solutions/app/tomcat \
	JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
	TOMCAT_VERSION=7.0.70
ENV PATH=$PATH:$CATALINA_HOME/bin

# Modificacion para solutions
COPY index.html /solutions/
COPY solutions.png /solutions/
COPY setenv.sh /solutions/
RUN chmod 777 /solutions/setenv.sh && \
	chmod a+x /solutions/setenv.sh && \
	sed -i -e 's/\r$//' /solutions/setenv.sh

# Script de arranque
COPY tomcat.sh /solutions/
RUN chmod 777 /solutions/tomcat.sh && \
	chmod a+x /solutions/tomcat.sh && \
	sed -i -e 's/\r$//' /solutions/tomcat.sh

# Volumenes para el tomcat
VOLUME /solutions/app

# Puerto de salida del tomcat
EXPOSE 8080

# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]