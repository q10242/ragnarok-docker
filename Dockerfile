FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git \
                        make \
                        libmariadb-dev \
                        libmariadb-dev-compat \
                        gcc \
                        g++ \
                        zlib1g-dev \
                        libpcre3-dev \
                        vim


RUN apt-get install mysql-server -y
RUN git clone https://github.com/rathena/rathena.git /root/rAthena

WORKDIR /root/rAthena
RUN rm /root/rAthena/conf/inter_athena.conf
COPY inter_athena.conf /root/rAthena/conf/inter_athena.conf
RUN ./configure
RUN make clean && make server
RUN chmod a+x login-server && chmod a+x char-server && chmod a+x map-server && chmod a+x web-server

ENTRYPOINT [ "./ar./athena-start", "start" ]