### tomcat

This container has the following characteristics:
- Container nfqsolutions/java:7-jdk.
- The java directory is /usr/local/java.
- The tomcat directory is /usr/local/tomcat.
- Installations script of tomcat in centos. This script copy tomcat directory to volumen. This script is executing in the next containers or in the docker compose.

For example, docker-compose.yml:
```
app:
 image: nfqsolutions/tomcat:7.0.70
 restart: always
 ports:
  - "8080:8080"
 environment:
  - PACKAGES=
 command: /bin/bash -c "/home/solutions/install_packages.sh && /home/solutions/tomcat.sh"
 volumes:
  - <mydirectory>:/usr/local/tomcat
 
```