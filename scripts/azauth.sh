
SUBSCRIPTION_ID=8385af88-3b2e-4d15-8962-838c178fef10
TENANT_ID=b05dbdb8-573e-4a36-82b4-8679e78095b4

az login --use-device-code --tenant $TENANT_ID
az account set --subscription $subscriptionID


az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$SUBSCRIPTION_ID"
# copy the credentails output from above
# export ARM_CLIENT_ID="<APPID_VALUE>"
# export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
# export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
# export ARM_TENANT_ID="<TENANT_VALUE>"