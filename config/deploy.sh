#!/usr/bin/env bash

source "/Users/abisarvepalli/Developer/nodejs-chaincode-bootstrap/config/blockchain-v2.sh"

$DEBUG && set -x

CONFIGPATH=$(pwd)/deploy_config.json
SRC_DIR=$(pwd)

if [[ ! -f $CONFIGPATH ]]; then
  echo "No deploy configuration at specified path: ${CONFIGPATH}"
  exit 1
fi

echo '$CONFIGPATH...'${CONFIGPATH}
cat ${CONFIGPATH}
CONFIGPATH="$(pwd)/deploy_config.json"
CONFIG=`cat ${CONFIGPATH}`
echo $CONFIG; echo; echo;

# npm install


# parse deploy_config.json for deployment activations
for org in $(cat ${CONFIGPATH} | jq 'keys | .[]'); do
  for ccindex in $(cat ${CONFIGPATH} | jq ".${org}.chaincode | keys | .[]"); do
    cc=$(cat ${CONFIGPATH} | jq ".${org}.chaincode | .[${ccindex}]")
    for channel in $(echo ${cc} | jq '.channels | .[]'); do
      conn_profile="$(pwd)/config/${org}-${channel}.json"
      admin_identity="$(pwd)/config/${org}-admin.json"
      cc_name=$(cat ${SRC_DIR}/package.json | jq '.name')
      cc_version=$(cat ${SRC_DIR}/package.json | jq '.version')

      # should install
      if [[ "true" == $(cat ${CONFIGPATH} | jq ".${org}.chaincode | .[${ccindex}] | .install") ]]; then
        install_cc_standalone "${org}" "${admin_identity}" "${conn_profile}" "${cc_name}" "${cc_version}" "node" "$(pwd)"
      fi

      # should instantiate
      if [[ "true" == $(cat ${CONFIGPATH} | jq ".${org}.chaincode | .[${ccindex}] | .instantiate") ]]; then
        init_fn=$(cat $CONFIGPATH | jq ".${org}.chaincode | .[${ccindex}] | .init_fn?")
        echo $init_fn
        if [[ init_fn == null ]]; then unset init_fn; fi

        init_args=$(cat $CONFIGPATH | jq ".${org}.chaincode | .[${ccindex}] | .init_args?")
        if [[ init_args == null ]]; then unset init_args; fi

        instantiate_cc_standalone "${org}" "${admin_identity}" "${conn_profile}" "${cc_name}" "${cc_version}" "${channel}" "node" "${init_fn}" "${init_args}"

        # # test invokation of init method
        # invoke_cc_standalone $org $admin_identity
      fi      
    done
  done
done
# install_cc "${CONFIGPATH}" "node" $(pwd)
# instantiate_cc "${CONFIGPATH}" "node" $(pwd)
# invoke_cc "${CONFIGPATH}" "node" $(pwd)

####################################
#!/usr/bin/env bash

# source "${SCRIPT_DIR}/common/env.sh"
# source "${SCRIPT_DIR}/common/util.sh"
# source "${SCRIPT_DIR}/common/blockchain-v2.sh"
# source "config/blockchain-v2.sh"

## TEST:


# if [[ ! -n $(command -v fabric-cli) ]]; then
#   exit_error "fabric-cli interface not found in PATH env variable"
# fi
# if [[ ! -n $(command -v jq) ]]; then
#   exit_error "jq interface not found in PATH env variable"
# fi




# # echo $(dirname $0)

# # for org in $(echo $CONFIG | jq 'keys | .[]'); do
# #   echo $org
# # done


# # Install chaincode for all orgs' peers
# if [[ -z $1 || $1 == "install" ]]; then
# fi

# # Instantiate chaincode in channels
# if [[ -z $1 || $1 == "instantiate" ]]; then
#   instantiate_cc "${CONFIG}" node $(pwd)
# fi

# # Invoke init func on installed channels by installed organizations
# if [[ -z $1 || $1 == "invoke" ]]; then
#   invoke_cc "${CONFIG}" node $(pwd)
# fi
####################################
