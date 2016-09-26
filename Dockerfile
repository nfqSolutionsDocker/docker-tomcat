FROM nfqsolutions/centos:7

MAINTAINER solutions@nfq.com

# Instalacion previa
RUN sudo yum install -y wget

# Variables de entorno
ENV JAVA_HOME /home/solutions/app/java
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8
ENV CATALINA_HOME /home/solutions/app/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin
ENV JAVA_VERSION=7u80
ENV TOMCAT_VERSION=7.0.70

# Modificacion para solutions
COPY index.html /home/solutions/
COPY solutions.png /home/solutions/
COPY setenv.sh /home/solutions/
RUN sudo chown solutions:nfq /home/solutions/setenv.sh
RUN sudo chmod 777 /home/solutions/setenv.sh
RUN sudo chmod a+x /home/solutions/setenv.sh
RUN sudo sed -i -e 's/\r$//' /home/solutions/setenv.sh

# Script de arranque
COPY tomcat.sh /home/solutions/
RUN sudo chown solutions:nfq /home/solutions/tomcat.sh
RUN sudo chmod 777 /home/solutions/tomcat.sh
RUN sudo chmod a+x /home/solutions/tomcat.sh
RUN sudo sed -i -e 's/\r$//' /home/solutions/tomcat.sh

# Volumenes para el tomcat
VOLUME /home/solutions/app

# Puerto de salida del tomcat
EXPOSE 8080

# Copy supervisor file
COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord"]