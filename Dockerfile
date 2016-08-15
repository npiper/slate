FROM ruby:2.1
MAINTAINER Adrian Perez <adrian@adrianperez.org>

ENV HTTP_PROXY http://user:pass@proxy.corp:8080
ENV HTTPS_PROXY http://user:pass@proxy.corp:8080

VOLUME /usr/src/app/source
EXPOSE 4567
COPY sources.list /etc/app/sources.list
COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock
COPY config.rb /usr/src/app

RUN rm -rf /var/lib/apt/lists/* 

RUN apt-get update && apt-get install -y nodejs \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN bundle install

WORKDIR /usr/src/app/source

CMD ["bundle", "exec", "middleman", "server", "--force-polling"]
