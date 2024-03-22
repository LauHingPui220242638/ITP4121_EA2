curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-469.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-cli-469.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
./google-cloud-sdk/install.sh --help
./google-cloud-sdk/bin/gcloud init



gcloud components install kubectl
kubectl version --client
gke-gcloud-auth-plugin --version
gcloud components install gke-gcloud-auth-plugin
gke-gcloud-auth-plugin --version


gcloud container clusters get-credentials gke-terraform-dev \
    --region=	asia-east2-c