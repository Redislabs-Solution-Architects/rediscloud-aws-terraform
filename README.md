# rediscloud-terraform
How to deploy a rediscloud subscription from terraform.

These instructions also explain how to get started with Terraform from scratch.

### Prerequisites:
* Rediscloud account
* terraform (install explanation below)
* VS Code


Based on the following instructions:

[https://redislabs.com/blog/provision-manage-redis-enterprise-cloud-hashicorp-terraform/](https://redislabs.com/blog/provision-manage-redis-enterprise-cloud-hashicorp-terraform/)


# Download Terraform: (Mac OS)

There are two ways to do this, the second method worked better for me to link with VS code.
## Method 1:
* Download the Terraform CLI:
  * https://www.terraform.io/downloads.html
* Open the zip file:
  * (if you see an error saying something about security settings follow these instructions)
    * https://github.com/hashicorp/terraform/issues/23033
    * Just control click the terraform unix executable and click open.
      * This bypasses some security setting.
  * Great you should be good to go!

## Method 2:
https://learn.hashicorp.com/tutorials/terraform/install-cli
* Open terminal:
```bash
    > echo #PATH
    > mv ~/Downloads/terraform /usr/local/bin/
    > terraform -help
```

* Clone this repo and open in VS Code
  * If you click into a terraform file VS Code will prompt you to download HashiCorp Terraform (Extension)
  * Do it and you should be good to go!
    * If you see and error about "Terraform (CLI) is required. Please install Terraform or make it avialable in $PATH" then follow the above instructions again.

# Create a RedisCloud subscription from Terraform
Now that we have terraform installed and working with VS code we can get started.

* Head to your Redis Enterprise Cloud account:
* Get your Cloud API Access Key and Secret Key.
* Place these keys in the terraform.tfvars file.

Copy the variables template. or rename it 'terraform.tfvars'
```bash
  cp terraform.tfvars.example terraform.tfvars
```
Update terraform.tfvars with your [secrets](#secrets)

* Open a terminal in VS Code:
```bash
  terraform init
  terraform plan
  terraform apply
```


## Cleanup

Remove the resources that were created.

```bash
  terraform destroy
```
