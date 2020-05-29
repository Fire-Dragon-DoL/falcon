# Falcon

Service based email sending.

- [Charger](#charger) - Configurator
- [Blaster](#blaster) - Email sending service

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
