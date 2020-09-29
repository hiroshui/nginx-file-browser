#!/bin/bash
set -eu

USERS=$(cat users.json | jq .users[])

COUNT=0

PASSWORD_FOLDER="/etc/apache2"

if [[ ! -d ${PASSWORD_FOLDER} ]]; then
  echo "[ERROR]: Folder ${PASSWORD_FOLDER} does not exists!"
  exit 1
fi

for row in $(cat users.json | jq -r '.users[] | @base64'); do
  content=$(echo ${row} | base64 --decode)
  USERNAME=$(echo ${content} | jq -r .name)
  PASSWORD=$(echo ${content} | jq -r .password)
  echo "[INFO]: Add user ${USERNAME}."
  htpasswd -b "${PASSWORD_FOLDER}/.htpasswd" "${USERNAME}" "${PASSWORD}"
  COUNT=$(( $COUNT + 1 ))
done

echo "[INFO]: Added $COUNT user(s)."
