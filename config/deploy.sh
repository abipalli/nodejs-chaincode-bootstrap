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
CONFIG=`cat ${CONFIGPATH}`
# echo $CONFIG; echo; echo;

# echo $(dirname $0)

# for org in $(echo $CONFIG | jq 'keys | .[]'); do
#   echo $org
# done


# Install chaincode for all orgs' peers
if [[ -z $1 || $1 == "install" ]]; then
  install_cc "${CONFIG}" "node" $(pwd)
fi

# Instantiate chaincode in channels
if [[ -z $1 || $1 == "instantiate" ]]; then
  instantiate_cc "${CONFIG}" node $(pwd)
fi

# Invoke init func on installed channels by installed organizations
if [[ -z $1 || $1 == "invoke" ]]; then
  invoke_cc "${CONFIG}" node $(pwd)
fi