FROM ruby:3.2.0

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y nodejs && \
    gem install bundler


COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install


COPY . .

EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
