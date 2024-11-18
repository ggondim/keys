#!/bin/bash

if ! command -v gpg &> /dev/null; then
    sudo apt update && sudo apt install -y gnupg
fi

BASE_URL="https://raw.githubusercontent.com/ggondim/keys/main"
ID_RSA_GPG="id_rsa.gpg"
ID_RSA_PUB_GPG="id_rsa.pub.gpg"

mkdir -p ~/.ssh && cd ~/.ssh

curl -o ~/.ssh/$ID_RSA_GPG $BASE_URL/$ID_RSA_GPG
curl -o ~/.ssh/$ID_RSA_PUB_GPG $BASE_URL/$ID_RSA_PUB_GPG

echo "MASTER KEY:"
read -s PASSPHRASE

echo "$PASSPHRASE" | gpg --batch --yes --pinentry-mode loopback --passphrase "$PASSPHRASE" --output ~/.ssh/id_rsa --decrypt ~/.ssh/id_rsa.gpg
echo "$PASSPHRASE" | gpg --batch --yes --pinentry-mode loopback --passphrase "$PASSPHRASE" --output ~/.ssh/id_rsa.pub --decrypt ~/.ssh/id_rsa.pub.gpg

chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub


