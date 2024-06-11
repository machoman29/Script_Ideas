az login

#create variables
resourceGroup="MyResourceGroup"
location="eastus"
vnetName="MyVnet"
subnetName="MySubnet"
publicIpName="MyPublicIP"

# Create a resource group
az group create --name $resourceGroup --location $location

#create a virtual network
az network vnet create --resource-group $resourceGroup --name MyVnet --subnet-name MySubnet

#create a network security group
az network nsg create --resource-group $resourceGroup --name MyNSG

#create a public IP address
az network public-ip create --resource-group $resourceGroup --name $publicIpName

#create a network interface
az network nic create \
  --resource-group $resourceGroup \
  --name MyNic \
  --vnet-name MyVnet \
  --subnet MySubnet \
  --network-security-group MyNSG \
  --public-ip-address $publicIpName

#create a vm
az vm create \
  --resource-group $resourceGroup \
  --name MyFogServer \
  --nics MyNic \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys

#open ports for FOG server
az network nsg rule create \
  --resource-group $resourceGroup \
  --nsg-name MyNSG \
  --name AllowHTTP \
  --protocol tcp \
  --priority 1001 \
  --destination-port-range 80 \
  --access allow
  
az network nsg rule create \
  --resource-group $resourceGroup \
  --nsg-name MyNSG \
  --name AllowHTTPS \
  --protocol tcp \
  --priority 1002 \
  --destination-port-range 443 \
  --access allow
  
az network nsg rule create \
  --resource-group $resourceGroup \
  --nsg-name MyNSG \
  --name AllowTFTP \
  --protocol udp \
  --priority 1003 \
  --destination-port-range 69 \
  --access allow

#install FOG server
    ##ssh into the VM
    ssh azureuser@<publicIpAddress>
    ##update the system
    sudo apt-get update
    sudo apt-get upgrade -y
    ##install necessary packages
    #sudo apt install -y git apache2 php php-cli php-fpm php-json php-curl php-mysql mysql-server tftpd-hpa tftp-hpa xinetd nfs-kernel-server #chatGpt version
    sudo apt-get install -y apache2 mariadb-server php php-gd php-cli php-fpm php-mysql php-curl php-mbstring php-gettext php-bcmath php-json php-xml php-ldap php-zip php-imap php-xmlrpc php-soap php-intl php-pear php-dev libxml2-dev libcurl4-openssl-dev libssl-dev libbz2-dev libjpeg-dev libpng-dev libfreetype6-dev libmcrypt-dev libreadline-dev libxslt-dev libmhash-dev libmhash2 tftpd-hpa tftp-hpa xinetd nfs-kernel-server
    git clone https://github.com/FOGProject/fogproject.git
    cd fogproject/bin
    sudo ./installfog.sh
    ##follow the prompts to install FOG server, make sure to select the appropriate options for your environment (usually "Normal Installation" and "Single Server")
    ##after installation, go to the web interface and configure the server
    ##the web interface is usually at http://<publicIpAddress>/fog
    http://<$publicIpAddress>/fog/management
