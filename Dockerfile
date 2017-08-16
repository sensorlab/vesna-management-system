FROM armv7/armhf-ubuntu:xenial

# File Author / Maintainer
MAINTAINER Matevz Vucnik

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y default-jdk
RUN apt-get install -y ant
RUN apt-get install -y librxtx-java

RUN cd /root && \
git clone -b docker-support https://github.com/matevzv/vesna-management-system
WORKDIR /root/vesna-management-system
RUN ant build
RUN sed -i 's|10000|/dev/ttyS1|g' webapp/vms/vms.html

# Run app
CMD java -jar build/VesnaManagementSystem.jar -l false -p /dev/ttyS1