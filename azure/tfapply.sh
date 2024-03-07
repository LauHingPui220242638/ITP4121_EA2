terraform apply -auto-approve  


resource_group_name=$(terraform output -raw resource_group_name)

az aks list \
  --resource-group $resource_group_name \
  --query "[].{\"K8s cluster name\":name}" \
  --output table

CONFIGFILE="./azurek8s"
echo "$(terraform output kube_config)" > $CONFIGFILE

cat $CONFIGFILE
# If you see << EOT at the beginning and EOT at the end,
#     remove these characters from the file. Otherwise,
#     you may receive the following error message: error:
#     error loading config file "$CONFIGFILE": yaml: line 2:
#     mapping values are not allowed in this context
sed -i -e '1s/^<<EOT//' -e '$s/EOT$//' "$CONFIGFILE"

export KUBECONFIG=$CONFIGFILE

kubectl get nodes


kubectl apply -f deployment.yaml 
kubectl apply -f lb.yaml 
kubectl apply -f hpa.yaml 


kubectl get deployments
kubectl get pods
kubectl get hpa

while true; do clear; kubectl get deployments; kubectl get pods;  kubectl get hpa; sleep 5; done