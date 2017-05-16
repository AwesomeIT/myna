FROM dstancu/ruby-240-pocketsphinx:latest
ADD . ./myna

WORKDIR myna

RUN bash -l -c "gem install bundler"
RUN bash -l -c "bundle"
RUN mkdir -p log
RUN touch log/production.log

CMD bash -l -c "bundle exec foreman start"