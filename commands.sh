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


"$@"
