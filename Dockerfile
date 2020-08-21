FROM selenium/standalone-chrome:3.14.0-iron

LABEL authors=SeleniumHQ

# Assume root user & set proxy as env vars to enable downloading packages over the internet

USER root


# This package is required to use HTTPS as a transport for apt sources, specifically the Microsoft source below. This requires an initial use of "apt-get update"

RUN apt-get update

RUN apt-get install -y apt-transport-https

# Add a Microsoft apt source which uses HTTPS as transport

RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb

RUN dpkg -i packages-microsoft-prod.deb

# Install our packages via apt-get

RUN apt-get update

RUN apt-get install -y \
    python3-pip \
    vim \
    dotnet-sdk-3.1 \
    git

 

# Install selenium modules for Python using pip3

RUN pip3 install selenium
 

# add localhost not using proxy, as Selenium starts a server locally and connects to it via localhost

ENV no_proxy localhost,
