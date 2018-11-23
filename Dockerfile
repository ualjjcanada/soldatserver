FROM ubuntu

ARG DOWNLOAD_URL=https://static.soldat.pl/downloads/soldatserver2.8.1_1.7.1.zip

LABEL author="Joaquín Cañadas" \
  thanksto="Carlos Milan Figueredo" 

RUN dpkg --add-architecture i386  
RUN  apt-get update -y 
RUN  apt-get install -y libc6:i386 libstdc++6:i386 unzip wget gosu 
RUN wget ${DOWNLOAD_URL} -O /tmp/soldat.zip 
RUN mkdir /opt/soldatserver/ 
RUN unzip /tmp/soldat.zip -d /opt/soldatserver

#creamos usuario

RUN  useradd tom
RUN  chown -R tom:tom /opt/soldatserver 

# puertos
# 23073/TCP
# 23073/UDP
# 23083/TCP

EXPOSE 23073/tcp 23073/udp 23083/tcp

CMD ["gosu", "tom", "/opt/soldatserver/soldatserver"]