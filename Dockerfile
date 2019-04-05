FROM centos:latest

LABEL maintainer="plonxyz"
# package versions
ENV UNIFI_VER="5.10.20"

# environment settings
RUN \
 groupadd -g 1001 ubnt && \
 useradd -r -u 1001 -g ubnt ubnt && \
 yum update -y && \
 yum install mongodb-server java-1.8.0-openjdk unzip wget -y && \
 echo "**** install unifi ****" && \
 wget  \
	"http://dl.ubnt.com/unifi/$UNIFI_VER/UniFi.unix.zip" && \
 unzip -q UniFi.unix.zip -d . && \
 chown -R ubnt:ubnt /UniFi && \
 echo "**** cleanup ****" && \
 yum clean all  && \
 rm -rf \
	/tmp/* \
USER ubnt	
# add local files
WORKDIR /UniFi/
# Volumes and Ports
#VOLUME /config
ENTRYPOINT [ "/usr/bin/java",  "-Xmx1024M",  "-jar","/UniFi/lib/ace.jar","start"]
EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp
