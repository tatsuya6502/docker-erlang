## docker-erlang - Dockerfiles to build Erlang/OTP images

This git repository contains Dockerfiles to build kerl-based
multi-release Erlang/OTP Docker image on specific Linux
distribution. For example, the image with tag `centos6-multi-otp`
was built upon the official CentOS 6 image and contains Erlang/OTP
18, 17 and R16.

These images will be handy to create an Erlang application release
containing ERTS for a specific Linux distribution.


## Quick Start

The Docker images are published to Docker Hub and Quay. Pull one of
those images and run it.

```
$ docker pull tatsuya6502/erlang:<tag>
$ docker run -it --rm tatsuya6502/erlang:<tag> /bin/bash

(Activate a release)
# source /usr/local/erlang/18.0.3_hipe/activate
```

For example

```
$ docker pull tatsuya6502/erlang:centos6-multi-otp
$ docker run -it --rm tatsuya6502/erlang:centos6-multi-otp /bin/bash

[root@7a0afd51e424 /]# kerl status
Available builds:
There are no builds available
----------
Available installations:
r16b03-1_hipe /usr/local/erlang/r16b03-1_hipe
17.5.6.3_hipe /usr/local/erlang/17.5.6.3_hipe
18.0.3_hipe /usr/local/erlang/18.0.3_hipe
----------
No Erlang/OTP kerl installation is currently active

[root@7a0afd51e424 /]# source /usr/local/erlang/18.0.3_hipe/activate
[root@7a0afd51e424 /]# erl
Erlang/OTP 18 [erts-7.0.3] [source] [64-bit] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V7.0.3  (abort with ^G)
1>  (Ctrl+G)
User switch command
 --> q

[root@7a0afd51e424 /]# source /usr/local/erlang/17.5.6.3_hipe/activate
[root@7a0afd51e424 /]# erl
Erlang/OTP 17 [erts-6.4.1.2] [source] [64-bit] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V6.4.1.2  (abort with ^G)
1>
```


### Available Tags

| Tag                 | Description                                   |
|---------------------|-----------------------------------------------|
| `arch-multi-otp`    | Erlang/OTP 18, 17 and R16 on Arch Linux image |
| `centos7-multi-otp` | Erlang/OTP 18, 17 and R16 on CentOS 7 image   |
| `centos6-multi-otp` | Erlang/OTP 18, 17 and R16 on CentOS 6 image   |

Please note that there is no `latest` tag.


### Repository URLs

The images are available on Docker Hub and Quay.

- **Docker Hub** - https://hub.docker.com/r/tatsuya6502/erlang
- **Quay** - https://quay.io/repository/tatsuya6502/erlang
