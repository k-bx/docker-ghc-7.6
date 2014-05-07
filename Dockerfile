FROM ubuntu:12.04

MAINTAINER Konstantine Rybnikov <k-bx@k-bx.com>

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /root
RUN apt-get update

RUN echo 'root:docker' |chpasswd
RUN mkdir -p ${HOME}/.ssh/
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN apt-get install -y apt-utils
RUN apt-get install -y wget libgmp3-dev build-essential
RUN ln -s /usr/lib/x86_64-linux-gnu/libgmp.so.10 /usr/lib/libgmp.so.3
RUN ln -s /usr/lib/x86_64-linux-gnu/libgmp.so.10 /usr/lib/libgmp.so
RUN wget http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2
RUN tar xf ghc-7.6.3-x86_64-unknown-linux.tar.bz2 && rm ghc-7.6.3-x86_64-unknown-linux.tar.bz2

WORKDIR /root/ghc-7.6.3
RUN ./configure
RUN make install
RUN rm -rf ghc-7.6.3
WORKDIR /root

RUN wget http://www.haskell.org/cabal/release/cabal-1.20.0.0/Cabal-1.20.0.0.tar.gz
RUN tar xf Cabal-1.20.0.0.tar.gz
RUN rm Cabal-1.20.0.0.tar.gz
WORKDIR Cabal-1.20.0.0
RUN ghc --make Setup
RUN ./Setup configure
RUN ./Setup build
RUN ./Setup install
WORKDIR /root
RUN rm -rf ./Cabal-1.20.0.0

RUN wget http://www.haskell.org/cabal/release/cabal-install-1.20.0.1/cabal-install-1.20.0.1.tar.gz
RUN tar xf cabal-install-1.20.0.1.tar.gz
RUN rm cabal-install-1.20.0.1.tar.gz
WORKDIR cabal-install-1.20.0.1
RUN apt-get install -y zlib1g-dev
RUN ./bootstrap.sh
ENV PATH $HOME/.cabal/bin:$PATH
RUN cabal update
RUN echo "export PATH=~/.cabal/bin:$PATH" >> /root/.profile
WORKDIR /root
RUN rm -rf ./cabal-install-1.20.0.1

EXPOSE 22
CMD /usr/sbin/sshd -D
