# rediscloud-terraform
How to deploy a rediscloud subscription from terraform.

# Create a Redis Cloud subscription from Terraform

#### Prerequisites
* aws account
* aws-cli (aws access key and secret key)
* redis cloud account ([link](https://redis.com/try-free/))
  * redis cloud API Key and Secret (*instructions below*)
* terraform installed on local machine
* VS Code

Once you have the prerequisties we can get started.

1. Navigate to your Redis Cloud Account ([link](https://app.redislabs.com/))
2. Log in and click "Access Management"
3. Click API Keys
![Alt text](images/rc-accessmanagment-1.png?raw=true "Title")
4. Click the "+" icon and create a new API Key User.
![Alt text](images/rc-accessmanagment-2.png?raw=true "Title")
5. Save the API Account Key & the Secret Key information


## Redis Cloud Account Steps

You will need a Redis Cloud API key and secret key.

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
