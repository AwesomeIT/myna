# FROM alpine:latest

# RUN apk update
# RUN apk add ffmpeg alpine-sdk linux-headers openssh automake libtool autoconf bison python python-dev swig
# RUN wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.bz2
# RUN tar -xvf ruby-2.4.1.tar.bz2
# RUN cd ruby-2.4.1 && ./configure && make install

# RUN git clone https://github.com/cmusphinx/sphinxbase.git
# RUN git clone https://github.com/cmusphinx/pocketsphinx.git
# RUN cd sphinxbase && ./autogen.sh && make install
# RUN cd pocketsphinx && ./autogen.sh && make install

FROM dstancu/ruby-240-pocketsphinx:latest
ADD . ./myna

WORKDIR myna

RUN bash -l -c "gem install bundler"
RUN bash -l -c "bundle"
RUN mkdir -p log
RUN touch log/production.log

CMD bash -l -c "bundle exec foreman start"