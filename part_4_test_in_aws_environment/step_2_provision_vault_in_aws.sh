#!/usr/bin/env bash

figlet -w 160 -f standard "Provision Vault in AWS"

bolt command run '/home/ubuntu/provision_vault.sh' --targets $(<.vault_dns) --user 'ubuntu' --no-host-key-check | tee ./.temp

while read line
do
   echo "$line" | grep  "token          \s*" | xargs | cut -d ' ' -f2 > ./.line
   if [ $(wc -c < ./.line) -ge 8 ]; then
      cp ./.line .vault_initial_root_token
      rm ./.line
   fi
done < ./.temp
rm ./.temp ./.line