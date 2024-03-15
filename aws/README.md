# AWS

aws cli sso:
```
aws configure sso
SSO session name (Recommended): my-sso
SSO start URL [None]: https://d-c4671417d9.awsapps.com/start#
SSO region [None]: ap-east-1
SSO registration scopes [None]: sso:account:access
CLI default client Region [None]: ap-east-1
CLI default output format [None]: JSON
CLI profile name [AdministratorAccess-745096851160]: evan
```

To use this profile:
```
aws xxx --profile evan
```

cd aws/
terraform init

terraform plan     (test)
terraform apply -auto-approve (build)

terraform destroy -auto-approve  (delet)

kubectl command:
```
kubectl get deployments
kubectl get pods
kubectl get hpa
kubectl get services
```
