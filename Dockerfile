FROM openjdk:8-jre-alpine
MAINTAINER Sankalan Banerjee <banerjee.sankalan2@gmail.com>

#  Version
ENV   SOAPUI_VERSION  5.3.0

RUN mkdir -p /opt/bin/testProject
RUN cd /opt/bin/testProject
RUN git clone https://github.com/Sankalan1987/SOAPUI_Framework.git

# Download and unarchive SoapUI
RUN mkdir -p /opt &&\
    curl  http://cdn01.downloads.smartbear.com/soapui/${SOAPUI_VERSION}/SoapUI-${SOAPUI_VERSION}-linux-bin.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
    ln -s /opt/SoapUI-${SOAPUI_VERSION} /opt/SoapUI

# Set working directory
WORKDIR /opt/bin

# Set environment
ENV PATH ${PATH}:/opt/SoapUI/bin

# cleanup
RUN apt-get -qy autoremove

CMD [testrunner.sh -s"DriverSuite" -c"Driver" "/opt/bin/testProject/SOAPUI_Framework/WebService_Demo-soapui-project.xml"]