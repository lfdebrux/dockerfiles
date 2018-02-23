FROM ubuntu:16.04

WORKDIR /

RUN apt-get update && apt-get install -y \
	bzip2 \
	git \
	mercurial \
	python-pip \
	python-setuptools \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ADD https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2?revision=375265d4-e9b5-41c8-bf23-56cbe927e156?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,7-2017-q4-major /

RUN tar xf gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2 && rm gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2

RUN pip install --upgrade pip

RUN pip install mbed-cli && mbed-cli config -G GCC_ARM_PATH /gcc-arm-none-eabi-7-2017-q4-major/bin
