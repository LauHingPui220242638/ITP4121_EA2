apt-cache policy azure-cli

# Obtain the currently installed distribution
AZ_DIST=$(lsb_release -cs)

# Store an Azure CLI version of choice
AZ_VER=2.51.0

# Install a specific version
sudo apt-get install azure-cli=$AZ_VER-1~$AZ_DIST