# Tensorflow supports only upto CUDNN v4
FROM nvidia/cuda:8.0-cudnn5-devel
MAINTAINER Edgar Y. Walker <edgar.walker@gmail.com>

# Install essential Ubuntu packages, Oracle Java 8,
# and upgrade pip
RUN apt-get update &&\
    apt-get install -y software-properties-common \
                       build-essential \
                       wget \
                       vim \
                       curl \
                       zip \
                       zlib1g-dev \
                       unzip \ 
                       pkg-config \
                       python3-dev \
                       python3-numpy \
                       python3-pip \
                       python3-wheel \
                       swig &&\
    add-apt-repository -y ppa:webupd8team/java && apt-get update &&\
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections &&\
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections &&\
    apt-get install -y oracle-java8-installer &&\
    ln -s /usr/bin/python3 /usr/bin/python &&\
    ln -s /usr/bin/pip3 /usr/bin/pip &&\
    pip install --upgrade pip &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Bazel from source
RUN 
