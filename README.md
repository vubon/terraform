## Terraform Tutorial

### Prerequisites
Install Terraform on your machine [Link](https://learn.hashicorp.com/tutorials/terraform/install-cli)

Check the version
```bash 
terraform -v 
```
Basic Command List 
| Description                               | Command                     |
| -------------                             |:-------------:              |
| Version check                             | ```terraform -v ```         | 
| Terraform plan                            | ``` terraform plan ```      |   
| Create resource according to plan         | ``` terraform apply ```     |
| Delete resources                          | ``` terraform destroy ```   |

#### Docker 
Go to docker folder and run bellow commands 
```bash
terraform init 
```
Now run apply command 
```bash 
terraform apply
```
Now you can visit your Nginx server by http://localhost:8000

[N.B. you must have install Docker]

#### EC2 
You must have AWS account before going to start this section. Get your credentails from AWS account and follow below steps. 

Step 1: 
```bash 
mkdir ~/.aws
```
Step 2: 
```bash 
nano ~/.aws/credentials
```

Step 3: Insert your below text with your credentails. 
```
[default]
aws_access_key_id=<Your Access Key>
aws_secret_access_key=<Your >
```

Step 4: 
```bash 
nano ~/.aws/config
```

```
[default]
region=us-west-2
output=json
```
More details visit on [Link](!https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

All right. Now let's start actual process for creating EC2 instance on AWS account. Go to EC2 folder. Setup the aws profile in below section. 

```hcl 
provider "aws" {
  profile = "default" # Few time ago we created a profile default. So you must keep it. 
  region  = "us-east-1" # Now you can choose AWS region where you want to create your EC2 instance
}

```
Now you need to create an ssh key with no passphrase for accesing EC2 Instance. Follow below steps.
```bash 
ssh-keygen -t rsa ec2_test
```
You will get two files in the same folder. 1. **ec2_test** and 2. **ec2_test.pub** . You just need to rename the ec2_test to **ec2_test.pem** 

Now apply the terraform. 
```bash 
terraform apply
```
It will take some time to create the EC2 resource. You will get the instance public IP address by  ec2_test.pem file you can access the server. 