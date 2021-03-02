FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y mariadb-server ruby-railties vim yarn git-core nodejs curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev gnupg2

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler
ADD ./Gemfile $APP_HOME
RUN bundle install
ADD . $APP_HOME
RUN cp $APP_HOME/config/database.example.yml $APP_HOME/config/database.yml
