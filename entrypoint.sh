#!/usr/bin/env bash
set -ex
ACCOUNTS_FILE=/root/ganache-accounts.json
ganache-cli -v --defaultBalanceEther 200 -a 4 --acctKeys="$ACCOUNTS_FILE" >/tmp/ganach.log 2>&1 &
while [ ! -f "$ACCOUNTS_FILE" ]; do
  echo >&2 waiting for file $ACCOUNTS_FILE
  sleep 1
done
node /root/set-public-private-key-strings-in-config.js
cat /root/playbook/playbook.yml | grep WALLETS -A 20
ethereum-playbook -f /root/playbook/playbook.yml eth-balances
ethereum-playbook -f /root/playbook/playbook.yml deploy-lottery
echo ---------------------------------------------------------------
ethereum-playbook -f /root/playbook/playbook.yml eth-balances
ethereum-playbook -f /root/playbook/playbook.yml make-transfers
ethereum-playbook -f /root/playbook/playbook.yml eth-balances
while sleep 3600; do :; done
