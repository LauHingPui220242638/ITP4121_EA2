terraform apply -auto-approve  


kubectl get nodes

# kubectl delete crd --selector app=consul
# helm uninstall consul
# kubectl delete MutatingWebhookConfiguration  consul-consul-connect-injector 
# kubectl delete namespaces consul 

# helm install consul hashicorp/consul --create-namespace --namespace consul --values values.yaml

# consul-k8s install -config-file=values.yaml -set global.image=hashicorp/consul:1.18.0 -auto-approve

kubectl apply -f mesh.yaml 
kubectl apply -f secret.yaml
kubectl apply -f db.yaml
kubectl apply -f lb.yaml 
kubectl apply -f resolver.yaml

kubectl get deployments -A
kubectl get pods -A
kubectl get hpa 
kubectl get services -A

