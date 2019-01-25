#!/usr/bin/env bats

setup() {
  export RABBITMQ_VERSION="3.7.8"
}

cleanup() {
  rabbitmqctl stop
  rm -f "${HOME}/bin/rabbitmq"*
  rm -rf "${HOME}/rabbitmq-${RABBITMQ_VERSION}"
  rm -f "${HOME}/cache/rabbitmq-${RABBITMQ_VERSION}.tar.xz"
  unset RABBITMQ_VERSION
}

@test "[rabbitmq.sh] Script runs" {
  ./packages/rabbitmq.sh
}

@test "[rabbitmq.sh] Download cached" {
  [ -f "${HOME}/cache/rabbitmq-${RABBITMQ_VERSION}.tar.xz" ]
}

@test "[rabbitmq.sh] Verify version and service is running" {
  run rabbitmqctl status
  [[ "$output" =~ "{rabbit,\"RabbitMQ\",\"${RABBITMQ_VERSION}\"}" ]]
  cleanup
}
