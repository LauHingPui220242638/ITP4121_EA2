terraform apply -auto-approve  

gcloud components install kubectl
gcloud components install gke-gcloud-auth-plugin
gcloud container clusters get-credentials gke-terraform-dev --region=asia-east2-c

kubectl get nodes

# kubectl delete crd --selector app=consul
# helm uninstall consul
# kubectl delete MutatingWebhookConfiguration  consul-consul-connect-injector 
# kubectl delete namespaces consul 

# helm install consul hashicorp/consul --create-namespace --namespace consul --values values.yaml

# consul-k8s install -config-file=values.yaml -set global.image=hashicorp/consul:1.18.0 -auto-approve



kubectl apply -f secret.yaml
kubectl apply -f db.yaml
kubectl apply -f lb.yaml 


kubectl get deployments -A
kubectl get pods -A
kubectl get services -A

