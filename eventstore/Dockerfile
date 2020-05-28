FROM postgres:12.3 AS eventstore

WORKDIR /app
ENV PGUSER='postgres'
ENV POSTGRES_USER='postgres'
ENV POSTGRES_PASSWORD='whatever'

COPY . .

WORKDIR /
COPY ./messagedb.sh ./docker-entrypoint-initdb.d/messagedb.sh
