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

kubectl delete crd --selector app=consul
helm uninstall consul
kubectl delete MutatingWebhookConfiguration  consul-consul-connect-injector 
kubectl delete namespaces consul 

helm install consul hashicorp/consul --create-namespace --namespace consul --values values.yaml

# consul-k8s install -config-file=values.yaml -set global.image=hashicorp/consul:1.18.0 -auto-approve

kubectl apply -f deployment.yaml 
kubectl apply -f hpa.yaml
kubectl apply -f secret.yaml
kubectl apply -f db.yaml
kubectl apply -f lb.yaml 



kubectl get deployments -A
kubectl get pods -A
kubectl get hpa 
kubectl get services -A




while true; do clear; kubectl get deployments; kubectl get pods -A;  kubectl get hpa; kubectl get services -A; sleep 5; done