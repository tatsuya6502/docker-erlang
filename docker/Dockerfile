## The MIT License
##
## Copyright (C) 2015-2016 by Tatsuya Kawano
##
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
##
## The above copyright notice and this permission notice shall be included in
## all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
## THE SOFTWARE.

FROM quay.io/tatsuya6502/archlinux-x86_64
MAINTAINER Tatsuya Kawano

# Please change this value to force the builders at Quay.io/Docker Hub
# to omit the cached Docker images. This will have the same effect to
# adding `--no-cache` to `docker build` command.
#
ENV DOCKERFILE_UPDATED 2016-02-17

RUN (pacman -Syu --noconfirm && \
# Install basic utilities
     pacman -S --noconfirm curl git sudo wget && \
# Install packages to build Erlang/OTP
     pacman -S --noconfirm gcc glibc make ncurses openssh autoconf)

# Install kerl
ADD ./kerlrc /root/.kerlrc
RUN (wget -O /usr/local/bin/kerl https://raw.githubusercontent.com/spawngrid/kerl/master/kerl && \
     chmod a+x /usr/local/bin/kerl && \
     kerl update releases)

# Install an escript to print out OTP version
ADD ./show-otp-version.escript /usr/local/erlang/show-otp-version.escript
RUN chmod 744 /usr/local/erlang/show-otp-version.escript

# Install Erlang/OTP R16 with kerl
RUN (OTP_VERSION=R16B03-1 && \
     BUILD_NAME=r16b03-1_hipe && \
     kerl build ${OTP_VERSION} ${BUILD_NAME} && \
     kerl install ${BUILD_NAME} /usr/local/erlang/${BUILD_NAME} && \
     kerl delete build ${BUILD_NAME} && \
     rm /root/.kerl/archives/otp_src_${OTP_VERSION}.tar.gz && \
     source /usr/local/erlang/${BUILD_NAME}/activate && \
     /usr/local/erlang/show-otp-version.escript)

# Install Erlang/OTP 17 with kerl
RUN (OTP_VERSION=17.5.6.8 && \
     BUILD_NAME=${OTP_VERSION}_hipe && \
     kerl build git https://github.com/erlang/otp.git OTP-${OTP_VERSION} ${BUILD_NAME} && \
     kerl install ${BUILD_NAME} /usr/local/erlang/${BUILD_NAME} && \
     kerl delete build ${BUILD_NAME} && \
     source /usr/local/erlang/${BUILD_NAME}/activate && \
     /usr/local/erlang/show-otp-version.escript)

# Install Erlang/OTP 18 with kerl
RUN (OTP_VERSION=18.2.3 && \
     BUILD_NAME=${OTP_VERSION}_hipe && \
     kerl build git https://github.com/erlang/otp.git OTP-${OTP_VERSION} ${BUILD_NAME} && \
     kerl install ${BUILD_NAME} /usr/local/erlang/${BUILD_NAME} && \
     kerl delete build ${BUILD_NAME} && \
     rm -rf /root/.kerl/gits/* && \
     source /usr/local/erlang/${BUILD_NAME}/activate && \
     /usr/local/erlang/show-otp-version.escript && \
# Show kerl staus
     kerl status)
