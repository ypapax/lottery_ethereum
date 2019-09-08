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

rund() {
  docker build -t playbook . && docker run playbook "$@"
}

s() {
  docker exec -ti lottery "$@"
}

#accounts(){
#  s cat /root/ganache-accounts.json | jq .
#}

glog() {
  s /bin/cat /tmp/ganach.log
}

debug() {
#  docker exec -ti lottery truffle init
  s /bin/pwd; ls; truffle debug 0x8915311dd9c268875a971b115f0c4c6937a2ea8e8cdad47001e009abb442fd1c
}

"$@"
