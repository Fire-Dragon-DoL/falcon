FROM ruby:2.7.1 AS rails_deps

WORKDIR /app
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN date --utc
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  nodejs \
  yarn \
  javascript-common \
  build-essential

RUN gem update --system=3.1.3
RUN gem install bundler --version 2.1.4
RUN echo "Package versions" && \
  apt-cache policy nodejs

# --------------------------------------------------

FROM rails_deps AS blaster

WORKDIR /app

ARG app_env=development
ENV RAILS_ENV=$app_env
ENV PATH="/app/bin:${PATH}"
EXPOSE 3002
ENTRYPOINT ["rails"]
CMD ["s"]

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY yarn.lock yarn.lock
COPY package.json package.json
COPY vendor vendor
RUN bundle install --jobs 4
RUN yarn install

COPY . .

RUN ./bin/rails log:clear tmp:clear
