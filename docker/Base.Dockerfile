FROM ubuntu:22.04

RUN apt-get update && apt-get -y install sudo build-essential software-properties-common ninja-build wget libssl-dev libmpfr-dev libgmp3-dev libmpc-dev

RUN wget http://ftp.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.gz && tar -xf gcc-14.2.0.tar.gz && cd gcc-14.2.0 && ./configure -v --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu --prefix=/usr/local/gcc-14.2.0 --enable-checking=release --enable-languages=c,c++ --disable-multilib --program-suffix=-14.2.0 && make && sudo make install

RUN cd /tmp &&  \
    wget https://github.com/Kitware/CMake/archive/refs/tags/v3.30.2.tar.gz &&  \
    tar -zxvf v3.30.2.tar.gz

RUN cd /tmp/CMake-3.30.2 &&  \
    ./bootstrap &&  \
    sudo gmake &&  \
    sudo gmake install

RUN update-alternatives --install /usr/bin/g++ g++ /usr/local/gcc-14.2.0/bin/g++-14.2.0 14
RUN update-alternatives --install /usr/bin/gcc gcc /usr/local/gcc-14.2.0/bin/gcc-14.2.0 14
RUN gcc --version