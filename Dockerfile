FROM ruby:3.2.1

RUN apt-get update -qq && apt-get install -y postgresql-client
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

RUN npm install -g yarn
RUN mkdir /users-library
WORKDIR /users-library
COPY Gemfile Gemfile.lock package.json yarn.lock vite.config.ts /users-library/
RUN bundle install
RUN yarn install
COPY . /users-library

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
