FROM ubuntu

WORKDIR /root

RUN mkdir -p /root/install
COPY *.sh /root/install/

RUN bash /root/install/setup-prerequisites.sh
RUN bash /root/install/install-hbase.sh

CMD bash /root/install/autorun.sh && /bin/bash

