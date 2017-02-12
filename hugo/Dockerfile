FROM golang:1.7.5
MAINTAINER minhajuddink@gmail.com

ENV HUGO_VERSION=0.18.1

# node support for asset precompilation
# pygments for syntax highlight
RUN apt-get update \
  && apt-get install -y \
    nodejs \
    npm \
    python-pygments \
  && apt-get clean \
  && ln -s /usr/bin/nodejs /usr/bin/node \
  && rm -rf /var/lib/apt/lists/* \
  && wget "https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" \
  && tar xvzf hugo_*.tar.gz \
  && rm -r hugo_*.tar.gz \
  && mv hugo*/hugo* /usr/bin/hugo

WORKDIR /opt/build

