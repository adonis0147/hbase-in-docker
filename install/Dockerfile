FROM ubuntu

WORKDIR /root

RUN mkdir -p /root/install
COPY ./scripts/*.sh /root/install/
RUN mkdir -p /root/install/conf
COPY ./conf /root/install/conf/

RUN bash /root/install/setup-prerequisites.sh

COPY ./ssh /home/hadoop/.ssh
RUN cp /home/hadoop/.ssh/id_rsa.pub /home/hadoop/.ssh/authorized_keys
RUN chmod 0600 /home/hadoop/.ssh/authorized_keys
RUN chown -R hadoop:hadoop /home/hadoop/.ssh

RUN mkdir /data && chmod a+w /data

COPY ./archives/hadoop-2.9.1.tar.gz /home/hadoop/
RUN bash /root/install/install-hadoop.sh

COPY ./archives/hbase-1.4.7-bin.tar.gz /home/hadoop/
RUN bash /root/install/install-hbase.sh

CMD bash /root/install/autorun.sh && /bin/bash
