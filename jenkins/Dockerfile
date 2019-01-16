FROM ubuntu

RUN apt-get update && \
    apt-get -y upgrade  && \    
    apt-get install -y git && \
    apt-get install -y openssh-server && \
    apt-get install -y docker

RUN mkdir -p /var/run/sshd 

RUN apt-get install -y openjdk-8-jdk

RUN adduser --quiet jenkins

RUN echo "jenkins:jenkins" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]