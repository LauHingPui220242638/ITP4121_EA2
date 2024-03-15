kubectl apply -f deployment.yaml 
kubectl apply -f lb.yaml 
kubectl apply -f hpa.yaml 


kubectl get deployments
kubectl get pods
kubectl get hpa


while true; do clear; kubectl get deployments; kubectl get pods;  kubectl get hpa; sleep 5; done




