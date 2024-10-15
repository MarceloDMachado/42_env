FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y clang-12 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install make

RUN ln -s /usr/bin/clang-12 /usr/bin/cc && \
    ln -s /usr/bin/clang++-12 /usr/bin/cc++

RUN apt-get update && \
    apt-get install wget && \
    wget https://sourceware.org/ftp/valgrind/valgrind-3.15.0.tar.bz2 && \
    tar -xjf valgrind-3.15.0.tar.bz2 && \
    cd valgrind-3.15.0 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf valgrind-3.15.0 valgrind-3.15.0.tar.bz2

RUN apt install python3-setuptools -y && \
    apt install pipx -y && \
    apt install python3.8-venv -y && \
    pipx install norminette --force && \
    pipx ensurepath

ENV PATH=/root/.local/bin:$PATH

RUN apt-get install libreadline-dev

RUN apt-get install libc6-dbg

WORKDIR /app

#COPY [project/path (ex.: ~/minishell)] /app

#RUN make

CMD ["bash"]