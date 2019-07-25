#!/usr/bin/env bash

# source "${SCRIPT_DIR}/common/env.sh"
# source "${SCRIPT_DIR}/common/util.sh"
# source "${SCRIPT_DIR}/common/blockchain-v2.sh"
source "config/blockchain-v2.sh"

## TEST:


if [[ ! -n $(command -v fabric-cli) ]]; then
  exit_error "fabric-cli interface not found in PATH env variable"
fi
if [[ ! -n $(command -v jq) ]]; then
  exit_error "jq interface not found in PATH env variable"
fi


CONFIGPATH="$(pwd)/deploy_config.json"


# Install chaincode for all orgs' peers

# install_cc ${CONFIGPATH} "node" $(pwd)


# Instantiate chaincode in channels

instantiate_cc ${CONFIGPATH} "node" $(pwd) 