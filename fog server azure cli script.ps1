#cli script to setup fog server

$myResourceGroup = "myResourceGroup"
$myVnet = "myVnet"
$mySubnet = "mySubnet"
$myPublicIP = "myPublicIP"
$myNetworkSecurityGroup = "myNetworkSecurityGroup"
$myNIC = "myNIC"
$myVM = "MyFogServer"
$location = "eastus" 

#logging into azure
az login

#creating resource group
az group create --name $myResourceGroup --location $location

#creating virtual network
az network vnet create --resource-group $myResourceGroup`
--name $myVnet --subnet-name $mySubnet

#creating public ip
az network public-ip create --resource-group $myResourceGroup --name $myPublicIP

#creating network security group
az network nsg create --resource-group $myResourceGroup --name $myNetworkSecurityGroup

#creating network interface
az network nic create --resource-group $myResourceGroup --name $myNIC `
    --vnet-name $myVnet `
    --subnet $mySubnet --network-security-group $myNetworkSecurityGroup `
    --public-ip-address $myPublicIP

#creating virtual machine
az vm create --resource-group $myResourceGroup --name $myVM `
    --image UbuntuLTS --nics $myNIC --generate-ssh-keys

#opening port 80 for http, 443 for https and 21 for ftp
az vm open-port --port 80 --resource-group $myResourceGroup --name myVM
az vm open-port --port 443 --resource-group $myResourceGroup --name myVM
az vm open-port --port 21 --resource-group $myResourceGroup --name myVM

#ssh into the vm
ssh azureuser@myPublicIP

#installing fog server
sudo apt-get update
sudo apt-get install -y git
#sudo apt install -y git apache2 php php-cli php-fpm php-json php-curl php-mysql mysql-server tftpd-hpa tftp-hpa xinetd nfs-kernel-server

git clone https://github.com/FOGProject/fogproject.git
cd fogproject/bin
sudo ./installfog.sh
# select appropriate options usually normal installation and single server
# installer will setup mySQL database, apache server, tftp server, nfs server and fog server

# once installation is complete, open a browser and navigate to http://myPublicIP/fog/management
# go to http://myPublicIP/fog/management
# login with default credentials
# username: fog
# password: password
# change the password and create a new user
# create a new image and upload an image to the server
# create a new host and associate the image to the host
# boot the host and image will be deployed to the host
