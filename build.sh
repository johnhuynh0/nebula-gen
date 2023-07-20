#!/usr/bin/env bash

# Check the first argument for the --help or -h flags, or if no arguments were passed at all to the script
if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "" ]]; then
    echo "Usage:"
    echo "$0 \"<name of organization>\""
    echo ""
    echo "Example:"
    echo "$0 \"Dunder Mifflin, Inc.\""

    exit 1
fi

# Delete the old CA certificate and key if they exist
rm -rf ./ca.crt
rm -rf ./ca.key

# Generate a new CA certificate and key
nebula-cert ca -name "$1"

# Delete all of the old directories that may have been generated from previous run of this script
find . -maxdepth 1 -type d ! -name '.git' ! -name '.' -exec rm -rf {} \;

# Create a new directory for each of the hosts, and bundle everything together they need so that
# they can authenticate onto the VPN network
HOSTS_LIST="$(cat build.yml | shyaml keys 'hosts' | xargs)"

for HOST in $HOSTS_LIST; do
    mkdir $HOST

    ARGS_LIST=""
    for KEY in $(shyaml keys hosts.$HOST < build.yml); do
        VALUE=$(shyaml get-value hosts.$HOST.$KEY < build.yml)
        ARGS_LIST+=" -$KEY $VALUE" 
    done

    nebula-cert sign -name "$HOST" -out-crt "./$HOST/$HOST.crt" -out-key "./$HOST/$HOST.key" $ARGS_LIST
    cp ./ca.crt "./$HOST/ca.crt"
done
