FROM dstancu/ruby-240-pocketsphinx:latest
ADD . ./myna

WORKDIR myna

RUN bash -l -c "gem install bundler"
RUN bash -l -c "bundle"
RUN mkdir -p log
RUN touch log/production.log
RUN bash -l -c "gem install foreman"

CMD bash -l -c "foreman start"