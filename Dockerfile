FROM ubuntu:16.04
MAINTAINER danbo <dan@danbo.ca>
ENV DEBIAN_FRONTEND noninteractive

# install handbrake cli dependencies
# https://github.com/HandBrake/HandBrake/blob/master/doc/BUILD-Linux
RUN \
apt-get update && \
apt-get install -y \
git cmake yasm build-essential autoconf libtool \
zlib1g-dev libbz2-dev libogg-dev libtheora-dev libvorbis-dev libopus-dev \
libsamplerate-dev libxml2-dev libfribidi-dev libfreetype6-dev \
libfontconfig1-dev libass-dev libmp3lame-dev libx264-dev libjansson-dev

# install system wide dependencies
RUN \
apt-get install -y wget curl python libtool-bin m4 pkg-config

# can be a branch or tag id
# exists here to save time on rebuilding if variable is changed
ENV HB_BRANCH 0.10.5

# grab source
WORKDIR /usr/src
RUN \
git clone --branch "${HB_BRANCH}" https://github.com/HandBrake/HandBrake.git handbrake

# configure
WORKDIR /usr/src/handbrake
RUN \
./configure --enable-x265 --optimize=speed --disable-gtk

# compile
WORKDIR /usr/src/handbrake/build
RUN \
make && \
make install

# clean up
WORKDIR ~
RUN \
rm -rf /usr/src/handbrake

# verify
RUN \
/usr/local/bin/HandBrakeCLI --version
