# Terraform Configuration for Google Cloud

## This procedure demonstrates you to create VM Instances under GCE and also setup enviornment to configure Tomcat Server with DB.

### First setup Service account for Google Cloud Service Account

### TO setup Google Cloud Service Account, Follow the following steps.
Create Service account in GOOGLE.

	-> Login to google cloud
	-> Go to Google Cloud Products & Services
	-> GO to IAM & ADMIN
	-> Go to Service Accounts
	-> Create Service Account
	-> Select 
		Name: vagrant
		Role: Project Owner
		Select : Furnish a new private key -> JSON
        -> One JSON would be downloaded and copy the content of that file and paste it under server (vi /root/vagrant.json)

### Install Terraform on to your system. Ensure you check the proper architecture of the Operating System and then proceed with download.
### To download the Terraform use the following link.
```
# wget https://releases.hashicorp.com/terraform/0.9.2/terraform_0.9.2_linux_amd64.zip
# unzip  terraform_0.9.2_linux_amd64.zip
# mv terraform /bin
# terraform --version
```

### Now setup the Terraform configuration to connect to Google Cloud Instances.
```
Used the following link for referecing this file syntaxes and configurations.
https://www.terraform.io/docs/providers/google/index.html
```

Follow the following process.
```
# mkdir /root/terraform
# cd /root/terraform
#
```




