FROM nfqsolutions/java:7-jdk

MAINTAINER solutions@nfq.com

# Variables de entorno
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin
ARG TOMCAT_VERSION=7.0.70

# Instalacion de TOMCAT 7.0.70
RUN sudo wget -P /usr/local/ "http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"
RUN sudo tar -xvzf /usr/local/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /usr/local/
RUN sudo chown -R solutions:nfq $(ls -d /usr/local/apache-tomcat*/)
RUN sudo chmod -R 777 $(ls -d /usr/local/apache-tomcat*/)
RUN sudo ln -sf $(ls -d /usr/local/apache-tomcat*/) /usr/local/tomcat
RUN sudo chmod a+x /usr/local/tomcat/bin/catalina.sh

# Modificacion para solutions
COPY index.html /usr/local/tomcat/webapps/ROOT/
COPY solutions.png /usr/local/tomcat/webapps/ROOT/
RUN sudo mv /usr/local/tomcat/webapps/ROOT/index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp.bak
RUN sudo chown -R solutions:nfq /usr/local/tomcat

# Copia de seguridad
RUN sudo cp -R /usr/local/apache-tomcat-${TOMCAT_VERSION} /usr/local/tomcat.bak
RUN sudo chown -R solutions:nfq /usr/local/tomcat.bak
RUN sudo chmod -R 777 /usr/local/tomcat.bak
RUN sudo chmod a+x /usr/local/tomcat.bak/bin/catalina.sh

# Script de arranque
COPY tomcat.sh /home/solutions/
RUN sudo chown solutions:nfq /home/solutions/tomcat.sh
RUN sudo chmod 777 /home/solutions/tomcat.sh
RUN sudo chmod a+x /home/solutions/tomcat.sh
RUN sudo sed -i -e 's/\r$//' /home/solutions/tomcat.sh

# Volumenes para el tomcat
VOLUME /usr/local/tomcat

# Puerto de salida del tomcat
EXPOSE 8080