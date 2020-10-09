ARG JDK=16

FROM openjdk:${JDK}-jdk-slim-buster AS builder
ARG VERSION=1.11.1
ARG MAVEN_VERSION=3.6.3
ARG THRIFT_VERSION=0.12.0
ARG PARALLELISM=4

RUN apt-get update && apt-get install -y curl automake bison flex g++ git libboost-all-dev libevent-dev libssl-dev libtool make pkg-config

RUN curl -L https://mirrors.koehn.com/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz > maven.tar.gz
RUN tar xvf maven.tar.gz
ENV PATH="/apache-maven-$MAVEN_VERSION/bin:${PATH}"

RUN curl -L https://github.com/apache/thrift/archive/v$THRIFT_VERSION.tar.gz > thrift.tar.gz
RUN tar xvf thrift.tar.gz
RUN cd thrift-$THRIFT_VERSION/ && ./bootstrap.sh && ./configure && make -j$PARALLELISM install

RUN curl -L https://github.com/apache/parquet-mr/archive/apache-parquet-$VERSION.tar.gz > parquet.tar.gz
RUN tar xvf parquet.tar.gz
RUN cd parquet-mr-apache-parquet-$VERSION/ && mvn package -pl parquet-tools -am -Plocal
RUN mv /parquet-mr-apache-parquet-$VERSION/parquet-tools/target/parquet-tools-$VERSION.jar /parquet-tools.jar

FROM openjdk:${JDK}-jdk-slim-buster
COPY --from=builder /parquet-tools.jar /parquet-tools.jar
COPY ./silence.sh /silence
ENTRYPOINT ["./silence", "java", "-jar", "/parquet-tools.jar"]