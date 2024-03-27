
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)

kubectl get nodes

kubectl apply -f mesh.yaml 
kubectl apply -f resolver.yaml


kubectl apply -f secret.yaml
kubectl apply -f db.yaml
kubectl apply -f lb.yaml 




kubectl get deployments -A
kubectl get pods -A
kubectl get services -A
