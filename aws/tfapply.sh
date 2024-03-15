# terraform init
# terraform fmt
# terraform validate
terraform apply -auto-approve

kubectl delete crd --selector app=consul
helm uninstall consul
kubectl delete namespaces consul 
helm install consul hashicorp/consul --create-namespace --namespace consul --values values.yaml


kubectl apply -f secret.yaml
kubectl apply -f db.yaml
kubectl apply -f lb.yaml 


kubectl get deployments
kubectl get pods
kubectl get services



