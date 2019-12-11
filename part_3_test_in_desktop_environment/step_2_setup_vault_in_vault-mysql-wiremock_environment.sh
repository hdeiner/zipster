#!/usr/bin/env bash

figlet -w 160 -f standard "Setup Vault in vault-mysql-wiremock Environment"

docker exec vaultserver vault operator init > temp.txt

echo "Unseal Vault"
grep  "Unseal Key 1\: \(\.*\)" temp.txt | cut -d: -f2 | xargs > .vault_unsealkey_1
grep  "Unseal Key 2\: \(\.*\)" temp.txt | cut -d: -f2 | xargs > .vault_unsealkey_2
grep  "Unseal Key 3\: \(\.*\)" temp.txt | cut -d: -f2 | xargs > .vault_unsealkey_3
grep  "Unseal Key 4\: \(\.*\)" temp.txt | cut -d: -f2 | xargs > .vault_unsealkey_4
grep  "Unseal Key 5\: \(\.*\)" temp.txt | cut -d: -f2 | xargs > .vault_unsealkey_5

grep  "Initial Root Token\: \(\.*\)" temp.txt | cut -d: -f2 | xargs > .vault_root_token

rm temp.txt

docker exec vaultserver vault operator unseal $(<.vault_unsealkey_1) > /dev/null
docker exec vaultserver vault operator unseal $(<.vault_unsealkey_2) > /dev/null
docker exec vaultserver vault operator unseal $(<.vault_unsealkey_3) > /dev/null

echo "Create UUID and Environment Registries"
docker exec vaultserver vault login $(<.vault_root_token) > /dev/null
docker exec vaultserver vault secrets enable -version=2 -path=UUIDS kv > /dev/null
docker exec vaultserver vault secrets enable -version=2 -path=ENVIRONMENTS kv > /dev/null