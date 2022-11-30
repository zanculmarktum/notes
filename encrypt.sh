#!/usr/bin/env bash

decrypt="0"
if [[ "$0" == *decrypt.sh ]]; then
    decrypt="1"
fi

echo -n "Password: "
read -s password
echo

run() {
    local i="$1"
    if (( "$decrypt" )); then
        openssl aes-256-cbc -d -k "$password" -a -salt -pbkdf2 -iter 1000 -in "$i" -out "${i%.enc}"
    else
        openssl aes-256-cbc -k "$password" -a -salt -pbkdf2 -iter 1000 -in "$i" -out "$i".enc
    fi
}

if [[ $# -gt 0 ]]; then
    for i; do
        run "$i"
    done
else
    if (( "$decrypt" )); then
        for i in *.enc; do
            run "$i"
        done
    else
        for i in *.txt; do
            run "$i"
        done
    fi
fi
