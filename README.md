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
terraform apply
```
Now you can visit your Nginx server by http://localhost:8000

[N.B. you must have install Docker]

