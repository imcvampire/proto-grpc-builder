ARG GOLANG_VERSION

FROM golang:${GOLANG_VERSION}

ARG JDK_VERSION

ARG PROTOC_KOTLIN_VERSION=0.1.4
ARG PROTOC_KOTLIN_FILENAME=protoc-gen-grpc-kotlin-${PROTOC_KOTLIN_VERSION}-linux-x86_64.exe
ARG PROTOC_KOTLIN_DOWNLOAD_URL=https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-kotlin/${PROTOC_KOTLIN_VERSION}/${PROTOC_KOTLIN_FILENAME}

ARG PROTOC_JAVA_VERSION=1.30.2
ARG PROTOC_JAVA_FILENAME=protoc-gen-grpc-java-${PROTOC_JAVA_VERSION}-linux-x86_64.exe
ARG PROTOC_JAVA_DOWNLOAD_URL=https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/${PROTOC_JAVA_VERSION}/${PROTOC_JAVA_FILENAME}

ARG PROTOC_LINUX_VERSION=3.11.4
ARG PROTOC_LINUX_ZIP=protoc-${PROTOC_LINUX_VERSION}-linux-x86_64.zip

RUN apt-get update 
RUN apt-get install -y --no-install-recommends unzip curl make git openssh-client rsync
RUN apt-get install -y --no-install-recommends openjdk-${JDK_VERSION}-jdk

RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_LINUX_VERSION}/${PROTOC_LINUX_ZIP} && \
  unzip -o ${PROTOC_LINUX_ZIP} -d /usr/local bin/protoc && \
	unzip -o ${PROTOC_LINUX_ZIP} -d /usr/local 'include/*' && \
	rm -f ${PROTOC_LINUX_ZIP}
  
RUN curl -OL ${PROTOC_KOTLIN_DOWNLOAD_URL} && \
	mv ${PROTOC_KOTLIN_FILENAME} /usr/local/bin/protoc-gen-grpc-kotlin && \
	chmod +x /usr/local/bin/protoc-gen-grpc-kotlin && \
	rm -f ${PROTOC_KOTLIN_FILENAME}
  
RUN curl -OL ${PROTOC_JAVA_DOWNLOAD_URL} && \
	mv ${PROTOC_JAVA_FILENAME} /usr/local/bin/protoc-gen-grpc-java && \
	chmod +x /usr/local/bin/protoc-gen-grpc-java && \
	rm -f ${PROTOC_JAVA_FILENAME}
  
RUN go get github.com/golang/protobuf/protoc-gen-go && \
	go get google.golang.org/grpc/cmd/protoc-gen-go-grpc && \
	go get github.com/envoyproxy/protoc-gen-validate   
