#!/usr/bin/env bash
set -ex

truffleeInit() {
  truffle init
}
develop() {
  truffle develop
}

truffleMigrate() {
  truffle migrate -f 2
}

build() {
  docker-compose build
  docker-compose up
}

rund(){
  docker build -t playbook . && docker run playbook "$@"
}

s(){
  docker exec -ti lottery /bin/bash "$@"
}

#accounts(){
#  s cat /root/ganache-accounts.json | jq .
#}

"$@"
