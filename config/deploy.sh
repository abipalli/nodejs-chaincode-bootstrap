source "$(dirname $0)/../../build-lib/src/common/blockchain.sh"

CONFIGPATH=$(dirname $0)/../deploy_config.json

for org in $(cat ${CONFIGPATH} | jq -r 'keys | .[]'); do
  for ccindex in $(cat ${CONFIGPATH} | jq -r ".${org}.chaincode | keys | .[]"); do
    cc=$(cat ${CONFIGPATH} | jq -r ".${org}.chaincode | .[${ccindex}]")
    for channel in $(echo ${cc} | jq -r '.channels | .[]'); do
      conn_profile="$(pwd)/config/${org}-${channel}.json"
      admin_identity="$(pwd)/config/${org}-admin.json"
      cc_name=$(echo ${cc} | jq -r '.name')
      cc_version=$(echo ${cc} | jq -r '.version')

      # should install
      if [[ "true" == $(cat ${CONFIGPATH} | jq -r ".${org}.chaincode | .[${ccindex}] | .install") ]]; then
        install_fabric_chaincode "${org}" "${admin_identity}" "${conn_profile}" "${cc_name}" "${cc_version}" "node" "$(pwd)"
      fi

      # should instantiate
      if [[ "true" == $(cat ${CONFIGPATH} | jq -r ".${org}.chaincode | .[${ccindex}] | .instantiate") ]]; then
        init_fn=$(cat $CONFIGPATH | jq -r ".${org}.chaincode | .[${ccindex}] | .init_fn?")
        if [[ $init_fn == null ]]; then unset init_fn; fi

        init_args=$(cat $CONFIGPATH | jq -r ".${org}.chaincode | .[${ccindex}] | .init_args?")
        if [[ $init_args == null ]]; then unset init_args; fi

        collections_config=$(cat $CONFIGPATH | jq -r ".${org}.chaincode | .[${ccindex}] .collections_config?")
        if [[ $collections_config == null ]]; then unset collections_config; fi

        instantiate_fabric_chaincode "${org}" "${admin_identity}" "${conn_profile}" "${cc_name}" "${cc_version}" "${channel}" "node" "${init_fn}" "${init_args}" "${collections_config}"
      fi      
    done
  done
done