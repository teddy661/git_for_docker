FROM nvidia/cuda:12.6.0-cudnn-devel-rockylinux9 AS build
SHELL ["/bin/bash", "-c"]
RUN yum install dnf-plugins-core -y && \
    dnf config-manager --enable crb -y && \
    dnf install epel-release -y && \
    dnf --disablerepo=cuda update -y && \
    /usr/bin/crb enable && \
    dnf builddep python3 -y && \
    dnf install \
                perl-devel \
                libcurl-devel \
                gettext-devel \
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
                uuid uuid-devel \
                tcl-devel  tcl \
                tk-devel  tk \
                sqlite-devel \
                gcc-toolset-12 \
                xmlto \
                asciidoc \
                docbook2X \
                gdbm-devel gdbm -y &&\
		dnf clean all
WORKDIR /tmp/bgit
ENV G_VERSION=2.48.1
RUN wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-${G_VERSION}.tar.xz
RUN tar -xf git-${G_VERSION}.tar.xz
WORKDIR /tmp/bgit/git-${G_VERSION}
# RUN source scl_source enable gcc-toolset-12 && make -j 8 prefix=/opt/git profile
# RUN source scl_source enable gcc-toolset-12 && make -j 8 prefix=/opt/git install install-doc
RUN source scl_source enable gcc-toolset-12 && ./configure --prefix=/opt/git 
RUN source scl_source enable gcc-toolset-12 && make install install-doc
