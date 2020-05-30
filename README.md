# Falcon

Service based email sending.

- [Charger](#charger) - Configurator
- [Blaster](#blaster) - Email sending service

## Required Environment Variables

If executing locally outside of Docker, the following environment variables
are required:

```
REDIS_URL="redis://localhost:6400/15"
RABBITMQ_URL="amqp://localhost:5600"
REDIS_PROVIDER='REDIS_URL'
FETCHER_TWT_API_KEY='foo'
FETCHER_TWT_API_SECRET='bar'
FETCHER_TWT_ACCESS_TOKEN='token'
FETCHER_TWT_ACCESS_TOKEN_SECRET='tokensecret'
WORKERS='EmailWorker'
```

## Charger

### Generator

Project was generated using the following command:

```bash
rails new charger \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-record \
  --skip-active-storage \
  --skip-action-cable \
  --skip-turbolinks \
  --skip-spring \
  --skip-listen \
  --skip-bootsnap \
  --skip-system-test
```

## Blaster

### Generator

Project was generated using the following command:

```bash
rails new blaster \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-record \
  --skip-active-storage \
  --skip-action-cable \
  --skip-turbolinks \
  --skip-spring \
  --skip-listen \
  --skip-bootsnap \
  --skip-system-test
```

## Further Development

- Cache Twitter API requests
- Support multiple Twitter users
- Extensive testing

## Decisions

The software is divided in 3 services instead of the planned 2, however the
first 2 share the same codebase (Charger).

The project Blaster could have been a simple Ruby application, but the
specification requested explicitly a Rails application.

Charger (and Fetcher) is a combination of a Rails application and ActiveJob
worker based on Sidekiq (Redis).
The Active Job is used to fetch Twitter messages asynchronusly to avoid
blocking the UI when the user submits the timeline request.
Fetcher will get the list of URLs from Twitter home timeline and compile them
into an email message (a simple data structure) through Liquid template.
The message is then pushed on RabbitMQ to be digested on Blaster.
Please notice that Redis was not used on purpose to differentiate "storage"
database from a "messaging" mechanism.

Blaster is a Rails application which only executes Sneakers.
Sneakers starts a sets of worker which process RabbitMQ queus and sends email.

Notice that emails are not actually sent, but printed to STDOUT using
ActionMailer.

## Usage

The following environment variables are required to use docker-compose:

```
# Twitter API related keys and tokens
FETCHER_TWT_API_KEY='foo'
FETCHER_TWT_API_SECRET='bar'
FETCHER_TWT_ACCESS_TOKEN='token'
FETCHER_TWT_ACCESS_TOKEN_SECRET='tokensecret'
```

The application can be executed by running `docker-compose up`.
It will print the emails to STDOUT. The following ports need to be available:

- 3001
- 5600
- 6400

The docker applications start in order but might restart on error due to
redis and rabbitmq being not loaded yet.
