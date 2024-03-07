jsonFile="./azcrend.json"
json=$(cat $jsonFile)

export ARM_CLIENT_ID=$(echo $json | jq -r '.appId')
export ARM_CLIENT_SECRET=$(echo $json | jq -r '.password')
export ARM_SUBSCRIPTION_ID=8385af88-3b2e-4d15-8962-838c178fef10
export ARM_TENANT_ID=b05dbdb8-573e-4a36-82b4-8679e78095b4

