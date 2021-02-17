FROM centos:centos7

# Please change this value to force the builders at Quay.io/Docker Hub
# to omit the cached Docker images. This will have the same effect to
# adding `--no-cache` to `docker build` command.
#
ENV DOCKERFILE_UPDATED 2021-02-17
ENV OTP_VERSION 22.3.4.15

RUN (yum -y update && \
# Install basic utilities
     yum -y install curl git tar wget && \
# Install packages to build Erlang/OTP
     yum -y install gcc glibc-devel make ncurses-devel openssl-devel autoconf automake)

# Install kerl
ADD ./kerlrc /root/.kerlrc
RUN (wget -O /usr/local/bin/kerl https://raw.githubusercontent.com/spawngrid/kerl/master/kerl && \
     chmod a+x /usr/local/bin/kerl && \
     kerl update releases)

# Install an escript to print out OTP version
ADD ./show-otp-version.escript /usr/local/erlang/show-otp-version.escript
RUN chmod 744 /usr/local/erlang/show-otp-version.escript

# Install Erlang/OTP 22 with kerl
RUN (BUILD_NAME=${OTP_VERSION} && \
     kerl build git https://github.com/erlang/otp.git OTP-${OTP_VERSION} ${BUILD_NAME} && \
     kerl install ${BUILD_NAME} /usr/local/erlang/${BUILD_NAME} && \
     source /usr/local/erlang/${BUILD_NAME}/activate && \
     /usr/local/erlang/show-otp-version.escript && \
# Show kerl staus
     kerl status)

# Clean Up
RUN yum clean all
