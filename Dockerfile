# Tensorflow supports only upto CUDNN v4
FROM nvidia/cuda:8.0-cudnn5-devel
MAINTAINER Edgar Y. Walker <edgar.walker@gmail.com>

# Install essential Ubuntu packages, Oracle Java 8,
# and upgrade pip
RUN apt-get update &&\
    apt-get install -y software-properties-common \
                       build-essential \
                       git \
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

WORKDIR /src

# Install Bazel from source
ENV BAZEL_VER 0.3.1
ENV BAZEL_INSTALLER bazel-$BAZEL_VER-installer-linux-x86_64.sh
ENV BAZEL_URL https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VER/$BAZEL_INSTALLER
RUN wget $BAZEL_URL &&\
    wget $BAZEL_URL.sha256 &&\
    sha256sum -c $BAZEL_INSTALLER.sha256 &&\
    chmod +x $BAZEL_INSTALLER &&\
    ./$BAZEL_INSTALLER

# Get TensorFlow
RUN git clone https://github.com/tensorflow/tensorflow

ENV PYTHON_BIN_PATH="/usr/bin/python3" TF_NEED_GCP=0 TF_NEED_CUDA=1 TF_CUDA_VERSION=8.0 TF_CUDNN_VERSION=5 TF_CUDA_COMPUTE_CAPABILITIES=5.2,6.1

#RUN cd tensorflow &&\
#    ./configure
