FROM ruby:2.6-slim

RUN apt-get update \
 && apt-get install -y git make gcc \
 && apt-get clean autoremove

COPY . /app

WORKDIR /app

RUN bundle install --verbose

CMD bundle exec ./exe/namarara-api
