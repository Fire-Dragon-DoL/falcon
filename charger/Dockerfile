FROM ruby:2.7.1 AS charger

WORKDIR /app

ARG app_env=development
ENV RAILS_ENV=$app_env
ENV PATH="/app/bin:${PATH}"
EXPOSE 3001
ENTRYPOINT ["rails"]
CMD ["s"]

RUN gem update --system=3.1.3
RUN gem install bundler --version 2.1.4

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY vendor vendor
RUN bundle install --jobs 4

COPY . .

RUN ./bin/rails log:clear tmp:clear
