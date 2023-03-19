FROM ruby:3.2.1

RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /users-library
WORKDIR /users-library
COPY Gemfile Gemfile.lock /users-library/
RUN bundle install
COPY . /users-library

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
