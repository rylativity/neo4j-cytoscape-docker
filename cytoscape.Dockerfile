FROM ubuntu:20.04

# PARAMETERS
ENV CYTOSCAPE_VERSION 3.9.1

# CHANGE USER
USER root

# INSTALL JAVA
RUN apt-get update && apt-get -y install default-jdk libxcursor1 xvfb supervisor wget x11vnc
RUN wget https://github.com/cytoscape/cytoscape/releases/download/3.9.1/cytoscape-unix-3.9.1.tar.gz
RUN tar xf cytoscape-unix-3.9.1.tar.gz && rm cytoscape-unix-3.9.1.tar.gz

# Set JAVA_HOME From sudo update-alternatives --config java
# RUN echo 'JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' >> /etc/environment
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 1234 5900
CMD ["/usr/bin/supervisord"]