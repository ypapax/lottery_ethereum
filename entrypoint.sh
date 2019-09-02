#!/usr/bin/env bash
set -ex
ganache-cli -a 4 --acctKeys="/root/ganache-accounts.json" &
sleep 3
node /root/set-public-private-key-strings-in-config.js
cat /root/playbook/playbook.yml | grep WALLETS -A 20
ethereum-playbook -f /root/playbook/playbook.yml eth-balances
ethereum-playbook -f /root/playbook/playbook.yml deploy-lottery
echo ---------------------------------------------------------------
ethereum-playbook -f /root/playbook/playbook.yml eth-balances
ethereum-playbook -f /root/playbook/playbook.yml make-transfers
ethereum-playbook -f /root/playbook/playbook.yml eth-balances
while sleep 3600; do :; done

