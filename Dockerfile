ARG UBUNTU_VERSION

FROM ubuntu:${UBUNTU_VERSION}

ARG GOLANG_VERSION
ARG JDK_VERSION

RUN apt-get update 
RUN apt-get install -y --no-install-recommends unzip curl make git openssh-client rsync
RUN apt-get install -y --no-install-recommends golang-${GOLANG_VERSION}-go
RUN apt-get install -y --no-install-recommends openjdk-${JDK_VERSION}-jdk

RUN mkdir -p ~/.ssh && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
