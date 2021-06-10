FROM ruby:2.7.3
RUN apt update -qq && \
    apt install -y build-essential nodejs
RUN mkdir /lantern_docker
ENV APP_ROOT /smalltask_docker
WORKDIR $APP_ROOT
ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock
RUN gem install bundler
RUN bundle install
ADD . $APP_ROOT
RUN mkdir -p tmp/sockets
EXPOSE 3000
