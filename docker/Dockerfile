##----------------------------------------------------------------------
## Copyright (c) 2015 Tatsuya Kawano.  All rights reserved.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##----------------------------------------------------------------------

FROM centos:centos6
MAINTAINER Tatsuya Kawano

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
RUN (kerl build git https://github.com/erlang/otp.git OTP-17.5.6.3 17.5.6.3_hipe && \
     kerl install 17.5.6.3_hipe /usr/local/erlang/17.5.6.3_hipe && \
     kerl delete build 17.5.6.3_hipe && \
     source /usr/local/erlang/17.5.6.3_hipe/activate && \
     /usr/local/erlang/show-otp-version.escript)

# Install Erlang/OTP 18 with kerl
RUN (kerl build git https://github.com/erlang/otp.git OTP-18.0.3 18.0.3_hipe && \
     kerl install 18.0.3_hipe /usr/local/erlang/18.0.3_hipe && \
     kerl delete build 18.0.3_hipe && \
     rm -rf /root/.kerl/gits/* && \
     source /usr/local/erlang/18.0.3_hipe/activate && \
     /usr/local/erlang/show-otp-version.escript && \
# Show kerl staus
     kerl status)

# Clean Up
RUN yum clean all
