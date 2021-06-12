FROM ruby:2.7.3
ENV DOCKERIZE_VERSION v0.6.1
RUN apt-get update && \
    apt-get install -y --no-install-recommends\
    nodejs  \
    build-essential  \
    wget \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /small_task

COPY Gemfile /small_task/Gemfile
COPY Gemfile.lock /small_task/Gemfile.lock

RUN bundle install

COPY . /small_task
RUN mkdir -p tmp/sockets
EXPOSE 3000
