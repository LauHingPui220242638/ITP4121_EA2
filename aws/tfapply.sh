# terraform init
# terraform fmt
# terraform validate
terraform apply -auto-approve

aws eks update-kubeconfig --region ap-east-1 --name multicloud-eks --profile evan

export KUBECONFIG=kubeconfig.yaml

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



