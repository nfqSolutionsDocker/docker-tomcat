### tomcat

This container has the following characteristics:
- Container nfqsolutions/centos:7.
- The OpenJdk7.
- The tomcat directory is /solutions/tomcat.
- Installations script of tomcat in centos. This script copy tomcat directory to volumen. This script is executing in the next containers or in the docker compose.

For example, docker-compose.yml:
```
app:
 image: nfqsolutions/tomcat:7.0.70-openjdk7
 restart: always
 ports:
  - "8080:8080"
 environment:
  - PACKAGES=
 volumes:
  - <mydirectory>:/solutions/app
 
```
