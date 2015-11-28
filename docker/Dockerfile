## The MIT License
##
## Copyright (C) 2015 by Tatsuya Kawano
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

FROM centos:centos6
MAINTAINER Tatsuya Kawano

# Please change this value to force the builders at Quay.io/Docker Hub
# to omit the cached Docker images. This will have the same effect to
# adding `--no-cache` to `docker build` command.
#
ENV DOCKERFILE_UPDATED 2015-11-28

RUN (yum -y update && \
# Install basic utilities
     yum -y install curl tar wget && \
# Install packages to build Erlang/OTP
     yum -y install gcc glibc-devel make ncurses-devel openssl-devel && \
# Install packages to build git
     yum -y install curl-devel expat-devel gettext-devel openssl-devel \
     zlib-devel perl-ExtUtils-MakeMaker)

# Install the latest git
RUN (cd /tmp && \
     wget -O git-2.4.8.tar.gz https://github.com/git/git/archive/v2.4.8.tar.gz && \
     tar xf git-2.4.8.tar.gz && \
     cd git-2.4.8 && \
     make prefix=/usr/local all && \
     make prefix=/usr/local install && \
     cd .. && \
     rm -rf git-*)

# Install the latest autoconf
RUN (cd /tmp && \
     wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz && \
     tar xf autoconf-2.69.tar.gz && \
     cd autoconf-2.69 && \
     ./configure --prefix=/usr && \
     make && \
     make install && \
     cd .. && \
     rm -rf autoconf-*)

# Install kerl
ADD ./kerlrc /root/.kerlrc
RUN (wget -O /usr/local/bin/kerl https://raw.githubusercontent.com/spawngrid/kerl/master/kerl && \
     chmod a+x /usr/local/bin/kerl && \
     kerl update releases)

# Install an escript to print out OTP version
ADD ./show-otp-version.escript /usr/local/erlang/show-otp-version.escript
RUN chmod 744 /usr/local/erlang/show-otp-version.escript

# Install Erlang/OTP R16 with kerl
RUN (kerl build R16B03-1 r16b03-1_hipe && \
     kerl install r16b03-1_hipe /usr/local/erlang/r16b03-1_hipe && \
     kerl delete build r16b03-1_hipe && \
     rm /root/.kerl/archives/otp_src_R16B03-1.tar.gz && \
     source /usr/local/erlang/r16b03-1_hipe/activate && \
     /usr/local/erlang/show-otp-version.escript)

# Install Erlang/OTP 17 with kerl
RUN (kerl build git https://github.com/erlang/otp.git OTP-17.5.6.4 17.5.6.4_hipe && \
     kerl install 17.5.6.4_hipe /usr/local/erlang/17.5.6.4_hipe && \
     kerl delete build 17.5.6.4_hipe && \
     source /usr/local/erlang/17.5.6.4_hipe/activate && \
     /usr/local/erlang/show-otp-version.escript)

# Install Erlang/OTP 18 with kerl
RUN (kerl build git https://github.com/erlang/otp.git OTP-18.1.5 18.1.5_hipe && \
     kerl install 18.1.5_hipe /usr/local/erlang/18.1.5_hipe && \
     kerl delete build 18.1.5_hipe && \
     rm -rf /root/.kerl/gits/* && \
     source /usr/local/erlang/18.1.5_hipe/activate && \
     /usr/local/erlang/show-otp-version.escript && \
# Show kerl staus
     kerl status)

# Clean Up
RUN yum clean all
