FROM  nvidia/cuda:11.8.0-cudnn8-devel-rockylinux8 AS build
SHELL ["/bin/bash", "-c"]
RUN dnf install epel-release -y
RUN /usr/bin/crb enable
RUN dnf update --disablerepo=cuda -y
RUN dnf install \
                curl \
                perl-devel \
                libcurl-devel \
                expat-devel \
                gettext-devel \
                gcc \
                cmake \
                openssl-devel \
                bzip2-devel \
                xz xz-devel \
                findutils \
                libffi-devel \
                zlib-devel \
                wget \
                make \
                ncurses ncurses-devel \
                readline-devel \
                uuid \
                tcl-devel tcl tk-devel tk \
                sqlite-devel \
                gcc-toolset-11 \
                xmlto \
                asciidoc \
                docbook2X \
                gdbm-devel gdbm -y
WORKDIR /tmp/bgit
ENV G_VERSION=2.42.0
RUN wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-${G_VERSION}.tar.xz
RUN tar -xf git-${G_VERSION}.tar.xz
WORKDIR /tmp/bgit/git-${G_VERSION}
RUN source scl_source enable gcc-toolset-11 && make -j 8 prefix=/opt/git profile
RUN source scl_source enable gcc-toolset-11 && make -j 8 prefix=/opt/git PROFILE=BUILD install install-doc
