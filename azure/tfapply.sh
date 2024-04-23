terraform apply -auto-approve  




kubectl delete crd --selector app=consul
helm uninstall consul
kubectl delete MutatingWebhookConfiguration  consul-consul-connect-injector 
kubectl delete namespaces consul 

# helm install consul hashicorp/consul --create-namespace --namespace consul --values ../consul/dc2.yaml

# consul-k8s install -config-file=values.yaml -set global.image=hashicorp/consul:1.18.0 -auto-approve







