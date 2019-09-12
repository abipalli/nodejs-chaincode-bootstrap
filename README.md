[![Build Status - Master](https://travis-ci.org/IBM-Blockchain-Starter-Kit/chaincode-bootstrap.svg?branch=master)](https://travis-ci.org/IBM-Blockchain-Starter-Kit/chaincode-bootstrap/builds)

# Scaffolding repository for use in Blockchain Starter Kit

## Environment
We have successfully tested and deployed this scaffolding chaincode component on [Hyperledger Fabric v1.1.0](https://hyperledger-fabric.readthedocs.io/en/release-1.1/releases.html), which requires [node v8.16](https://nodejs.org/dist/latest-v8.x/).

## Chaincode Development Instructions
* Create a new component directory under the [src](/src) folder for each component.
* Populate this component directory with files to be deployed.
* The [fabcar](/src/fabcar) directory is provided as a chaincode component example. 

## Chaincode Deployment Instructions
Populate the [deployment configuration](deploy_config.json) JSON file with information about network targets, inculding organizations, channels, and peers. Please note that included in this repostiory, there is a deployment configuration example file with the default network architecture to install and instantiate the ping chaincode component on a Hyperledger Fabric network.

* Developing current directory skeleton to be used with `IBM Cloud Continuous Delivery` toolchain to deploy chaincode automatically to `IBM Blockchain Platform v2` via `fabric-cli v1.4`
* Add all connection profiles exported from the IBM Blockchain Platform and rename them as `"org_id"-"channel_id".json"` (ex. _org1msp-channel1.json_)

```
nodejs_chaincode_repository:     
  LICENSE
  README.md
  deploy_config.json
  src/
    ...
  index.ts
  tsconfig.json
  package.json
  package-lock.json

```

### Configuring `deploy_config.json`
```
{
  <org msp id>: {
    "chaincode": [
      {
        "name": <chaincode name>,
        "version": <chaincode version>,
        
        "path": <relative chaincode path>,
        "channels": [
          <channel name>,
          ...
        ],

        "install": <true , false>,

        "instantiate": <true, false>,
        "init_fn": <chaincode init function (default: "init")>,   
        "init_args": <chaincode init arguments (default: [])>
      },
      ...
    ]
  }
}
```