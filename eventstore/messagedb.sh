#!/bin/bash

pushd /app/message-db
./database/install.sh
result=$?
popd
exit $result
