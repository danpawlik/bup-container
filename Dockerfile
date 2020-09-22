FROM registry.centos.org/centos:7
ENV XDG_CACHE_HOME=/root/.cache
RUN yum install -y epel-release
RUN yum groupinstall -y "Development Tools" && \
    yum install -y python2 python2-devel libacl-devel pylibacl \
                   fuse-python pyxattr \
                   perl-Time-HiRes \
                   readline-devel \
                   python-tornado-doc

RUN yum clean all

RUN git clone https://github.com/bup/bup /root/bup -b 0.30.1

RUN cd /root/bup && ./configure && make && make check

RUN cd /root/bup && make install DESTDIR=/usr/local PREFIX=''

RUN rm -rf /root/bup
ENV PATH=/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
WORKDIR /root
