FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y nodejs yarnpkg postgresql-client
RUN apt-get install -y sudo vim tree
RUN ln -s /usr/bin/yarnpkg /usr/bin/yarn
RUN mkdir /Library
WORKDIR /Library
COPY Gemfile /Library/Gemfile
COPY Gemfile.lock /Library/Gemfile.lock
RUN bundle install
COPY . /Library

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
