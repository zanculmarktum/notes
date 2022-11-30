#!/usr/bin/env bash

decrypt=""
if [[ "$0" == *decrypt.sh ]]; then
    decrypt="-d"
fi

echo -n "Password: "
read -s password
echo

run() {
    local i="$1"
    if [[ "$decrypt" ]]; then
        openssl aes-256-cbc "$decrypt" -k "$password" -a -salt -pbkdf2 -iter 1000 -in "$i".enc -out "$i"
    else
        openssl aes-256-cbc -k "$password" -a -salt -pbkdf2 -iter 1000 -in "$i" -out "$i".enc
    fi
}

if [[ $# -gt 0 ]]; then
    for i; do
        run "$i"
    done
else
    for i in *.txt; do
        run "$i"
    done
fi
