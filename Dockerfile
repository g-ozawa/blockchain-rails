FROM ruby:2.4-alpine3.6

ENV RAILS_ROOT /var/www/blockchain
RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

RUN apk update && \
    apk upgrade && \
    apk add --update \
    build-base \
    tzdata

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install

CMD bundle exec puma -C config/puma.rb