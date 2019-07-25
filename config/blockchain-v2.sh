function install_cc {
  local CONFIGPATH=$1  
  local PLATFORM=$2
  local SRC_DIR=$3  
  # local ROOTDIR=${4:-"null"} #TEST: 

  echo $CONFIGPATH $PLATFORM $SRC_DIR; echo; echo

  for org in $(cat ${CONFIGPATH} | jq 'keys | .[]'); do
    # echo $org
    for channel in $(cat ${CONFIGPATH} | jq ".${org}.chaincode | .[].channels | .[]"); do 

      # local conn_profile="$org-$channel-connprofile.json"
      local conn_profile="${SRC_DIR}/config/${org}-${channel}-connprofile.json"
      local admin_identity="${SRC_DIR}/config/$org-admin.json"
      local cc_name=$(cat $(pwd)/package.json | jq '.name')
      local cc_version=$(cat $SRC_DIR/package.json | jq '.version')

      # echo "conn_profile...${conn_profile//\"}"
      # less ${conn_profile//\"}
      
      echo "fabric-cli chaincode install --conn-profile ${conn_profile//\"} --org ${org//\"}msp --admin-identity ${admin_identity//\"} --cc-name ${channel//\"} --cc-version ${cc_version//\"} --cc-type ${PLATFORM//\"} --src-dir ${SRC_DIR//\"}"
      echo
      echo
      echo "fabric-cli chaincode install --conn-profile ${conn_profile//\"} --org ${org//\"}msp --admin-identity ${admin_identity//\"} --cc-name ${cc_name//\"} --cc-version ${cc_version//\"} --cc-type ${PLATFORM//\"} --src-dir ${SRC_DIR//\"}" | bash      

    done
  done
}

function instantiate_cc {
  # echo "still in development..."

  local CONFIGPATH=$1  
  local PLATFORM=$2
  local SRC_DIR=$3
  local INIT_FUNC=$4
  local INIT_ARGS=$5
  
  # TEST:
  local ROOTDIR=${4:-"null"}

  echo $CONFIGPATH $PLATFORM $SRC_DIR; echo; echo

  for org in $(cat ${CONFIGPATH} | jq 'keys | .[]'); do
    # echo $org
    for channel in $(cat ${CONFIGPATH} | jq ".${org}.chaincode | .[].channels | .[]"); do 

      # local conn_profile="$org-$channel-connprofile.json"
      local conn_profile="${SRC_DIR}/config/${org}-${channel}-connprofile.json"
      local admin_identity="${SRC_DIR}/config/$org-admin.json"
      local cc_name=$(cat $(pwd)/package.json | jq '.name')
      local cc_version=$(cat $SRC_DIR/package.json | jq '.version')
      
      echo "fabric-cli chaincode instantiate --conn-profile ${conn_profile//\"} --org ${org//\"}msp --admin-identity ${admin_identity//\"} --cc-name ${channel//\"} --cc-version ${cc_version//\"} --cc-type ${PLATFORM//\"} --channel ${channel}"
      echo
      echo       
      echo "fabric-cli chaincode instantiate --conn-profile ${conn_profile//\"} --org ${org//\"}msp --admin-identity ${admin_identity//\"} --cc-name ${cc_name//\"} --cc-version ${cc_version//\"} --cc-type ${PLATFORM//\"} --channel ${channel}" | bash

    done
  done
}